Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438A397680
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445434; cv=pass; b=pbzdHLdT4M3O1p4jUe2h2AStNMK5vsp3wdQZY9yxzK5cb0mNmWuFtjbzOxbAaRuxi974zem5M9btvheplMBOmk06jNNFDrq+DRnJyjWxmD5LXBClyCxjoQhVYDso8su9scTjQb16eG4mN0MYDkyp/58T2IjGmysSP4htmQUYUg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445434; c=relaxed/simple;
	bh=C9LyQ/r9VXNRCD4sBDFh5+TNNt0TsudnLk+lY2Kni1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKD2Y/vFtO9l9nULjqJ0CZRn+p1UOqljEcBrJy1GZsfxYCQaaR7XjZ8NSKJD9nuCpHQptUx1Wd0vPnhaqq9aQUCqwtdI2Jsvp6LelAnImq+cmllhpxZnlvKHXSyr9z8o6zJXilmafHl6cgTyE5CZG5hWM1QgeDlWcNHcp1JjMrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtvZD5FW; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtvZD5FW"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so975280a91.2
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776445430; cv=none;
        d=google.com; s=arc-20240605;
        b=On4tPjnJKdv9NSVVZtCSTJxRSlcdMtzXoGsKAM+dyxzG0tu1pGlKbzt3FWEk6GdZHC
         Frz2LRlTi2Wl5ALULvw+VwQaeLXrXP5zMtbtWw+53o1gwLxbBjKcwvMvJUK0biuOdPUW
         ZAA9lv0hyBmhSTtTJr8o0XSNFk5VGxJQKSgFQq90vKjcHN3cjxm/ihIIEEoqgJo+yZfI
         5lipQ33HHMck25jSR6rDq/POgW6scp7Yn5UtlREZD2KT58kvBb8O8kctvCoGQ4dS6qHx
         Pl3Cx0QrUyo6O2zLIlzyAjuMEViOL57Xp16k7nMsP9H020FneiEmlAJNs6pqIAyol60d
         y4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0zkZoeTowZqxjC3m7DdL1jKQ7pdE2WsMMXAIcTsbHDM=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=CaPl4+p4nkJMDvYb+N95ZeDVa1uJv3fQZT9kPznqW8+ES+imyfPYdYVMDyQoRvsNzj
         ej/AqRbCWvzutfC1wY5D3KTmM/8b9Ud4TObI4lTPbTDewU0WnOYifGMfja/8N3asdAff
         rIckNXPZAlTU1gNc/lY+iJBH9CCemtDV24SREPHC3aBXg1JcOmYgLrx9T2rWt8B9w1rv
         vr2SQ/pPPSB/0jgq4yyVzdTHIeRVk3xP5mFVNHTQit7FvTzaRElAFuXh8GYzplPePQO2
         AFQUnHh9MrvKLgVwLTJ0Fa0ldOrO76aVLjuWjyDdMeAGVdyxZ2fkUCRTqCjloUpm8RXs
         sZQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776445430; x=1777050230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zkZoeTowZqxjC3m7DdL1jKQ7pdE2WsMMXAIcTsbHDM=;
        b=NtvZD5FWEmt77dEucqYI46ddEhmHTYQuXQXwFEH8LIuyR/moGNauPhfl8Mvt57X+Ze
         upSX1+qXH/EDTCrMa4mgErAhj4DyadOD06CVMOYVE3BKy789pYm6bbECC9q0ajP/yntB
         E86b61aBnK1eOTZzg63jyBeWP2tloJGKfqHVrdTyIoL7k9RkXAEIUnxTVPYb02iH2o7Y
         wlJt9T45Si4AJI2YmA0vl+KDTbZ48vcPfCCDxhXsOV4LEvKY7qZMbAXV1VI/0CTGHPm2
         80h5pfiEOSH329lE3taoo0Q+iZ5Qn7YIpLVKhiS6esuiLiUG/IKiiBdUDMt1ttGtSoI0
         MWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445430; x=1777050230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zkZoeTowZqxjC3m7DdL1jKQ7pdE2WsMMXAIcTsbHDM=;
        b=IM0AfnDurs8//jRou+z8b2PhLV2VdiFM5LYEqM0uUH2LchMGnlZCCEglCY665aBjq9
         YmDluy1wiKM+kAV8neoGHUky2WZnArlM+QBVV1/XINdEZDXCu1DbCW0dwv+jqONdC7hV
         YmIlzRL9u4ye/mdpgotjB2CdfiCaDKQoNkqUY8zf4OasTGnV1YCv+Mw/DvGU6gKI+6IE
         Hoj9fy9CeRZ0Oh/ZVxEHzLD34IY0jTzwuZuTWsIGwmdVBCjrtFVMnbhmQ/hZ8ZP87YPZ
         HQUE9m8YoVZ394Z83nGbZHkBUGbAiY4gueigPP11FBUcbVfcbCPtLnXcWjDHdQFpHr9+
         K6Yw==
X-Gm-Message-State: AOJu0YzI7WP7LJ4Nv5419ZLUUqeHs/QlKrVMxrRmesOEcsierkdMtF8i
	4uSDDTozVGv1kAksRPCzmXHzdDAEnM8LsrLeiT7uDAHtmvVfsVeuSZ1TQPw/IurSeF9b94Ge4B/
	nwyfHOnTfQyDXmGGsorsMzp2PQ0P8UZU=
X-Gm-Gg: AeBDieuTfVCoEBzLN6ttVjSHPQztjJghTpe1Qma9kwaby16TJqu1iKB7DEIW7iG62WV
	vB4J3OcnGTNW5IazMEfJQsitQb/YAmXqG5MrE5JDL72hOROFX9h1vA4Iv9jjsImhaMRbn9CqiQn
	cb2uY4R+TzXZt1/oiTx74MGNETvXP5m+qnbwECPD/7LJHrzWCZT7vkMtSts/d+A9SrY0nhVcVj3
	wESiVTnw6c4zUwcLyyMevUvt8Z6PQ6A2+qCtgIiiwJl4COhWiaCJTwWAN2HljkAk19zTRLAKj0n
	x08tbn53puiDaf/2TxXR/n/60z0UzGtMJMXyNrbqP/c8IjfhXvFaHphbIRuAf0c4BCLZbvhlKxq
	UbEPhp7OzeOgIBik20WNG++hTBO/V9Cy8IgqD
X-Received: by 2002:a05:6a21:32a5:b0:398:c4e6:fec1 with SMTP id
 adf61e73a8af0-3a08d74a3demr4108458637.23.1776445430322; Fri, 17 Apr 2026
 10:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqqzohd0sh.fsf@gitster.g> <xmqq5x5py5ql.fsf@gitster.g>
In-Reply-To: <xmqq5x5py5ql.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 17 Apr 2026 10:03:27 -0700
X-Gm-Features: AQROBzD0rKhUfR8Vq4K38zqXxSvMJzChQUKE3KyG0uZ8-WIqI_kVFbNzqUtKXPs
Message-ID: <CABPp-BHEL4upLLjFL_1j7HRov5oAUxgofocU_6G_562biCp=4g@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.54.0-rc2
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 8:21=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> ...this pushout will pretty much be the
> final shape of what should be in Git 2.54 final (modulo l10n),
> although I might have another update later today.

I did find a pair of new issues in 2.54 (NULL pointer dereference,
read past end of string), which might be worth considering for the .0
release on Monday (see
https://lore.kernel.org/git/pull.2093.git.1776443163041.gitgitgadget@gmail.=
com/).
It is only triggered with core.quotePath=3Dfalse and some pretty crazy
filenames, so I could see delaying that patch until .1, but I thought
I'd bring it up for consideration.  Sorry for not spotting the issue
sooner.

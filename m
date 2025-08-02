Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548131607AB
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754157815; cv=none; b=rpBkzUTCOTVOQbUAyNguyKNQKk/gbS9kBoov9Z0f2xbHTva1uqM+jvo9q+0dBJxu2s5qhNcrwkIIIOomDx+2qVnqbmz1kTRVuDb3oXt6QqUMnZCdV/L0wFsYftD+xd0b114Ld05TIElZYIYoGrRx8oqCZE8LpMtyD/gEUG++PlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754157815; c=relaxed/simple;
	bh=e7P6ZS91ed/AolZKVIFJ7+baykc80Z6Y92BiagCJyNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/Sd6RqNHVK+gHlPcpAJG0eI+nXqCag6MaoZy7zyjFx7Vuyik24Rg/C7h5g4aOQSwO+kz6Lf+I/OgUjEM5sootNKqArfzTAGQ2RIm5INv4hAjJQO27QUJ1zSlToVFDLuMwlbhBqAqBQ4t6J9fQUoOK6mnN3xZH/5tcv7mCb/0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qlx+fc0j; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlx+fc0j"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31ed9a17f1fso1953250a91.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754157813; x=1754762613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7P6ZS91ed/AolZKVIFJ7+baykc80Z6Y92BiagCJyNo=;
        b=Qlx+fc0jr1vpf7FhQKhd0q0H5LG74B0wb5FOhfQOX2/Ev/eOGCIigrbsp6G5HCBzBX
         7PSrbKlOOsnNS9ms1q+oTb+Rgzz4lqtHiFsraDYXucuIljVvRhUMK6NKKIFuWvpG7RII
         oxZQQBqFYYIEkMAjtuQtfnZ9Skwal6hP2UfLp65FgyBhxo2Ndz+ZPxB01TbGQz/ANfCM
         YjOLfNdfTd2Jgx2wPhdsxuRm2lqeQYAJ2+L3Kg3mD3S65GwXLPGfKhTHvatbxaT8VI1W
         uEqXb5CCvlBHCrmC84bjgKz8+u0WhWEVpX8swOutco0U8Sr39ZQUjvRFSMoeYruVH7j/
         GqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754157813; x=1754762613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7P6ZS91ed/AolZKVIFJ7+baykc80Z6Y92BiagCJyNo=;
        b=wI/kKHh3dFjfMRZaiONhE+3l4Awbkh6oe30bhtkdPkgnlTPvEt0xMm7ByN37/0gefa
         WlKYjbWTi0blZGct6qx7zv9FCWsTSeLy5C9c4kQnRh233LAU0Pluj2WsvKrfm/Rn6V9W
         iKXh0DMuARie26pZ+AjcPRBMPyQEDbTXM0/aGiiCfHbD9bB3hpVasB6pC3Ivky763cw2
         QO97J2A6yzxk9IwzEQcCYTrn3aKL9IvEXa2HyYFS13iLDTDVV6DLbolu5NtL/5MpFsyj
         vO/YhI9dnOSu8OAE6lwLr/k7TT5Le/pQ/ADkIn/km28QRatf2wTaPrsN9vWw/OP4lhuC
         GEXQ==
X-Gm-Message-State: AOJu0Yxht9agfUhqVjzrDqfke6ES+cyHYv+AT00+fqStTz+9zCDpIngQ
	hMNvCc0lMa2JvgFhF3n8BZy3nIl7L3vx5mAcK8jkRXI8FKjcptaksbChHlk/H3RmsvDtXtHbtjv
	+1KY2QLNphXYFoz9Yonw6AXRVvRGcM36cMK/7kA==
X-Gm-Gg: ASbGncufGgNshDj8iNnfNDbEoWGYQFyhk8i3qU4rI+JPkH6cFsIYJkko9DjTzSc1Yth
	7tBzCk7NFoRGQgo+WapBQUBAPo5yO8HEzpDay6TY61JBSsL2PdS26zhKjRuM4/G1pdMr4NG9htU
	X7LaMfQDn5socLeWhtIedAQpeiIgGezarNNkLr926u/E0wSOGmy9mX1/YOaRlXSTwvvCYabQQ4E
	AvpY3PMazGLTnYQ3lbFLFmFgP96O3EKJVjl4pPk
X-Google-Smtp-Source: AGHT+IG5gBTABgZy+VYpOAkxXgepYG0MzHVoPYNKLwC/2frbbHHAFkIuXUH1nzlQzPCLHS6Ti7JrnJDkxNdE3/JDn4E=
X-Received: by 2002:a17:90b:3b4e:b0:311:c596:5c6f with SMTP id
 98e67ed59e1d1-3211629f31emr6480110a91.17.1754157813541; Sat, 02 Aug 2025
 11:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=S_8+LMsSpnRWQZwK2Dj63WdcPy1vp+aJ=erDbf_aaPoU3cA@mail.gmail.com>
 <20250802093226.GF3711639@coredump.intra.peff.net>
In-Reply-To: <20250802093226.GF3711639@coredump.intra.peff.net>
From: Justin Su <injustsu@gmail.com>
Date: Sat, 2 Aug 2025 14:02:57 -0400
X-Gm-Features: Ac12FXy2eBhADbjLZYg9D_BemPpYEdHYczwTKA_gY6dRJZOOg3KOz0M2aZaezpk
Message-ID: <CAB=S_8JYbFHJ6WQSyzGO5ns8Fe-NPCdyKjWLmRrsZ1UiZJsReg@mail.gmail.com>
Subject: Re: Fetching upstream remote fails if repo was a blobless clone
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 5:32=E2=80=AFAM Jeff King <peff@peff.net> wrote:

> Is it still happening for you?

Yes, I can still reproduce with that sequence of commands.

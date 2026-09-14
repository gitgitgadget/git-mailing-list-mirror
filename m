Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D039B48F
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369929; cv=pass; b=dgsVgNW6oiew9pv316hKKGMkPY79IzW3gxlUvqr66EyrarvFL63EY8HPChHiPMcJWQUYT7yKnXDfwxHzjdM/5jJDpSN3HF5g0TP2uI0vNe2ItPtoRkc2czR3o+pUTdzWh1mZEGpOVc+Kth7PnV6CRuByDi1D0r1RfHCl7pDPmhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369929; c=relaxed/simple;
	bh=icxbd1rPRSmzU7t5mXqklI9avL40WS/JEHkWJz/7P8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqa4Wh/EVr7eabXWqJBw2SRNw9gYhDYbUDoVk9MEDUX0fAcCaFsykRBVQXlIEimQbykEYkyGtqXAZR569TwA7TdwCXU7sUuYIqiMLp8DnCAIxqMbqCOKKICjXxvm+QfoUevHQ+h+MjhxdYqHCTCz+38SiFojoB5W+n5rIq7yXrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=NqcwBcnr; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="NqcwBcnr"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcdso12132047b3.2
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 00:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789369923; cv=none;
        d=google.com; s=arc-20260327;
        b=kFYS7UmWY6Ct4WpDKkMcUSvRsw9YB7shhFdkrRaP4mjj/6W/3f+M6K5lZOvoLQngo1
         oSChFs619zslTRPriwnIllK8TGATSxp1zsy3uT95NC7p/OKlyr4mpxbFnIt51FMk3eWb
         equC2FOrFeOnhBrlqOOYFWZh0XG4bfA6g9qSE9MZq/3XIQfQkVl1K5CFuu3/UcsGfMcZ
         N6tWQVMCDFyPCjI4G4VmorGpwRr28XiiRrklT7HWFCyqllvIU5fAPaaJy8LyFUv4PI/+
         vNLU7h2uhdz7zazcJ3eo4kdYbQBtzwKe6nYzJANrD4YdOH+WSTBDLr19JgTtVOON2z6z
         h6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=icxbd1rPRSmzU7t5mXqklI9avL40WS/JEHkWJz/7P8c=;
        fh=Xpe55vmlF54HhjEIAi9KFscNJkOrE6gMA0JmwkkzuRg=;
        b=YoOZqXBNqdXNEY2N28iK0cORYRANpRjl84+CRm4HgUsh2EvJbdOhXZXiX7v3c7PhMK
         q1c0cwTPLSolC6VYDn9k4ZpuhICQB0ThRe8OxqmEF1xRjiCBi8zX77urJvZS33IEXb0M
         uvpcObBOmpxAmvLU8TfsqSR1ANCK1wkSbY+p7+GvX+bxZKyGgAd9ZqiaIegwVjksE+wB
         cfNUdROLznXZjAMfBMC0W6zWnK2CpWQu3WZP5QKfcj3b3nWd0YelwOpiJx+Q/fLyfa3D
         7LRSP8GLCOhP/rGGAkLsHzO9J2eTnDTP/QJ2tmyMJ53XJf1wDtOXyInz0GWu5qMGptLp
         0edw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1789369923; x=1789974723; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icxbd1rPRSmzU7t5mXqklI9avL40WS/JEHkWJz/7P8c=;
        b=NqcwBcnr2DrxyJowHrZxKVW5kCUkPv/Lv/fWGGZ04yJCc+/yQgMBp4Gxh6xaOtcsQR
         UA50veO7qXXPDSbWbOD6nyVJf07WZHFwiXrWf1sCJUx+vsuWGqLKtp5Woxh7oj7UblOj
         aJkl4Fz8JnJ6d3OGcOrmeq7fgZYQyNkI4Cvub+gnram1bAG3Zr1jKy1j9DKG9SNWuKMk
         HEQsDj6W8vKw2aSZ8bUlftE8DCdrHhdTECI4vbIO9q7vVKFA+5BN/FGDqzDuVixewnvD
         eezs4n2GvJ1sFcSSbz1tx6MZpsl6BnG67DxXz/TidFtlnJnlh3orJ1wJDfudxMBtuiDR
         mSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789369923; x=1789974723;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=icxbd1rPRSmzU7t5mXqklI9avL40WS/JEHkWJz/7P8c=;
        b=T//Z8juMAsgrXjULAV8luwDr/ipjALH6KJsRZqUaw+/J5FcWfPdBEtsDBG7TEn8rFR
         OWCX41mEO+Vfzr5Y5wmwI9Q+38udV8Y/2hv7FRmgAUL3VUj3G7kwaYIrf1s+XWSDLNOj
         dXslXcyNi3/wkhgd8qKmez70A/oY4AlCgLZsMVCJf7kITz8uNVuMqYiIEmMhtIvPdY3G
         Q/CLBMQpnvSs/LDY77Hdxmu8hkfN1ktT7sYyXn8pHfDRY+7bD9QdfTNhSgwd2q8/fOeF
         thSNtUvyeZVxfNN7PSA6Y6JviBrcBktA1sw0wnC7T890PQB7MtKmq0D6nhv9MTS0DCum
         KDBQ==
X-Gm-Message-State: AFuF++k8/3ZHyHVnYw7crS9UGR8QdW2E8/GQidCFzHzuLHp+iMa0HEaU
	ycBcwFAPAa6m9BCcBzimw8f6VhPjDbJMlxfmKvLv2Qyb/YpfYr9UkxhLixCtNjznt7kB9hjiybn
	z7rkc2B2Nc89TA3SGJcd/K7EhUAF9IZ3Nuj8fGuWFeg==
X-Gm-Gg: AYBFou2neBv6kMuy2S69SPCLlgdTqqPWScZdFU0CZWg1eITyZYd3KOcSwR/jSpuVWbR
	2lNTYc5Ano1P3O+u+fPlfv9Tkxdj9I9+wKw8TB+D68Mcv6FWDNvmQ54+GuYhqduNm3w1lx+8SW0
	YO7IkJg0xaWkVMWN3Z3qNdL8MCdcYe5Arck7Mjg9C+Yvgh5jjZeuO129g0FcWGqBO6G6/DS0IUG
	KaQsvzAmok+XBLJ/rJVfKoDzadccaWpDw4bz+7G6eyAugKtp821+mZLFtgu9wTf8MOpQf0k6A6o
	5V0aP0GdSwHGhDFqoXNRh54E8mbYOrq6TKclBNbbWALBOVD6ehxrWn1qL92noXOr9okHfCxp4rI
	Ri68f7L214k+FaAryYpSJ5eHYR+75FkNdCGL4/lpWcp5biTrSqkT89Q==
X-Received: by 2002:a05:690c:e208:20b0:80b:9114:3b7b with SMTP id
 00721157ae682-88d229f7d17mr4032097b3.17.1789369923398; Mon, 14 Sep 2026
 00:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com> <031b3bd498bd5efee7e0d9752a6dd36fe7a55360.1788942331.git.gitgitgadget@gmail.com>
 <cd3d98ef-ad80-405d-98b8-fc40e7c5ec9b@gmail.com>
In-Reply-To: <cd3d98ef-ad80-405d-98b8-fc40e7c5ec9b@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 14 Sep 2026 09:11:51 +0200
X-Gm-Features: AcwNN1XKiP3eDEfpn7sLZJJfGQuSxcP1KQVqYzVjkUS-KR_mJnYTkuQUO1gxvEg
Message-ID: <CAA0xjtr6FjdsfhfDbBW6OaxUqKpUo0prWE_SrLD_-0UBGfDAGQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] sequencer: disable auto maintenance in spawned commands
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	johannes.schindelin@gmx.de, kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

On 09/09/2026 16:40, Phillip Wood wrote:
> This is much more concise, but still sounds a bit strange to me. I'd suggest
>
> When the sequencer spawns "git commit", or "git merge", those commands
> run "git maintenance --auto" in the background which can interfere with
> the sequencer (e.g. 'rerere gc' holding MERGE_RR.lock or repacks
> deleting active packs).

I'll take that.

> What's this trying to check - there wasn't a conflict so
> commit_staged_changes() will error out without trying to commit
> anything.

There is one. In this script topic and main both add F2, so the pick
conflicts and the rebase stops before it gets to the exec. The
"--continue" then spawns "git commit" for the resolution, which is
what I look for in mid.txt, and only then runs the exec, which fails
and stops the rebase a second time. Without that line the check for
no maintenance run right below it would also pass if nothing had been
spawned at all. I'll add a comment to the test.

Thanks,
Thomas

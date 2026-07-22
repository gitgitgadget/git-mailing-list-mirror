Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078C18871F
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784755949; cv=pass; b=cE7oQcTUEKXeeufQ4S3YCVrJ1zf9fBMlgni4SUqpbKBWOh8/L5XB6SVvTa38APiNHl0uNOH3ZR3ia+BMDWKCbuQ1cumyUL3WWI183/4wxD6AMAQCgchmjg1b4OPxcGJKJk3r9Ztitz3IvBX3fJ4oRoIBXaWL4+xBbnUOg3CLRWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784755949; c=relaxed/simple;
	bh=ZeYTiwlkAphIrpT+io7oNGAB2EUpJQKV+8Uk0i3SBmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqVuWYzKMPtGmCChAIqRPdMGZ6FDHR3Wi/Xf2fPTnfycaaLtBVtEYDA4dXtZCkHlcSBLeo1QTEz25fa7TvgPowXTSegSEAdV1J512V5bvL1Z2zBInEiOPL57Ruttkg34YOlj6W8tVKYKxcYlOxJgDqRGLf0+2IfXA7faWt5tfJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=infzTRzw; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="infzTRzw"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so17815200a12.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 14:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784755946; cv=none;
        d=google.com; s=arc-20260327;
        b=QPdbz8yH9zHay9ADVOuKXWqPRW+59Y76uPCnLKhbtsxTgDVGV2cwYJzZxMRMl6UnFB
         tEu8o7tiHQRoHp7ezy2htv9BVV3FwvWKJ64wgjblO3yW0Xy8s4pzzrOcelJ3kl56n4T2
         f6VSeGJqDrt2fPhS0eRfn2qlM0XmjU0HhAyEEydxwz4hzeJ1xLpS7HDOId5KF/1wyMGD
         5EmCSFAO6bRKsOofB6If0ICQ/LVSyMaIJDNbbK4CaTdvx0si2vrPvhatNLjyApUulQqU
         P2Ol/1chyWI3uwUpq0PYp0yEmXgfmU0LO874ruxG9Fvze7V+yzPrRfJn0ECGbBtfG/Ew
         4tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u5azqv2WNviCPLD5zMjdiuJQHr+Tf477GnfxXy1U2L0=;
        fh=meqMFyHkGmL1WCrC5LhAw2a+Vopba3nZcCh2Z6kqUfY=;
        b=d0mjpmCmFeaXybfuF5r2vfcj1Ro6OzJ8fu2sugPjLndg1LhY6oIYmtL/DmmmO9Ngon
         63TIA+TCI0lZbS3XUHDSuoO0YMr8gFZ1cIzwDCT4d7TEN87HtWLokPFpUSZSxwGYkmg9
         VkTdxnHKVgHUdYtMUNY8sRFHHNff9ZzFgTsZHKUz1L7kx0lef4qVGQZyLd74017gqQMp
         a+aberzZnzLsJJA0h2UPnbuMvD55fy+SSq2YUL6RhszYJU3oaqu2segobdd9QCGjmcBY
         qqhWImyE2IarhuN3q/j/n1zhrUyZhJAxsoEx/pZGu7KOcprRK5XsksnEHV/MVPrTGcIe
         Je+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784755946; x=1785360746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u5azqv2WNviCPLD5zMjdiuJQHr+Tf477GnfxXy1U2L0=;
        b=infzTRzwyac+sVt/hIes7IekoHP7oVEgAjJmvD1iy74NQ7Wn8Z/pfn+Gxr1+X/20cA
         C+hP/1o52Xc1PMs5zyM2jXWHVrcaN0hnXww3C6jAxTuPVTa8wY4MyOZzSjtFll+G1iIK
         cGOfcB1YRKBuztZVLDNvc2JbqAa35R0J5M6uWI09tIJZF9KoFRBNA75pa8afhQdgFSt8
         8bPthHBwF1zJPknZpkodtUZ/JewaPyKaeOYeQLoIDt1F3YCLTfRoYBkvKyK/SFWn+NwH
         A8LVH+viKKrfOMao8NMGZ3q0vqqJHvKw6N+sKtRe0PR7f7h+GtazbCexCuavZZs1xKSP
         virg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784755946; x=1785360746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u5azqv2WNviCPLD5zMjdiuJQHr+Tf477GnfxXy1U2L0=;
        b=Ilv3ltbtuYSPpVQ132cH4vN0qmac6IbH+6helL3T7JlrW6gJ1hAm7i9XK/RerL/PDj
         yWW2Ehz6OKE1/BEkcAp2NX6jv9lJCdGRBPnvsBFBty8u0wbzfCnk878vdLKHQZkNAPd7
         g858SImmxlpM89oYu26hnQ3swkxqFNbP4BQ2/iUv3dI8Nn5h4pB46ZHxcI84pHjGUYpk
         QiVa9zbjR4txPIC08B4WDbKRpg7D1dPx7rlCwGRIjngxD10clQjOFwDGRawLFGJNilUX
         tEDaclgKbA6hcZe95qn2ke6uZhcEOw3lHOupG2xFsZwm/pJuM9b9vbG94sYr72tiZ+EW
         Ajbg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf/BT2pZEYKrsdu06ELVhu4FbRtKw13NTfZypEuusztCK8mpRvI2sbSGY4WwwD/60K/h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxU8rD9eo0d+UriSxsmqGk8sPxsue9Uhq/qDiA83+V6wsCDHtk
	p2nuTJRy9UR8YUzl0e0QxU+H7aO5zyHaQj6zefUhVaCFTgxt1KvLSoXzTduz6HgCKegNWaQ9Wou
	3yvy2uONcLZ1FE7rPoGiFkCaKoaEhTCujNAWh43w=
X-Gm-Gg: AR+sD12uGtIUtmYF5490yH8dY6uqLsYA9f4UmBK+6eGHuK5qcBuVi/rOnkU+EVAET1T
	cSumNa/FYxOTG1BHHJ2dPHRbVd72R7hYfdf4/1oPNVyjsoZWI8RStCnuXowA9KdkQFlITvjrcz/
	kb+8mhfKTC2J1HDMANXzKymkILkDUvTZXRtW/aqChE7C3OwuFCqE3Le5H8YW923oCI757o3Z3h7
	WZP8mNdCi+/EC9iEIF91dqpxPSdJm01p3scLzFRv+HR6AesqRhuGQY5RQ1cfQ==
X-Received: by 2002:a05:6402:3888:b0:69e:98bc:b74 with SMTP id
 4fb4d7f45d1cf-69f6ab4372amr163107a12.35.1784755946138; Wed, 22 Jul 2026
 14:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com> <C6C7AB29-7027-467B-8DCC-3443CC356628@gmail.com>
In-Reply-To: <C6C7AB29-7027-467B-8DCC-3443CC356628@gmail.com>
From: Lucas Zamboni Orioli <lucaszam0@gmail.com>
Date: Wed, 22 Jul 2026 18:32:12 -0300
X-Gm-Features: AUfX_mzuRRYlThhd1OJighKuHE5Q0B-ff0lHXNqPJAybTtG5mWwpM3gi0LYTqkQ
Message-ID: <CAH01Q-9vWb0j3=W=vZ4yrAvaofabeZH2hYR8m_haviqZnp6DHg@mail.gmail.com>
Subject: Re: [PATCH] mv: report missing destination leading directory
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Lucas Zamboni Orioli via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em qua., 15 de jul. de 2026 =C3=A0s 13:50, Ben Knoble
<ben.knoble@gmail.com> escreveu:
> I suppose this still allows a TOCTOU issue where the check succeeds and (=
with lucky timing) the destination then disappears?

Thank you for the feedback, also great catch, this does end up with a
TOCTOU issue.

>
> In that case, I think a worthwhile additional change would also be for th=
e error message to diagnose which file is missing (or at least include both=
 source and destination).
>
> Now, without checking I somehow doubt whether rename(2) tells us which en=
try is missing. Worse, if we check afterwards, we could have a =C2=AB TOUTO=
C =C2=BB :p where the entry reappears to confuse the error diagnosis.

I think your suggestion of including both source and destination in the
error message is a good solution, I verified rename(2) just in case and
it does not provide the information about which file is missing.

So what I'm thinking of doing is change the error message to

        fatal: renaming 'source/file' to 'destination/file' failed: No
        such file or directory

'%s' to '%s' seems to be more in the pattern of other git messages
instead of the cp arrow style.

So for v2 I'll split this into two commits:

        1. mv: name both source and destination when rename fails
                (the die_errno change is race-free and always applicable)
        2. mv: check for missing destination directory before renaming
                (the checking-phase/dry-run detection)

The first stands on its own even if the second is dropped, so I'll
order it first.

Since this introduces a new message I'll leave the po/ files to the
l10n team, the new message adds one string and the early check reuses
the existing
'destination directory does not exist' one.

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793355291;
	b=2jFgz9SHkRmiB/AEGiomxhTkmujUy5XXQ8fb9/B76UWdAXUhnY8k3SS3wQPxyYOTee2e
	 fFzxl4RfCqg/KbWSUMUZgyi9KK223zXfikT22wxbuKBbhoqNoVTDmLYMMu82b6JJfLelt
	 ZAap52NnF9EJwg/y0aCt9vl6uGQKBGGQcIDqSv4/NRTh7GPvqiMXc8BXbgXYhsO5WeUa3
	 dYJnZnLDyRQvSE4new5L6LPvLwlqE8T+tX2moUNioFmUL4koJ8Vi+rz9UtBNPLjeJOGc/
	 0xX4Nyoy/xCXu+OG6lczErUN/krWMFgldvnqTBkEn8OhF09DHYI8gs7D1PdOCUIjEvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z2CereNKYdKbeSoqZjLw59d1EX6qufZh/2foSVVJxxM=;
	b=cSdF1SRqrAtUSweVCSrgLWNo+qLBO8zfiZUjG4GoGOur1TVR4sPcG0vyuO+LVKC25FDN
	 hG5n6ZE/GcPjkM8VRHTzGR1m9fYRbEGVZeYQ0sG4SjLzU9ZYC6RvrAXazr9GMCvb7dB2A
	 tTgybgq7ORcDDS2yFefjxhYGCUH8TT3vCrp2GKAwohD32XeDRzC6WsVMAZHLHq7ki5qh/
	 fOSPoSGs+89o/b7LzgTdD2Bn8ZOd9i4+CVkCUqDSb0jI8gkMK8i9e2CHuhKIm2MiCRx/H
	 p2lfGm1eDi2PsI377CgWGUs965ieva5G+jl4Enyq3FOpHrrutkCmntjDz36ILpGuc5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pkujzdka;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACD606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10ACD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pkujzdka
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c411e139259so41873966b.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793355289; cv=none;
        d=google.com; s=arc-20260327;
        b=VCeLG3axlBPei+2lbqOt5Dylycci6J3OAJzW+NnIC8cQEO+I4qb5xNBF3xal/fLTl1
         NJgncGGB1hlo08LiYgx/5GqXSkW48o4VWe6UBi/PAATO+vT1OvQkw0JsrhGSCayzdAjZ
         80JOnSN8OjPAqLtip3BeKK0BFeesqtG3YSk8tR59w927nKqlSl1BlRcuMsQeHoDtHyU9
         Rjf0dQA4mWenthywGdKM8EeGMxLCAFMymxsoJmkUdKTHDJ09CFt1sYaMy2jZovpHwFre
         7TwDSW60fVaCC8hZ3A1d4vDS/ivsvexK5yAznox4gr1S7T+HF9ezERylf4dKZxLNaPE+
         eVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z2CereNKYdKbeSoqZjLw59d1EX6qufZh/2foSVVJxxM=;
        fh=5UlTQ5dTSu5jTytgZq3B7xBqRb4CTsrcI4A8eBsThfU=;
        b=BGR1CtBSlhrUq4dftQMacyHJ2OjlL85Gf3qxND/sgrp4YQHXkUrJXVa6vSna+R/IP2
         YnHxB0iD0LaFZ86BSBrZEE+nxj20POSRyZTtwc4cHNAaBW7yYPWG+EEdqWOn9CZhtB7o
         ZuEhn22ojQZjOKrAW5ROLrYgk/A0T/whm7xQ9x1A9AcEhc8A90DcKmUjBFrgOIMwrAVB
         8tZ14PiEbio4b+yXyAsbJPEZr0d1lvaBrPiFwucCGTfIPYR+DSWSdwz2GbplTYpHapSk
         OZA00R/Qb3YKHgqiU/p6Xi4WhDfqxYsiTQgcAygAxm9EFhOJ40vhK1Wyo/NIEexNodS1
         m4PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355289; x=1793960089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z2CereNKYdKbeSoqZjLw59d1EX6qufZh/2foSVVJxxM=;
        b=pkujzdkaHAvAkmKHxR4Dk6M4Zk6E4u24vxyCcnHHuDtiC08g+RQJ2OuRJLaZKM2/OI
         GfxBX8Pxf695RoOfnu4hcK9N3zYymacvIZl8EwHx6P/8JNQmxnWKKVwttfpSz/aeRbzB
         Hy1aYqWszFg6sj20YZ64HM4rwdLuFgU+nkous776uG7fYfHdKEg+xj4jNBs6SdMejAB3
         p23lSVOwCZ0viGbgyOppkzW17AAkWhYcJIweBx4wpA5ZukAcJKju9iYFt3t5PHC09X46
         hhFzZ0B9KZ42ZNLTaudWcjqyknTyCeGarkhqfsC+6xoD9uPIn1ApuTzu9dSu53eGvt6d
         p6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355289; x=1793960089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2CereNKYdKbeSoqZjLw59d1EX6qufZh/2foSVVJxxM=;
        b=cRPaDgb7sJAyoVPTDrURLsV8FgCRTTzcSb85M9hAfaRHdsIyQuno1OLxdf7UEq2uPk
         bivDdutibfaPUGJe9VMFit5Zkwd/e4L5VAt8dBri9yC4Fx9MyC2GCdJgJOPiUsa+wDDU
         IkQVdPnMq/iS0J8/CEeHTR3jXr6/WPjuSYlwrQ3SGMImGvJAYozbLGJQEqCngIKSrnov
         S/odrideRp24XOtcSTiDWHBTJBLkyw5kqPFhwUZkMShXj3jZC2/hLF8zSXmFSZLinekr
         YVS6Jp606NivTAF9sjqknyw+zB8z+OYFlUZojvO3bjMRTzEv5nZFJarnWmRWBCmvs6w0
         FF5g==
X-Forwarded-Encrypted: i=1; AKwUvBy1fk/TuZoOb6p6cglSvg3fYWOJeP1gJ2DTSJHVSRQkX2gCcTVcsxfXgggpLOSi9vTYfvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZD3XwEcewUryIdzWoASxPLCv8LQD3MkbHKYJnUGhRZPEvdsSE
	h9LZXQf6XCfRS1XTRRfEb4NeYcTQZQxh5/AhzK5iNBPGmg1FeY0UXVdZH4OpZbMhhIWDyKqcwJ7
	sk++1af3m3TVxa+Z0UXNtSaBCUdgCLCI=
X-Gm-Gg: AYBFou2EEswXNiuBU8BhRKdHGLcHqJLLwLEdaoyfETffpx8w8Bb/ZkgjxqzFfCmx/81
	UepXIUwenBUl7+P3bVRSn9PvBYpW8wWrUL5Akf3PEm+VEW5ZaWPu+vUDGlYmIVt7s0sQ2h4eFJu
	thPxhYISh2MlM46ZrWSIroLqPgSJ9kqHAXrZn9H/+8BpU53ci20hifqbsWdRcitw5Fqfk2vdj1r
	OLiLiO58uenzMcr6mIKZqGmTxkCpS1siQ/U6SiJyjsWVmz0wDqT7hRiecUTS/DgSlUZD8YnG8a8
	cEYdSxOhU6rsvN15MskattdEC83NTozFhbW/jJLH6gQf4ucYraK9fFB01V+me0nEriu2fiep1hS
	njRkgMDZRbEpiqcAclwNLMBSpuH2SeBCwdlkz1R47DUBUydB2TJHaPVhTxFJH3myM8VsvYQ==
X-Received: by 2002:a17:906:4fd5:b0:c46:7fa4:922c with SMTP id
 a640c23a62f3a-c4ca7b20e1fmr161936466b.24.1793355289414; Fri, 30 Oct 2026
 03:14:49 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com>
 <E50044F1-41F6-4FD8-9A22-A43FF36932F2@gmail.com> <xmqqmrrwywq8.fsf@gitster.g>
In-Reply-To: <xmqqmrrwywq8.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 30 Oct 2026 12:14:09 +0200
X-Gm-Features: AclHuK_-CdP06vN7WvBfSr-11vVKAjQycbte47P0QZIggfxWQ1jrm6_bNlgydBw
Message-ID: <CAHwyqnUzKAD42qTMbAV_9DttzP91PUTjHxXehy1cX0=B7e0cbg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 12:21=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Ben Knoble <ben.knoble@gmail.com> writes:
>
> > Yes, I would love to add pushRefmap atop later! It would
> > ease my working with notes, I think.
>
> > Yes, I would love to add pushRefmap atop later! It would
> > ease my working with notes, I think.
>
> Tell us more when you are off mobile ;-).
>
> I do not think I planned to add '--refmap' support on the push side,
> even from the command line, but I can imagine there would be
> reasonable workflows that benefit from having one.

Not sure if it's related to this specific conversation, but I realized
that @{push} is not being resolved here, so I plan on adding a small
fix in a v13:

```
--- a/remote.c
+++ b/remote.c
@@ -2018,6 +2018,8 @@ static char *tracking_for_push_dest(struct
repository *repo,

        remote =3D repo_remote_for_push_tracking(repo, remote);
        ret =3D apply_refspecs(&remote->fetch, refname);
+       if (!ret)
+               ret =3D apply_refspecs(&remote->refmap, refname);
        if (!ret)
                return error_buf(err,
                                 _("push destination '%s' on remote
'%s' has no local tracking branch"),
```


Harald

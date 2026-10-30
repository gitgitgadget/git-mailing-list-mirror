Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793356719;
	b=bYNqWMiQ0q8AtPMxJJox5ApZOeILHH1Ch0DoC2RZ1AMMSjkaVomD1i+bnvpgUulrqxQd
	 Qsl2peFYFq+mxg1r7kQJF/3uZNJP3dfAEPAQ+jH3b2FzXwWCMXAX1wYQ0mogM8X7T8tcI
	 vzFhv8/Qs31NWxRpFRAI4Cn3O+WoMbN/L1D9LGhgyzJp8Dk03/ncoDQ9G8uW3zev2Tb9A
	 pEQkP6pfXv3LzXa1t/JUAVMB6VOfBDR1/0lPZMBCr7QEd9AAis50tqRwXTvB8ClNbkKmr
	 DzQYLHMqUxww2oyPmCKZlX3/PpiU89KGSfc1jdLNEEBjhNwh7z9EriXiuLfN05BDoRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=w8B1CiZMPoyzpOZbBjzGBSISnlpUxI+SsDrWjXNpDZw=;
	b=g4uNAQniLyewyvcwOBlqa5vwuuGqoUDXsqnty76+q/UbB1UzNJpbcbuJWQQ/4gCMh9AJ
	 FZPH5IX3qjnI2LSEBA13kCh2Zc5gNdLL18VAH4yFGJETNOy9PL4iy/7YgrZxpGHf6y6cb
	 PbT0NMUllQ/CNB49b/EGjskN1wixNFiReZu3Lr1srpfYfWdT4QxxotbbNTp/ht6SRrOQP
	 Gyr45KftUUUckEO1YPoBxIBKvycC8BzzQ/6bGr/Uvy1kXvTl25egYsG3UYNtVZNbxSIaN
	 m7+aEnVozFI/UpFPxxn9369H3yvC6FM9FLmLLdpX7h6ilg0ijNzXhAv0Da7U91gvFSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzaNjG3G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392B606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7392B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzaNjG3G
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso145486137.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793356718; cv=none;
        d=google.com; s=arc-20260327;
        b=ax0Gdblm8SDXdQL8zhIOu+2Tm9FK8D/mgKAmpe/jhFjwMh8aBFMiy7ZeC5ZSZLKAP1
         +wHly42ZDnfnwRiRmZ5qyCw3/dgFHIxisZCqfdfQGEtXwJsL7beXUWkv22Z5Tk6v+Ost
         FAglWbDjAhvYc8xM3yvbCAcj2O2/vRsTQBZbywLWZcTuimsRH53LHaSK4thhjWOk040L
         F4XMoejYR56OxJb7UX0sv+XxjhR/G62mb7JayjkvLYQnj+41zvK8cZ2tE3iP/QAyBjcy
         JZRzZbUhnDrq3J/nntdqIk+CWHMuXKRRwSYtQX53am3s2/QBKMyQc0FAcbiL0bckTk/9
         kI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=w8B1CiZMPoyzpOZbBjzGBSISnlpUxI+SsDrWjXNpDZw=;
        fh=9eQbt4i3fowvuj2X301wipABxjg0OHhpm9ECzav8zW8=;
        b=atg17KRwrfz9qp2YtVOcAgTgagfsnklI6IcH+lKzIRXwa36ASxtwq0q1rNU14qVD8H
         ILZRnKbAMXPCFEpZ2Nce4H7yXxDH/bvDDYF1VHXJDdyW+H3QW4G4m2EptDqweQtxfUJj
         UGdlEmMu7aHOa/N1a74andHocAB5HLHnb7sdsAqSZbN6/wUkQ0bUq9cjQGthqyos2QuG
         Nd9cauIanyA/jM9aeBprquMQ+utcmVv+2+8IuHN4wks4bhJxPX8lP+gJRn777T69iTaC
         fQdOjSW7ExmzakFnsWxFrfL5f2cXDxngCYk4bHBFQStTutE7thw1VQsQPYT5oOX3omnd
         7Oqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356718; x=1793961518; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8B1CiZMPoyzpOZbBjzGBSISnlpUxI+SsDrWjXNpDZw=;
        b=pzaNjG3GPuD1zTw9rBr3Olhz2crQ7eSIWW4/t/R5dEhl94RryPhOvZqIUImx6xi5i/
         TPoJCTIyLESNnDcq+f0kW7SfihTMljYuJBbrwmg2OpYISLYnzOOB8y/ClSZySq7R/NVe
         NA8mxr+H5yYSF4dr3JwVdkRgZW51Tck1rmTlYEe3LqGnP8/GUnmjreTpBCDNWJ/3sdFY
         wCt7cLvPpWscmKKaMRsIxpTKFVBoVY2YCWyB95PaDLwgqvfSgjyjlw6XMq57k7c2Z5Uc
         t8Mxv3VC/HSIg/v5/iun2Ad3p6dewFZL3MWIol9ZI/O/0CBgQgvB3Am5Kor33+aVSDyP
         8KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356718; x=1793961518;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8B1CiZMPoyzpOZbBjzGBSISnlpUxI+SsDrWjXNpDZw=;
        b=yQ+R/YezTzASjkqtclzuG/YZrsFC6Ajq6tYcjVDJX4PWZm1c4H//5EQVZOekTQbdju
         C49lwvZKVAomZhoxISbcaZdZLDzYxvy3QTm8V31xBBhGiqGaG18P10zTYmeE4G8WOsfH
         45DLiiIISSDrfen7PP3/QyTSEanmNZKKFoEy+sfrTawz9IH6ZvC45nIHHUAmrj79DhzK
         zDpu/mI6BeAwITIdzPhZL0b6EYszsrO9q7add1V3C7qrA1Qwgc5v/PqZilI7k5ZRrCtZ
         U4T0hJHCIkh6X1CvvLXNjeaIjVH4OKOBUpDFNlx2ka4t6YteHqwUn78epV3lTwLJjzgu
         WUfA==
X-Forwarded-Encrypted: i=1; AKwUvBxwt5Ie5WCg20k2QHJxri6s9Oj9Ki1g3PeiajofUkr17/QWZiPO3kh9ZqPliCxhAJwrhck=@vger.kernel.org
X-Gm-Message-State: AFq9FYLft7AZ2ZqJcqTieBdB+QprSdZ3fidrVL4+DzC2VxtX+YLPN6m5
	7Nwca58oP5AzJBPMGbemuTtCgFXfcDWNlvi+BU1QSQIBb39dHEwR0IkaLebpn2zGo1w7aCecaGz
	C2qFukN+vgM0UqWkytpK04bU1GlLcDdI=
X-Gm-Gg: AYBFou2uS1pbVp5e+aqBJe17N6CkjB471tF4DJDdONL8XuWAYAeCQ+MgNNgdFAHn9cz
	4tRkh+qt9//rlO/+m1Mh33zlRA4iGQ1ai4owu1AWpPpqP4imLf4TOZU7bxBgR6tIBQiaCUsNGNb
	tW34Ju+5tFP+4YSVy9fPmfb8jFYtIu3ODFZzXQviBLrGHnzaL24k5r5RvwtbZNxtqGvzbE3m3Im
	x3Yz1VajYJnNyqEFDzFLwJ3FW/B9BYWUlSiCapB4i3PlM8Gt3btirALGqp8lWLxT2VCtDm2C88N
	0mk8evRnxtGvpi5yUXIL2wTg0qDnrYLwhpQZXTg0HKvcEMaKk3LxH7j/A0WljqMc7fjNu1zDWzx
	N4CZlpZdrzFj9uhIoGpnqRx10qZ4vAA+I3ApR0JU+bc/klVBUF8OdR9cuT2NFgudubAD6dmjdpt
	JIVVfxjvWT4GlGA+FTGX6VHhxJkAo=
X-Received: by 2002:a05:6102:f08:b0:7d0:5688:f511 with SMTP id
 ada2fe7eead31-7d0725b54c6mr943436137.16.1793356718365; Fri, 30 Oct 2026
 03:38:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 19:38:37 +0900
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 19:38:37 +0900
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261029232220.1245827-1-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com> <20261029232220.1245827-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 19:38:37 +0900
X-Gm-Features: AclHuK_Ncm7Dt66F5dRLTOE-tGhcuIO-yn96Pu89WFEK25drvOaXW1KgZs9Wbfs
Message-ID: <CAOLa=ZT_ZNcXztxE2gmTORD2o72f3u2i0Ptj5tgNzS54_V1MTg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] loose: fix migrating "loose-object-idx" with batch fsync
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000002779ed065f0c66c2"

--0000000000002779ed065f0c66c2
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> Greetings,
>
> While working on a separate patch series to convert the "files" ODB
> transaction to be eagerly created instead of lazily, I encountered this
> bug that causes an ODB transaction to fail on commit when a
> compatibility hash is also configured. This occurs because the temporary
> directory migration code does not know how to handle the loose object
> index file.

Okay so reading a bit, and paraphrasing for my understanding: When we
hae object compatibility setup in a repository. THe 'loose-object-idx'
tracks the mapping from hash1<>hash2. The issue is batch fsync, where we
use a temporary folder. I'm not sure what the 'error' here is, but I
guess we'll see with the patches.

For pack files this is a non-issues as they're content addressed and
individual packfiles have their own corresponding idx files.

> This patch addresses updating the migration logic to explicitly merge
> mapping entries in the transaction and atomically write a new
> "loose-object-idx" file.
>

This means we write a 'loose-object-idx' to the temporary directory and
we need to merge it with the one in the main directory. Which seems to
make sense.

> Some other approaches I considered:
>   - Storing the uncommitted object mapping entries in the transaction
>     without writing a file and only writing on transaction commit. I
>     chose to keep writing the temp index into the transaction so that
>     child processes that write to the tempdir could still append entries.

So the child processes write the objects, so they write to the index too
I presume. If not, we'd have to somehow get that information from all
children to the parent which owns the transaction. That gets complicated
/ messy. Seems right.

>   - Also writing mapping entires to the main ODB loose object index.
>     This also didn't seem like a good apprach because it write entries
>     that may not ultimately get committed.
>

Yeah this approach definitely doesn't make sense from a transaction
point of view.

[snip]

Will dig into the patches...

--0000000000002779ed065f0c66c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5c49049dec4c15a3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ya2M2c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzRMQy80eTlGb0xNMFlkb0FlQ3hSZ1hONHMzakV4cwoyM0Q2blUzejdS
K0M4UFF1bEo4YzNMSWNZWjFFWStycS9idUR4RmRTMzJ2SU9TMU1BRjNNeFdjeUNLSmRzTlowCnFm
QXRoVlpQc3g3NnJRMC9zanAzdTFXQjV3cjc2RldkSGY5TG9Ndmd3OUhFdURDQWtFQk9PZDlKQzgw
MHROVSsKaUdVTFdEYnEyUEZqT0F2blIySFgrRnR2aDEveklCT2orc2ttZll6S0NmVDJHS04rS1dI
YkU2cVhsZjgrWVoxZApDK3dkMGs1ZEZNbTZLQUpoTHJ5MktreVdmTkJQMzEzODUwRlY4WGFlWHQ0
cW1Mb2x1YUxzUDBrcXlVZCtlNk5ECk5yNkZqRU1PMmRnRDVIdkovZ3R3MFZCbnhpN3EwdkI3WFZl
UUtyelJTOVJsOXVyeXZEWmJRUStCeDRiZVVieFoKREl6M3g2YjFhbzZocW9mdVlSRndJeW5Ea2Fz
eVo3TWNrc3hBMW9ncHd6b002SlhYSGtEVGZGM2RmblAra1k0WgpzOVh5NHhUdkU0MUpxTzF1UHBq
Z3VPQmk4Zksvd1g5YityRG9IOXdDdmxIeXhiY1FQMlI0ZnBaQVM3Y05XVHdHCkorUUZldFpodkRw
U3QwR2J2Q0JJTzFVeWhFVm1HVEx0a1JlUTVCWT0KPUZLOG8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002779ed065f0c66c2--

Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503122BB13
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730450; cv=pass; b=mGGjavb1auHWuukP3AS6JVVl2SW8/iT7mOxck24AM+tlH1k9OusY9ZS9eATQEHSor+HehK1qVVGAYhKY9gwdPZnxhNP8yb4SFv2G7JdRHPiszxQ7qYfe2MKZyVOGTuLwwiY4Z3BvgcfpKzQV4gDWgwGlTKwwBwiJ1uVLla5c2Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730450; c=relaxed/simple;
	bh=TOX4aGtL4tiOXtGnK8wF09WQzlMFIwet/UeRrhyFeR8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3+nyEqEMRHiApHiDj0Dqm75NaSPLveAI8D6wSGO0gHPo4Ec70aSGhVTrESwrUPbOSQhJx1lFWUalfLEEHYFAUBMu5HHTPf+vwJnODAqJSR7hxHVtJIqE3/nJQa8OF07rDRQ7H2a/8Qnnr8qVPDve9LcNAtLEAByE4MxYGfxgPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOWlweMB; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOWlweMB"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-953ad5a55b7so427117241.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 03:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775730448; cv=none;
        d=google.com; s=arc-20240605;
        b=dhG6vBG/B7JGVhdAtyOzcIq4Cdr3EG7Q437wBgHjkhlRKaxWgVDZzRwYBUaONH7xC8
         qBD1A8AItKgq0mnxOx9srC+oZC+FlQTNmXsAY46Y7I1tVwT+oLMbCNZ89MAq2JQEL1UZ
         mLyjxbKKOby8X3oVBmaj1NYKamfHnjHXQKjfRXIcVkyz4RbikzmGK6EILqV3lj/w8bWE
         UwAnqYyOGBfMCvyTOhFyw4KedlyqO3FcQJ22j1szXJES7iVklRxws22GJKAIN9z64UCl
         ja6GJvqDADz1CK1d/PUrUYqY3MGSxIXHSdNC7XrBlfXF4clifF1oAc5sgaqc27W2B6eJ
         79Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RY03XCptjkdutiQ6JQPoKb+yvZ63bNDLH7r8vd1HzBs=;
        fh=zPZwCkXcspNwHmqqnBbxo5Myye//koD976nmbZ7t6U4=;
        b=egsu5qu1Fc4MLNQbgtMhDjITKgy4bDyM0N1i9k9h7vJKXmvDF/aTGnVwKWE88n2yIu
         huYGVb9vPDoL55IBsuanZ0vsuekpkiVJVGn5cAqCpl18f2GdGtLfS1cr4uqyrKpZlXwl
         LL+5EiHsUIBecL+zdPS5wLoB+M9unZaVAhM/vu3Yn89N8LNSXWOdePmbkcooEUEiDJYh
         WpTrFEhy4+UCCE2PHGvcX30g99E5DKWQlQXQzm2khfwz3FoLU3T//FzrSR2jNsYdSlLP
         YU9+p8pFHFV8J+6s93PGLowDGW70yv8wv6TkEs7U0ckTt9y0B4y3LCvxZWTN9GgpYx6A
         rcog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775730448; x=1776335248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RY03XCptjkdutiQ6JQPoKb+yvZ63bNDLH7r8vd1HzBs=;
        b=sOWlweMBcnttuweljwMo3pw6Q/bKkswMXp0PDSS9Cu+uaDbkah+RUdeVzGRVRQz8hg
         pGpeZDmA1SciE3rfA4NNdMiNrKZWr+b6WhCjOTQCmmWLoqoJos0PZGfdO/8wGgFFQcYv
         RqrnOWY+gbEYX9bBNLM3G15p6TSC4AKFjeea60e6SnqWL8E2IkTyGtBxHz+Qx0z+OjzS
         ibWj5mDfPaU9uobIAkr9xRpTvV/xIzJZQetMZNqSe36/h3Wk3QwP5KsAucVRyiwVGm3u
         1CzCOac55NiRDycfxJWavsCXltX34uqiC9kBQ/saqzmqEV1pIZB8xYyehhZ+EFUzlF1r
         cTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775730448; x=1776335248;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RY03XCptjkdutiQ6JQPoKb+yvZ63bNDLH7r8vd1HzBs=;
        b=KRdS4kbQYS0IVfGL3soXMHLfUiOadBYP3szJmAreUUP/L/HOPdvRdO8QV11bYfvQt7
         P47D7zv9aOgr9+BG9Sb/QmrYRCKuS6rUfboFtzhz2KGmnH9slq2t/szIQPZMDzRHATK8
         3e0MoRwES/+CApbXDfBs5+kkMUk9Ngh8ZCKNj2ilOvYQ7HY3el2cFrgLbWvSfvms7zhj
         tg0nWsPpTY+NoVFdBv9JEVQBdTeo1WEDMLcHPOwOtvfYUPNJ8R0o5CRKC/2lqadlpBwf
         fNUWK+RMRiTaRi/ybe/CbyWRnGB5P8sIYPG213PvheYxN80gT5oNAhjuq528DbZvhJh5
         pS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2+T8cX15ysFPlIfosPen2780VHeYPKHm69C2KeKtMu3IA1J+TfamcXzXCWxmPjx0PhPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqaySzmlqAIyC3w8V8kdnBogRRvG5OdpggoMwkJx0bFK7dlbs
	yMiNxtbmXLpZ9Jxa4JTrWzAFFe7gW1hncM+CiP8ESJwwqMFonj590zGgG4Pqjl1HOx9doeaTgTs
	WxcldmIDlGFi3bYn9+bLPs2Svzt3Taug=
X-Gm-Gg: AeBDies1EDMcA7kOYR434VghKQs/MDRLmQW9SXvNn8zqaOYIK1tQIrH0VhsdKb7XW0N
	SLAcoznAUgb2BXFaN+SnNJTYsLOOt9cHawHpOpIrNpPFLnfNE5/KfBubKDbkdsv/HvUhnDTqqkk
	LjQr1Sa6s12KbNPkLRZFEy0rQFgoqg4oJh+bzvKWNZQWTLF5EXnl/J2bXUfRoHK7qVLx4XYiwdu
	BQaarABfvg02DEkUnL99PeEoxJYPv/oDymHqDWpZQ3hyCIMvGRs/XOXkUUHLcd4yAO9RNsrQW1p
	wL+bEhMbZrFHiMVfUQI6e9uBLr7ZxZR4cQIOk/4HvUCOKvFBFzD/
X-Received: by 2002:a05:6102:3707:b0:5ff:e39d:9f93 with SMTP id
 ada2fe7eead31-605a4e180bcmr10118965137.11.1775730448138; Thu, 09 Apr 2026
 03:27:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 06:27:27 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 06:27:27 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-7-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im> <20260409-b4-pks-odb-source-inmemory-v2-7-f02b4f1c0f13@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 06:27:27 -0400
X-Gm-Features: AQROBzDsKul7rSN0KGxPYuR8ASYpkpxx-TMaaKT1Zy5AlDHJ6E8PAx9fq6oVxuM
Message-ID: <CAOLa=ZQHyhDGGLLcGBjFwG9FOtvjpyjgmrnOO_u3rwZyAYoDHQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] odb/source-inmemory: implement `write_object()` callback
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009420d7064f047632"

--0000000000009420d7064f047632
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Implement the `write_object()` callback function for the in-memory
> source.
>

rebase error? Seems like the commit message as the last commit.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-inmemory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index d2fc4c4054..96e8efd327 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -1,4 +1,5 @@
>  #include "git-compat-util.h"
> +#include "object-file.h"
>  #include "odb.h"
>  #include "odb/source-inmemory.h"
>  #include "odb/streaming.h"
> @@ -112,6 +113,8 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
>  	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
>  	struct cached_object_entry *object;
>
> +	hash_object_file(source->odb->repo->hash_algo, buf, len, type, oid);
> +
>  	ALLOC_GROW(inmemory->objects, inmemory->objects_nr + 1,
>  		   inmemory->objects_alloc);
>  	object = &inmemory->objects[inmemory->objects_nr++];
>
> --
> 2.54.0.rc0.680.geaeac8ef83.dirty

--0000000000009420d7064f047632
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 49a2ab49e9ea1810_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWGZ3MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTBVQy80OTU5dUJuYXJ1VWlDeXZQSy83Y2UxRmp4RQo3WDZhNmxnWndq
TVg3c1p5MzNzL1o2UE9TOUpRK2QrdXl1VFQyUS9KVnoxMzNET1dnYzNHbTdab0dsemVxMGNsCmo2
cnBZL3dmaW55b1NuU3ZKbk5kTEJ0Uyt1bFhncEpnYXREckdOZktUbnIwRVlXUzlSL2pNQlRIR0ZS
VHdkYkwKM2hQRFBVZ0pIcnJuUDlIYmRhYVM4djBGSjUvbG16Y09KRUkxaU94QnVlRU53b2w1K2ds
VDVaN2dmSUppQmlzSwo2bjNvOUg5T2FLK3ZodnAvRGJubnVvK0FGS3RvWWVRbXJwNFdmQTJsbU9t
YzJCZUtpK2Zvb25ZYitXeG94dmNmCmtTNVJtMTFvNVIyZHNVNlRSLytmVDNVMGpHUGs1S2JYWmdX
SGlnTkNWcmRkem41NFRjK2I5Ymo1eUpXeW1BZW0KYXB5ak43QjJBMlJJcVc1d1JqZFRBU1FaYWZK
KzVubDBScmJtOU5DM3JKOENONk5JdTIvOVhyVElxS2xISDdXcgpqNkx0MzNQR2I4Uml1MGpYdUhm
SElwRFNuVmFiUm1STVVpSDhpQlBsYm9nVGN1Q243TnNZMEpiLzN5SWFBeXg3ClN6ZFVNRFdBSG1I
K2p1alZLb3RhU1JUR2ErMk1NSVMxNWo3d3lNZz0KPVE0NkwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009420d7064f047632--

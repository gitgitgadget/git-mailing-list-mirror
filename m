Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490891;
	b=d55jbDe/jNClYjT2kJNBq9T3/1G17OPl7k3USI7QkA3MqxFPuFC/7gxBZe5lRyZ1J02C
	 0L21MFaep77iCMtTqLmwJF7BS/i4G27oYywasDvKIynmWZkJOJKD20PZ2rX+hvxFL8C09
	 Z/Yz5NkEvWy4XiYbQ/XqL5EIwV/2Qag/bLfiCpgtlKXPUgzEZQQn65IXcCZ9Uej5bXzg3
	 C+Ct5S6d1ox9IN6OI/86q2KehfeYiHnz1It6W6EvVbe0kBXJeZGNszNZLfvdZd70QDnyC
	 S0AZ2tbrHimZusc2f5fJhRrO/bTU9kZiQHutrIheKxgfI4NKo8vO/vj04+Ox7htLbBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+sY7B0YQ39OzuXfjsMo6bO4Fy4VVqRTIenYgVR+/4bQ=;
	b=SWPf2uN59fsYqN06zgN2QiEp5N26o4Q8q+rU0qF3B/7ExXn3xwBGy+XtvMKp3JC7ARPu
	 AiplkUHRwqmmnMST4KuSmV+Pep9txlwUo2PWdeJWz1/Hr2fXu5dmHYvYyIC1NyG1WvJd+
	 /OGIovYjgysYZtf2QGIqklJPPjQveeNw/xuDv8j9TVnbVd/cB90r94124ctB2m3Ap9GSF
	 Ff86L8jkGZkHbmkVQ7RJ4kXcLr211wfD6ZLv0ud8f27jguXISeo2OnXxgjnSAvd89C+b3
	 vo0qTgXxPtsw3j7iONuf6t3KgnSlFELP/6b/MLixKdthT4UBCCz8zwzvM+lnPE1O9Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QIwZDNdO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F9606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 746F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QIwZDNdO
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc91ddf447so1671102137.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 05:41:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490890; cv=none;
        d=google.com; s=arc-20260327;
        b=BVGYBBq/4VoThFTzZdetfMulSg09ce9jGeAgSyM0V4HuhtE4IvpatmbCONsUJsFWbP
         Hpns7FjkDYVohJ59sSQJFEsH+6WagA0oHrAUSA/Ge/tF/zTir3RxgJdLmsFn3dnHNjQg
         pls7nED6t/DJQFZIxblYEo5uUOp2anA9RuLYwiCPfxVudtwDqADq4drfY9a8ZAOojuuK
         3dbmbFXtrf6FIpCf7H6LLP5iIKocq6vq0WK7TmBZ3rn7oqATvNHNEc/rtB9eJg9zHo49
         g+1MgTROupm/6EQoOK5gbVrKkUPL+NQcDBgR/iI6pTPh/dG9Z6Le9BKStUH6qFYcJCYb
         lELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+sY7B0YQ39OzuXfjsMo6bO4Fy4VVqRTIenYgVR+/4bQ=;
        fh=AU3iG3yTwSYfBR6+ee6tJ6Calz9q6I+e0SfOUDkcPSo=;
        b=YM1/Q6Ay0MciyANvX/SlyhoFJ75na59EeVjm5eBcb/4tXmWJOu483pxP1X6L1Zrnup
         qimOFaOOttuk+AYrNQtRMCQ1upoPIV2n5ZQ6eEjsEk7ODjjg3nmg6ZLQc//Mw1/jXr//
         o52U5kOQVj2NpAzixiohoaGnOhyEBTE1sVpXq5MLNI9Yhqu3pRkpPPPF6opapgdkLi1x
         pwkT9NE7//FIDnE+C2Co0kAyPalNsChFCy+Cm9qMXltWemA2e3AMTnucPVW3Xo9Q6m3g
         jhK3pNWGC40U+rsoVgQ/Y/tbP1P+ec0maMwDeBiwkc+XcvtOF4qLPsggO8nirNf0MTq6
         qoUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794490890; x=1795095690; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sY7B0YQ39OzuXfjsMo6bO4Fy4VVqRTIenYgVR+/4bQ=;
        b=QIwZDNdOR3QWK1VweEJkwp1ia5GUv8kwvdowCmLnCbzzUiCR/lsohZri0RtwGVLBNl
         UabSwxsrsljN0g7g9j1/pxm1vA3R6ZVbtMm2uB8KY9t90K15AEGDJTDOpbU1m/xmrdDd
         y6R1N9Pg6FtWTAyYj2xKsnft2c5/v8tKkSGAgYX4GXZ8biHjzDYJ07egjgDBjgOB8gx4
         0lsdfEdKc4BOPyLQB40vEH/jEuAF0KMzYXj2/ca1wzMV3MN1EPcwZEl6/3zlyuZMDa2/
         rupGzNroOQIhxTKc9+2E4RdK+xyWw2Bv/sWJfRCsZP2bQnDnuIOzQhzJ8swP0bC1FW4P
         7zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490890; x=1795095690;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+sY7B0YQ39OzuXfjsMo6bO4Fy4VVqRTIenYgVR+/4bQ=;
        b=DcwRrOIX2LEt/f3DWFuxHuw7+iPkECtE/yCB4q8+6GuRJwZ5bKY6qOofjb6Y3M0+vQ
         tKSuP5sySxPPnG657ipo9tzbEecUEnptMI2K6/dk/eY0bcDePi8epSkOJeiZNHo4U5WR
         9RvljDvR4vxf0OiY+SJcxVHxJredSExX8H7nPqv8iZAcmsG/pB34WZk/arQPRsl9QfOE
         +btqsYiHsGZ1mGAvAyjsy44aSafQOSCnodUJMS5ouaUAbLTQe6w991PdZkDyyb/wS6/N
         pp5UrVlSX8dtifFlB2849TnrJaV+fML2A7rMd0NoyM6Bh8nUnF+3bbGM/KjEetksHTvU
         gHlA==
X-Forwarded-Encrypted: i=1; AL+hErEFNoylcJCEW2k8CplWtmOYeul0hiLVFbK0UYmCyI+7bTPliRfbtz/6Cu6NBjJ+6XV2xsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TCQKu0rVvJu5FEMvjohtKMsIdB3HU3VXPrL1qaAdriy5wBMNI
	D59AWq8+nexMAR3nhKTS5Vw5js5RlggxpQeOA51cKRu+BX1NGIemHk31ReyuZEgVz7mR15CsIG+
	JGHmywPbGOudIFBWxPcEhvR1BRPQeemSmZQ==
X-Gm-Gg: AYBFou3HlSdE1mfNTq0cNg9qyX4awxyKB+LRJ1rkdIV3mJ37cMBeLNr0hsI7UO5ZRzk
	/1KzjlHefc328+wvA0+7YFtZkPRFuOwTllbmd3d247BG9kgj8gbTjMd+CXO0l2bMPMg4irORXZ1
	Op5n26y5/XxBv/mzso2mShkqCdfCEb0hbun89Fb/TXtH+lDkfS2hxeaGzf2WLCoIPo3+dm8TZ8Z
	d9izFKJ85RFApv/IHOh/OcMbt6Yffm0qkAwNn7vCDW7pU6MMOEsAUnjA06ydqPCp+VVLceNuz0L
	ze3vL7zcaxjBvhMyTT6UX8Kco6wV2o56S+gaWscmRYNMOqBKQHBmYhuyxIjE9AV/t37mHOs6zaG
	SmTTDWvKVpwmq6/GB8fIt7bkURZRyEZtYL1+5I9QYQh+Tu05US2A46MQUoe2s0h2QuU9dw3AjqS
	ug68L9wxVfxc6j8judLXcxBSVHtCg=
X-Received: by 2002:a05:6102:2927:b0:7c5:4da3:aefb with SMTP id
 ada2fe7eead31-7d50611c6f1mr1835828137.34.1794490890216; Thu, 12 Nov 2026
 05:41:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 05:41:29 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im> <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 05:41:29 -0800
X-Gm-Features: AclHuK-bs3OmMG862SaN-AD3lgv7toQjhL11Jl-KBVUKyzpvbeFTR2VI4_7T2ko
Message-ID: <CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000001086f206601478b6"

--0000000000001086f206601478b6
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> while reviewing some patch series around git-rerere(1) recently I was a
> bit appalled by our custom subcommand parsing that we do here. This
> patch series here thus cleans up and modernizes that part a bit so that
> git-rerere(1) behaves like every other Git command that happens to have
> subcommands.
>
> This series is based on 37b3475fb53 (The 9th batch, 2026-10-25) with
> ps/rerere-remove-global-state at b948c10c8b3 (rerere: get rid of global
> rerere cache state, 2026-10-23) merged into it.
>
> Changes in v4:
>   - Some more polishing for `RERERE_{NO,}AUTOUPDATE` documentation.
>   - Die in case both of these flags are passed.

Definitely a welcome improvement!

>   - Link to v3: https://patch.msgid.link/20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im
>
> Changes in v3:
>   - Clarify what `RERERE_NOAUTOUPDATE` does.
>   - Link to v2: https://patch.msgid.link/20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im
>
> Changes in v2:
>   - Document rerere flags.
>   - Rename `rerere_record()` to just `rerere()`.
>   - Link to v1: https://patch.msgid.link/20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im
>
> Thanks!
>
> Patrick

[snip]

> Range-diff versus v3:
>
>  1:  e9237465706 =  1:  f669dc6eddf rerere: rename `repo_rerere()`
>  2:  94d91a0620d !  2:  4fd3f6aa650 rerere: convert flags into an enum
>     @@ Commit message
>          around as enums so that it becomes trivial to see what kind of flags are
>          expected. Adapt the rerere flags accordingly and document them.
>
>     +    While at it, detect the case where both `RERERE_AUTOUPDATE` and
>     +    `RERERE_NOAUTOUPDATE` are passed. This combination does not make a lot
>     +    of sense, and it's not obvious which of those flags takes precedence
>     +    (it's `RERERE_AUTOUPDATE`). All current callers know to only pass one of
>     +    those flags, but let's be safe rather than sorry and `BUG()` in case
>     +    both are passed.
>     +
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>       ## rerere.c ##
>     @@ rerere.c: static int is_rerere_enabled(struct repository *r)
>       {
>       	int lock_timeout_ms = 1000;
>       	int fd;
>     +@@ rerere.c: int rerere_cache_setup(struct rerere_cache *cache,
>     + 	repo_config_get_bool(r, "rerere.autoupdate", &cache->autoupdate);
>     + 	repo_config_get_int(r, "rerere.locktimeout", &lock_timeout_ms);
>     +
>     ++	if ((flags & RERERE_AUTOUPDATE) && (flags & RERERE_NOAUTOUPDATE))
>     ++		BUG("RERERE_AUTOUPDATE cannot be used with RERERE_NOAUTOUPDATE");
>     + 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
>     + 		cache->autoupdate = !!(flags & RERERE_AUTOUPDATE);
>     + 	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
>      @@ rerere.c: int rerere_cache_setup(struct rerere_cache *cache,
>       	return fd;
>       }
>     @@ rerere.h: struct rerere_id {
>      +	RERERE_AUTOUPDATE = (1 << 0),
>      +
>      +	/*
>     -+	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
>     -+	 * working tree but don't touch the index.
>     ++	 * update the file in the working tree but don't touch the index. This

Nit: s/update/Update

>     ++	 * can be used to explicitly override "rerere.autoUpdate".
>     ++	 *
>     ++	 * This flag is essentially the reverse of `RERERE_AUTOUPDATE`. It is
>     ++	 * invalid to pass both flags at the same time.
>      +	 */
>      +	RERERE_NOAUTOUPDATE = (1 << 1),
>      +
>  3:  99faad47068 =  3:  48692c2c88d builtin/rerere: drop `the_repository`
>  4:  f164c482227 =  4:  e76991dd39d builtin/rerere: stop passing flags to subcommands that ignore them
>  5:  0573d2323e8 =  5:  2474dca4713 builtin/rerere: turn "forget" into a proper subcommand
>  6:  2098dedf4fd =  6:  cecdbb1c63b builtin/rerere: turn "clear" into a proper subcommand
>  7:  e8eaa2b4092 =  7:  54fc766f9d2 builtin/rerere: turn "status" into a proper subcommand
>  8:  a5781284b8b =  8:  fa2c839b2cb builtin/rerere: turn "remaining" into a proper subcommand
>  9:  9a4278df0ea =  9:  416b8311ca9 builtin/rerere: turn "diff" into a proper subcommand
> 10:  e63b9be0d74 = 10:  adb2b68f833 builtin/rerere: turn "gc" into a proper subcommand
> 11:  47889896ecb = 11:  a12e19cb2e8 builtin/rerere: use `OPT_SUBCOMMAND()`
> 12:  5e16a247b49 = 12:  4b1b6170ba3 builtin/rerere: introduce proper usage strings for subcommands
>
> ---
> base-commit: 710910c03a22ac663885049213b9fef5853ea8e0
> change-id: 20261027-pks-rerere-subcommands-318d41553438

Looks good. Thanks!

--0000000000001086f206601478b6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 19f44f958ad5829d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMXdnY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1RlREFDQXdtQndRWjRpNHRJTzNNaVZnSzdOOVMwbwo0OW5uTmExamNB
em5tWlB2SFN6MXVxMExIbkEvYThHN1QrMENvZ1Zydjd2NVJhdFhtTEhVTEVuTGN1bXdLOUpsCjcv
Snc0LzU3VFhxQ3lBNzh3VVRvKzQzZDJIT3Z0REF1QUFlUlBqbnFUVVF2YjNhRXN5ZkZ2UkNjQlZJ
dE4vbXcKRlZENDg0cHYwSDdvbDVwK3RWUll1OHRzbG1mUU8rd1l5TkhxQnlvMFpaNlhiN1RONDYr
djM5dkowaVRtRzY2RQpaUjZtSXJjMXJwUjFpdE1hNzBaSEVRSzVCMFNzWHlvUyt4QkYxWXBJa2l5
SmJ1YXovMm83cmVZdXFxSTRMV0RyCkJvOElFV1U2VlVMeDR2M2ZreDlZMGlwR2VyRlFWNTRic0Js
R3NHWm1ubWd3ODMxZ0R3NWtjanBNa2lHK2xjRG8KOVBkVXpJVVYwSVFjVngzYjd1VFNEaHIya25K
Qmk2ZGczeUlVTlYzZTlyTGhBYjYwamJuRC9lRE1GVy9kdG1RLwpTYmQ0cVdTbG04bk04Wnc0TXY5
VStTc3dwd3pnRFh0Q1hWVnliMHNad3JSTWVGWmdQdUFtTE1Sei9nbG5QNjhmCnJnRWNHYlUxcGxu
SUpJdjNObW5qN1dBOHhLSENjZ2psVGhyRml0MD0KPVRQbEQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001086f206601478b6--

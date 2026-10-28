Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203970;
	b=1gy06045bfDbnPe9dGHcjc3O2jYWfqc4gI9aj5Ib8vV+sH0M3Xoeu2Fqg/0y4mB3OG3s
	 Prw9zOZRfazR77VVE/ppX27lDXlhNdzziAShtnMv2w/qHtf9TVGtjuuJeSZFwYaYBKwhh
	 Yutwrda2PqC6kAjiI99DNkmFjK4EXlNdPnrfNb6POSFwtqdq48thu271Bu7gFmuGTHPsG
	 PXT9q1EKHmXC5w+JzFxh9m2jeYeddGp06TRglDZYn/iOM76+3jKm4H/miaIYuehWc4Jd0
	 0F0jfYoaPsWAC2zhXHy5a70Jxd7PjIUo0fiTtQY08daBdqM+fqKo2a4aIhtemiYGslw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203970;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TfUgQoFaKZilz+iVByIrReftJ9K0C+0b6vH+R/WPQPU=;
	b=hsU5hZa7k5ZkCKgEsNm8mNtdQNIXVdUag1q6ZFxwlSyuYhYoQVF2fDrUmDMZM4bZZP0T
	 MRGdR4AjYP6SCnV4h/0her78uEGs2nQ9r7yJKgzJXgwRN59VFqHXLHV+KAcYjUvkDTI5h
	 IJeC1vATQJiZZTvBaoR6xAPYboQtCAD/cIL2zt+6mqZxymzNa1ep+Dd9cT1iwxbnZQzz7
	 8+FOv2Upy5da9t2eBHXb113ppBWMGyt3fEzRXqaexPKNVqsTwnpBy3FAD6D9geAgo2gJF
	 b4mvuWHKvXeVN7SIJxKIPbEZ6t64IAZczoIRW1chaOEumOFf9lK/GpM2LFNJED4+Obg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=krTNmSaV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hqt9ZEKl;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A6606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4A6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=krTNmSaV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hqt9ZEKl
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9776A7A00C1
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:12:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 28 Oct 2026 12:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793203969;
	 x=1793290369; bh=TfUgQoFaKZilz+iVByIrReftJ9K0C+0b6vH+R/WPQPU=; b=
	krTNmSaVGzVw3zLyVi6DnYg1rGTAnww5WHpKScTyWuO//Rm8Y1C7jR4Ikb6b0PKF
	dDaHd2pFljy+O51hK4wRTmvirOYHJbD+i5AQ7Fdfiq2iWkNj8VMoZzY22meahNRg
	53QVeaUjiYqfzYxYcDT4xwLPveRSd5H+3iE2d0MoWmMwEct5/r8qlULbRwcAFh8N
	Xq0EP+lgakKcUVDZEaa+JvgHHh2KfohAYAHuAYdpgoDqTp5IFN3fhKd2iZyP5BWo
	f8L7GnoSvgpYFU3kU8QkpWxVJwxoSnATDzpxw62kuE65YXpR+7IzGQHZljJ3am2Z
	p6b4JPCbO0RJfB/7SH7Yjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793203969; x=
	1793290369; bh=TfUgQoFaKZilz+iVByIrReftJ9K0C+0b6vH+R/WPQPU=; b=h
	qt9ZEKlTYhs0z4ldNEsBDSoFgdwb5vIlqs7KOZt35AYCxzoeSMAW2VENlPaQ99AW
	Y/HpelgpboC3ELspWWMDcx3WfrjVxXjaq3vi9iHz1VL2RGf0qTwRfs/C/FpDi8vk
	Q2HvPoTAHpA/HfBGjdiwkD0B5IwateR1JhMs37Ya8zCWOCCkN/LNTzR1iXipQv4X
	/UNL1yQRH+XiAeIZwYuZ77cynJUi6WZNxn+/RuPm6ut/03ZDypmcZJoRzbtGYPpJ
	zAJa7R6R1a0JbSgzk/uE1B5WPVpDzy+SXLXI8iVxNG+uf+H6pLz0cQDyWMARY2E+
	WLrJbcEh+pnc4HRgzYTjw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793203969; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:F0ERr/pYeXQL7BQ0tRMa1oEu2xk0FdH+lhGrRlBSucQi7eX
	8kmcB1TsNslkQTxj0NJMTwYtZW3Uw885DoDKXb0U2ees9s7E6I0lmpI8LsSFIo6x
	FiQCCVuve3z9WWbmH0MichvesKJXdYtURhClWDqNbptE+S3Wi1uOXst3eDs0zfpu
	1CdjR2bJ1k40KIkV05tDoH7LajoFgp3m41qiVKy5mqtA3hO/8fvQALRAikuAeUMo
	47LTrd3ahPsuKHkfpc8mPq3QhUN7Z4L2lDoSM3rbcUjrZ8hr2EK+ZB0tykmXMkXG
	HkQYFwHjY9lQjzOnUjKkvgRy3IvCWktBGJc+eNw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Oz986JWcMtLUYarU3vmSqpNzdofjvRmozJi/LF/lrXA=:ytNe9InQUcpy5LiXyu4Ge3c7h3wtT5wMShOeaSSEpWo=;
X-ME-Sender: <xms:AR_ialJ8eivM7zep6uzRTLYke5tt58ePqLArR1AkjpHXX1vY2HCXtg>
    <xme:AR_iaoJbn6kAqyB7bze7NrdLi7PBZjE_Te0WelvebwU15qK-ig-MwJtz1cEsKkkWi
    rVEMbLOMK-i0oojVYZ0fwvDxAT9T-U8gtAgQ9ql0ckOcL3N6nhzUuw>
X-ME-Received: <xmr:AR_iaivQ0urQfVCw7MQpaEQuV9x9CxRpQOYHKnNXYif4UsHC0FNNL926upW94zR0BLj9t8YRSn2Ltuu0CB-8bHHsHQPcrXnlGHUM>
X-ME-Proxy-Cause: dmFkZTGICf40+PhT2El+V16uWBB1qEBgmApGuaoeoFaBkTDAlbyceu+COqFLA0sKxq1eAo
    TZfklfj6ZxYQlLxlHBi5w7bhLDWmjJbWMOjyt1y2LbkmjbRKJ0RQ7kMVZZmSgO5nx1p6Tp
    xKJmfQlqIovx1qrXdGLcwp3lDLkBUYVdudcwEbtMxH8lSAARUrmmtPRG9gMEuijfnNHRzW
    dmYC2LQMbWDK7upNfx7b5UWcEYeJlq6Y+3vqEa3FS+WGW9Zxn2V5+MMsEERERB7nUJkCmm
    V5UYIcaKwOxnXAV+y9lVdRxYBOr+r94riSeek5Q8uSJxfxcrjcYQMXGpnWIgkRRDnrbfYH
    bpV3lgkQrb5W8r46eTROhw8eTenunw8IPTA2X++weYbPWh8pDMIGqSe25io1313Ue56Pdt
    mEFAyZDMB1JS09ID98QEbBazQ288bWPUPzu+SAVe4d/7VV46/dACQP24/J/ueMl7EC1QRB
    9CzaU0JhSDyKkvE9LogLsTpqmQb5hDtArWUODnM/2vsKMuVGSTWm+Ya9bGJ5ywu9A0E9tN
    pj23NBtGN/EDnYL1bkQoKuBsJ2kGXbKO4KC8A/O9bLUIn1M/EX3z8TmomB7Qcry3q4eDqy
    QNO7bSoTwSV1lA4+alvFkZYjAXjb2pcfNo7+4AoSD/1GeDunVPvNM4GloDkA
X-ME-Proxy: <xmx:AR_ialRSjW3SF0lrhvAkY3WEHds44l9temJJfFhzGw-N6Cvbv9jIfQ>
    <xmx:AR_iaoO71Af9tzOfZpLqC2UDuMM7Tg7QiwRHGHM-ZI11ePHClOxUyA>
    <xmx:AR_iaqbWZTvmMqlS2rWsgEghYlxHKzM08F8XkjhEPm7Aba-DTBBWfg>
    <xmx:AR_iaiycKCavPbIioibCUhvUg_3W_kbbvhQP_5E5_hj5ZMVuUjKVGA>
    <xmx:AR_iaiO6AJrSqDi00xRBA7o_mHiyfHWfgesQNBI7LuEwQtR-bFNpSIlP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:12:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/6] odb/files: reload alternates on retry again
In-Reply-To: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
	(Patrick Steinhardt's message of "Wed, 28 Oct 2026 08:11:38 +0100")
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
	<20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
Date: Wed, 28 Oct 2026 09:12:47 -0700
Message-ID: <xmqq8q3hdcsg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

H
Patrick Steinhardt <ps@pks.im> writes:

> 3:  da5a24624e8 = 3:  8882555124e odb/source-files: reload alternates on retry
> 4:  13e4e857f68 ! 4:  64d76b0ac94 odb/source-files: simplify directory duplication detection
>     @@ Commit message
>              Wall Time    266.5 ms  ±     2.8 ms     262.6 ms  …   276.7 ms            -7.8%
>              Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +5.1%
>      
>     +    Rename `dirs_paths_icase` to `dir_paths_iscase` to match the naming of
>     +    the newly added set.
>     +
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>      
>       ## odb/source-files.c ##
>     @@ odb/source-files.c: static bool odb_files_dir_is_usable(struct odb_source_files
>       	/*
>      -	 * Prevent the common mistake of listing the same
>      -	 * thing twice, or object directory itself.
>     -+	 * Prevent the common mistake of listing the same thing twice, or
>     -+	 * object directory itself.
>     ++	 * Prevent the common mistake of listing the same thing twice,
>     ++	 * or object directory itself.
>     ++	 *
>     ++	 * NEEDSWORK: we're using "core.ignoreCase" to deduplicate
>     ++	 * alternates that _may_ be the same. This requires quite a bit
>     ++	 * of boilerplate for dubious benefit:
>     ++	 *
>     ++	 *   - Duplicating alternates should really only lead to
>     ++	 *     regressed performance.
>     ++	 *
>     ++	 *   - We don't properly resolve symlinks or mointpoints, so we
>     ++	 *     may still end up duplicating alternates.

Good thought process.  "Mountpoint" is misspelled, by the way.

>     ++	 *
>     ++	 *   - The value may be lying, in which case we might
>     ++	 *     deduplicate alternates that are in fact not mapping to the
>     ++	 *     same directory.

This one is much more serious than the previous two.  As an
optimization to avoid repeating work known to produce no new
results, deduplication can tolerate false negatives (e.g., we
thought "DIR" and "Dir" were different and ended up scanning the
same thing twice).  It cannot, however, allow false positives, which
would lead to "missing" objects that only the mistakenly
deduplicated object store could have provided.

>     ++	 * We should investigate whether we can remove this whole
>     ++	 * mechanism outright.
>       	 */

Sure.

I guess the previous round was already almost ready with Christian's
review, and this round addressing his comments, we are pretty much
done with the topic and can mark it as ready for 'next'?

Thanks, all.

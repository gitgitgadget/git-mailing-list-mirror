Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795068330;
	b=E4qw3Uz1ZyOO9qsRlPNQNsb8F52+TvHZ5GzOK9onXRcJZF60MKZP1rrDn0k2lZ3OzhKu
	 xO+h0lkI122NDedngYNJZjrGmpRbS7nZgsoKWvDRQr5XzfWslz2z6qAVAAzy25W6p2ucG
	 zpQ6DD4DIfVeo/jxwr8LeYBcn+ZdFKtvwRi6tTivXK1aAqFnp6IGe4j0OnnEnAyeExJCO
	 f8JmSjbfoDWoOOp6LbkdUifZ/E3/tKSVlUXl9CJM0E5ZAI3dpwiUD785NsX1Fq8rtLxby
	 uko51gC9FaDtHPjzJUn60P2yO5oyaEASYa73AdZxiySpWy7xiJx1b0piFIz9KMs/kQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3peen0c//eAYdicNj7AskgAUp6g88l7+3QmaUpFGN7M=;
	b=cetINzEH/GgkmANczOEhU4a80taPnLyVUwv9s8Zkf5G9M19z1JD1GIM50e8MV33fHQh4
	 x0Ufr2I7hvFyanSijQ+af/s0eW8EW6nFH/g9ujBDkiAKhd8G5iqt6opXJQnT6cZ1fTCH4
	 XHM/z01IGqxk5RYwkdlMNP6CyqJPqkdDX606lSKbL07vTW+hxMmZ/+yhkdm0sPLQWc+N5
	 ErT4QNPUWTBbb/Ru3Q1RS8w7yVU42F10AoxLJTAK3nRtrOsQvWvbRBO6YxTY881f069dA
	 LddnutKDqYdIFeJpwdojXBjDkH+RRbFgQrtuAKWiXMdQYDqNN5EfHjCrh7iY4f23x/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lVXWZ9Ha;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CD606A332
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C0CD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lVXWZ9Ha
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so18495525e9.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795068328; x=1795673128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3peen0c//eAYdicNj7AskgAUp6g88l7+3QmaUpFGN7M=;
        b=lVXWZ9HaXJxen2eNtfX7Vr757/F3fg63b0wgq/YA8etiMJkBC93GJ01cDSzQB5A6Z1
         DBmEWjg3azTaANjGLKQ5iVpAI38jA3RyKqOeJa9Cno0dtwKUxFCQF5LtVoJcHTsjPvCo
         BKfrEEVMc7Dkm527DUeBX/v/TvcV7aBMRBPuSgem4BaxLgvdley8jb0GFGA02r4GAcUd
         xVf/RmlHnovVvRKwqBogaHxu08HdeX1BkaicXZ2qGi1bQ018ttMbepeHNzWRTC2SEPkN
         rkR6tppDlqIr0Dpqk0cxPc8d1177/V+bvgnexTBttEHRhKPmFQnAdacD6cOVT8eYarQI
         YT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795068328; x=1795673128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3peen0c//eAYdicNj7AskgAUp6g88l7+3QmaUpFGN7M=;
        b=Cs9mn15N/z8nDuxhWEpRfzM6nzhCF5QzKKOo+735djGd9bOIG7Oiu0GXQUxrbzx678
         JGW2i+D5GuQf32C7S9P2KKd3KiRzyZehF9yKhO5ZMCKpG/milCT1SiL2mSForg8NXu6z
         8PHDJt5xtupaB0bxa8CQW7IQps1c+EgA1mZY5rpmpf9OIUD4aU0aJeAxFGkUJlhle+cr
         6xn5NQigTTJ7LoSuePQbLF8Wty9XbeCIWlOxOwpEdT+W6pVpKl+P7feiBuOdspmuqq2t
         HrdIEehqaXQTqUYJge8ynGFaeGVbbzRp6jMfgMKtAOTe+T9s08S1A3A4QhzoDRRkvqYU
         j5aw==
X-Gm-Message-State: APuU4Z/txXw5RpEce6xsEGtPE4SXq9k8p+tULifPToe1ysxIZO90ZHLn
	DWxcZDhvkFon4jtS1uQb91E8XFJtQvI/pgd0B4l6bBDmkIEuhIz288Yai3cpWg==
X-Gm-Gg: AYBFou2NJZNw6jZuEFpAUaT47PR5Nfdl5pxSZnurZdJjLV9QlMeRds24JFlsva2zGJh
	h2rRC1nMwa0bjnPj6Lv3P1R7v5DRCnbTuFE85fmbwqHLydfz5uJm4L6tx/LUD7eOqb5ROUKNvwH
	h2ZJEzoYl4GKx9Xs0UTLY7weUD5Vmw+fhm1uZ+VHHmlGYWNUXoPyn/3AtxUZJU+ZS0cgh3zerIZ
	dJMndvqCHyd04IyTTU4LombsRFby/CiRDmAXTDXUrIVom/I37UMETfEBqFLUjFk0fLXrgU+N5IT
	wYjRvUbbPQdTxL0r9VK1NwjYbUMviOFHANmCt23ZgsH7jPZkWldbenZCLLClk5ARe3RUdL3hkVE
	kNsUwjLXQHUCcXxHePN/sXkU1UhzpdJ+hBlAOtAditgT0BR8RjZzkJowFehSW+bbJN0codUsy4N
	hiU+OTuxYn9XSSjR65/jXyceR9hl/ZYZ34Ni+X447+4Ihp4Q+U+byATPspIbmYhsXHzE2LSLivD
	y/2ke5e4ytksHeGwmRaVKV1lEdbCu4t4OOaL22b/3wMO4r4Z6pPjPO4mkxHkigSEvgXOn57J+/5
	PuYSRp3tA46oo43iwbsYTcQsPAVQz12WV3peRagAhyAkTrqn5FGNO0XbGbWdMUY=
X-Received: by 2002:a05:600c:4e44:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4bb7da12957mr89913965e9.9.1795068328282;
        Wed, 18 Nov 2026 22:05:28 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a6570dcdddsm8006902f8f.54.2026.11.18.22.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:05:27 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] index-pack: use size_t in write_compressed()
Date: Thu, 19 Nov 2026 07:05:22 +0100
Message-ID: <20261119060524.775205-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <av2pOWbYxNDYvS9p@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com> <cover.1794984184.git.gitter.spiros@gmail.com> <9952f0fb104450461661b3f8b5f646760198744c.1794984184.git.gitter.spiros@gmail.com> <av2pOWbYxNDYvS9p@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 02:33:45PM +0100, Patrick Steinhardt wrote:
> Hmm. It's probably an improvement, but the only caller does this:
>
> 	obj[1].idx.offset += write_compressed(f, buf, size);
>
> That's a `struct pack_idx_entry`, but its `offset` field is of type
> `off_t`, which is signed. It feels sufficiently unlikely to ever
> overflow, but should we verify regardless that we don't?

It costs little, and index-pack already does so for the data it
reads: use() dies with "pack too large for current definition of
off_t" when signed_add_overflows(consumed_bytes, bytes). I will do the
same in append_obj_to_pack() in v3.

> Not even an EXPENSIVE one?

I can add one. It needs a local base of 4GiB and a thin pack with a
delta against it. Writing that small delta by hand keeps pack-objects
out of the picture, so only index-pack has to hold the base in memory.
As it still takes a lot of memory and time, I would guard it with its
own variable, like t5608 does with GIT_TEST_CLONE_2GB.

Thanks,
Elia

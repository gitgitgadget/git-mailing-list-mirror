Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793782705;
	b=hRwXB7KpB4sL/uEYL33zrViqMZdMJ0mTEWjTjPzPaVkCFmZ/8GY0WvN18HDKNLEmMDpI
	 a7bz2aj70qCtvDAD3MUvhK57QCDFdvngeUWlX6cJdGJ/fvkOLO0v1PWkbaT28HJCRxX2Q
	 LXM78w5feYS1nh0wNYcp5Fg+NyhjK92MnHgQ3vdbsRFgP1sA4AOQAW3Xc+JPyk7rz8Dni
	 jxJDWNfW95HSx+Md9U2zFTq4KGEkikGQ1hcPir3eiUQYRF5Lh+FIVcCwxhziFxtPwiEIv
	 R2yssLQURNSotZWYgG8B2TA1rsIUnwHNdrIjm9pqUN2U47HrDQs0eM7LevABnmh6u6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=ficUrWX2w+Npe4F5PPXl3GNQjdXHHWp8V/iQsB6LD9U=;
	b=T4SU0z12SkJARFL2yHiYf3XR1D3oeBI0BjYA7U7VQJpHkyX6RZhtF6uQFmO5AIOwVI2+
	 hW8CFiwm1eDS3kzA5Fw/qp7O16BzmivY0T2sSGbZoe9DXn7cDqH8wXiRJnVhdZLBEDNX1
	 Zf+pJ7oLKRjmAGlgAnEKlm+X5kIc7I0B7AoEjPgcUBDRu3JAaeGUfbJ+Fs5FanVdMgW85
	 9c4iQcAyqX5mq0utaCnQhyLf1nHi0EW8zcorW9Qyh2LKx3VgS6C7zFQk6CHCpgBa3vgrd
	 rG1Cx4BNZk03iT+ZifQK3WCwiCGy8nbNgdiTGaeTpp7J8c67/JZi/f4eaumti6CMDFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOnx9QUH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BE606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 08:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F2BE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOnx9QUH
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-990835cec4bso276115241.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 00:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793782704; cv=none;
        d=google.com; s=arc-20260327;
        b=lG4vazCupCq2E/cVGuzIB57HO8bnt58m3xgb0epnqyDXrgG4cHndiUeApmlMCrT1w4
         kKCbT0051FLp4Ohf/fNbWgA7Gx2kbfynePHQtnlpHsIT0AtSbTcsLb/6bqIo/vdcV+tb
         fFEKGicNoidSUq4SPEQVxpxC6UCna7eyOrgqHQnTMtQPT8uBVL/oeo+WF45Wi4XDPoBX
         TU6azg/snw/bz2k7WhOPlH7kut01GpfaBIANCoLMesaH101JAvOraAmALi/iRcimaK+U
         CvpwyiDNgT9Juhn1keYUW+zNcqQehEaxdBwOvq6JKD1hMxI+/d2dPCCZ6pUKciGIJOxG
         CepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ficUrWX2w+Npe4F5PPXl3GNQjdXHHWp8V/iQsB6LD9U=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=DMzqINh+VobkAYjuom7vFOR2yQV4RIHVOLx4vVIsd1NFqta6l7d3HzJ55KhcJQ6l9o
         35QPpO6fXvb11VOYY2nApUlZxJeL9unfxqQueeJtIS2Ru+MVMhR0cmBjftZI7WokROJ5
         GVb04ixPB0LAcMxgtRxQqcH47Exg5i7aCKTQfaef6P8l5t9t93DVFE2E48l5pAqed4kd
         ktx56aAUMO9YuJdOTciOrfZYmGEGH7ABssuTq23JXmlwtKxDQluTnv05UAWguLq/VUPc
         WpKxWHcS22G6A3x/mWoR/cIPE1WBLufuWCzgOQUBgg0iXoiJIjfGvh0uQIXSPKBKMrcL
         6zxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793782704; x=1794387504; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ficUrWX2w+Npe4F5PPXl3GNQjdXHHWp8V/iQsB6LD9U=;
        b=gOnx9QUHHK50D/RKRQDtRla5q6XLPTEEkyuTcZjtBsu0wRbLMKo9MqQjXOcmX0s7sL
         iRMMBo+8ZEHbsa6mCFpLfG8+mHUIV5ntUF+KbVYY1xHla8BeKqJDh/5XW9HUCUTPvgjU
         SrD0bTxESWLYoI5jeTAbYeYVtXpV4PjbnfDgwx7e/uLx8OgGgku+5Chn/n3YmMYc9Tar
         NMnwsqp1NCS4X3+UDhQYDUOmw363tcnIegICYOcEPxlHbQVpzLCAQYImljn4dZeLFrP0
         aPA/AURSH+OFT5y0MD0XafG3B8qcqMjrGPYBMxPDBQtPB2bvKlUtbUFXlnSVwTlzC/dO
         +5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793782704; x=1794387504;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ficUrWX2w+Npe4F5PPXl3GNQjdXHHWp8V/iQsB6LD9U=;
        b=p+sGPxLh6c8bYHap46RXqkZ8gdM6psqf5+/WFP/XBQAm9Xan6/l37knoxZn7Tf3SAN
         K7zNuxXZrVD2QrNQzpO5yA0PQ5tK/ZvtVYh6Fw0rgTIecWm0/2WYehgBd7V9kN7do78F
         Jdenuqx5uLjRAoqOCjzn6Gdxajgvhffh8b8rBGLvQow6TuFqSHgq3D5C5lsoCPMTAQ5Z
         cHHw416tED7ywFwvsy8c41XR3cL8H632XM9byQn0UP7ECeENmwbUwKFzi4rUojSeBpor
         cMJcWMo3mLsZtuRm5PC63PmQhn0ST3qYZ9b4VrzvKF6aGLBSpqZa8iErPTeUXiFsylxe
         JQMw==
X-Gm-Message-State: APuU4Z8JWUVJdRZuEg86JLaJD9fDItd2Vz4Ir1/AQIS6J1lAZMZ3rsge
	95EnJBAiSUUG9Cj7Wctjeglw5+BgYHbhuxeri0pIZCOTHOCGs3jxojKFWa67LMquUsnySh9PKgO
	nZWtD/II4LObpX14j9Z4IQfmrDlLp5gjUhQv1Bg4=
X-Gm-Gg: AYBFou2+3fFLUleirJp/OB6nBTWvWyPBRRqd0KOI51oStr9a6WxBdY5/VasXVbyodGb
	Qg5f9jiaxc9p+ZsXVkU5EuuDelbf5Oz9J/RbTrftpR6Gm3BlqcJArgyst98CFaXV+60Ry4zK5sg
	dygByu7Gp+rikcFZOoBthz7vfb+0ZqyARhiExo1rsYuEl6iSmBkiqP1cV6O0Td9Yy9LcLuS1fO0
	1xISEDrvXY386QI3vC19VaQftIViFzFO2UfU4Rjt3h4TeDZB2U326v+4NG+I9k2M0AenmbBopfW
	emHn/3r2r/DjL2ot3tcA2klhN1ff1x4FzDuqWChsLw5HfTOkiWucG2kRlC/viZlTrSXd1JTv48T
	QzoFTHaC4nXo1E15bKjfqTF2B/qba4G4/Yjboryt9vF4xY/EZBeFHKu8OCDqYgCT8q2dRi/7skz
	uHKDPQ/sdTd2/f7+BMXdZRDGQ8FgvkuuSTLTs9/eibN5QAmyQh
X-Received: by 2002:a05:6102:644b:b0:7cc:971a:61ee with SMTP id
 ada2fe7eead31-7d072bb37ddmr6855260137.10.1793782703989; Wed, 04 Nov 2026
 00:58:23 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Tatchou Yopa Nelly <yopatatchou@gmail.com>
Date: Wed, 4 Nov 2026 09:58:13 +0100
X-Gm-Features: AclHuK9ASPvbK4wK_QvH5aJfZdFYfK-ElbvWT0PurxnN0TFWgiIhjdL6poPnCbA
Message-ID: <CAG7jffxDguporrsGrB1Wv6K1DPVa4zbRpNjYNn9B1Nytp06RqA@mail.gmail.com>
Subject: [Outreachy] Config shape for promisor fetch ordering some thoughts
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I'm Yopa Nelly, applying for the promisor remote fetch ordering
project with Kaartic Sivaraam. I've been reading through
promisor-remote.c and t5710 to understand what happens today, and
before I start writing anything I wanted to get some feedback on
the config shape. The project page says to float it on the list
first, so here I am.

What I think happens now: remotes are kept in a linked list in
config order, and the extensions.partialClone remote gets moved to
the end. Then lazy_fetch_objects() goes through the list twice
once for the remotes the server told us to use and once for the
rest. As far as I can tell there's no way for a user to say
"actually, try this one first" other than moving config lines
around.

So the two options I keep coming back to:

  1. remote.<name>.promisorPriority = <number>
  2. promisor.fetchOrder = <comma-separated list>

I think I prefer the list. Numbers feel fine when there's one config
file, but once it's spread across system/global/local it gets hard
to look at and know what the order will be. A list is easier to
read, and it's easier to override in a later config file without
having to pick a number that beats whatever was there before. It
also maps pretty directly onto the linked list we already have, so
hopefully it's not a huge change to sort it.

The thing I keep tripping over with the numbers approach is what to
do with remotes that don't have a priority set. Zero? Infinity?
Something in between? With a list, "not listed" means "after the
listed ones, in the usual order," which feels obvious.

A few cases I'm not sure about and would love an opinion on:

- If someone names a remote in promisor.fetchOrder that isn't
  actually a promisor remote, is that an error, a warning, or just
  ignore it?
- Does extensions.partialClone still go to the end, or can an
  explicit entry in the list override that?
- Do we expect to want different orders depending on which remote
  we're fetching from later on? If yes, that makes the per-remote
  number look more appealing.

I'd rather sort this out now than write something and then have to
redo it. Any preference, or anything I've got wrong about how it
works today?

Thanks,
Yopa Nelly
GitHub: https://github.com/YopaNelly

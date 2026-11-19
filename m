Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071192;
	b=PCDRb0WpjtjxZklVx0sBOeZ2DshhBuRZyRMXTYQBNqziF8gWvCceUomKnEROemlJoZKd
	 Jpx/kgAOj3dKAtMyQiAvGUmH/YatMALv3LJGm7H3YWYBTSa9bwFkBN3ih2089QnfMoDdo
	 1iIleinCyYMvbwEdDLsSAb7znXWElR3mNGK2JYKCouWDXF+aurdJDa59ELVGNhPY19/Hv
	 Zo6e74upHnFo3MhLZ2GLcIzS+y9+GaoRGfHqZmMx81tO827Tw+7ljHJrJFaBeEed/BuEe
	 rMLhmdtyZJcZGt0cVN2hKC/9IGP4UbaF8YfBN/aweI8n5VxF9izbymomHuxrfx6M4RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ddoucRhbiMivw9eEUg9c9sjqdPev5slS/FFRwmLyOIU=;
	b=rBVrJsNGUg3GKKwDiczPI6kMoDRxnDVMA+vlP2OwqTs8QtsybCec9jICyZSFtEXQlYNR
	 DOmhP54ruy6kNFcN2W2Zjm/LJFr4WWVIGnYM1xuU4q8T4cXJXfOJA48BxAN2DJJ8h/7oR
	 wd3uC0O00C8foQdWDyJzuPrbOVwUTVK2xrjv+46kM4buYSKObht0hXA5XqZUiWLvWHigM
	 PDbSne85hgvL7p/HOZA7JySv6oskecAWwao3+mxlIBHDH0KcUjuKlVVDVOfbkVCBTYf6d
	 +lx/rb5bKJ5wRF9l8jLwA7L29pemM5dDOYZK+kLLHMoikquJ+vaLonIsXW4EM2G9nQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BafSnPgL;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B319606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B319606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BafSnPgL
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so26191355e9.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795071190; x=1795675990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddoucRhbiMivw9eEUg9c9sjqdPev5slS/FFRwmLyOIU=;
        b=BafSnPgLKAtT4JYfYL0Oo/I+hGZHEu4lwWnduVnLEya6cOf5Sffj1kdacymB3S9c4n
         UIWAVr+vIMXKsGdzm08oRUzq86JJNlkCXEGk24tK1JUPEp12PkeXFHDJuWhkCtmahG5B
         eu1FraBiS+ALgvUUq5If02vtPIqPHBXQqdkVh5OW+8jPZ9UwD1sgCh2YE+cypNNYleNe
         Gb/X50FPxXBms/X+aksgsFwqVp8Hj29sv58r/Ytva7Cy/0eyPySlXvtVPKQ4JNXa7r8b
         +lDoTm2rsLeuJ0I9b40+9jZkMXicgM8zbTWHWByAj0QQeyOHZ2Q7Ukwl4gFPDKSTdCqL
         JzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795071190; x=1795675990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddoucRhbiMivw9eEUg9c9sjqdPev5slS/FFRwmLyOIU=;
        b=O9qyMyiP4LqRN5arZ7saDa2eItoUXahhhpOgsKym4mewSI+XLbB7AyGZpXJhEfjcSY
         YCwBuodXnkIAOTyNwhREDDzPGbB65PAVO+gkpOz1726Yh4j1lmYjVzwpaaR+1RjCCiLU
         hW5yVlTcyV1z7qgv2L61wmlo9Whhgrth/fQv9f+xrb7vVTI0QzLoqufYRT3r3jIGzyrI
         Wf/TrWZOD/JN539ohlK8gQvP2pwm0cmGgRq8jej4U0fYMK3/ME4umO/F+vSwGEINens8
         SWkb21+MW/7yZYvLncmR3jzBx1pNN9P2C2Bc9OFGJ16Fbvyga2N2DpdE+LLJtF0TU2Hf
         AXBw==
X-Gm-Message-State: APuU4Z/BUFI0eFS/lioVkVPoOJSaiVRYRB8UwlNtY+NLZ4A7mnlbxxSh
	hTGcpYLVAxbT3DFI8w3QDdQ9EkjmWLIz/q1FiLdbfHROS4KwD4AAFk1J0SBtdw==
X-Gm-Gg: AYBFou0kbZPJI1B7ZPyksrAdtmur1A2OrsS3N8kyppO1nFZZiToTaVhLwkn8bd9JsGK
	1QjmZODhDm59TShQJMbuY32QWOPF5ij5b2KWQliRa9utRYQn8oRIlfruPYSTEJLQvLtIAygW5xI
	hRFPJ8cfN1hvHqd9yU761KZMXb39WBZIYCGOkEnlAbYh7GivTBdaKuGgURa5QPTDgwwYeMLxtW5
	/3S1V3BbtF393vhaqLuKgio+eEjuy4y/I8307ZqGv8YjUcq6S7Zv6YDxG7Crd2e2sogDJC9UhUM
	Aq5XYZARJtMbS+WAmAl6WfVY+NznWEBWop93GjIr+rdKyuuTCggqPJtYFrULzyQCFvNtf9Fws1p
	RDOwgaZldtvlpwKNTnKjeUQdql4G75Sf14SEqEC9TORqi2BrUxqYLt3NQwRQGkQV1zSiNMj6Z8v
	lI8DScptI+X5c9Y8duteF0cZf1B0BRPEstoC7ZGFyJ9EZRuEE12duebNW/2eO7AE5SkRShhin8+
	+8jcqfpx+yE+LzqjTFmsrXjfdhSb/2dZH3fufcON7gDQRoFgqTzZrP4ZaFKrJkTqEw0pWPBPpmo
	ZYmTOQjSKag+6rU2dpmICOWqQ27AobrstO4JGTS2yOiXp3lPVtd7l1y/yukDLbk=
X-Received: by 2002:a05:600c:1d82:b0:4a3:59c9:a756 with SMTP id 5b1f17b1804b1-4bb7da03e09mr92235775e9.6.1795071190369;
        Wed, 18 Nov 2026 22:53:10 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e06c73sm26961465e9.2.2026.11.18.22.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:53:09 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Hamza Mahfooz <someguy@effective-light.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] grep, diff: do not silently truncate sizes of 4GiB or more
Date: Thu, 19 Nov 2026 07:53:07 +0100
Message-ID: <20261119065307.826988-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793521916.git.gitter.spiros@gmail.com>
References: <cover.1793521916.git.gitter.spiros@gmail.com>
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

Hi,

A gentle ping on this two-patch series, which has had no comments so
far. It still applies cleanly to current master (e1ec09b23c) and
merges cleanly with 'seen'.

The question I would most like an opinion on is the approach of 2/2.
Where "long" has 32 bits while size_t has 64, it makes "git diff" die
on a worktree file, textconv output and the like of 4GiB or more, as
it already does on the blob side, instead of silently diffing a
prefix. Making diff work for such files means widening
diff_filespec.size, which touches much more code. Is dying acceptable
as a first step, or would you rather have the widening instead?

Thanks,
Elia

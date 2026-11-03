Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697928;
	b=BKevLb2iYmsr5hp+dco9Ga5bH44XVOqsc640Qa9Yedhjc9sFDUv1q7RvJNXtxrLqPqBy
	 737w/ewisBoqaHFfpJJGi7pfk0ObHIB9ITdyuDDDw73ma/x1Qd3CoUvIDKdNZp6eS3ByO
	 G5MQTwRSG8wn6VkNq5Fa7ElaMUju1l2qMYU8nSxhAUmURBLYmu68raKBXJR4zQ4aKJMbF
	 18XH0iMP08GdXkT1gqfZlX5KGwA9qHX4dIMVta56jOuaywDMyIEDfJ2fL3UQiPSTHqZSH
	 pDdRHnH1Pd5WlpEESOT4sJouLjvqGDMOBN40Q8ShFCLd3J0l00GxdzVHtLiSbYFJMSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w1/bZK8jxGYsYg64fI289yODXnzvAyk0sTT8K2yAySw=;
	b=z0lxAmciuFtVShecNG6Iatsr0gY/OMRuafRFfb62Sfa+oz5xMHTVLHZzwvBA0nMbWxxB
	 lKEy9aZ1inlYnKOmwEsPwKuQGvb92iWMYBBv54DNu+nf3d8046WT4pNf6q5vcylf0x4E/
	 uh+qWiYFfUBxrtW09AUB5e90LMdfgMp6zbVAAtt+8oCefD5fldbqXqTCks5Fss0zfMx66
	 2D87/DVv8/6d2aQ44+aQiEfzyKKCasU3zE8CRJeXBKs6VhUEW4Fkok24wCUR90MsmkpeP
	 kP6G9PsM51/zCB90XaCwzsVrF9jCH+TGQOTf3sKKnSn0yRrHk+yXyYnfAV5LumwxZXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXwMkwya;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EF606A32D
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 09:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B73EF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXwMkwya
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a210470b49so31102145e9.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 01:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793697926; x=1794302726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w1/bZK8jxGYsYg64fI289yODXnzvAyk0sTT8K2yAySw=;
        b=qXwMkwyax3J4V1U82RqkgqUoEKRlC4It/9xeQPFeFMXEW4tkgmp8bo77lunTS5MNcT
         0rCWuXqiOvPmDcUOI+9U2w5HAAoGMqeAipw1OCNQJvJd6OuZIMFABSkgOJxNakepM/MH
         4U/ieLzwssp2Dcqpz51aPxJhbRMFda+AfYzOXAInVSw4MrMMf1yNv2GU5oRrZyp+fHlz
         5N3sVyOoWi8BdoGMfXhYUpBO9J2wpl/SCEdHEaVHf/Xks2MY0J5bLR1xn8wtpixx0kQT
         y9sG22j/HhWllJ4vTnv9/H37tcRJZj2RQVraLRdNQelysSwVcLWflcY/dYsbwe+vA1a4
         DGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697926; x=1794302726;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1/bZK8jxGYsYg64fI289yODXnzvAyk0sTT8K2yAySw=;
        b=RblIGppeU6O1Ke9Z+zmTt0ILiUhNBEvnkXtBqf0WNPh1vzCXDldmwI/i3MQJuaosEr
         fHvx941LBP/88X74nnBQFhcKCnpr8G3F5ZjwhyaIiT9pjDxw84GQRBVdnYIzMxyohE5V
         +ODxnd0D0Gp5BS+YluhxZDjTEDTcBKogmxziDO+bV6KC/wVidBEJwhCrolUguTCIM0ui
         UGxzasED6bRsqRuZ93WtxrOf6GZekx5WgvQfJdF45ve2X4vAr8jIr9Nqm66HLjIQmJmM
         3PmpzyBeNy56seJN3P6nG8sipjJWvoIXE8nKo1by0u32bHKNomtLY9yWbQUg3mqCEQhG
         a0iw==
X-Forwarded-Encrypted: i=1; AKwUvBx4t2xtit5V1+YitFLXm/be2nS4WOyCDd6h8IcqSXSRSSevqvwkiImfxmqQ9xVzomK0XXw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7NcahCKV0TuaQN47MWPCwK3MN3yq1O6AYACYZqRKpnctrdx9F
	tMoco6dw6PNUZXHfBJl82g5bbnBD5oFk2mHzBfdBqEq1y+n2Vp0QGXe9
X-Gm-Gg: AYBFou2EeZ+l+RrvHn1veTcPlb72MIntKC2E7EKKZsXto+AMlULKuHX3/QngOQstSAh
	Mfcsb0ZWT+InstDXk69wr/BWFgujDhYNHzH94UET7t80qiwBcrByMIl3VaGY/4zbHH5XsZ6JDrt
	yw+ViJ4CvIEVL7UhcPDMOIntzvDxrhIQBEbNda8cdiLifaxoKXZ2TQXIBYeses73ld3gdetuekB
	lCd6V2Xi+03maXbwOhsoELQ4ksKg+cTQyun/32QuWUzU3VH4JsJbAtu+NnYInGpc9bj3b7CQsrD
	PddWrcf2v0VhJSb0R/qu5CuVGNznlR6IUNlPmvJY27GfDwk9MxqqHP9MZWoXBaW41YMDaViwiLz
	hVv44uD9tpujiqWZsz2DoF0/iRy6kueJo7KhxsxwM0Ky/viW81mV4WO6S0rodcORCF1e7IXClkB
	vBuFiQmccr7DP5sR60KGJEj2AFvExl8c/4BIZhiB4vfejI2m2Koe98oRxEha8YmHbe2JOYwMyWQ
	pssf3FOM6sCFHFxjt2fY17CcmB2AccZGUBlqFVp7MLBBVmHdUTaEslD0beKxNyzraa9DXV6Rw4Q
	HOE7wxDBsmRw0r5fIa9eAugSepzgC9P/FudYW2KTDZBtsG70tX4=
X-Received: by 2002:a05:600c:6099:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4ac180f2ac5mr264029025e9.16.1793697925837;
        Tue, 03 Nov 2026 01:25:25 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.57.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a82cf248sm66754205e9.2.2026.11.03.01.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:25:25 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: tangajoris@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	l.s.r@web.de,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v3 1/2] parse-options: answer --git-completion-helper before command runs
Date: Tue,  3 Nov 2026 10:25:01 +0100
Message-ID: <20261103092503.14872-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <20261029231621.48958-1-tangajoris@gmail.com>
References: <20261029231621.48958-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tanga,

I applied v3 1/2 and 2/2 on top of master (ebdc087dc9) and built with
NO_RUST=1. t9300, t0012 and t9902 pass. On master,
"git --list-cmds=parseopt" lists none of diff-pairs, fast-import,
patch-id and var; with the series it lists all four, and the first
three print their options with --git-completion-helper.

On Fri, Oct 30, 2026 at 12:17 AM Tanga Joris <tangajoris@gmail.com> wrote:
> +		} else if (!strcmp(av[1], "--git-completion-helper-all")) {
> +			show_gitcomp(opts, 1);
> +			exit(0);

Since this affects every caller of show_usage_with_options_if_asked(),
I ran "git <cmd> --git-completion-helper" and the "-all" form with
</dev/null for every builtin in an empty repository, with builds of
master and of the series, and compared stdout, stderr and the exit
status. They were identical.

The new t9300 test fails without the parse-options.c change, so it
guards the fix, but it only covers the plain form: with the "-all"
branch changed to show_gitcomp(opts, 0) it still passes. Could you
add a test for that branch? This one fails with that change and
passes without it:

  test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
  	echo garbage | git fast-import --git-completion-helper-all >all &&
  	test_grep -e "--allow-unsafe-features" all
  '

Cynthia

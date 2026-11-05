Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914541;
	b=UCclm2mJXz9KOdVic0w1qgvFGfXZQUXn0eoZnMWvyi0bbHe5fmaovQg8jHocaXYkjQvc
	 J0M8zRQvh88otzrGw6BLLSIvfAcodELSgbKmagym5MHFKZCmN8J06qak9H+Bx5G7NhPJf
	 zkHEA5udIvjVucGqFMCvjObvotsWkDno/l7Zc6Umsx/utFXmRI00SDcMzvEJXNHqX6+XX
	 sT0QySfjw55Fd4NBbt8zKFq0B23uFPsy7ggt4l13PpqhOnwtXXxzZ+GFPU2r3Wteb8Hw1
	 D1EyK5FBrnb4GNZdctwVa2R9dsYE625Gry7+tljyp+FcI9HDL1sqPPCXccFpKTSn0bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IavdHgcCp36gPyB+7kihkyzd1Nr6VKGLwpSjU3Xzqx8=;
	b=EDDNQlnrI01GhJeMrVbKAkn35JOKnBlnYJtRsCuDCyMUaw8OFkodbc1Sm1VKMshuTkSX
	 pOt5V7iMiWiZ/sFEDfKXhrfSdWkkphRr3vXyculLV5OqYNtBH3slUhUUWjVoa3kBqqTHI
	 Wos3mStEeShKLZUdOJsfbSQySVq0UA08M9xmSpVTmxpXopsH4t3x50RObqur1mYUgFwDu
	 r/1ubL2gwpYax0KBzsLivZKmdfvEEAteRgebjyKRszN0d+5rNteY2/QttnAh3PaIoZF6h
	 i9gg5BDDoMkZQz4Yn/kuCBcX6R0ShiJcq0Yv2MMnWhhMtRz3kh5Rb6kJMPdQdLsQ1gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OnDK+mmf;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4876082BD1
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 21:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4876082BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OnDK+mmf
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a215e64962so22843405e9.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 13:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793914539; x=1794519339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IavdHgcCp36gPyB+7kihkyzd1Nr6VKGLwpSjU3Xzqx8=;
        b=OnDK+mmfkWeIlkq0Je5U7ilgpPZVs/TuDeGIJQIHSPqdSVW1Z1InR/lxBhhZDMvtPA
         /rRijpkr07QhMmR0Z32jdPTTX+9+z6XGQkc2+vk+OYNHNsCwTWw0dOD/2kP/thakTSVl
         dq3FJMnzlyjG4wba7+oLJKdEdO7pN9m58kFz93HUd+AeUP4hTyOTssskgUuSL/tpUxXF
         MZ2f9kc1EHdeWx5qyEkNTwI2hxRvaV8uW1S+F7TqlLMQJAR0eXG/hFEGCthnqvaRWBXN
         L9V9PWChCcjW/GCmt2kbgx4KBYxOADGzmWr2tKNZJ70O2mySH9CzM8Lztq1Nuumhasva
         IWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914539; x=1794519339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IavdHgcCp36gPyB+7kihkyzd1Nr6VKGLwpSjU3Xzqx8=;
        b=GDTEyL3I9xIF4ALyNrIIvvWMeLGPw/ECS8600jAxVMCafW2fAeGdEHddIsX4cTwGvS
         3hbkN4xJRIX16X3yL5o9JwqijdncLuztdZ7a+jTaq8kBJFzJQ/ZQ2xuu6pdWSBzWeRDR
         wBiwlyq0cFt90BmakmCh2Ybm8yx0LI1Rqvjri1i4Na8WEteCt88zgCXBEXb6dE/ips/L
         PaTB5mTTFhPgtIwYBssGXBI0eXA4S688awb7pI32wJR6zfBcy8S6B5A/Q8YCnvEImLve
         4CGmHcFuUnx/lw6bwnqWSTBMYIaDbRNhhlE0k0GjM+hxOoL0ZV/nq3dte7oRxJXQfBg4
         R5Gg==
X-Gm-Message-State: APuU4Z9FLMoqG4EoEX/xpfu/z+KCt2dcPLlD0ELP+jHYPr1IsZf33qXo
	KD8YV77zjDrFtFFyFeU+055HPf5ZuEyxkgNAOPJJJmGlkMcHLWWLghvpY/i82Rrvbd0BqQ==
X-Gm-Gg: AYBFou3W7EIz4vcuQUlsSyLKbiooQbvmaFAv7xlU/FRz53sdEhqPZyQejRKGVJaMbqD
	DCNWwJHDMnuTJ1uE13K67oksy5YThGJuSwbyr9AY62aQf4nQh2oAEz72ckicPvnrfaCz4dGeEeK
	XC4gZLYUdYAgJVY5dSgm3T34zvhue5QroltBFD6HRSeQFnc0VSyD3ubwszy/AibzcYrqsqOCBEo
	Sktz/nvM9a8ZmHOacn+/kQqiVlTKA+COz3ehKyNxZi4RQadI08rAlIi6OpAVH7pXO2GiWWI7n65
	5nUjP5GeINUdrsD9iR6N1/BZFJKtc1ZgThQbFcNfcXCJXXBQTgvYSm/fs7bQYBsW3qNAJRkOmjR
	13aJPmPtsau4Eb+pS/L+StRFsqWRHyxeGF08UoCincEBEIRCM2MN33wjB9MdMk9PjW1QS/HF7lk
	LT41BLd760uDZVAMnfrNb9pp2pJ0ISLn6aifbTx1/0lEN1mV9mKtHr5SN5y/mIp5K4BaLV8nRLp
	quveOpYANwvYFdoVY/FBNX/Q7T+9nsO0b+KOzMnUffySZdE4L4TNKMErZbixr/KeYcZNf7AVF7Y
	QCnVHcAJyHpOxtuKsFu+GiwnzNOd8VFlAKCQe8XRjoVTtZUCHZY=
X-Received: by 2002:a05:600c:3111:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4b6dff87640mr6041165e9.30.1793914539168;
        Thu, 05 Nov 2026 13:35:39 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.57.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57317cb8esm92822345e9.13.2026.11.05.13.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:35:38 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	herroyalpriestess@gmail.com
Subject: Re: [PATCH] api-parse-options: add missing flags and macros
Date: Thu,  5 Nov 2026 22:35:21 +0100
Message-ID: <20261105213521.637-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <CAOLa=ZSfNPt03R2F_xG930pBmXCJ-CcC-GnTTLA5AgWoZm8eaQ@mail.gmail.com>
References: <CAOLa=ZSfNPt03R2F_xG930pBmXCJ-CcC-GnTTLA5AgWoZm8eaQ@mail.gmail.com>
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

Karthik Nayak <karthik.188@gmail.com> writes:

> We don't add the '_F' versions as we talk about all such variants at
> the top. But will add in `OPT_ALIAS`.

Ah, right, I missed that paragraph when I wrote my reply. ^^;
Thanks for pointing it out. I'll take a look at v2 when it arrives.


-- 
Cynthia

Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08513DDAE
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774162528; cv=none; b=LnG5KT2vdngniMUEPbSb6gLJZ0lvkz7CuC7cH8KpR8IuBmvCt5Qy7qf0N6oD+ZDvLZXreWzW7i+Yk3IjTA0IPV3CPf7qvs+yUAacc6+JUxhmyh+v16wAmcYejJTERL5NStLOGUweXZGGz8fYhWXGcU1/M5WtrozkVbwsVW6VSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774162528; c=relaxed/simple;
	bh=2aYaTMrr15ps+pwPa+4g+Q4CB5HQKX+gjxdxTV0yi9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDTmAOKh25xvX2Ak68q6QraF8iCqmzE4j/J04SNxXQkOU5QRWZIFQFY0cPuGjsE41Pbm/uqlCAwL4BIwhLoHS7UMK7Uiz72gKoE7I9EXOUw53W3hcB8wJCJ8G0aX/ff3/+XHe1XRH1nVtnD2kYZkAB+GO/7ZXkvjvBL02KaZ/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9HmYgZ1; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9HmYgZ1"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb40149037so356599385a.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774162526; x=1774767326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rUqEiAVHSc1n17zZnSsVjMHyeZRX33j8fsGmjRT418I=;
        b=U9HmYgZ1vpWV3UrQms9/0/qjkha8t3lrDPUss8zq166MFTQ5bmKxkU3pJ2i7NxsYjV
         +JnN/PQCI2Jf/Uy5J8Hkgyj9cPzmGOAgt7dadPv237vLa6H56A0WD/36VJrRygSDHn7v
         MujAv69h5QSDnKGHn9o4xP0Jyg0x8kBKRn9oOV+U8UIUznkk9e06AjP07hd3QaPcAvDy
         vElnqKFDzOXCNu5vex7oDBHc+gFZcUFOjg1SDtuJFnINL6pIlLhEIOVHWCRGJboWaEdY
         LRbdMliPsptfx3Rx+xp9LSZINSENBYvmbMjVFmQV8ibq0JJq3J+hXVFYwCTK88B92ADj
         llpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774162526; x=1774767326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUqEiAVHSc1n17zZnSsVjMHyeZRX33j8fsGmjRT418I=;
        b=F8IGWVGfU6cSLnhpwRlXEjHAlkA7uwYp2OZQvyst31wUUm6yO1JJkcwVxYIe2ZETEU
         aWifWoUnToQUoudPGa0zIeOdJj3q98H17bhkG7WlCw9R8C4fXkqnjykXIvpL/1m0D+xv
         hri8DBltAnpkRq4MzTLUzgC6K0Wky4OygJQ6Kiu3kMBjHdmklZUuN7/jk6WEj6JVLQua
         cADLUs5leqFu71P2lUSn/TaA1PYL672VA2zOSEmt/rF63PZmpRpMlgsSS3i+vYOBfGwV
         v7YBy0AD3BERtLP6ttlq0bYKCRg/DE91YIad4zPgy6dEBYL3PR3ACq7RfldiCeEL7w3I
         6Qow==
X-Gm-Message-State: AOJu0YxZhcD2111hijlWWeZIInqFZzqiBROGlnNuOIbn7ByWIwC9yXHN
	2+suC6i4y20baD44pxHYAPkKuOGfJdjHMkts2XEzmddG9W6GPWpBcNqRBwMZxwNHrbA=
X-Gm-Gg: ATEYQzz+IC1dKIqb/DYNPEe7QJywYbpn97+AXhx4Vc3j0UGSfY0RNEjRONwVj3hoJer
	MZ1uKp9slSPkHsL8QSgoIWbT26h5Nny6jVt+ej0CLo/uZ52rpvhlOZq08KkfbxGfy7J3vjdlNal
	AkVah54y6LFlw8rJUzigzmEpZ61HTDULkhqBJXBwMnHSZVQZnXAeJ8ulUKUrLir3q0dWj+O4spm
	eKKxLQk5JNmULQGUOqtE61dLKeouLWH21GL2SuHYxWwoG9qVyoOcHA8HmFoL9jaAkOXLg9IQELl
	XPs7DKQGEy/gwt4lb/P2j/8NQ4TJ7WNTY5QBEWkCMYY25ZJAYU89Br+McMNmammbRA0cRfZxldV
	xmqO+nfnFF51PoAfK1GZXgslEM++3MGTIarrSIbm48FT+qJ8SC/qHrXDkYr/bAcL/c1nUTvV9i7
	wiCAYJPqZ23aih7FxNIuWKXHo7hfQooQgTtD5yNN4XYXDm5N70+/anKeBzjYxz1s9MwAB51lP/s
	pwU
X-Received: by 2002:a05:620a:198c:b0:8cd:8f18:d1c0 with SMTP id af79cd13be357-8cfc7f22c51mr1238786085a.27.1774162526190;
        Sat, 21 Mar 2026 23:55:26 -0700 (PDT)
Received: from localhost.localdomain (nat-128-59-176-155.net.columbia.edu. [128.59.176.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f9210csm533083185a.11.2026.03.21.23.55.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 23:55:25 -0700 (PDT)
From: Mateo Patino <mateopatinodev@gmail.com>
To: git@vger.kernel.org
Cc: Mateo Patino <mateopatinodev@gmail.com>,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	ps@pks.im,
	gitster@pobox.com
Subject: [RFC] [GSoC]: STRBUF_INIT_CONST: initialize `strbuf` to constant string
Date: Sun, 22 Mar 2026 02:55:09 -0400
Message-ID: <20260322065509.5384-1-mateopatinodev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello,

My name is Mateo, and I'm a new contributor to Git. I'm a 1st year
undergrad at Columbia University studying CS and applied math.

I wanted to ask the community for feedback on a project proposal
regarding the `strbuf` API. Seven years ago, a macro to initialize a 
`strbuf` to a constant string literal was proposed in GitGitGadget [1]
called `STRBUF_INIT_CONST`. This macro would work just like `STRBUF_INIT`
but it would set `alloc` to 0 (i.e. the buffer would not be 
heap-allocated).

Someone made a pull request to implement this feature [2], but their
changes were not merged. Later, Robear Selwans made a patch series [3]
attempting to implement this same feature. Robear got extensive 
feedback, but his patches were not accepted. The same GitHub user from
[2] sent a patch here [4], but his changes were not accepted.

More recently, the potential need for `STRBUF_INIT_CONST` was mentioned 
in this patch series [5] by Patrick Steinhardt, though it was marked
as a #leftoverbit and not directly addressed.

`STRBUF_INIT_CONST` has been mentioned for a long time in this list,
but it has not been implemented yet. My Request For Comment is the
following: is `STRBUF_INIT_CONST` a feature that is still of interest
to the community? If so, I would like to make a GSoC proposal around it.
The past email threads have already laid out the considerations of 
implementing `STRBUF_INIT_CONST` or something equivalent, so I would
like to propose this as GSoC idea if the community would find it 
worthwhile.

I would love to hear any thoughts about this.

Thanks!

Mateo <mateopatinodev@gmail.com>

[1] https://github.com/gitgitgadget/git/issues/398
[2] https://github.com/gitgitgadget/git/pull/824
[3] https://lore.kernel.org/git/20200218041805.10939-1-robear.selwans@outlook.com/
[4] https://lore.kernel.org/git/20210105064502.725307-1-adlternative@gmail.com/
[5] https://lore.kernel.org/git/Zrm9ix5aN_g76Qxq@tanuki/

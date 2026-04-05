Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D62B663
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775351601; cv=none; b=YcKCAMqMw767olCuD2Dyj1OCfgkYcX+E8Mv8iPCDqFHzWisw5LQkgsH/5Gobr6qhEkc6JOS2G1v8gxQKaat7OgwZAn32f7FxIPserE47WKLd7ozs8fyeXKh4zOEX/i0/1IOPYqQQomOvCFz27R8dirnwo41N52Gdleq8f9rCgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775351601; c=relaxed/simple;
	bh=YwXyy0cEmVgLOIkCTvxPHbaQYcq6FyHKg/szAmraKuc=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=h/0M3Alwxdc0Lsag08zW1X5uYrTr5QqpXhiVL2dPm6ULo0+oMEHWtbLgELN5hObt/dnG0NQ2pv6LWDHzY/2O/llu5OOw32fZOEg31vbVnfOAjnmfNgZRvO9DBXqyPYZc/K2C1l8iAWMVUSJL3Os6AIMFKqxmjAdPMadCrBF1Two=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X86W6J2Q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X86W6J2Q"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a04f39d2so12300755e9.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775351599; x=1775956399; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwXyy0cEmVgLOIkCTvxPHbaQYcq6FyHKg/szAmraKuc=;
        b=X86W6J2QIsCZaK/DttBJmpzUbdSeB9XQoAfrz6itX51NUxPgKFffMOhPLZy2gNJXh5
         dTqne3/dwZklhFGnEanu22yjaiK7uZE8ppdgCtwFl2f1yO5+Pv1JNjNCWPytS6VFCEvF
         3bVf8BHOh5SW6B9p/YItAEd/8+bbOldt0+oRs5xN7kuS5ykJfHwCkfPQHH6E611+XNJG
         Kh9VSKNazKku2df7OVdkF9RvAv2K/xIPemoNrpYtgLaMW6Xy3yFMfPE02CsVz9QEmwkZ
         +7EFN3VHxsIL58Q4rx4dOc2qP5Sudq8EL08TosumHmW65qVwtGKgGqs7Gvsp7Cm9+9nv
         Kt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775351599; x=1775956399;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwXyy0cEmVgLOIkCTvxPHbaQYcq6FyHKg/szAmraKuc=;
        b=pIMYrFXy49wKHWpeilRALweieLPwoYKeSdxAP//ivEX1qSp1Am9BYekIettugdS2sV
         sx318mESXXxPgXk9kWJQ83H/Up4rekVKQKlwkU3nPQ1/1T4XpEGQppWUkK/eFPwYl/el
         Nl21yS3+Rs0S0kEa00RCtxlw07Ma5UoukaVnnSVOKauMM01fyc7+l+FcZEskxzrAOGsL
         aIlIZmcttFIltWQj0FsCFWZniGQ7F32asJu3HY0uJWu2yQNXBTxJZ0+CHOkaM1yToK09
         FtrVeoGMtjg4kLSO7alOtFZ0pR4rwnXoRHRavtq/Bki0SFLv6HsPoCo0TbATCE/hSjQ/
         kNbQ==
X-Gm-Message-State: AOJu0Yxbm3xFTelLMfHDSBBxmuPpJ9JiShkVwJroFh61R4ilxAx6BlYc
	Zo3T1vKTStgjflTINLhvMFxCkAa1kq6CAUIg4crdREXqKNUUAXiZjEHI
X-Gm-Gg: AeBDieveJ5gqYfWu/FukI1+edKw4pI9KKMnFeooKcr56gMsJMGIUIS9mAz8HoN/ggDU
	jJ8B+6LklhY0EvAv5krfGh5jY0a897dJk3SwAG6rlMvJGN4bjkpwH7QyFGVtVX8o0pycn5YvcHg
	g6PKJh8VjAmcKgdIoRvABCfvWADcrjNfLR18wb9xWBiCvDMh2lElapBTfjCqamGv1uz9q0V7RVi
	TjUgEKcuikt0flumTJolQgPd0/zf1I0YkGZ0zTy4qBKaTqIlEUz5BEkC0e8xtUGI+sVo4sJEabn
	G3KA4rnf7DzUc23/0kldzec6wfWW6NwvQya3fTrld24qZImTmqdwfu+9W3FBcS2Ya5HL9+HxPt8
	oNegjMId/Elu6aJl67z3pv7DT9PCuWLQUCAhGH2m9tE5EcxyKz2m7D8cadUPcFcUukhHdvaTewf
	q8076QmPR3SsizuTTdXX/M+ht/G2zOeaM7k4xOhy2ky96bMkYoNrEfrLYYV5s=
X-Received: by 2002:a05:6000:1249:b0:43d:3113:6eed with SMTP id ffacd0b85a97d-43d31136f34mr5106370f8f.4.1775351598450;
        Sat, 04 Apr 2026 18:13:18 -0700 (PDT)
Received: from smtpclient.apple ([185.139.55.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5419sm33894126f8f.11.2026.04.04.18.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 18:13:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KHRgtC10L/QsNC90LXQvdC60L4=?= <stepanenkoaleksej1988@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 5 Apr 2026 04:13:04 +0300
Subject: H
Message-Id: <B91C73AB-F689-4D32-9455-9DB74362D2B3@gmail.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23F5043g)

DQrQntGC0L/RgNCw0LLQu9C10L3QviDRgSBpUGhvbmU=

Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E7242D70
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767297563; cv=none; b=au/Zb5Y6T8IXsbPHf/yJpWdVe1IxHpxaC68+BaZf2PyMgMR52+v/bxmzPBf1Pr3jH6SHujj+HP4J74+eI5K1xkToR0vVZpvJN8US4IOBQbnLl/BDkhTeZI8RJ5xKL9zWwo47pu804w06RixiJ2RLf2Z7Stuyo1RVARMR8c7FneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767297563; c=relaxed/simple;
	bh=Megp1iE7XsYdMuKRbd4u2JYaK8mdp3jVq6ASzGbkjxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9Jw4/XcH94b+o9hoks7J4MyuTx6U0I8K3fX3kY1FZlFrxnL0e3jVgmUyIIDX1/wJuzEgOrz/whLP7/GBgNnM+p5ZsNY22Gx/zt8VDoa5xTAhwv3wTxypch1lEJixbm74B4nKUyAAnAjQBpJFynfvPCrzm0MmIzqd+hn6KksxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb2qsPhx; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb2qsPhx"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a3340391cso93253371fa.3
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767297560; x=1767902360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Megp1iE7XsYdMuKRbd4u2JYaK8mdp3jVq6ASzGbkjxQ=;
        b=Kb2qsPhxAynhmyIPz2MLHtrbZaR4jM+d2o6fRQxy/T5bxrdIi5rZh3j4Wb//ADQI3i
         dlwGAjpRRZdb1od8oq+oW9XC1rsx9nO6wdmVUH/oGxhOiV+BjjGuwKmoAAOUhK0S86w8
         7sTTPvHjbSPAW3YA46M2MW3aqjKdXG0WcH2d7Z0+jrFtpsQaMhp8daVRQQAFzsJkYAY9
         merBdloUDDbEA5jV88EFZa16QbvLVsk+T8LsFo1ZtoKeD/vJwOn//ajG7bKM40HqD1NQ
         zycX4BwJMEHv0WOqjH0RjwwlGa1ZLfqPreeNcqGJ8SrVNadFVf0B/XuVwiAz3iluWgmL
         4V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767297560; x=1767902360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Megp1iE7XsYdMuKRbd4u2JYaK8mdp3jVq6ASzGbkjxQ=;
        b=Yl+/WJ0AV7qBqxJ9nnbvf+rkZMsSUAmo5/wWhNWdrOERzfyCAQSWIqot6qDLHaUj/c
         QCZxJmnryXWqQAvxZ+ojAjFvdOdihHuv0H0Pi4lNCLeUVrvTZyf0V0TmkzoKwChMXGnQ
         m69BgwC3kulet9Lu/THn6Mre3CDLyRj0NbdF4YIEtNSNOhh1vBhux4jXTkOdpbCzOWSl
         ywWO04TIpwFcLaz1QaK572U/pV5b7rvEk4X20mXOnBBRbxMRTTG17zI9ZhmA/HHQkB+k
         cVWt/4+bLFGNPRc2VytOGxVak23OF2fHr6dhn0oe2/LbrYVBMIEu1qX4/J9CFp/TF841
         DDNw==
X-Gm-Message-State: AOJu0YzQBM2GCU30LZO/9BEsYAlmGra0FjkntAJRGOpJc0S2+IR/8r3s
	Q5MuPp7Sks2j0T9CbeCzf9QrcMFVXCAxZSnBYBSMK9Oi7JnN+Ak7zD7j
X-Gm-Gg: AY/fxX6p7YF7WxN7RcQo7R8zwFvF4xal1kV/8duERBrlG2+5l3BIhPEmtU4guDvaR74
	STzqConat73w0Ce5KWFNLer59yF05BQ1G+eyb821CpPr6cThwJ/3pG9cEZZIXQRnSWWIyfWWEpn
	umwvecyS93X87zFGEYUFTobkmDkiupDd0XNHZ/3CjkEWfxmEqiwjCw1E7vldSn4Hwr7KyMvviQy
	M/XSGIcNgslz2uFiHXn0EJoLi/EvsLKefjnFWDsrQIAKSbt9suWDegQAKDlWIpp7+Zgku4HHOAw
	qqHU39Cq00hIvmUdVsBEXUqGouu5FiqoPcrpiOMZYqUTrSXzzHYrMkm1rBLa9kZHU3UK6gwqHuo
	UfJ76WDVviTEhW2WYVxwP5BpCGc5LPhzjAOLLoZKNuiQS/uwHbLymF16V0Vc04OS7XJiubTWh6p
	mpCwCpBnFhhV5JADX8mX61gcSkF0uqUBxJSYqwLw4vjsCAPPFWBS4uHDzYwj78e4IUmiipkC2U6
	1XRYOiuQwvibGIV+YaI720=
X-Google-Smtp-Source: AGHT+IHcqZ1ytTO1syFnSp5a9DIYvxE4evM7ugAgh9d76k5nVHE3QC1mnAK3ag+irGRc9EL41UrQXA==
X-Received: by 2002:a05:651c:b2c:b0:382:6067:a1df with SMTP id 38308e7fff4ca-3826067a6cfmr62184131fa.2.1767297559902;
        Thu, 01 Jan 2026 11:59:19 -0800 (PST)
Received: from localhost.localdomain (h-85-24-230-171.A753.priv.bahnhof.se. [85.24.230.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812262b360sm111924701fa.28.2026.01.01.11.59.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Jan 2026 11:59:19 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: chris.torek@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Another look?
Date: Thu,  1 Jan 2026 20:59:19 +0100
Message-Id: <20260101195919.14951-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAPx1GvfrQNao78WYfadttM=B8iyXKfxYaxTyX5w_MLZt2_bU4w@mail.gmail.com>
References: <CAPx1GvfrQNao78WYfadttM=B8iyXKfxYaxTyX5w_MLZt2_bU4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chris!

Can you take a look at PATCH v10 to see if it achieves that you suggested here?


Harald

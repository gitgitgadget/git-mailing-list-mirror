Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC2156F46
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746169; cv=none; b=aRU2EdMKXeXALWvIL9subI4QaPMfzQOW8G2sbAN3V9TITv8O2S/nxAu9tVDCuisveHC3lglBiQQd9BUcDqBvXJpy87rH9BcEus7XL/Au0w6Kq0QPXqaDmSYEkXruTrsz826hTuJVo8x+k7vuIqlVQG0CTQDEcAoQGI28+Jb5XSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746169; c=relaxed/simple;
	bh=agWXyG2CY7BPcWKP81MqjPlqakRxlrs9C8C3A9gFTuQ=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=IA6NaOlLX9fOxBw99wOuT6gLOBNsvOsoVq1GA6Fd3mtPHQKBhWWblUggdx97u7N5ssHLCY2cZ3SucuQ8+ntQKH0HhnCCMJDnaNw9p+KG4jKRuJRlTcLTB5Hfms5bSaMkG4S+Q1jHuiCR/1eUPkiBt45kA4a3nvwhtMIknCgKz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQERHRtG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQERHRtG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367940c57ddso2946877f8f.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721746166; x=1722350966; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=agWXyG2CY7BPcWKP81MqjPlqakRxlrs9C8C3A9gFTuQ=;
        b=HQERHRtGJ6XEu/mgdobRaNdch8Rko6Q9tWqLgMxUfkh9s3TdktUSHkWKEa35Nb/GYg
         ryVrOQFktRKaSjScOSGMTv5HRUkkTV5NQioN0jnPLB4Uht+7c7ZSrcZOQK4MbGxFC3Ea
         pCtaUxt2hfGOChrJZGKk1mPQU2nQA1ZRzVip3iK03hxHotWPFkDGBF0px3dB+VvBTnDP
         ej3JnQ2jlQ8xTOUjCh3czeQ2ELxOEo2+3HBiOGPuqABoPn9gkvrvFTx61h1yvvGX79vN
         +0zng3aiaKKLjNio5WlC9DJQpFxeImIhz/Q2Vlpyr27a7POybPo7JOQK2UuuTHkzrYWV
         3kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746166; x=1722350966;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agWXyG2CY7BPcWKP81MqjPlqakRxlrs9C8C3A9gFTuQ=;
        b=et1eUdTY95CfM4ZKcRUD6cXIbUG3nObFcNDfjheOHwFpzna5mGosoRNtxtU5F7J3k2
         QAl3do8IQaOxXidtzh8Yf9TB/ysAeyuXvP+GAEGjYyJVozfCNy3lh0Ioh5LldgDdnZHZ
         OSSJcLawSLwNYgGJBdVtCjOxV+zbjLFhYSSiR5XtRx+zBP8lK1E7FAZIjCgpe4utKfsW
         IkvGOLseQShXKuzvxMxAM0cy2VryROgk335dXMwQybHsZjYztiszjhkQi1zZSepI2PSR
         uK3oAH6xne/zpzoQ1FWwXdGOeWOe5PYeWek9VMXxxpg2KR/QicVqXIwAajmjUR9pZzvb
         01/A==
X-Gm-Message-State: AOJu0YyO7HfpbGy2edimSM53VTqk5/QjCYQY0pcDV9C3xJVPtuCT47rn
	ZnMNKcLTgZ9rxboacPjOEQ+o2Xn6f7ZnKgJbJ8uIyZkaFON2on/y/QBFGqBD
X-Google-Smtp-Source: AGHT+IE0dUeRQMi7f3MFbXJRUFhxb+Gqfq8ZvW4w8XBvzKehXw22qyMe/aEzgVr4QWaUnSefRmZxcw==
X-Received: by 2002:a5d:4a02:0:b0:368:326e:1df6 with SMTP id ffacd0b85a97d-369bae13a0bmr5519967f8f.19.1721746166369;
        Tue, 23 Jul 2024 07:49:26 -0700 (PDT)
Received: from DESKTOP-5DSTT8B ([39.46.228.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d69070desm178099005e9.24.2024.07.23.07.49.25
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 23 Jul 2024 07:49:25 -0700 (PDT)
Message-ID: <669fc2f5.050a0220.177ed.2752@mx.google.com>
Date: Tue, 23 Jul 2024 07:49:25 -0700 (PDT)
X-Google-Original-Date: 23 Jul 2024 07:49:29 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: hyden.classicestimation@gmail.com
To: git@vger.kernel.org
Subject: Estimation of Services
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkRvIHlvdSBuZWVkIHRoZSBlc3RpbWF0aW5nIHNlcnZpY2VzPyBXZSBw
cm92aWRlIGFyY2hpdGVjdHVyYWwgZGVzaWduaW5nIGFuZCBjb3N0IGVzdGltYXRpbmcg
c2VydmljZXMgdG8gR0MncywgU3Vi4oCZcyBmaXJtcy4NCg0KU2VuZCB1cyB5b3VyIHBs
YW5zL3Byb2plY3QgZGV0YWlscyBmb3IgYSBxdW90ZSBvbiBvdXIgc2VydmljZSBjaGFy
Z2VzIGJlZm9yZSBnZXR0aW5nIHN0YXJ0ZWQuDQoNClBsZWFzZSByZXBseSB0byB0aGlz
IGVtYWlsIHNvIEkgY2FuIHNoYXJlIHNvbWUgc2FtcGxlcyB3aXRoIHlvdS4gVGhhbmtz
Lg0KDQpSZWdhcmRzLCANCkh5ZGVuDQpNYXJrZXRpbmcgTWFuYWdlcg0KQ2xhc3NpYyBF
c3RpbWF0aW9uIExMQw==


Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A342369960
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801259; cv=pass; b=Y9fyYOnsueN7SJtZn19YvTR40dPm/5pImUl9tBxLqrKU3hRuCZy0LAUm2MTZd45yiOV+oaW5KrsMt548B8rFZ5d3Cvrj9+ZL+yrYLXb2dA6P6Z/XYiGqhaN0oJoNZBPTljs9NlET5KxVD5qwKNzFLoyXSa6bArGopz0M2Lh1dDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801259; c=relaxed/simple;
	bh=oKIkYR6qMN4wbXPMOuWaFRKCenzaiBZN7Vt9Dq3p6jM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g1h420KwZM8ooAtgGtVwi5w0Wpq2t5w4IN5GjQjaNgEZUji8ISIa+JNIhfzcUXR5Ozcbp7rnJ2/7iIXv+FK48XbA/8Gb+LilLiJTy5U7nnh1bwYRZjKJN8Sru5hMZvg+hbzM4nG72TX50LUK8QSi8wJoRfcfnMFMCspX08BdF8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrMR7hcX; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrMR7hcX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b941bb3e23cso218170166b.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 04:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772801257; cv=none;
        d=google.com; s=arc-20240605;
        b=esdFPgb5FyuHzcL2RtfUlpC0KmhPtAjjW/jM2QkLRWvC8gNI37WGmAY8fvNqzhgEQS
         sxFfxGTofD95VLgs5VVNWZeoZg8a6LeEXY4UdsnHfGiegRAh3dk9BB/d973xSMk/Jtz+
         VrlzuSS45y8PEjCgZrMxlLPqI2240zLdvjg1nMJAJCy0/TfIqEzZE8PoOVqD2VmrVLN8
         mY+jfXwL6TWUQVY/lfJv3WdYqNB5cVCHLpfPg5vUbzdnPwzG07eKZFwnRh8fFj85cbwt
         dZUEK0PhRQXWYaUrx9OUfLwuDYomhV5IVN9OrtanSnMOwyw8H513t76Xm2lMKWMeNNqr
         mhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=oKIkYR6qMN4wbXPMOuWaFRKCenzaiBZN7Vt9Dq3p6jM=;
        fh=QC0gDPjx8fferjDb62QVYwcf4OJdXTzinsMeJnVrRZg=;
        b=UCo/S3kzB1aoqkegWl5LzQm847pUl9HXWMvVxtOxqvmHs1jRdbsnXojOwVXmZOSLzR
         1lIidDOxxD5nYwjaQV05+p9nIl1s0dWDs5461LsJRgj7pyciBiJDNwN22RxD9HoiFGWj
         vBDnRiF0CS7V8B3NhPrb3SSl9uyiuQN4Ua4sS4+BuVNx+U9hA1lyqV1GicqV3vsF8Iu1
         PaYdFBukfF/FS4zVQkeY8/S7tl3HmIGFIuvZDZLQHu0HxgJKhdjs4XkPiuQtg5cndQer
         8unaRHhrr6fyMs4RVP6vInPDDDmRvYlcm+0velEZ4xNEiLHe13DkkG5q7GGnKIICrdP7
         EG2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772801257; x=1773406057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oKIkYR6qMN4wbXPMOuWaFRKCenzaiBZN7Vt9Dq3p6jM=;
        b=LrMR7hcXm3Ue6FXx3WDRGw0p/9LqF4DxZ+SGFDE75iH/PBM/Rqv1Pax302cqHc1DuS
         Dz3N2GUodWgA1CGfMXEwVjXhAroqDwpn376N2kWeg++tIDY7khJ3i2umMyfzqjjCXTlp
         JaZwLRUv8YFP7sDjuLYgjYQaZsx69hWyg5ge5JpqI9EhUnj7pDFqPDFSh2DchMFjInNK
         SqOm2+UadEkytgYtpDARr5b77206Do/iK2PaOblTnfWlZrvYSYUD6dcQU85nEkKKY69O
         Iw+SUd7v/uoDmH5MqD5mkUnmwR4WKvuLbDn4//egC4YFoB365ZxDQAkmDsOABJMhyCQV
         wVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801257; x=1773406057;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKIkYR6qMN4wbXPMOuWaFRKCenzaiBZN7Vt9Dq3p6jM=;
        b=ds0/hHG7eLoATlFwIvgx5iqm1eWBMofCbSfonP2jxHgKnm9qlYCPv0+golu2jhXf+T
         pMuTSSpfUperNeD/GZG1aHbgJidpjvkrcZbAOC2zgdUOPjpw3gYA2gK1shFrGykMq7Kg
         V6fJCBwPezKARHuv/j8Mt+bNAU8gvj0ROLBjJ1Q2OlFN5B4km3DAXWhKArMvgQQbfBQP
         I2d3VBiQURp7y7QzXvtxZSNpEkIWdUi4vDG0qTZuF2mgd7P/fKXSK43SeslPEqHo9zuC
         JbUcMWl2+KB5MlNS5XcmOKRCOEr8swpmRdJzb6iD6rFbU4KZ8bxiBINFYjAYdcJe5s6z
         TNmw==
X-Forwarded-Encrypted: i=1; AJvYcCW72VNhTkTiwjWFg2GVDRbRy8xmYMs5w/lIBwGKW2ywVfizKxkc4qm4txH20X4eS0mtjv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRO2UPUxISehK0HKR72Ax5e7xN71QWrCH0x11RN4wxfhAJX//
	6Q13/CJpoiJoQy6UosF2SL+rlO0iob0dV6ZTsKuHrkTajrlYZ+bzHLdxxpvHqzUhEsExLwdz51A
	+E8/9FF/85upQGR3tsZRA2GhSiMipCY8=
X-Gm-Gg: ATEYQzy9wcIEdT13AxmKnkqZfNLpdsqxUnZffVzlWwiu7ZYEZgj4gpOJNCyR2GJHiDU
	xMVqb4z10Lk/fkhAMXMcKqIGcd6fxINHbOo61aDBqF5lD2cJb0nvfg9QLW/XSP7GsnqyCJUr1JL
	bdGkHjE3I62j1Vfu116GPo3d56ExkOxgh2Ff02kZqoEMSI/J/XOy/8A5LVyet7iNi11qtYcvwtK
	mHZDMtjTZwAhQvCjsKAnisBgwaQsPki7BqSra6StRvvNTAtHJxcAf0uGfcDPjcgfKS/BJeGnwyB
	oElkp4dw381CjQYiWSA=
X-Received: by 2002:a17:907:7b84:b0:b93:7255:2d5 with SMTP id
 a640c23a62f3a-b942da4aed7mr122778866b.7.1772801256455; Fri, 06 Mar 2026
 04:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arsh Srivastava <arshsrivastava695@gmail.com>
Date: Fri, 6 Mar 2026 18:17:25 +0530
X-Gm-Features: AaiRm53KV3ZLb1Nm3gwIjNQs6NgH2ARaQlWCu1dR2fzA-lGP89fBcFGFD5tleYg
Message-ID: <CAE8w91savQsmZQ4_6eRz+Jzse+Oapw2sHnW546SZjBB=_91g7Q@mail.gmail.com>
Subject: [GSoC] [Microproject] Added advice for files which are >50 mb
To: gitster@pobox.com, gitgitgadget@gmail.com, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, nasamuffin@google.com, steadmon@google.com, 
	rsbecker@nexbridge.com, christian.couder@gmail.com, code@khaugsbakk.name, 
	snaury@gmail.com, l.s.r@web.de, mhagger@alum.mit.edu, tim.henigan@gmail.com, 
	bobbypowers@gmail.com, Jens.Lehmann@web.de, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

git's advice currently has no restriction for adding files of size >50
mb which allows people to add multiple lines of code without any
restriction making testing of code and PR reviews very difficult.

Proposed solution :-
> Add an advice which checks peoples git size and push the message so that it doesn't make the code reviews messy.

Signed-off by : Arsh Srivastava <arshsrivastava695@gmail.com>

PR link is :- https://github.com/git/git/pull/2221

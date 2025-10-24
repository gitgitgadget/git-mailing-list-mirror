Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212551B4F09
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340569; cv=none; b=SreCKKbCijqT6no9PIW6pfO0Igc9B3rUD0PcShJUnKFnEhii5vMFTosdBGqXYZ7qHHT0gQGMlOnq2hHe4ba5+aLP0QRm4XmChznddUM71ZlEVy8u8hgy+5bBBOCSCFAWNi3Xzn2p8IVvfu0S5kQhSL7f92yJZzuHLvAZjEGx4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340569; c=relaxed/simple;
	bh=EcFTy8waD4aNhHXSu2IOS2uA7kjeYerO16HOgoEvxXY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Eft2iD7sD4B2TCBro0+H/G3biWdLBdxHoOkgeo+GCpaZXb0uOuVJYvG+Mr5gtxuqttwSntYvEdl9Jaj6e/f75ic5XS/B7Tiy1IOw5oQKDPIfIC7B6lJoFlIn+YEWpK1WkyCsSZJBePICpozIoBJS3UEIwBmZzTC3vPKPYrt7A1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MerOdM8s; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MerOdM8s"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e330a1360so2756325d50.3
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761340564; x=1761945364; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcFTy8waD4aNhHXSu2IOS2uA7kjeYerO16HOgoEvxXY=;
        b=MerOdM8sJsy2M6YXLkQ9uaV5508flGMbcO2FN0Nsg2DOPs3aTZq0rh/O4MDgungXwV
         NiOdIiWqfMyY2uYLq3UNaMCk7mCZLScfZiGsFJU+WZOIDVmmuaSopZl4JGGNZTyx+nNT
         sjesctbh8aIfjr6sZuWILR3LwSRtO4hsplacsB4NHYoVKnf0mIfVCdi34yJ6SECQoFpp
         hVYhFSOKmmwQfyPHdN9unNXEdU9iOATdPvRHwGxrEF7Efpa9OzfHlo2GrYcWe0zRTn45
         TBnj/PF93AMrk5n/E6kqTIbrjTSMzMoipd3uwViOwCwlgGxsIKc6hyLGGO7nIGNFi+bW
         XXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761340564; x=1761945364;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcFTy8waD4aNhHXSu2IOS2uA7kjeYerO16HOgoEvxXY=;
        b=I3KUgx2dvo1L48ZtGvXzDJZTVz/0LZFPyRhtxSvR4zE99NhR3i12WcJ9H75KMeEaOp
         yVxCJ2VeQ2c9HSs5W2tUrJeTnYdllMDO2FfuBRNQW4sbB7hOWhiutqVFcSY/bt0Ru4U8
         R4KRr85KlSjjRmPeyiRoiMrO+VftZjHOJejnaA8BCRZcpARP3NP169jK00uTvvGwXTVu
         +YwDZ6ZvoyVCn8yx4fx3SxQ88GDSoQdxY7JSvmgp05NUfJvJey7emwp0FjXAYXWY//ze
         joWxl4wQoVrlt6xvGOynYjxv33NFwoxBiRt5Zr4NUUAVQQjgbNLAjTh/XrkP/nPGfTrv
         mlYg==
X-Gm-Message-State: AOJu0Yw4+LfJAdCb07yvvjoXCxRY3aNWQdog4rcRikCyPIf9vflVG55R
	/dgTJMTVphkLRc6y7Pv+EZw+XI7mJsN/CmVTNxj+dw+x2fGr9FlTiTm6
X-Gm-Gg: ASbGncuvXWJhPoEg0dMxeWU+7ManHKzolJ+DUr0sErIr8K7iMxw05DlyLzW2naT0hbC
	1qMJmDiSjspKgFf30xA4YCH0Nkgwp9hJp/rwmFKHST26G/cJ7WMXrDeo2ceKQ4+KtPtnzlj2rMn
	TeFhASONqU16x4UYi4hLMG6kr9BvVOS/HzH+nPvL05DcrnDmt+1vTCT8i7TVZjQ9+Xnjb4EEFlk
	v537gfQuxwWrRgSo4b93+Oo679bomGaL5Hyzf1knTNvdQa3nJX/DcOEm60fEJthT8aVbQnoo5Kk
	6C40besrGftRqqADoBYN/vWDO8P8FU3c958oiUhmbXVA8g8KlDUyc5CUOG1XDzqFJRBjCe0/kna
	hQUr6yBX+HIcd4FEyimmr8AugHCgmqhxJl3Zj+uvV0JuvSqNKFebwhFmRcZRsS0+t0Qaj0PRJ0/
	vMNF9ldYlUJJJ8A5uPV2ZXiwPEIX4T6euKMCmlVfUGGaWcXFytnw==
X-Google-Smtp-Source: AGHT+IGIWkgP9oogFQUhNkg2sVEJX4Y7EDmB/jAxskTtPCuNO1gtw/X5pmctNySSFlTyrYJl/ivE6A==
X-Received: by 2002:a05:690e:1509:b0:63f:415b:a787 with SMTP id 956f58d0204a3-63f415ba805mr3717088d50.0.1761340564026;
        Fri, 24 Oct 2025 14:16:04 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1db265sm592737b3.49.2025.10.24.14.16.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Oct 2025 14:16:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2 2/2] repo: add --all to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aPcduvnjD0yphja2@pks.im>
Date: Fri, 24 Oct 2025 18:15:50 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com,
 gitster@pobox.com
Content-Transfer-Encoding: 7bit
Message-Id: <CC193689-1CFC-4682-95A1-2303642EA8C0@gmail.com>
References: <20251020181943.6314-1-lucasseikioshiro@gmail.com>
 <20251020181943.6314-3-lucasseikioshiro@gmail.com> <aPcduvnjD0yphja2@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


> So I think we should accept either `--all` or keys, and die if they are
> used in combination.

Yeah, it makes sense. I'll change it in v3.

Thanks!

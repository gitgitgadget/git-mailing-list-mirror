Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D53085A0
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275132; cv=none; b=sdOXJor9hiAsdtfqIFGWK2P/4Kn8ZofniQHfnzRGn0Hrh6Xme8N8irQPcNzzsiA11FS9YTSu1apIUS96CyuaEKM5qwU/qDK7KgXRhQhGbDtT+/i5NqgRK7s8flFueemr0CGe9z+T9+QTb8XYjG+Vu5KPWg8fivxbaxLN21vFgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275132; c=relaxed/simple;
	bh=gm6H5t46vr1UEVVqqR1NpqBYZ2sgwoDDnmdpdvrZ634=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DuuVscEbTtaDQ1RgWpK6z/7oO3sBAjkvZihdawMIDXM36jxt6JhmReXpCTPiigZGpUMj0ds/Sb32MdIYiX2Tp8iRe5tlGkl7ho2z2loQ9otynrqjhrbWm2gehNlrygQjpkGOuMscGJyWKDEl/V6YLMnrnC10LMVJTBHQLw2WMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8ab7RVv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8ab7RVv"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso5639079a91.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750275130; x=1750879930; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm6H5t46vr1UEVVqqR1NpqBYZ2sgwoDDnmdpdvrZ634=;
        b=B8ab7RVvrEVAO6CFT65ihi5nrHNt1dihzScpBzpJKQpVGVxjjZqkg5sC1vjg0Dg0bV
         Z4shP7SZZkWtq/UmmUUlC0Ko+8Vag/Y74svpjG97GXgR/0q4D3DO36SNYQefOpBRc87x
         9W3/vBYtZLVNTT6OPDFe5KR7x+coch/1Gx+9ddcf6o3zYjTVO9BqiYsapwlz/VMfEpVC
         /ihKKL+4e107ak3guaXlMMCVnQ+utkr7H9HjkOn7A6O8spRnmhMWSQvwIkWYtrtAhOPT
         Vlv59XRQrE6Grr0w8vgHiq/TYpzhsyk9ioN2bDC/5hEnWRHqSTGnI+n5kyXB6rf+qjjb
         6cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275130; x=1750879930;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm6H5t46vr1UEVVqqR1NpqBYZ2sgwoDDnmdpdvrZ634=;
        b=eYLf0r9EvJ5O9RRkx9ZK02HpMrGaMbUMTLfVxlrXo2dQAQx4qS2tH9HkDlO5zOZqJQ
         H7fdoFa1QOS1eaZdwHh0UpR3cBOwYw9VifT6/G1AmQuf8BZWKQdZlNas+T7dzMbw6Wld
         JpGof4gq0nA1BtSfuQne2rPzrtZhw90w1bFasrNxs40QzMoYQ5luqh/o81wDPdzP5NRG
         CV4WA90rAqmkJOkH9ZV2BXfdBXc4DoDUur8T1K3QOLERLOPk0yNYC0CBUlEs1EIfdSfM
         zPyq3iaS1sJ9l6GbfvevkAww3vvepblKX0ZF60uujWDnLbhAS2fBjeaSUgVVf7erIKKs
         OxBw==
X-Gm-Message-State: AOJu0Yzypm8ZFDhLtZ54Ek8QO8nELV08wOo4VzJ1rmk27u+HcRWsOMN6
	muLPcX5vTaKoieWFpm/9qlcA1jXv7o+2LfXAzrL4wMbgNsSiTrUq66ILhdcVoA==
X-Gm-Gg: ASbGncvxrwJF4Uw8T0TkQ5e1hGu1jrv580lF1X3rBCYDMW5brw1sqe8NlqSu7/RpLVF
	lEtNQxRI5W+fbDVwi4UO5vhuVrEGl3SqVWrTHsg0gK8wl3OOqmRxI7Q/2nyzifdfpR6gYKH8RUG
	4mKoh0R+4IRcQ7sTFtZWjI9oUB+9OnmVuEsqrtuC2LxJDiJ6zgOdBJ9BjA350xsWrXjbwSDk9ec
	zLiKTHz6VYFQ8EtTJ0/i+99PCGCTbmvNv0fUDizWQo7i/ajuR9rSZCRqx+9qYG9kGCq2kWUpVuk
	veQPLCIpDbbgfMcwTFEk/b8/079p2hVfqtll4AzjldZHVW4svn7KtSRNYYp0bKszGC1CkCbPd1r
	OzIi2tq5osk8=
X-Google-Smtp-Source: AGHT+IHf0KsF+Piq0z+10uToCNbxi2LU6oSHDDqE69e+0U7zfT+SMsc0RYnl/ayHz/DS8V2ULxOnGw==
X-Received: by 2002:a17:90b:3e4d:b0:311:ea13:2e6e with SMTP id 98e67ed59e1d1-313f1db9fd3mr27991430a91.28.1750275129610;
        Wed, 18 Jun 2025 12:32:09 -0700 (PDT)
Received: from smtpclient.apple ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a4d6csm104850775ad.88.2025.06.18.12.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2025 12:32:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Wed, 18 Jun 2025 16:31:50 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <AA2F54B9-5A8D-4576-A10F-3A00F3F0A34D@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi!

I've just posted my 2nd weekly update in my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/

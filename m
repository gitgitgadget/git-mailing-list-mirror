Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6919DF5B
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140584; cv=none; b=ugAJgub/hWhpgdA2aWmcGH8BTnJXFLMlmEB9eTh4BzUj0drLwHrAQcjllRZNQdeJG2dtmYpHZyfRrPU025rkvPqys8jVHegzbPAnFrJlZEFO5tAFe1yv14FRHlB2yBA1Dub8SNlrtFS2aYvtpCxHp4dKgzc6Wgx1idkZ71VMER4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140584; c=relaxed/simple;
	bh=/lwsXWEzlMebSzYy4w/0C2KvIl8raL5EiKiHJV7H0WQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TE2IzVptKQbEVT8/ryWDz6kRO8OgidUdKX2wDctFiHhwiMX1mFTupZtBz0R51CgQxFcoQhGccgLEb3GGJ/np7M4G1VgAa4oq3DZpxJWAP4vOotp6oICIWHe2A2d8ykIH19Ev4rnGx6VIbcUybFM6IhFkPLoHwIWsWBOYtU+Rg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J25D1YHT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J25D1YHT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c980b55741so3699970a91.2
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721140582; x=1721745382; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lwsXWEzlMebSzYy4w/0C2KvIl8raL5EiKiHJV7H0WQ=;
        b=J25D1YHTXH/dRCTseZ5IZRqTpLqbkijBVzKpfNmnyrp6OLtsY7UQNleIFpHAQHSuDK
         d5oJh9Y2X4sF1+94/jEWkdad5rnJJlMs7USSAW8IdwX+w+o9o7+51tvhZPc3hC8gMzGF
         qDw+Vu9sr/RgQNnIvnZOXYtWt7IFPFZxEU4w6CnGozgE5JK4PjQZg45cPgxivfmZsq1J
         K+XvbeHhEm8CY+fPliEmsACTTXO+nKHU7r0SiAMLZuMupaAFVNdtCwxEXuGgkf5/+QaZ
         H8XXDjVb1yMGuFmyAEQ6FOkYZDYKYs80bQK/+3E07rWwhC9jlI25pnHtbgNN/goBlv3K
         Yb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721140582; x=1721745382;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/lwsXWEzlMebSzYy4w/0C2KvIl8raL5EiKiHJV7H0WQ=;
        b=JbopTL64dBWLS7APs7YPVK/MiAT71j7qF2JptrsRBd2UpcEcq23cKMFpjGOgXvulp1
         6bCQfHRJflKoJiSUCUJNFuFaX/Ed292S+5GTde+tyYklmtv/YCju9f8xHzDcjmhwWlu7
         ksgsVJjoyvSZixy09xjPxzsaN9FD1BX5Whm662QADs71SrFb9OpWq6HtI+Ybisu7Ut54
         6/9Bt92/03YaMlbwO7TLYizratgwt5i4nTuc4Bseu3BZx/JOfgPpkuV1beiRm2pLA9Nr
         OYp1jTe9C0HnK0G8obQ0oRbInjqXb1A6bmPFKxbtu3tG1DwV4MBVJuZA6cMr4E9styPS
         Wz0w==
X-Forwarded-Encrypted: i=1; AJvYcCU4MWucHpPFJRDKJ0o09HQBrV+wI6ZbaC9Ejm+JoBaVlSORF741AlGcEtLCN+RpwPYLLxuO0t4ppEfSQ7V8Mleqe1lM
X-Gm-Message-State: AOJu0YySsrcpLIsshMbNSDVORHmEI2JfpIRKbwepT4X41a7maceYJtJ3
	iDW7q0HgBEswbAnwTNpgdLdK+XDOqTe9tLCKeGk6E2y/y90yfFl+9p8VUhyV2jE=
X-Google-Smtp-Source: AGHT+IFha8UijSPeSIxX7CB0Vfce33rz6WsLTA7YO+RsD90lY+4CSxUG+riESa5JKUBhSLY2LGpBvA==
X-Received: by 2002:a17:90a:1541:b0:2c8:da73:af82 with SMTP id 98e67ed59e1d1-2cb36cb72e2mr2041103a91.10.1721140582150;
        Tue, 16 Jul 2024 07:36:22 -0700 (PDT)
Received: from localhost ([2401:4900:1c80:9ba1:2b04:8394:274b:70f0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd7037d6sm8369696a91.53.2024.07.16.07.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 07:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 20:06:17 +0530
Message-Id: <D2R1EXZ6J9OU.JE9SD5PBQ5MR@gmail.com>
Cc: "Christian Couder" <chriscool@tuxfamily.org>, "Kaartic Sivaraam"
 <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC] Blog: Move existing tests to a unit testing framework
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>, <git@vger.kernel.org>
References: <uhysopkwfeucsptx4n2jgase2duqhckcgujiyobqd3xw6ioez3@wv2vpethsjre> <D2GPA4L6OZG5.17BQVOVDLS672@gmail.com>
In-Reply-To: <D2GPA4L6OZG5.17BQVOVDLS672@gmail.com>

Hey everyone,

My Blog posts from past two weeks can be found here:

Week 6: https://spectre10.github.io/posts/gsoc_week6/
Week 7: https://spectre10.github.io/posts/gsoc_week7/

Let me know if you have any feedback!

Thanks.


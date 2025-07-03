Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C32E7657
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552091; cv=none; b=tJaVmRgzOYdKsqazuIFhKx91t1OH/3uSgjQrD9DfcI6r/dLA5LX0+JellAdG3IVEMrKhfoBS76FNakSQqbF/Bq3AmzJKI/+JZzpC52c8N4emzbGUsm14CYY+h7Ps5UzBGtO8Y8DCdAXweZCUXJzpvVhHucmtvyNm2Ydwm9uAiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552091; c=relaxed/simple;
	bh=kF0mlhKXhrIJWHe/h+qO6ZfeoY/BiuPqTdJXW2eSheE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RVKvb/wGU9RfgI3FlGknn+aN2MYKvOs8oSoCV7wX0Ewg/3wZ04T730UNMMpzu0cFuIJEPrGOlKiE1p72469VWElwNlU7sYFpuuwbOKAVdbuqZcugW8Fo1+kZLc58/yN54K15QK62VYwxUyE1c0BkzgfYJyiUs3d3JYmHm4uWFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4G3cwaa; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4G3cwaa"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a823b532a4so40411871cf.2
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751552089; x=1752156889; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF0mlhKXhrIJWHe/h+qO6ZfeoY/BiuPqTdJXW2eSheE=;
        b=C4G3cwaagaTX1pS5vMusQFwEdXBK4TiceOQyeyU31xCBUyya06CQ5+gTXe22G7PSjU
         2wgsP3KShc43pVLAAr2bqYc8NKTVb8uoR+U2Eo4Xzq0XW/KWHJ+WBwyP8fFBKoufRz/G
         576N+iGs6UHdQVtvYtgrCSBYATrvUypyVzdk/l8/6GfInAFqmxXmI7PCWq/nHLtc/TO3
         tfO2oAfd0NZYrrEJlnwKbgVCJDf3hqaPcUKbSb/sSZMoV1Gc6Zd0bgcgbHDXd5xNgAbS
         4HHqZHq5NakmnRjyls4lyacwvAhX86el0f6AmWjlCMfHkCk7ed2TrU8xd5XY5QGyKSgI
         7p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552089; x=1752156889;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF0mlhKXhrIJWHe/h+qO6ZfeoY/BiuPqTdJXW2eSheE=;
        b=MnIs8Kje6KWZbJR9yeNj40pGKAfI+e3lCluY7arCG1w6rUSwlQ71ABee1Cx7Kj1fdD
         cvfXxfuoANFDNSpYuwRfKlGrVIdc+h19aQgmZrmcNzOYXvV0HfcftFvThfwCXBpYYyIV
         lqVGHx1l5LpxWwdhLfqzSaCXS9TTLhAsIG7oeku3ZM3uu4zyoMNJQjpsW0LDUicMvAVw
         pjfMrg9AX5z8xoBa8yZwNsv3Q7rnP+Bl7f79Uv1mGpSH7KfILZe/fwm3mwbCmEfUGWSr
         m9yis5E4XMr/8GfiK87CdvDRXCJFmDeShvH9uyQHtnJXCL5axdLCASakWRWVch4d6mIv
         DX9A==
X-Gm-Message-State: AOJu0YxuBf7zpGuWx0EPma8a8nA9b2hOos3fEsa+wNl6dpFfOiQXN9EI
	eijng+PacfI1IysKipANllVTEMGEs53vhO3SceBkviEHcfOU0JyvAL0e
X-Gm-Gg: ASbGncty2ZGWAzj3MilPZGEkmwd9OMZMaUOtcJJLHGU3ov4AnJbDBXaHuN/G7j57gJ7
	C3vutxiXinSR+e/mLP4lLAuOW0ofadUjaRIMWgs0+Lo0uVTL6Z9pgE0a21r0Sk1bTI2tbMjmASm
	F2pkM3leI/pysIDV67llESaRbZyHbtk63gkkz7tpFWQqGPyQr2YAGfcItzQ0w0Le8+bWY72ytYt
	GP2QWbKLBgCcx1gBdsrfv4Q5r94aWRTkSm9j+2G+9V0wYjJ/rOW6DPtZKRnxQAjbZ6Z5diJQekr
	rT6xNn/o9J83k/oVu6Z0gXpVxtD8/JxwwysV/eu8l8eoiWHvwu+HOyao8wpn54aQVzlXq5VJKYS
	/QOfi0EQ+oOvGQFHB0+VvTf9l4g==
X-Google-Smtp-Source: AGHT+IGE2WAqceGY6uVApPl8d3mTYaIll3L60B01S6/d0AA0xipb+kIg/xa4Q9EDo6IpvC1SZQqr+Q==
X-Received: by 2002:a05:622a:124f:b0:4a4:3e89:d5bb with SMTP id d75a77b69052e-4a987a8b63amr64478331cf.49.1751552088869;
        Thu, 03 Jul 2025 07:14:48 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc139296sm109791621cf.23.2025.07.03.07.14.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jul 2025 07:14:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v2 6/7] repo-info: add field layout.bare
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aGZqPC47iPMixyvW@pks.im>
Date: Thu, 3 Jul 2025 11:14:35 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DBB30CE-D30F-42B6-A81C-35460B462D45@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-7-lucasseikioshiro@gmail.com> <aGZqPC47iPMixyvW@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Meh, `is_bare_repository()` strikes again :/

Yeah... I tried to avoid it but removing that dependency is work for its =
own
patch...

I asked Ayush [1] about this as his GSoC project [2] is related to =
reduce the
dependency on `the_repository`.


[1] =
https://lore.kernel.org/git/CAE7as+bTKE5opov-Xn0P8R+cy+=3D-XRkX9Wpie_W0717=
XMF1b_w@mail.gmail.com/
[2] https://summerofcode.withgoogle.com/programs/2025/projects/no7dVMeG=

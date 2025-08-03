Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB42AD31
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754261679; cv=none; b=WpZAZE6u0aLfPFX+JaFXkXGG6ACSEJI8vdvJt+BwSPCT7hqmJg3xFepi6gIu/AzOVM08GugwlWSY7DS2p+frFGgCFqG8VXD5R2JTEJlCu0hMSA4kqCwhazcRQLZj8lnvvtssa+AZ6hCo9as8skcCZDl1jahSDWmiVWNtAbFX8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754261679; c=relaxed/simple;
	bh=a2hrJmheOP0NDwJYclXhw0NVhD/uZikQ5ifQGhZC3x8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R97dXppNFRe4aZN/OVhM182IsHFzMkc0hWQN0KfA2P8Onh1ZZl06phGlLIBQRKL/eRHlfSV1puDJ2CodknX3lDfEO00m5OMvXCKMHSH7c8XC6t07rx+eygaiPvqVuKobKTLVpNQYrEHRxhas2aGyKvzkhRvN8h9c2pbCBjBz67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmIymA1L; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmIymA1L"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so4785380a91.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 15:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754261678; x=1754866478; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2hrJmheOP0NDwJYclXhw0NVhD/uZikQ5ifQGhZC3x8=;
        b=YmIymA1LCRnXW5JJSnt4Sw1jfdypo7Jm2EGfELEw2PUh9+DXgJu1W45jLS8MsSvXfG
         3+Iz0TozR6jAI8ZaIEuIggad+t7w+2DHi1vh8MSMNJGC5kktYlOyRy5yFKDz952Mr5Tl
         6gpV2SepM2ZGU3MfsSwj4ZT8Vfp2jUOexsHZDnHL5K2MBDeFrDC5W1xdrWhwWR9DWxe4
         CpWkYtzwa+uLbm9U232cEoAbNsyunTjTKaDz+xNGjGnxv26WPzOZZJZKDE2SSn+BXcls
         kLsbZJ6/l79r6X5WXzi/a+BLzDou9fbiGlxP2L0+U8Qr30mibg4F96kWKXUcBpjuJuFV
         jrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754261678; x=1754866478;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2hrJmheOP0NDwJYclXhw0NVhD/uZikQ5ifQGhZC3x8=;
        b=CShfEMogARwftK0CznOrkxKOEVvH1ZxQqkYHH5ty3Yszooky4ngGA7k3o96G/31AT8
         NBNLJrrn4RMgsL7/DrZxla3JCxl1LnuHSLEwmsYSrB3hXDXfI3p+nnBaeLi2WvI/dHwz
         GqUzSb1cjOI0eDiDzFLJYxDH7Bp28GA4VKqUuwwO0sByHKOBqZ41e753ZrW/PRWErgxb
         lRor0rF40I4jjpgv9Birecd/dIghG6Zw204cTEqmPkTwHP/r4wQKqV9MbaNjCmxeMgpy
         MJ4d/pjINznc+Wz06d+NRMxeuihUMLTxAotjrQNPtsjzD8X5JSEABAr85cljLCjwqB9n
         GXkQ==
X-Gm-Message-State: AOJu0YyaqIOzfahrmP707OZZcWB6EpxTvxp0uzs6y2uQmcoQLerHpbNL
	wsel+MFMJb1qfk3ULMBH8kPQ6wX2gfHRu5TlF1+AQGlb1gdQvZ4gLrxa
X-Gm-Gg: ASbGnct6zBBAeXOUvS0PaUhA0NzC6qcNXk97umD+NzWeVygm0KX8sAEmko5+K+DhXcr
	4HyBUHrmMD7Jg1BS5OFCqLZb1V6nqAfpP7tBqQHTCQyQjp0dG7GeosI/8AEGfm+FISSK4wM9ybx
	fVZpCuKGvoguRrrCdji5uIAhefC94OvYi6AXX01Zigj40fIVSN4Aqc8O1OJbGiA1pPmkB4F8/b0
	OwsPKb9oxcqozyHxu+Z/9X/kP0wHL8KcbnSVPo399GiocneGS1Lxczc32r+cJXBaohXC6TQjTdG
	NhXIs7aqXD8QDeUL/48gOk6mJZvB3CwdCiCXG2HVYXIW0Qw5TJLij0830MHGyY5iBLiBc25AT+n
	rXtkKH386SG7tY/X97LRCjbcjagUS8AuvY8j4GuG9nMMIX2MrGGYNln3B+R65tfuz6A==
X-Google-Smtp-Source: AGHT+IHYL3hu6PCICNsSqTUvNwJomUqX5RSHWl9ZLHRpBZOnzEkgLiv03vc/WT5YvtkSILTvoyUSug==
X-Received: by 2002:a17:90b:1a91:b0:321:335e:19cc with SMTP id 98e67ed59e1d1-321335e24b2mr2908264a91.4.1754261677777;
        Sun, 03 Aug 2025 15:54:37 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8359:ec14:6f00:6014:d8c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b4aesm12841217a91.26.2025.08.03.15.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Aug 2025 15:54:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v7 3/5] repo: add the field layout.bare
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cR=vRu7GwGx_wpS_GZNdX7giosDK12K+qQdOW1va-6oWw@mail.gmail.com>
Date: Sun, 3 Aug 2025 19:54:22 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: 7bit
Message-Id: <DADE940E-482B-45DC-8020-BD422FBA7B2E@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-4-lucasseikioshiro@gmail.com>
 <CAPig+cR=vRu7GwGx_wpS_GZNdX7giosDK12K+qQdOW1va-6oWw@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.700.81)


> The quote placement used in these calls to `test_repo_info` is quite
> unusual and more than a little confusing. I'm guessing you did it this
> way to avoid having to use a backslash to continue the line or did it
> to mimic how `test_expect/fail` is called

Yeah, that's true :-). I'll change it. However, in the next patch, where
I add `repository.shallow`, I need a more complex script for creating
a shallow repository which needs several lines. In this case, do you
think it would it be better to use the backslash before the line break
or would it be like it currently is?

Thanks!

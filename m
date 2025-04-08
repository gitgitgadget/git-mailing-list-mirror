Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41082AE6C
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079930; cv=none; b=SuurDVPKeztV7TgH5fvbJ4/RN3A84DIaBG/mwyYuKdQ9m3eaQmQQgAUHDow7oLFRydS4MGL2a9zdBmEFmfsmPqRneOPaAr2Rw2+VCWpsidcSj9MSCHR+JJyCdIm4qAcJUBsPDjLVvpqJF1uwP5ASjiiWkYNjMhibghPUtjOsOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079930; c=relaxed/simple;
	bh=f/HDWh4jXCsTCuLRHCBATo26f4Z5+nbI1UhcYuiLn5E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W8N8ggIq2OCo0Rrl1RDxAS5adOCLXXGLIEcxdw6zWfdE97GgRaIOL8VOTDSaBcLssZ9n+snrvzhzzMNdHzbpE72tDuRfNU3YkTkV4K5T/c3mHx601LshpxM8kwF7cbFi2zpyU6KRX+B93q1mOV/N/YdSvHndltk29warhf0JtZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm8irhlC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm8irhlC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22548a28d0cso69705755ad.3
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744079927; x=1744684727; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/HDWh4jXCsTCuLRHCBATo26f4Z5+nbI1UhcYuiLn5E=;
        b=Fm8irhlCGHU8QD5lcK1fNHobqyraSM4nMI5b0yy/ny9kxR2RGiwRRHmFlFpHnCDqox
         ZwSGum+mjV+SkdmmMiIbwlWzRISsE+nsJda95I69ewIlYtgaZwuyI45t3BUGSFaJNarh
         WN9rXvES05RO/jU4B2iZ7WhWEFEBHGLo2rGO2CQXjFkRygxKPNSR4Q32DhcIN+kDVTzE
         F0MZmmcRkNp7XS3AADU6BxObrUSwi30TaP8k3qjPpIhOceoZASHAZP4d+A0P1YcAk7fL
         kNO03dgIatqW+vD/Wp9OzeW4thmk+mg7HvDQV6WAb/iX619M1dFe5AjyOV/BAc6pW2YI
         pUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079927; x=1744684727;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/HDWh4jXCsTCuLRHCBATo26f4Z5+nbI1UhcYuiLn5E=;
        b=pUBkugk8S8xbtBNmpp2sMsthVKecZ5CdFwjq/Y7trlsjNgbf/H5rHvIbRCEiMOwzdA
         NU6g3mCTX/AKnZ9yAENhxDH2GP4CTo+gcbi7RfEiUCvaRkjU2vic061JWNRVTVTWpuK0
         HYejdZBH0Mgy4iyPkKDh3V9i5wqOQHFOu2zz3XRpcg+IFttiLxaMmcCPqbM0KI0AkKkW
         zxQnKE8vpHMJouYHJyMeGJKaC1ma3luTQNuFOmLBKDUjbXaYZM1h767QAnsN/p5D12EG
         cvnCGXtyjELrGDruChYybY8c/qOaYmKjcrI68yb5XUtyYbRCAlXBoh75AvcYSoAETFoL
         u1ug==
X-Gm-Message-State: AOJu0YyUB7QhBZyl6WvT92MV783EbZLqJcyBs3iCn7bVzmZZFvEjE2tc
	DO1GzOXlbAqChaXaE6U2LDkCtlPQN8kT97gFwn4rS+neXKMrmYU/uG+cuA==
X-Gm-Gg: ASbGncvHTw/csrxR5FlYT90HIm6lIC1mM/mfPunRVDK5DSIDQQg2EUOnwB6IVsqfscq
	uVmsO/NpMhPBtcwad9YhsUPJNNiiXFcZOVIo7y6G0RHDB5MUgqVa0soiXSryQtuLx0AMSv57WHr
	6HvhUuRfyKDhVYg1SYGgs/7kaZqgZs1j3fu1ToZOqAmxS3DvB8r9W8PGjN8yA9A2qKTEe9PeoxG
	Rsv294MDXJx0jOqYJ34aSEwIDsj30TbBg5u2UOFXcmwAjd1BRQU8jAkcaes1jvlk8csl+NdFva9
	9zlHguKq1+Fl20b3n7M7Azmv/TLdTvLJNITB0WQ82dT+keTOSuKegQYAJfVPfEGYSYt9gKR2CQ=
	=
X-Google-Smtp-Source: AGHT+IEjU2Li/TVxeYfc2gmepsjvhW5KrSZRwpkYD2MOysnMjKrLGJrFYtPLAo0YfUfw6qHdkwh/TQ==
X-Received: by 2002:a17:902:ecc1:b0:223:faf3:b9c2 with SMTP id d9443c01a7336-22a8a8682cbmr150940475ad.27.1744079927069;
        Mon, 07 Apr 2025 19:38:47 -0700 (PDT)
Received: from smtpclient.apple ([189.62.149.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787780b6sm88773715ad.258.2025.04.07.19.38.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Apr 2025 19:38:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC v3] Project Proposal: Machine-Readable Repository
 Information Query Tool
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <4BD1FDB8-6A7F-456E-AF10-DD3AC1BB507C@gmail.com>
Date: Mon, 7 Apr 2025 23:38:33 -0300
Cc: ps@pks.im,
 karthik.188@gmail.com,
 shyamthakkar001@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <E49ABB5E-8789-49AC-A6C0-93D8CBCEBD99@gmail.com>
References: <2E36129F-71FC-4053-A20C-D41C4B3103A4@gmail.com>
 <4BD1FDB8-6A7F-456E-AF10-DD3AC1BB507C@gmail.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)

PS2:

Given that at I didn't receive more feedback after v2, I just sent my
proposal!

The proposal is still open for changes, so I'll be paying attention on
this thread for eventual late changes.

Thank you!

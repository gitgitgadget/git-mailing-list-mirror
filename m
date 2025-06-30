Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69842AA4
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297274; cv=none; b=VHWVHar5NpJfkQ2SVOzYXClip53ImbohZ3ENph22Z0TfEBksD9Snodv3o+AuiiwB1QD2NxYwn+tnELT9O/3Bh/8K6KZCOrkeVCspu5Wc3gRE3VputbaQ31fpdFulMjPa/q4pwImld4HDlt2VEL3904P9Fk3psSgzLNAlklBlcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297274; c=relaxed/simple;
	bh=tXEHgHTpjurvuPJ/4Uk7iL+ohIC33RgTlEA/Jbx4dbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9gy0fpo20l51OPNkAPfgKJhPfhyTJFdWbembgLhfH2GLa1bVAxeSn2QiCO6kg46Njf4mbDtSR4i8CwnP1mXqIcDWmAlHh8mzOFI3Xjbutm2LEaLez9CxkktdhAeOTGxcuEBP0M5wDyqyMq9vH1bnicpGn5UTx6ANWt9P8kwh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m99BvNox; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m99BvNox"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23636167afeso18887755ad.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751297272; x=1751902072; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aqb2Y0hHIyWqPOyqzeyMrBkUV2A7SeowaXckC4ii8X0=;
        b=m99BvNoxqN2DLVLXYw8lbv9LaYx4K7O625+Xmpwfls4uuekv40cBIEfc3reS+QMrXS
         z9rOoydxpn88ddBMT6yjgwz6MuQ4mbtVz7Fjvi4fUlt7CqdwUr70dtNUklts3RQuyTdm
         WdOBEw1r6K7OTMHGZ28VEgFC5uxposugTbFiG7Qkeh5d0wKHb5BQ7J2aIc5rOxp9bzqI
         TA0iaBI5DPyIGHYm3+CbDX+86fvtgCCjFwzvcxZjuUcIvce6mYVp7i2U2pplc4808c4C
         47v7WjOrzgrTmOCDPGKklLRQsVCVKKqW0AJkHXceD46HZg0p7M5htybIIcS45uu/0/yj
         hBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297272; x=1751902072;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Aqb2Y0hHIyWqPOyqzeyMrBkUV2A7SeowaXckC4ii8X0=;
        b=ETgt98DKodggLhhJKOVLj+NmCBzTSilIfHoKOm+SaE2tQEY5OTx+2tz71SnFNA4+2V
         2BFpbaif03zzzC6ZQDceTfySbn+LhZoFa79yZ9ml9eSsvfDfcvTI7yrFAPNGawOlmXjw
         FbMM2rPzZJujf0xGGWpfM/Sgla44KL/ToI7NMR0MZTyGLqeYdWHyKm4Y0+ECQu1xfpnb
         fykHdc2IFWR7ky6+7hwKutXJM25MvKdoqu7ZfY7BW72J2/hKNqZMsjeVpacpA1a1KlP2
         AadY63Lg+/fpyGkAGSXcbMQGD+eDwpCXPFDraPTJUiioPphwYmJdoyZfLUSDOhI5zeVx
         5EGw==
X-Gm-Message-State: AOJu0YyHRJeDqQltjKxgZWfcIFykL2C2fskRoQj+gmwbRgwFrFAzDrvO
	n6CNqE9ec8r/CM+Ry083y3MLkZrV3CA276xSQr+RFInwcMB+txxA8hKb
X-Gm-Gg: ASbGncseBxnjGkJjvgD98BAiP5NjLM4lqHj3bHUMYT3Y0FhsT+RU+3JSFWDpMpgCNRp
	OpO8doJcu5/rg7fKlzQwlqsPE+Z86gxLLKDHOccxRNrKYGnK3sr+sTVvvDgRTAV8zvElHMg9ex5
	aodBa3/u/pBIMR76D+RjI+7xp/B/TKaPHk1QUNPg+3Q63i2hlH6GivBWCTgd+liPiN2LPC5Fblm
	1L9EHzXMYy+2UcoTo+/WlDxIU/VqTcAtDc8Gn5uGQoUmB05LiMCjPHIZ5gMhePuKHm2wY2vYIwd
	23ume0BQBzjhLm2y3SdTA/YWntStScIUr3PsG1XEuBFcZ+711gZNVr7vI0kd7c8x/DV25Ijp1qt
	TbG6UfoLvcee86rI2Rncc7yAj19o=
X-Google-Smtp-Source: AGHT+IEsBqGJ2CEdCQXTQdGNWZRAL6nxudtpUldtlOz7aKuapMBUWAwO48QiZDjTVO2n95o0lSXdpw==
X-Received: by 2002:a17:903:3d0e:b0:234:98eb:8eda with SMTP id d9443c01a7336-23ac45e2211mr277299405ad.28.1751297271906;
        Mon, 30 Jun 2025 08:27:51 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c2352sm83090335ad.208.2025.06.30.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:27:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  chriscool@tuxfamily.org,  jltobler@gmail.com
Subject: Re: [PATCH v2 0/3] clang-format: modify rules to reduce
 false-positives
In-Reply-To: <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
	(Karthik Nayak's message of "Mon, 30 Jun 2025 10:38:19 +0200")
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
	<20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
Date: Mon, 30 Jun 2025 08:27:50 -0700
Message-ID: <xmqqzfdp45c9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> - Drop the patch to add 120 column length to editorconfig. This way, we
>   will continue to use the default of 80 columns. Adding a higher column
>   length makes editorconfig combine smaller lines during block
>   formatting. This is not desirable.

Makes sense.

> - Ensure that meson specifically checks for 'git-clang-format' and not
>   just 'clang-format'.

OK.

Looking better.  Thanks.

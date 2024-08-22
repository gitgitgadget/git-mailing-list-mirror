Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7771C9448
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328347; cv=none; b=h6YVuftT8XupqKcMIoKf/5Vgb8O3MuFTXCcALz3X+5MVaA+MlQRfdy66TWw9xXNP4u/pqM4D+dT833Qtp/B1R6P6/WxCBhVpUn3mX9lNCXfkU1z1JBJPeS7FimPk1hl88Dydc4aN3tHmkEqgRSuqtMvnDJgUtuncZTGY84q/dEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328347; c=relaxed/simple;
	bh=TcK/+EqEx/lnW+PAiEFiHWZYIxXphEZdq2U0Hh8174c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH7XYB6ASAG/zeWPqVFIToxAO39ooucHL2AFLWqjhcSdqxZgPQNCwZudaj/JgCRoXVjIdGmgROjZwv9zjD5GhZ/gbqhnpterqNwKmKU19ZBa5613tbl+m/3kCEcX1JLbCzjcDuBdkl/siVGmbJFqdJCt4KrQyDDeOyfkFmNUgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0wEb+Ez; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0wEb+Ez"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2023dd9b86aso5697465ad.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724328345; x=1724933145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cguvjB0vWlxkk2HZT/sRz4KpSgCKcqiQoYmL7AzE7po=;
        b=V0wEb+Ez1G9eNDfffzN+w8leDVgyfZpqrn0yOstgNP7n1haAsj1EiGAnuyPKvYutnW
         PiNI4c/gQdsWzSHygladDoXt3nTxXSGKSL3cwDdlvHfXRBCCaq5SSZyUoxEFtTeDDeV7
         BtnFd2HKn6tcvN9lgiTZo4ahEr6mw8DCDJtx5+EMpZ1D4LQkjXUz1XBE/PmCzCOG6Ncd
         O1s5u/mfE5YG+KkHKbjc0MArJmunFHgPtTzNKfM65fy5Nw57tVFl84XOxI4rBX7hov9p
         LKTbKAe4481SIDNl4aW/WU9F4EiQd0x6IFKHCeVWKPLyI8Cu/8eavFlMEoDLgVsN+GsZ
         1znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328345; x=1724933145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cguvjB0vWlxkk2HZT/sRz4KpSgCKcqiQoYmL7AzE7po=;
        b=rSb+jrrK+8nyauz5rOrwOgPqSiIYc6Va7wlK8AGDfMwfFFOWHAzeXZS37jewTDlYPa
         uOgdw3lHcpL78JnJ8C55b0lzmyV9jugHn9CPUUmQwM2EIHbW7YtiQGfFvVdBQezHM98d
         hAZMyCeQi/9fR3JHrEIRUAP0g+Kd/3uHQxwOfruY3LN/NpHp235sxXSd7BftEiZElQRM
         L1H38Fm+R+wuaHNh6tTzo26EEm2+qxJT1oxyw/lgzHX/M5Yc0UbFDNe99Q9s0To3dA1E
         qZlfexUCypWy6QNUfjr90DEKmKuaWh6G3pqsU+h65h0gKWr0mE4vv7uwCJHpI2ohdzHP
         xpQw==
X-Gm-Message-State: AOJu0YxnkszsoaOusIoazOqZ2WnbhY5FvJXgkUCJthk+BstYQLYy8C2K
	PJeHi+IFJ926Nq3nvaL7p/QnEBenvCYcM59jhuR0s0uMJBTKn59t
X-Google-Smtp-Source: AGHT+IHLaDDF/tkBuBVK5SkrMbz1HZJRTLSazeXkCri5/p20LWrLFBs7gM4pUpGW7czacia+6+lAjQ==
X-Received: by 2002:a17:902:6bcc:b0:202:26d:1465 with SMTP id d9443c01a7336-203882048b3mr17391295ad.14.1724328345145;
        Thu, 22 Aug 2024 05:05:45 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855682b1sm11212775ad.46.2024.08.22.05.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:05:44 -0700 (PDT)
Date: Thu, 22 Aug 2024 20:06:29 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
Message-ID: <ZscpxXaHLpycuMGH@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM2DRDbJsvNjAM@ArchLinux>
 <Zsb7XgX4Lt_4LX_P@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsb7XgX4Lt_4LX_P@tanuki>

On Thu, Aug 22, 2024 at 10:48:30AM +0200, Patrick Steinhardt wrote:
>
> We can avoid having to indent the remainder of this function if we `goto
> cleanup` here.
> 

Yes, actually I have thought about this way. But I don't want to use
"goto". However, ident is noisy too. I will fix in the next version.

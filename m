Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A524CEE8
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373019; cv=none; b=E5KgKhEYifYgSs19CJwON+kEsOR1JDV5YSwk6+gAhKe7o/avZRuFekfGnkePUrmuX9tW2BlBUjnhqUInv05BB9ELkaw9m048HUlg8rhWQr+K7CSk/nmeIm0ppE2OWtW1ZE8iqW8xzvO6HHmzgWb4OKic9B0bD2Fuh5I77Nweezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373019; c=relaxed/simple;
	bh=KIDV4b6xjxwklOxIFRGicbEQ9qGuBBxUlI33UTT0pSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSEJ6oHqJvJDkW3AQSEwAaGUQ02BkW3eik4RRf4LzRzlIEKs6Cpf3Wls5CuntU0EpxNkgl4P4lkXnle0HtrVCZTtdQsNF88nQQCf+B5mwsCpvwJR9ntrnB3g6LlToeX1WaRxrhViQx/0orTVfRNlkw//ViguxV5D+plMVv1OTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik2/zzDQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik2/zzDQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27edcbbe7bfso6562835ad.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 19:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373017; x=1759977817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mebHahjC4pj6pEr98UClDJGQFI2iOLu59vwbVswIY34=;
        b=ik2/zzDQGD2C5qkXh+QnE6l2Wdxi0MRXoCZxjdA00/SD/rgyto7knNGA1CRP8QDI25
         lAYTsmNQJjRQLdfFmiZMhygavyoen3V5TRxUNFhlBj6+EVavLz7ifVBsEBvZINMdXbTJ
         rX0Lf88cCuNNjts48D0osOXF91cFcD3D+VST84xeg113bBa/kEsXJrwGYZeuNtHnRmvl
         B3U601tf0GpHM860W9vIEzxM/xK8XDG/+5gJTLbZYZTcLqMr06otOk/4vy6KIiK71Qvt
         BSnegjBdcPdTlH+aKgeqsItMsuIR8WNY30ALfb/tXcR51m5NCGO0lPf8Vr12bbOFlstk
         sltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373017; x=1759977817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mebHahjC4pj6pEr98UClDJGQFI2iOLu59vwbVswIY34=;
        b=H75nWpeWB0KVnuKUsHRMLczsalPLF0SaH2cY+RXvK2GTlmfWA9dAeiKVZc39GocvVc
         kKFlD3FjMiL1aJjJ1Xs8fP4LLQIIqc7CJHVGJuypcxzRHDy2EmFUbQ/CdLnKFxbIvy05
         e24+9cljF4/ibwgxEpxV86syElMnFa8A7WZwRKesmderhnHdBDBTjDbIYBECR8cqJeoa
         SWL353KiEEeSY9jWJkfB+EDC37fjqRj5ljg4YKOhrBMJqpbh2KrVKghh0jqUDMeZt02C
         gf/i3LbgofBzIrScbuoeo0JkwB5n4OXmO4W9pVCwK6thY2+m2KfrmyaRYQMjLW7RqeWG
         yRRQ==
X-Gm-Message-State: AOJu0YxJ5tO9A9wU4Z53I8UU5n951KF9Zj8U8cEGnQN8dAP/F5ic6aaA
	BZqdh49dO68XSGr18OzB53Diba4mhn7HVr4n0bOLHMq9jl0KELAX8XXBLHiR5ZQ0
X-Gm-Gg: ASbGnctaSsA651ZR+XCIlHoK6fzopHqp+waucUzkgsOhcm+nDkzXIhTOXOFSa3zxfok
	Y5w8lD0gZbXPlBJ9eg4aB5dHiaf9ulCcnOQtX2B1scaAh+0anCG/cranLBrSNCw5rl7pBTEMld6
	PwSCjAUMF/d1h2TN7CXO/adPZrbRy4SuUTTSWY1SxT8wgIepzR8m86UqrOTadClJfZwaJchLPod
	3e+hBoZUtBIG+dHalAU2noHMklAguPxHYsXLCRp8hy8BvZmRyOpjINkqE1ClgKTi34LkQqDvgLg
	PZte0sl7ogb7zI6hi9mnKHPOqHQW/TH5sAUl2g8phrFOLsMWd8wh571wDiHjxRqfBvejm1pXZK+
	ivwIwxfjg0QdLVP9o9SSQwvhVqP/1ZAJsVlKO1829Bi0bDg==
X-Google-Smtp-Source: AGHT+IGlPA/fISvgW5D+f1asxpUFb4LazWZRGOVYhMNDo/cL41mrHnJzfNln/q6Rx6z50feb4osIWg==
X-Received: by 2002:a17:903:15ce:b0:264:70da:7a3b with SMTP id d9443c01a7336-28e7f441e97mr72125085ad.49.1759373016984;
        Wed, 01 Oct 2025 19:43:36 -0700 (PDT)
Received: from localhost ([2804:248:fd27:1700:3748:9d8c:286:76f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1108b8sm10236175ad.26.2025.10.01.19.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:43:36 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:43:33 -0300
From: Henrique Soares <henriquegogo@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: How mantainers check Git diffs and patches?
Message-ID: <aN3m1dvc5yh0CGTG@localhost>
References: <aNygY8Cm7LEaBzV6@localhost>
 <ba6b9a5e-72b5-4d66-a484-37140438702a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba6b9a5e-72b5-4d66-a484-37140438702a@app.fastmail.com>

On Wed, Oct 01, 2025 at 10:15:35AM +0200, Kristoffer Haugsbakk wrote:
> Here is a relevant message (2016).
> 
> https://lore.kernel.org/git/20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net/

Hey, this thread is pure gold.

There are a lot of comparisons with GitHub PRs (BTW, that wasn't my
motivation), but besides this, it's pretty nice to see the review
process in "e-mail flow". 

E-mail threads are really great for discussions but before I follow Git
mailing list I did never realize how useful they are to PR reviews as
well.

-- Henrique

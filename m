Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8B19B3ED
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592984; cv=none; b=rwit/E7u6dvuJcbFYB6/Kn39YQUAVGPirulkEzNhVGqS0DiuQ6y19hIu24NVOHluABkOXZiFMvBNfAyYlgJSUKiXbnxzUj+tWTUkX7G0ahGL1BQ6vIbobjj9ulCmdcOvbzArvMKNhm8/o9m1p8oXVDnEqcB9oP3B0nMOs4gPWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592984; c=relaxed/simple;
	bh=Tc0Sfa9A+R9XuD8EO/U/+uHo78A9YwLHWCR7vfOw9yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQN9417ezQGRAIGRII1QL+MJBcOuM8yBys86bPMwL36fQ71YMn2LDOtZ4RV/Sa4lnwQZn12ISFDsLe+QDVpjQnDP5Uprk4o34Xds7rzCD69Qx2exTcRgOoKmVFhUpClZmJS7NProwYdDbWDj2n1pP0U0AhvQXhX2cpp4mp1AniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyA2mzQn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyA2mzQn"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f629a7aaso987588066b.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729592980; x=1730197780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZoJdFCHNegfjWTZ6JWMBFyCBacexfSGY0SzVwnTQpQ=;
        b=YyA2mzQnIWLvpmIBRybP9NabyP/jKAVyoOu+I4o6x6Sh0EJreMEimw/W+/kg3dKKIp
         DYtZyCVdvlYaMQTKBuFKMKLWFSes9AszrDMwK83kJBXYc8pra53sL30LZF7WzErVnaJh
         v1OauIRS4c1QLZL2WOEDENr4ckkHmO4Vxk27BdYxGtUIIR4+wvuOdONO42yqjhslqHFx
         4+ohmVVV5bYu+12vdxQAXkm6xXS1bt6FU95gWJPzoTZku4E0z/7EtzEZuj7YIAkDrssU
         gYH0l7dMzZRKT3/TevbrSJ16R2KsWYaMdFkyHklA2gU88jiF55M8NvOdEpTFbRZ7GWiG
         iZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729592980; x=1730197780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZoJdFCHNegfjWTZ6JWMBFyCBacexfSGY0SzVwnTQpQ=;
        b=jM0GpTTmEhGGijOB4DZ3oJS1EX4s0XzZpWK3NMNZW5YdCYLPKRRGy0xPThAbjYLJ0/
         Q1coMUvTi1FSpXQr0KlnHNmNwLhjHXQoRjPj7AdwEOWkiYeHFLnmG+MPnSa1NzQvBel7
         HlbCh6yyn2o20E71plzBxpHhH48UdQVAdjPaMLFvcNZQi7LjIXvjczAizyqiPK/zoqOp
         AydNTFxIyNVH74zBDVJppwzTvUmeRXOp0pWp3Euoi0xExH0Eus5EGG3QWBP2m50D+2fy
         CVYvplZsMRo/mBreFrcWC05yETdY1hUioOoUuTSrM7an6c8pJ8wFp1lmUOluMVM06OYE
         i+cg==
X-Forwarded-Encrypted: i=1; AJvYcCWvuTvYbQ+IxAoELPauHiLK7IUjsOZe5QvO7HTKT+5zphRQv6p7W779TbLxRQBe0/WoT0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjP6HMsWb+1Q4pLd4uPzPxl0rouZSt5QHtj5HpJfuzEdGuPw1s
	/oDswkYnx09eTsTvZN0VAVFbkERkv1ykyqYcEpyqtZ+Ro8sxMjlk
X-Google-Smtp-Source: AGHT+IEHV72/bRrKhnrer7yD0QGmT87zZJr7rVA21n/v3mTaRNQNt1G8GLbwJkNt6uX/L3Gnp6hfxw==
X-Received: by 2002:a17:907:94d5:b0:a99:6958:a8ba with SMTP id a640c23a62f3a-a9aaa51a5c9mr273113066b.12.1729592979697;
        Tue, 22 Oct 2024 03:29:39 -0700 (PDT)
Received: from void.void ([141.226.13.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edc1dsm317463066b.56.2024.10.22.03.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:29:39 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:29:35 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] t1016: clean up style
Message-ID: <Zxd-jynYyT2j6blH@void.void>
References: <20241020121729.27032-1-algonell@gmail.com>
 <98c5e44f-42c9-47c7-9fa1-e6cc3b35cdb4@app.fastmail.com>
 <ZxbLlA0xbuhP7DJK@nand.local>
 <ZxbMFQSL1brz86f+@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxbMFQSL1brz86f+@nand.local>

On Mon, Oct 21, 2024 at 05:48:05PM -0400, Taylor Blau wrote:
> ...but after queueing, this patch does not apply cleanly on ak/typofix,
> which is what this patch should be based on AFAICT.
> 
> Andrew, would you please send a version based on the aforementioned
> topic?
> 
> Thanks,
> Taylor

Absolutely, thank you both for the clarification.

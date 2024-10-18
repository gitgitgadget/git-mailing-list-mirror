Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3B13541B
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285592; cv=none; b=c1/QzN5sSzrEBbxqiSlLlSf97kuN+SAoqouRD7yzTJ4I5D34W9iHwQy30tT3CGeBKVv26V1R9ANyKUs5h1cagkNyuV9uFw+2jPh2w73tvT8WVTyxTbdBPIRWHV58p9525eSCD8T40tjHJGaLhNpQ5rGMR8aQyfqIRYyeuqyw2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285592; c=relaxed/simple;
	bh=DYHWeAtBRPgOmZs/dw+qzreon6xYIipeZElrKjH0itw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/ZFevO772bq8uJekJB9k70Yrog09y/FU/SjDMqzLcvwDxhH/OjLmeIyFsvLCKExO+F3m+toZkWG0JFaHDSDIvKkUm7vxXQbv1PdDW/GPEeJ1d31GbDc0tEC5Nlnd9euv9Ja5syywOes7ifRLzrIA5acuhW/1FTsQsPLR3KRQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DG80Fl54; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DG80Fl54"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e2e508bd28so20341187b3.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729285589; x=1729890389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5isbZ9/4X7YJ2BbaCCxET21yD5wyehB+g0kQJJ/qSfc=;
        b=DG80Fl54IUVjSeYtIkLwLeyuOaF6mSQ4hm1X4R5LLmd9jdd1Rua9sxvMPkwXbabsNa
         NeCAsMziI505br/JIyYn41tlZLkb5HYHAblpFat6TkIIuKAGGz04kd2bPjheEowf8zkA
         jS4WYN4UtKFY1M1TSm467ho8oezcdNvyC/it5I2/WV3G4l7HOxkp020HZgdurAZef13S
         UmHrpJF1nAtPcdVFLgvJaRsnM8TfN2iLaHZaDSLouolB8HYJWTjuB1r7yKVhsgQam0ns
         R2ykI2R3D5yMxcBPIaBAKXdUl7v8YrfpV0XypNnyocw4MxWc0EKzdgv1tbrFVraeJpup
         wVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729285589; x=1729890389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5isbZ9/4X7YJ2BbaCCxET21yD5wyehB+g0kQJJ/qSfc=;
        b=cu5XdPc/hnMwkUA5g3vW4qJx8/l9qAsarkPNU8/1tJHHXs2vwjs70XQl97lbPbeD/t
         XctwTMCuGg8nPGMNTCFarQDrGHLVX42fscjF+r5pBB6yH/i8fBuTAnKCtpEgvJDMXnEP
         4dd8HbIpmK4i/3X+ytvh/tu60rQEsyEFnCpksdUue78J9cwC0wY05BapJFCvTFKxOpNc
         X6K3Gk7nuLKTwC0jEwzkzClFpx3aaaxapgGpFrZKbtmiSCFDmEdLp3+ad9DIMhzW9Qss
         5CervETgQZ9fRO2xnu3n+xJuJKvHdBGoBfVcmrXJYVkqAAS+91j02snUTRBwVjZqy39M
         HUXA==
X-Forwarded-Encrypted: i=1; AJvYcCWJkYoheWuedri2XQxNsOtpUwdF/TEC7WkIZJ8QXTqA0Yx1zZh1eYDzxOwIItd9zaXlNWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycsvMG/Xi0yP9GK4DvQcsV1SD6wyQVkbK9OB/2S/rMhl1Qq60v
	NKVzXVxsvcoI+km4HYHycWkkb60afqVhPP9pLM7fNKNzbQcrHCsDNTi8TIKtbe4=
X-Google-Smtp-Source: AGHT+IFl3XAc0kQOQT2t0Lrfe/Lg4/BsVzcGZUivZxFFQuQAsvsjz1beEPExyiovZ6bWXywe0v9JiA==
X-Received: by 2002:a05:690c:3001:b0:6e3:e1f:2434 with SMTP id 00721157ae682-6e5bfc26e7amr40823297b3.12.1729285589253;
        Fri, 18 Oct 2024 14:06:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c1453909sm4476327b3.89.2024.10.18.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:06:28 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:06:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxLN0u5r88hQsY+c@nand.local>
References: <20241017112835.10100-1-algonell@gmail.com>
 <ZxFyKXDCJkRZYYQY@nand.local>
 <ZxKSFBl_pV2r99dY@void.void>
 <be0c95ee-1d9f-4e97-9710-0ceba9c3aaed@app.fastmail.com>
 <ZxKi7qn6tEWyBXsd@void.void>
 <ZxLNj59mKfZubiY/@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxLNj59mKfZubiY/@nand.local>

On Fri, Oct 18, 2024 at 05:05:19PM -0400, Taylor Blau wrote:
> On Fri, Oct 18, 2024 at 09:03:26PM +0300, Andrew Kreimer wrote:
> > On Fri, Oct 18, 2024 at 06:58:48PM +0200, Kristoffer Haugsbakk wrote:
> > > The code style says that redirection operators should have no space
> > > after them.  See Documentation/CodingGuidelines at “Redirection
> > > operators”.
> > >
> > > --
> > > Kristoffer Haugsbakk
> >
> > Thanks for the clarification, will address this one as well.
>
> Thanks, both. Kristoffer -- it's fine to do this in the same, or a
> separate patch in the new round. Thanks.

Oops, I meant s/Kristoffer/Andrew/ here. Sorry about that.

Thanks,
Taylor

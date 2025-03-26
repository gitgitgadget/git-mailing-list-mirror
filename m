Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C8219A8B
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010166; cv=none; b=meqGDYukGEbyue+1VbY60WAWnzBcYfK+Qkuw1sY3aNlKlnMaJeRngx823Ka/JwRH/LJnFpI6UiMFQ8rL2mj5T8GHXRunSPyV8ODTAzW1IEdXWkm4fZshve6+9LBpC5TmESgj2lWrOoi6Wk9ZYCXe74zak50D+0x6Ubm7HaW+96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010166; c=relaxed/simple;
	bh=+xAVtuGaom7mcD8rHPfWcamC3GIWcr86U7fhsSgpiyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp+RsIwl9fiHrWnbR0ewvYgZgNvp14EANsqrwQFQtbL/uXTmP/j6FP1euUSEjIBlnHjbBBZiW2DSdRRp5F5cSwf1dBoTx4DdFvSZFoxnCbrUNQjsl6l9ynoGZRqQQWQe8is33BaxzvVWOVuvtqsKViVltTMLwGbydNqSwAOi2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=f78LffzE; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="f78LffzE"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e900a7ce55so307636d6.3
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743010163; x=1743614963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xAVtuGaom7mcD8rHPfWcamC3GIWcr86U7fhsSgpiyk=;
        b=f78LffzE3K49dVtBQ8JmhRk9cHsExg2PCCo1i2pIvCmDC++9mo/EjIICXg/tGagnkX
         OPuOK5q9eTUoaD0ULgD2qmxQGUVxCp5szIYmw7/Oh78rMK0i0oJ0gi+42jVF/zlRI4z5
         jBTUw0rkrwDjg9CYXQPVQ1feHbqT9HGNAbeSQuzl05Sfn2yuW2eIGSlXidP10JHg9x8F
         UTiUVE9gADvAbteqoD2PVic8uIOSoZQTbM5bvETSYy/tYeyZbxjGGMrKACbO4WwELZqj
         3ohUrLFcySaYuorWFFSm32GJ7R5F3Ftve4VkxctmHN/sUFLyeX+JxvgojGTvssDnsGP/
         DhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010163; x=1743614963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xAVtuGaom7mcD8rHPfWcamC3GIWcr86U7fhsSgpiyk=;
        b=WNSupS0u5qWmUN0/Ie9yNuuqLUWLhYPe31ewFzVtA3cWvB861PVVh+dj06cP800L+e
         SJo6fnZQ0azZs+JP2WnYruzOgnhOD3w/LFkiCAX1u6o35QQZxvCp5t720vy0U3O6p/73
         NS8uJGPGyUK5/LUji6+ji7wxS96sUNd4Agx2YcUQ5JnBXjNZ8cvFC5/Or5wO0lSIMLFK
         SSMw1S4xfOxJ7jEu02v8FO1gd0WxxaSd8XHVqRO1LgKgLduIgMZnbKHDsS28QfA9VJAB
         sdlsyEQP2DmAtMdOGXB+U3E6YXTfBy41Jv/dfOmwcHfKAZjzXbdSVCS5BSaBVmVNUO1+
         Fm7g==
X-Forwarded-Encrypted: i=1; AJvYcCVitAATs8uinR7Ry35RbGl6UYbCB2/1Y7NWB4F+fE+0ojYbaMEF03X8ewN2Narb4c1UxrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDv2BXm5/mk0uQgaHHYqXNNpqHNl8xwBMPDk7RsTNcpzZjjOgr
	TPgdMaTvoiNdlbS+Gy7Nd3jY9dVHoIYvOuN6s3x6UbO51ZFtPBPnSSEEx05xVso=
X-Gm-Gg: ASbGncuWl8ZJBiFT8m+ti6JwITD74qN9b5tDEkQ+5pC82wfmYucbZTsNN1oq8UxUe9l
	porPDJWRD20TiOhZr5RII+2VvOBzEp47Xf5b3Fsn31stbQDL/eq2fpdv4slp02yK4DuISan+hbY
	JcNzXrums+JvopeoI8ETUmDmOxZ0B0TOhENmI+xAYA5rdlCuO+0WZ4BW3iuib96VWtdg0b6yrHm
	XVpNlTmaLo5RHILP7JyEx0tgfJZ1Xi85ZoBzN7a1lnwRwK/hMPdaAdLv+YXkqsiJxoV+pWTDYEx
	/tg+YjiGhzSRje2JjeReaVQDkz2md+b5Ai/x3u8us8cu5sdnd789qk7xENiTtH8Hu3BntXEIHkI
	jCOL6adGIWrh+X/UC
X-Google-Smtp-Source: AGHT+IFhb/FA9OuFgnYESldrKnoL7OIr/Tc/GN4tg+ITLA0eLmLyCsWS6Y2Q+Ea/JkC/kGqQRN8+cQ==
X-Received: by 2002:ad4:5d4b:0:b0:6e8:ddf6:d137 with SMTP id 6a1803df08f44-6ed23897c57mr4070396d6.18.1743010163015;
        Wed, 26 Mar 2025 10:29:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3efc557bsm69203346d6.90.2025.03.26.10.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:29:22 -0700 (PDT)
Date: Wed, 26 Mar 2025 13:29:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Philip Oakley <philipoakley@iee.email>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] Avoid the comma operator
Message-ID: <Z+Q5cWAHxxNm8BhK@nand.local>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <f30d8ac4-4748-4b73-b86d-6f85c9bac622@iee.email>
 <ea6bfd92-3d09-c611-abdc-dc7bc987446f@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea6bfd92-3d09-c611-abdc-dc7bc987446f@gmx.de>

On Tue, Mar 25, 2025 at 03:12:21PM +0100, Johannes Schindelin wrote:
> Hi Philip,
>
> On Tue, 25 Mar 2025, Philip Oakley wrote:
>
> > On 25/03/2025 08:01, Johannes Schindelin via GitGitGadget wrote:
> > > The comma operator
> > > [https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
> > > rarely used in C anymore, and typically indicates a typo. Just like in these
> > > instances, where a semicolon was meant to be used, as there is no need to
> > > discard the first statement's result here.
> >
> > Minor aside: How were these 'discovered'?
>
> I am working on a GitHub workflow that uses CodeQL to find such issues,
> that's how I found them. (I also worked with the CodeQL team to get this
> query added, way back when I was still working at GitHub.)

Neat. I will be curious to see how the results compare/contrast to what
those of us who run Coverity get.

Thanks,
Taylor

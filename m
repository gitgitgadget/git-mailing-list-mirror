Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F060D13D297
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730073074; cv=none; b=MhIc5CBh3QSEpl2CwDvmEYZHgeTYj1aTffd9r1iVE2KwfkifRNiZ61AWhiGUaDYituw9dVA4Pu9Eljvj07KnhTfDdLs8E3Ck5onlMTfpZ24M7CQvsedFkxbHA6Vp3U6p8p16yzzauP+qR6mlsl+tPK0VOv7L3EMnqprfkKjDXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730073074; c=relaxed/simple;
	bh=CNWxh3SP2bHnBkqDXBWMndV5uG0+tOOGe/N5kUT8UfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9vs200WZIADLR1AUGL7A/Wz+Vh2/S+Zz/2njlMrqQ4b7ubUMDbAcUJRf31FSx6QHEk/9+JB241X5QZl15TgImTC4QdrnM4U3XAsBeAnSbp05tjJe/GiwnLLPCT+8y+LYAlzjyicAFKSv76TGuaQFuaemrmpewE0eBUElLDCT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2x537YNu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2x537YNu"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so3688290276.3
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730073072; x=1730677872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OhnkIr4L8eA9Sb9nmFYz4PQg8VGuykH5uV5vM6kD/s=;
        b=2x537YNutKi2RUjA6R7/cn1gjIMTtK3y8/OlSqca4HK9qwk9Qd1g5avIEdWZ2rVsDs
         rHjHSNLiUXHVCl5ZwypK2JOLFT0QQW6TsGDcjycOIFthrVeWQTozBe1ZUYsX2ALuFni3
         247d+a47kbw7SDu7drqzP/A8h3BKwpFC2lin1o7xeBY1RvXwChEg6b1n4g+dvjooe3Kv
         b3GRlHFIjH9Kc3EPoHW025jxsp44CLjx4njw9fibQ6UJeqyPfHPmkHFRikd7ZrGUCpOd
         GdBgGFkTu6OwbKFITtRA2DfOFyCvyetibmJ0rwjxv/eva59uq2tmlwa47Ys7d1pDPdFu
         QaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730073072; x=1730677872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OhnkIr4L8eA9Sb9nmFYz4PQg8VGuykH5uV5vM6kD/s=;
        b=fJHdOsRfO5te32VlbqOXonrpz/M2Xg/F/lxy18d2QAW85Nx/gdd6wooIL4+aCKkUCO
         RcsD0S4DX91aFl77Nrna2B5SVD20Vrn43q3qtjhdBHukP7CgQ0e25kIb1LxVyvLKNUbA
         cfOyo2IFZ/GQHbwRs5dyQuxPJjmukJ++YGtAZffgp9mM4y5rNAyKmAq4j7w5yXSL/8jL
         f+YKxyBZeGwmBae7XdZKdS4qvGz0u9MlyCYnb8ajAhznkPi2nXrIHQWsCP2/x/U2Xl9t
         zKLTnNdf2AiNUViMsH/B22AO6ieyuhFa3Zi1LxX9QIe1AMPqaIq2aRpPHODNVlHhWtNA
         NmHg==
X-Forwarded-Encrypted: i=1; AJvYcCXD+9rF6/3CuKA/67tbbRV4Ba2JlpqACRxEesSdZOeHqtVM+QDxVCdGI1shgIzZnfdHx+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzhPjBLpjny5/6eUo9wHlBx/8Y8JtdA6U1js+8DMGGGF0/WenO
	24mAbIvbLuzrP5fz/lJ1YCA1PRce8cCwg9F7hbvlnmqVaPyMEc3u1kqlaF9uxaQ=
X-Google-Smtp-Source: AGHT+IH0R4dDnXuiDzFw+hd8fKqVTz2cDErWD7pMDQ+IBOmT/VQnESmsoWjmC0fmr8OPJ3+3+YQzzw==
X-Received: by 2002:a05:6902:2b88:b0:e2b:d5ab:986f with SMTP id 3f1490d57ef6-e3087b7bc3emr4506699276.31.1730073072002;
        Sun, 27 Oct 2024 16:51:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d73bd4sm1113566276.18.2024.10.27.16.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:51:11 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:51:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <Zx7R7R2xDXX0m0kU@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
 <c308eafbbb5a7c853b8126750c4c44a8b8635192.1729770140.git.ps@pks.im>
 <a769d5a6-0d0f-4df4-b581-539d00aacbc9@kdbg.org>
 <Zx5eipv_Un3x1j-4@pks.im>
 <Zx7RU6sgIJjNSutE@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zx7RU6sgIJjNSutE@nand.local>

On Sun, Oct 27, 2024 at 07:48:35PM -0400, Taylor Blau wrote:
> It may be nice to write this as a switch statement, since we're always
> comparing the value of oflags & O_ACCMODE, like so:
>
>     switch (oflags & O_ACCMODE) {
>     case O_RDWR:
>         access = GENERIC_READ | GENERIC_WRITE;
>         break;
>     case O_WRONLY:
>         access = GENERIC_WRITE;
>         break;
>     default:
>         access = GENERIC_READ;
>         break;
>     }
>
> , but it is a minor point and I certainly do not have very strong
> feelings here.

...and I see that's exactly what you went with in the subsequent round
;-).

Thanks,
Taylor

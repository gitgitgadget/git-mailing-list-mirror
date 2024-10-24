Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71421E7642
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785039; cv=none; b=U2nSlx7QVKehygyxGNFJWgQj7v6P8Ov++9OG964yGClY3NQ4zzFM0Y6vByUAyljlgHi333FLadF3aIPdprOR1RKddG/dI7WyO2uidN5VjtSCVg2FW5Dl3ue2FwpXEQi7epu+f704KBuBim1mE/k/6gDP8Jt+9QVbFlUH/8hZMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785039; c=relaxed/simple;
	bh=EVvgEmsTLlpzYYkxCJJwt3Bz0ESHaAgUh9mHqvtaEv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eodeagutu1rSz4WAfzZpV7ZmwCgQmg3ju/3+6aQRuiNrM8tpFr0uRX+I9uPS+Lz7Ik6frAxl6uiEwV3y3RqLPFEvgcWnDlErikehBMaogkFVCDtlb+vQSNZryCxULb6QEGRpOaUR3iQoyc+9u0sX0otaAADN2/IKfezZMjwSxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iFdy7znG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iFdy7znG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e38fc62b9fso10581437b3.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729785036; x=1730389836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EVvgEmsTLlpzYYkxCJJwt3Bz0ESHaAgUh9mHqvtaEv8=;
        b=iFdy7znGyihI2Tom5GFigaPvnew2kB/Y0bere+wKUlIsVnwMQpoe8HjCcPZdmg9aT6
         9dUI86TW9aVn4MMhQ7o0vUJ4u9Px+wL4voIJyGbssxavvUDG4kNPDies3kXbE6Ekt1+E
         fonu/cEMrU7jHpmOliFZYoxn/MEbzHJrbtujOz05FtOtExECAk3Piur6dSzuPQSUR/kW
         WNpsyimD8V2YSuVAeT0icsuYWCRXKXAreJqqNLXZ1+ZC16nF26Ra/CMc89DGNAWKntrS
         BZjba5N80GYVa186sAhV2zQK6BscuCVtLwIOWdLzegLvuhv6mnR8S8zBHHhl1dBbZIvS
         BEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729785036; x=1730389836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVvgEmsTLlpzYYkxCJJwt3Bz0ESHaAgUh9mHqvtaEv8=;
        b=gIY2nylzYtLK1xLCZVDl8MG//1CUoc1H3xThw3ft1ODq6FYvhh/AhsTd/xQK5ktJzw
         kYlFKdf3vhXkVdiBDnfIEaCN4/bvigEz6uutqf2PWN2H8c6OeRlLEm60UFsNic3rt5VH
         TiXNRGTRmwCT4xxpwpfVFmX+T2rbEGZfMOmIRBS7pwpXRg0bAjPk1YhByGvYLnrgzKDz
         EtLGE+5J584B5MeSsTXglCxisGYjg5F+zgZ/VB881ZLSj+YOKkEByXuqJlP8zv4MMc4a
         Clp4VUx1QCi9XHhZJstjR/e7WDfcYdDFdG/A5NH9sHQv+H6OOX7EXZqaNHDG2RwFT/KX
         5Wfw==
X-Forwarded-Encrypted: i=1; AJvYcCWLVop2bXLyVpIsQzODfiHc6udeOt8Lrb3EFes0ygCBWosi5AON1yQ7pGPbi+MHvCZnOMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86r/xX62yu0TW10W+hLG4vAl85FL5qAoVB7ADkEGUn+WGHnBr
	bRNJRWkJWtnEMmmQS6l0gNBilxyKwCIKHIIJbpwrd2pv81MVKl4L+meao5aSDkw=
X-Google-Smtp-Source: AGHT+IGCKOansSrTMX0JjPtsUjZnDqdhzKb8IyF6vUMng6qyDOJtzVo8eUxTnJfgYQCAHaQwid1rsA==
X-Received: by 2002:a05:690c:60c1:b0:6d5:7b2f:60a0 with SMTP id 00721157ae682-6e7f0f7e3b6mr76850317b3.34.1729785035882;
        Thu, 24 Oct 2024 08:50:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb78asm20345807b3.88.2024.10.24.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:50:35 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:50:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc: avih <avihpit@yahoo.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: RESOLVED [Was: Re: bash prompt evaporates in subdirectories]
Message-ID: <ZxpsytPwKM70/XqD@nand.local>
References: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu>
 <ZxfKbsapf3MAUmcy@nand.local>
 <D53YJ81WH001.2KRT4KHARKLC4@cepl.eu>
 <1101848017.3146876.1729770380522@mail.yahoo.com>
 <D542P2ZTHIUJ.2GEJYE41VTC0J@cepl.eu>
 <D543UAO2CPHI.RQIN1V1IC85A@cepl.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D543UAO2CPHI.RQIN1V1IC85A@cepl.eu>

On Thu, Oct 24, 2024 at 04:26:59PM +0200, Matěj Cepl wrote:
> On Thu Oct 24, 2024 at 3:33 PM CEST, Matěj Cepl wrote:
> > On Thu Oct 24, 2024 at 1:46 PM CEST, avih wrote:
> >> - What is the "innermost" distro where this happens? Thumbleweed?
> >>   which version?
>
> It was a bug in one of my scripts, https://github.com/openSUSE/osc/pull/1632/commits/294001c46ea2
>
> Sorry for bothering you.

Ah, makes sense. Nice find, and not a bother at all.

Thanks,
Taylor

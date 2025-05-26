Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94B1FF1AD
	for <git@vger.kernel.org>; Mon, 26 May 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267413; cv=none; b=QRAeDLEozaNvEuFgDI4dBoBk/O2uWgoeWhvZ5/EjDomBFC7nCBBle9gEIEsmPMOMMyg5RYCKgE8tVRLVutKoUqyEXbLEaDcIf4G6y7+ts4d6c3KzcHkqxHLk18Tp3td1lENefTgKpIr1miZcBW2dVNI0JuywPuz7TkU+LOmmbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267413; c=relaxed/simple;
	bh=vTlrVQRVP9GDCS66e8dtf6uf/UzqOUguSVy+cTAJwl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onmf5izbTp6Z74KOJMOmTNGSSq31mrhC2gJS6A8LYyP4D336Kt74NEy6XFD/3zXiMzeBqoPSnKOYQLxXvHe/zJvxz/vfDHqNGBQRug/glW/qIiDynGFFBkePFsasJmZfiaxQalhHTTfXSU3/jig0c0SqJW/v9Lo6rDP5blWe3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT/Hmelk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT/Hmelk"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7426c44e014so1730538b3a.3
        for <git@vger.kernel.org>; Mon, 26 May 2025 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748267410; x=1748872210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NB/5di858n1HeZhA4UySwPiaiA7qRbtnjJ5rd2smXxs=;
        b=WT/Hmelk7RkCz6YlG0x9jxDH0RpANkivsW3YQ7lLKI3+q16eb1gA7FKmFyh7r+Rq44
         3pSZNqJA6VHLltzw8QrL6b/eeNxRCJu+OQzX+Q9yklwn2wkDCGyRxcPC0ASdZfztDVqu
         3Jf+YudI9OUUqpzI2IYJq+xz/GeUqY5wEhlWGI7t1mdmONt9wIJoJ3XKLBFIadPzrjEl
         mst61Vv3XGee5sB0poIUf9hARgxOv+RYa5uv2/xpKonBak99FFL0qpXX4Ldy+4IVD7UU
         GkdbjXJi1Hf1N/1jbs1Eym/tZHaLF2incLIf4hj4PhvZbiJc2Y6iDa2uUvoLZZG9AwK5
         VjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267410; x=1748872210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB/5di858n1HeZhA4UySwPiaiA7qRbtnjJ5rd2smXxs=;
        b=a0i2s6EyuUduvx6JLJRGnlYR05UJrCIXKavW8Z6dnAaKi/6FsEOD7UsVqDtxSx0f3W
         i+OVRHX2n9VyYZWMQ/cwOYN4oGK5CYxXaGkBAIfZGmowuxkVvbYPZhy1EBHttgs3B5ch
         USWjVhK2CQ0tJEUyTilja5iU02A5JsHDNXiHYsCLwY+XTXNggbDrNu6g+1layVUnMmHT
         3zBKHpw3JjC18OGM2s4pK1SEHI7SF1rKX3iL2UM2EkHP0WKehYInMsunCoN2LKB0YRaI
         qLbpINeTKVLU6fNMT0PTNn4eYQ2Ag0YMyUALWLvPt223qn4dsspnPEhMmA3c/o/2XhI/
         bEXQ==
X-Gm-Message-State: AOJu0YxOccUdnqb9eP0rDnpBKozq9qOXmsCkgkyEM9VIfCR3bm4mWDPi
	MEwNp0Z4eTXO74D4znb28tvLYbozglnUpR1ig4WR2SNCIC4lXZt4nNSUE7JpPXaP
X-Gm-Gg: ASbGnct+MlidaMk59jZK8d3CocihWZCF2OmHYk8y8ZD9hZJd6y0VasRSLnnj8MgxbsE
	HRbVcdwxCfrUOBEGRovh1PSlnAWO/A2h57Mefc9F/QmyGguxuNZSYxApNpp5/Rxdhd6vRJH5EMP
	ta63Y/Apvwvdx1p9SRL2v+Nd1MBkKJGGhNVlPJMlAHRLFNWGOtuo7kE+vUElVpSyMp+zHCFMrw8
	l07bhmdJ1nKLeYCRZkpLLQxvPBOrSi+yG9up5UAQUW806JCOvgT02Cob+ZHPD8AAYRE33hCTGHZ
	M7TndWodxQ0KleszoaWGGLSfO+Ki4aTJJKGTe1PIbMVyrPc=
X-Google-Smtp-Source: AGHT+IEf5x9ZTOJr4UfTTB5l9yBIphnmQGccYmZmq5CkMvX49V5ji/CpvxmEmZkdLvmu5Enm0OhR9A==
X-Received: by 2002:a05:6a00:1383:b0:742:da7c:3f27 with SMTP id d2e1a72fcca58-745fdb4c492mr13877536b3a.0.1748267409748;
        Mon, 26 May 2025 06:50:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a9875e08sm17596613b3a.133.2025.05.26.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:50:08 -0700 (PDT)
Date: Mon, 26 May 2025 21:50:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] string-list: fix sign compare warnings for loop
 iterator
Message-ID: <aDRxlsr8_ElgeWa8@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDSyycHNvFCT93@ArchLinux>
 <aCrbG0lavNa9Plc5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCrbG0lavNa9Plc5@pks.im>

On Mon, May 19, 2025 at 09:17:47AM +0200, Patrick Steinhardt wrote:
> On Sun, May 18, 2025 at 11:56:59PM +0800, shejialuo wrote:
> > In "string-list.c", there are six warnings which are emitted by
> > "Wsign-compare". And five warnings are caused by the loop iterator type
> > mismatch. Let's fix these five warnings by changing the `int` type to
> > `size_t` type of the loop iterator.
> 
> This naturally causes the question what the 6th warning is, and why it's
> not fixed in this commit. The answer is that the last one is more
> complex and handled by subsequent patches, which you should probably
> point out here. E.g.:
> 
>     There are a couple of "-Wsign-compare" warnings in "string-list.c".
>     Fix trivial ones that result from a mismatched loop iterator type.
> 
>     There is a single warning left after these fixes. This warning needs
>     a bit more care and is thus handled in subsequent commits.
> 

That's right. Thanks for the hint, will improve this in the next
version.

Jialuo

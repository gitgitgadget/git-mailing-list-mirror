Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793577113;
	b=HNM7DdJEMX2wYPYN4LKGI7+HHP9tYhK+e8oI/NyxGLhuAVGe5nHVqZTT3nboGpirYmZP
	 1Yca18rn2xdHh6G+6eiJKHEWO9/IOqm5uE6GIVoyCXw5NDGaDGycl6a89Ugfa9J+Tq6nS
	 UMTAYPDDTcxlcga3Qkb9jhzvh+bSGPQjLyd6lL0xPWa5Eb8pfuqolm4HhcPllq1HzyX10
	 vd5JYFE+nP9kFkOH/yxHFIVLOuW0to939ru9z8tLaSOnAL+c8wJe5Pq1FT91IJQFN33Jy
	 uh4W2mFswnQ7eYxHEj0utWwztHR9mQExx3BRi04Sbrdft76ooHC58dpn69iuULAEZZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793577113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bn+ilSmL1LxANtJMrtu4gVKmi0vJ5XkydzQrzBWgMzc=;
	b=uwyQZyb2r4jt9rp2nhNdnhVGdSLrak8E59w0jKPidb7knzyNwLHU2jiI9vWQZIN4037Q
	 b3DqJc1rTyujk6eQfS3W0FXwTZZ81b7gyhh1rTN+mkqge5ZFgcoaerKkUlcwwDSiYwJ6o
	 YUNxyShAM95Gamsrm6uatvpefimbdtrF8YKRRGu9Ky7yzdsTLIaOVwwbnMgctQ0GMPOJC
	 rk1p6kS5aTibYra1HIVjbsEacHiAuzWxYQ+Odnz3lS9OS8UNH5DoYTajfQ6fZ62FaI/by
	 H9SXIK8DU15yybvoiOeEKVHDneW6giJw1QtQzOUv0M5M+fn0CmlTeFSjDw/nUsLBSvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5DGjxyq;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA03606A326
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA03606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5DGjxyq
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6f74f6b46abso1463431eaf.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793577112; x=1794181912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bn+ilSmL1LxANtJMrtu4gVKmi0vJ5XkydzQrzBWgMzc=;
        b=h5DGjxyqUPXq/vbMIXGScz2h+f56ywCdTWLdz2W/baovCOC4DckeJUrx45xkSIQHEv
         bzJKjKyb+yEyEmdITHHP8n7YtZz0Uc34l80dYZZEc/JQgoYvmb0yw/OvTXaoTuP5PqUw
         FV7ji30/NEeD3BcYshvBsaR7txPLPSLXIJpH7HqFBDXQw//un0/i/59qtsohv8j/d8VW
         NRg1Sk1GoQYCrg87FmS6LKPeRyjow1JQwBOb+cJh6YPBgPhPoneP4ajb9MolanmGW1lO
         m2g0wpoNifcIMtQ4KfOqZPbBh9bP40T8szaEU84hh3lEzqlhcJLC+lClI58YLEcRSpjP
         Lc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793577112; x=1794181912;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bn+ilSmL1LxANtJMrtu4gVKmi0vJ5XkydzQrzBWgMzc=;
        b=0V2+PkooxwWqdDMCDX+SGUyyCDufAYkxOvm/0uIgEvW+Q4r1ESzqprqeoQjusVF7xk
         wjb27LvdPwf7fMmNVKzDPM8NfZ9/M9nXEJFEfAjTqHKdFI6v3s+VGoPxW5gfyIhoId0y
         110hjMxhHvgQ3BmSa1wAHAfnXg3cOFD2JQtAJEvSLvxnl46lliZBo+xMyR3P+z8Xu586
         Hkmd8A8vuq9LYYBDUNSSUJjk/PWJeq4Xi9C0hW8t3q+TzTDY0O2Ck8IXXLQMu628Pxld
         kB2SCSu0RmmWg7XzsxqY2D4Q2Nkuo8ej+6fC7g7oGjZY2pfRHFjdAoB5d1bab5amQSFQ
         rRiQ==
X-Gm-Message-State: AFq9FYKU6525TjZLea/U6hFJBM3nb1oyO9i29jCVNC2fOY+itUNDjJWk
	2HOPNsTfKTSPH+iyHVoL/ORtplOB7qxI7gXXryRQ8CqjQ/sTnI2qmCuw
X-Gm-Gg: AYBFou1wvaDCYtci02KATlfaEv8dA/m6QW8KSSJlu7saCuHAVxgi1ClSavxJLnqYFC9
	Tz8wloH1K5gocp/v1wYhi2sTU8yLT3fJ15TOP/OMkxMKdo0cI1RwgUPPoMvqDoSbzeVBwcvqwxc
	18BBGdysYlQWMFicTnCeR8F0w1X8OXPMsZr6hnSGt5MybioKdmSc27fyoVx10AQkBSY22DV2MCA
	uZAAtrTeUARq2n8AEbKBoPawoyn6I8DPdc3fWgVJduBlIqwEhSjKhhlWAF5g0C34zKT1MdnsPs3
	Tk9imUHOlbY7nZl6+5UaTqKf1FmzFtY6HI+MZz3cZ+ZzVXy+/WG4KdWi9qaCeggguSyxw9V/LIR
	fGS9UW2zrXZnCRw0+PtoewU+736rWJEwzTN2owJASDI4/UHUR8LBja6G9ZQrt9lUrb05JRLdkfn
	nH0gxvE/WmNydvAWx1tE8Ma3r6kRVAMucvXXcFoe3wetSFXTfJpJHjHwg+ynZIjhn3wZdeSF5hh
	Z01fSb2txX4wBooLlgg6IjDVjstF2sIabTNOJFLjt1gL+rYtbxOZCRQF3j+arikdWSlfh1ukpIq
	mwRGu9z/3lsYdeKVamSuJY2KB2eypIyOkO98O8i7Mh9O+etTYN6n
X-Received: by 2002:a05:6820:55d7:20b0:6e2:4cc3:b142 with SMTP id 006d021491bc7-714f2887441mr3467070eaf.29.1793577111794;
        Sun, 01 Nov 2026 15:51:51 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9218ef39csm5129631fac.6.2026.11.01.15.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:51:51 -0800 (PST)
Date: Sun, 1 Nov 2026 17:51:50 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, 
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: Re: [GSoC Patch v7 0/8] add more path keys to git repo info
Message-ID: <aufP4wwvnZsoRdv9@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqld7cuo2l.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqld7cuo2l.fsf@gitster.g>

On 26/11/01 03:30PM, Junio C Hamano wrote:
> Unless we see some volunteers to give it a final review in a few
> weeks, I will discard the topic out of my tree, as 'seen' has been
> crowded with topics that have been collecting dust without getting
> many reviews.

I've been meaning to come back to this topic, but have gotten recently
distracted with some other topics. I'll take a look at it tomorrow
though.

Thanks,
-Justin

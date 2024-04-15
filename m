Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2330157A61
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221513; cv=none; b=TqGLoCCiAkiumgPTFq097SpEWgZyfgSDTnfb/e4RqObccPiZeGBAnVSK8UnTcF7an1F8zoxNCv8y3v5K0lySKSsp7pJeLd2uHFUopXFklkaSgXUnePNQ1oxF9b/rzMxP5bA83lkLUpF3CAW1zxeaQyHT1rLTnbpcVH7Nw53fw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221513; c=relaxed/simple;
	bh=QgH6Tdj92n8rBsfTLjbRRVoEF2GORXiMcDGfmIr6CDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxopO5oE7pHQ8n4QpeSsiTbAfaCgzEq1co/+qCZyhBbKJnQ7ccWvtCL7k6pdEGNwaHArnyn1DadipsFerZSzuDyFLM99euMVVw2mvvoV0dOqjSibRTw/bju0oZX+mj5AjUh0QeK3+ChiQOC805OxXZNd8BEWvledUHX9YH+tH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pKLAAmV7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pKLAAmV7"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61aaf71c495so22917267b3.1
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1713221511; x=1713826311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+x/ExmjYwvDGsnwkhVw1RODynpaHL2E16hfYOXBQ0Kk=;
        b=pKLAAmV7NA9u3+8FGqCy6ZWaRvWvBVwNZ8JFNXZnKJHz7kpV5l3hrMjjR5To/FVTPl
         UC5ml+zhkLFR4MGpIfsOVmKjEdgCNZWvOou/HJV5oiNVXQQMyeZrdespKq+0wpt6B6nk
         CtwbhkeeosbMTkCbuQSYD5aIwXtG9CqxoT9bwj98M6RwySeyLrQ6kfshRjUmSgswks8z
         wzOMD+wio15mEWf41KsOe0AIvKTncrIUHXG/Zx/GHOCLiS5hQhu5rpb1JSqZBFSyhuUf
         Wq+pleZ5qHjcpZwL6TVEqTylrfpyRM67wDrkcyxSCnBm1Z0ZV6sk/bMnn1+x9aR3pzRP
         U2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713221511; x=1713826311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x/ExmjYwvDGsnwkhVw1RODynpaHL2E16hfYOXBQ0Kk=;
        b=HGGcWJfvfm+evzhaEXKF3g79sV9P33g/As1uTGfZOwcJ86bf2/A4XW9C9WLPPeSWtI
         Q73Xcy4EVaDhM+T5IutmrYMKFmvUQ4Ase0U1Li8Rl231XrczgCYUrN9DlzJhDak+HwSk
         wDEFut6r0sDi92chnT/VDAm7/3T6GWgWeTe/r0ua0IFAnx+9IWkpzL5jnCUpfnUHS4sd
         gReaS2UYGHD4HjJLrL/KxDrI+L79V067EMeMJI1naC1YOkd53znUdP5TxIx7Gv3Gh7Y2
         r3yxRDLhEb+Hq4D4kCbOG6ruNGTM2SgokT/PY738S7Ms36YjXte2WLpPDVNc3LijRnHw
         5ukA==
X-Forwarded-Encrypted: i=1; AJvYcCXMAXpfJCdcqYmS382W8RbIFrU3oIWiaAs7dFk7S2Q8oYfv244INruJHWoY3tdBzwmJIpk6/PAAOTcBbmf0PPHMk14g
X-Gm-Message-State: AOJu0Yy/i6+K7A0pT+EqyrMsPUwK4EVMWTX45BjLPxV2tGq87CV0OkYJ
	jML3yLpcBYgGdBKmxv2863gje5ZmRnJ1PEypuQPICl+aIMoXU5o9WpcYzrxvroJO7lcTexaSs3h
	kgUA=
X-Google-Smtp-Source: AGHT+IHoXu2Oqfkalul5Tl+ZLAbZK7kNx6k3H1oXU3bf8pZ8W5vsGoYuNT0za5CxleQvL8y3XNy/4A==
X-Received: by 2002:a81:4fd1:0:b0:618:4077:fe22 with SMTP id d200-20020a814fd1000000b006184077fe22mr10301464ywb.10.1713221510185;
        Mon, 15 Apr 2024 15:51:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fq9-20020a05690c350900b0061813dec952sm2270961ywb.1.2024.04.15.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 15:51:49 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:51:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <Zh2vhDraCnqw4YFL@nand.local>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
 <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
 <ZhzqeRIcyR3lmBme@tanuki>
 <xmqqil0io762.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqil0io762.fsf@gitster.g>

On Mon, Apr 15, 2024 at 10:41:09AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> >> Helped-by: Taylor Blau <me@ttaylorr.com>
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >
> > Junio, it would be great if we could still land this fix in Git v2.45
> > given that it is addressing a regression in Git v2.44. This of course
> > assumes that the current version of this patch looks good to Taylor.
>
> Indeed.  It would be nice to see an acked by or something.
>
> Will queue, in the meantime.  Thanks for a ping.

I took a look, and I think the patch is good. I have a couple of notes
on the test that I would prefer to see addressed before merging it down,
though.

Thanks,
Taylor

Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47814EC62
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714369; cv=none; b=QG5Q3H57lTPdAXGpq+PlPVVkbjN1LuVhmmRj8+vBqto8hlsnDhjk3vFKr8SxnLQ/+WDQuUVa836HTWBXe4bXHJKLUP/4VMHDT9ydWpG+ZcJ7L035B1rX1l4z6bttrjsVYuOSeBGealUD+Del9Rz30Xlxv8Xwk0tWm2CcM09QH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714369; c=relaxed/simple;
	bh=PkraT7q6++a5/7flstvSCbmAeg3OlVMUMvSoy3KJ3ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oi9mQRlz0KOXUpbZUlreAPhuiMYzsDx/9nol0GSo1TwWIDoCK2hRVbxmmrNXiT+cdilxN8gcCrKicdHFr44RV5xNX7MJxQVer8X7kAIJwhA3cuvc7dEs2JUz4OPJ5CyL9ZmFDv6soCjwUkVAYO5rBKIS2DiNWfz8+9n/ZaHMXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=3U1xTr7a; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="3U1xTr7a"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6db20e22c85so1594417b3.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729714367; x=1730319167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MhidxtaTmFXJRvb0zv2KYZ4gxNW8c/fco2kb6SAJ7g=;
        b=3U1xTr7acfaBseK42ycIMoLvX+jgcQzikDUJ+WiFX4Kqssbg8UQnsJaFVJttvb5mKd
         NTl93A2tuaSeLO4g4Xn8YsLJ8rYWLPyUFTDxykSvZJfuqy/ocPL8opNJAYiF1RdPEtXZ
         hTwZVNso9byXRPImJy9mYswYi976EMHGHz3iNZSQl+NwkQInrCEPGoFK8xnRs+3NryeF
         NO9SeWpcE/WpQuuBYSRhbJJK0g2BT1aabc81qaCeCYVoP5festGbwxR5lOuvPGbEnAOH
         aSzMs7mRWEuoMMOSWAb2fU5QT8ZEBkjPW9LOOHKR+GVd+Y5/LwC85wbQxkp/pZqfQ4lH
         RIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714367; x=1730319167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MhidxtaTmFXJRvb0zv2KYZ4gxNW8c/fco2kb6SAJ7g=;
        b=V5pvpPrsdt3p2z5OTQTJ+j5RSZFZsmStsf13ETVSpZX1FH8MVRymFfJ14CDhRGf6h5
         vKCr3bwnFJcd5JKoSI/U2C9yc/r+jmr9hgkA7N4lzuU5mAAnbKs3UezvtOj801EoiCTw
         c8mtZYRn0PJfvecWwNazpITbjB3LdouPb0N+wHZcWJXz80SBvu2VgQT8jaMvQlyDBxsh
         h/Icaqd1EfK54VE4+XgF67hEZqWkxp0PR+hN2TGzHt5C/RxSUbOVQIZopsrBrRXcKO0E
         lvg9CJhdrzoX4/lPyJE04KapeAqCreP6XmE+8vts0BZsdhXYCMS5SwoC2CFyBzmYQwpA
         oz9g==
X-Gm-Message-State: AOJu0YzhnELOGmbv9TyCPYHtVFVb1XfwUUumwNrw1G2nDEMmf8xgG1n3
	dWfRXTdXcAqXyPYKHETdlnuDO5Y/0Jiz2ieauQKiH89gT7uD8Q0cqEKXD07AfYYAbhRuCODOm36
	mFfw=
X-Google-Smtp-Source: AGHT+IGmR3CFglcbQafMiHFgkASIg5TpFwRV0OnYK6PcDymt/HcDZbosJHxuTzWoIMp8uNZQPy1cXw==
X-Received: by 2002:a05:690c:2c06:b0:6dd:d119:58dd with SMTP id 00721157ae682-6e7f0df5742mr38995507b3.16.1729714367230;
        Wed, 23 Oct 2024 13:12:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f56e4sm16769727b3.17.2024.10.23.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:12:46 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:12:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <ZxlYvXDOH4cup30u@nand.local>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <ZxbRQjQQ4TDdaFgl@nand.local>
 <ZxjmRQVh7osfAzP0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxjmRQVh7osfAzP0@pks.im>

On Wed, Oct 23, 2024 at 02:04:21PM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 21, 2024 at 06:10:10PM -0400, Taylor Blau wrote:
> > On Fri, Oct 18, 2024 at 02:23:47PM +0200, Patrick Steinhardt wrote:
> > > This series is based on 15030f9556 (The second batch, 2024-10-15) and
> > > has the following dependencies:
> > >
> > >   - ps/cmake-clar at c6d3e52c91 (cmake: set up proper
> > >     dependencies for generated clar headers, 2024-10-15).
> > >
> > >   - ps/upgrade-clar at f3501edb0e (Makefile: adjust sed command for
> > >     generating "clar-decls.h", 2024-10-14).
> > >
> > >   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
> > >     FreeBSD, 2024-10-16).
> >
> > While this is still sitting on my review queue, I rebuilt this topic
> > based on the above (extremely helpful) information, but it seems to
> > produce some conflicts when I try to merge it in at the end of 'seen':
>
> Huh, interesting. The first two series had conflicts with each other, so
> I wouldn't be surprised if what you see comes from that. Those two
> topics have been merged into a single topic now.
>
> I'll send an updated version of this series at the end of this week that
> also aims to fix conflicts with 'seen'.

Great, thanks!

Thanks,
Taylor

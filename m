Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007401442E8
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343072; cv=none; b=Amdpe3CRkOZ7dB3OeqRWi1BdRmN0keJVvcSOyY1A6qUR8YYIvOxntHUDcHskiRIiodlMHrcnTnKnLaHbVX+zvPHHkBBO1IBn3jj7nJiET3tF/jWibkokWRMr5O4xQN7/NXZb32bkFmjLoBZ4DKSw5cfL7PNSrxkOCys+uD74AjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343072; c=relaxed/simple;
	bh=npWSgj5e/+6e7MiK5AxgD/vt8pWlAQyEFroxuklYwEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INDf/BV0RpwXJMau1adUV+KHTXXqygZA3mEOhqiN7t3fw5KeNf8yK4PMx6KkIq58mSRApfxUKkGpSLaBJuF7lm+xwobmuyk3cVwO0pE5eZ9BoLNcLv24D+tQzc/kMDs2pFzEVbs9LxZ7cyObdyJ2k18/PDa7uvCfsQHKMsUk5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gvLetXfs; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gvLetXfs"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8218de5e3beso403858241.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721343070; x=1721947870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HeT6WpVaBFuVia7E6z+Xw1F/ef61S74JF1/OtXBpQEg=;
        b=gvLetXfs/SKhCHRcOZ8Qnj8zCLMP/9Me6di7qRNv9aYgFmvH3/bGipJdn3VcvapKHu
         ZN+bC/g69KX/gUsCM7e9yHB/09fBrzoeQJ4S20ro7bOMRjgPDIGDqkfmWg7LzrPsZXYe
         so9v6q04lB7ABdZ19t0GBFdzps4eQGLIpMEl1J05LvQ4QXNeOrWBYGXleBNWxal7bxeR
         bjiGF2N6szYt68QCaWXSUQmtr1euHvxe6y0vH3qYY/dYcg5uyasy+df9POKyKwypi//+
         Gnaseb8XrQnDkHZosi2cQR9XCFmJYTUgboxeAL6JNdr2ZKwg8oCMqIaxuFYFvTu11n+F
         /gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721343070; x=1721947870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeT6WpVaBFuVia7E6z+Xw1F/ef61S74JF1/OtXBpQEg=;
        b=ixqi/s0KtIDuA5m1x019boADi3MJ+Tc4PQRoEIrwfnZJ3xDes3SrCXSSw/ZgpUtS90
         nnngYNJJeuYwLf5WfpNufUUzH/jTRI/EmdTt/ZlDNfETcPNxeWMm0MfpeemrkW7MU7U7
         lX2ljPplFc146MlS0+Kv9BZSpMVFtdBEJBxXDz0CLpNxIKd1y15eR+enBttsdh+Mdv7h
         o8uIC6yANzJC6EX9VTeozrCJEiwaROLUpdzDCtgHm5S5ONlH1waph/Zm0Wo7ZUpwlxse
         pINPNptqBsEXlnvn8FUA2nb5Oc4Pgwa4RJI1K0fb2siFDnGGNf1iqywZzU7R8b+c9fV7
         BCBA==
X-Gm-Message-State: AOJu0YzOJ9gStUUnTTb0C5kDjWP+myNUGs/rcAWTh3DC4xmhj/IWUSOZ
	33rpf/RSucMrjuPrssPLoIhPtTonq9+ROMQAkOvHSq2Jn4pffk50oODWwgR0QM0=
X-Google-Smtp-Source: AGHT+IENwmVsvDADSllQ0WOtT28JS/JDUwbuW6iuvyoDMMl9j82G3U/epiitGDxeV57O0ThtQ2OK9A==
X-Received: by 2002:a05:6102:1521:b0:492:77db:72b7 with SMTP id ada2fe7eead31-49277db8177mr807615137.26.1721343068717;
        Thu, 18 Jul 2024 15:51:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd13b51sm748231cf.38.2024.07.18.15.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 15:51:08 -0700 (PDT)
Date: Thu, 18 Jul 2024 18:51:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation/gitpacking: make sample configs listing
 blocks
Message-ID: <ZpmcW/fT6BZVwE1L@nand.local>
References: <20240717105432.2801097-1-martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240717105432.2801097-1-martin.agren@gmail.com>

Hi Martin,

On Wed, Jul 17, 2024 at 12:54:28PM +0200, Martin Ågren wrote:
> ---
>  These buglets were introduced in faf558b23e (pseudo-merge: implement
>  support for selecting pseudo-merge commits, 2024-05-23) as part of
>  tb/pseudo-merge-reachability-bitmap.
>
>  Documentation/gitpacking.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Oops. Thank you for finding and fixing, it is much appreciated.

Thanks,
Taylor

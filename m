Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BD1F03DB
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738359585; cv=none; b=KYDq5F1yDn9I//yAVZoSbaxxXcUOMz3Jzdo08ig/uESp/junujluIno+c7TyZqQFi4DHQPzkpY4pyZoLVot72/ir6U99GaM1N2tU4xgugzLbCeKLD/GSnT0dKpNyRDfa5TmGZ3o9iGy7VvmqWESqBDQjj6Uc8BpS+2StL50KYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738359585; c=relaxed/simple;
	bh=g+2uwRPXlbPM2G49hCB1Mo7F3cvpr8rlAZIaqAHYQno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl6BYjBer+vROus8Tjp+I61N3gBpv3jCQzwOelKqIr06whcfySl2vd7s1ZnJoOG1xrH7O2o/FIW9ISj1sc6GMAUFk6olxqD1m06T/TDY926DVATwx+bW0Z2bxjeWBxoR1hwE8RuKUaMAD+BmxbEM5a7bfikZgjG++iYi4DadAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Q9rm8Iab; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Q9rm8Iab"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6efe4e3d698so13395957b3.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 13:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1738359583; x=1738964383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZfA2pDqFLXIw/3wJXZO6cXe113DCHnu+v+XDC7Kxxw=;
        b=Q9rm8IabHa+4x4ko/elpo7KYBMEjYqcQMNrQ+qjWr9e44O1urJTVjYVD//MhyI7bIj
         BDESc7dCf7mkH5MhigzTRS1UL1ju0E/FRqrBQnNdhJxykKLodRsXWP7LcAR246zmWX3i
         s+eO8ip15qG51CnGahwdeUlHWHy1ZCrv0Q2s89HxXC4++dXYqqIF5ihtcFu30ob+lPuv
         r4cdggKu3Z3htLaeZWRjBChdQ3w5oTNjYJ5qhgV833UR041vGbWK8QIdbH7oqhlarUQF
         kKXLrUf0lXcF5DE+wLW7F16hvk0UaHdz48ozkn7GWYE3Mx7mIb4i+moZXAbImG++gAt3
         RLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738359583; x=1738964383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZfA2pDqFLXIw/3wJXZO6cXe113DCHnu+v+XDC7Kxxw=;
        b=WcJhsUlEmJw7E9NmjBDKOjr7IHFwe5yFCBDcAUsQi8B5rmtmzjBRbGscwA2EXQJUib
         bx0yuvdXlOA+MnbNJWNkmNsU/HtJMDQ+2f0zF9f+fX+dkNmpIVl5hjATNe0/WYZ8qoJ5
         sywgOUaPaWno2j4uxOap8SYg6IC6uVrlWiPHJRB0frf+c0kM6EPd5mqEA3eUsU1PHOWy
         EBO0W54aP9k8dJy436fu9LYtB0vpB8L/Fq0/oKsrjUrCKDGwL3JY0C4txnDvszLc9L4L
         OukALZ+DsCuDvrl+Qoo8tlA7phZZBPRK39Mfu12D3p9CjTRXsllI33pGNd8DWiryDphW
         /DSA==
X-Gm-Message-State: AOJu0YyXk8JTfp+R6srOBAjY4dzADjVfJweQ79qvTSca98JLxKronM/q
	QhRDFyS4D1AABiirHtyB7wA8vNUrp6/PbGZJnha89kcz5RWGGuSTQtfgrzJhbXE=
X-Gm-Gg: ASbGncv88bQGyrTdAOznu9sKo5e19YM1YaRspzTAf5L9ZQTzJrHVzK6Zkge3G/s1vId
	y6WhGVPyyvOXKJqTI4NA3mFYt8DsYLEUv78/Bus/CLVQR6mn2vnpZdxCMW9NlSY+Sbc5UQ2fG//
	8auMCwFUmu4ZooRqAEErZyCWa/jc5azMsR9Gs9cppKZlSUUTYkyrGi03lcP7Ges+kuxDGacBbA7
	mevRu3THsVEJBSLbhmSqtbj54xZNBqjb7XCkNAgNfhyCxmA9gQA87CzPnul2oQLsuMuWJF5YNYA
	9WMYbFxL10x7TGO0TRmuq3skgAjVmcHVi2qfo3Zo+yGUsP5d1a/mzXn/Ig6XtOM=
X-Google-Smtp-Source: AGHT+IHdxNMgPPiCrjlNDxOpiLWkjHOd4szZu8kjd4EzIP2cUZXPp7dvMKCG6R17kixBll83+XAnkA==
X-Received: by 2002:a05:690c:b83:b0:6f6:8ce8:5a35 with SMTP id 00721157ae682-6f7a832a331mr98740507b3.3.1738359582822;
        Fri, 31 Jan 2025 13:39:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f9425bfde2sm926367b3.122.2025.01.31.13.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 13:39:42 -0800 (PST)
Date: Fri, 31 Jan 2025 16:39:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 0/7] pack-objects: Create an alternative name hash
 algorithm (recreated)
Message-ID: <Z51DHdS8SStRGalX@nand.local>
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>

On Mon, Jan 27, 2025 at 07:02:27PM +0000, Derrick Stolee via GitGitGadget wrote:
> UPDATES SINCE v3
> ================
>
>  * Style fixes for switch statement and setting a test environment variable.
>
>  * validate_name_hash_version() is now responsible for checking
>    compatibility with other options.
>
>  * The --name-hash-version=3 patch is removed to avoid user confusion since
>    we don't have a clear way to predict when it would provide (modest)
>    improvements over v2.

Thanks, this round looks great to me. I'm excited to see this topic
moving forward!

Thanks,
Taylor

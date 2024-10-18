Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24A713541B
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285525; cv=none; b=AlCYb+hetSHTgVFGPup5NDzYIEWY4LZ0/lR4QxTxYKsLtKJqbKbJxSD7rfo2JkptdID20xUqGewZ9wZV2Nc/CEiLHbfFhF4z6JgnXXM6VuLv8SnTDf56xlsVmfUrbcBGGB8GYw1JZqaOq5NbKOWC4E4mZYWfUh94dmHIHPi/55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285525; c=relaxed/simple;
	bh=68Ok0/jc+VY08VpYG/piODC6ojazBS1/GnJmshBiLFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJWUWxQP5zySbnBQOxijJ0ytozZJw0AZLsJ80rA6COhKgnI9+5J4vBfA0lXyKTbaZsMXEd9vNuDEjaH/DDIEPN+xwaww2ZM8JDIbLo8a3Kbg54EanRq21Ww68Ioe/gr08xBX/4Dw2I8EbsUZypddnm79cS5x7sI2RV/jkK8R8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fUDEIHni; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fUDEIHni"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so2607294276.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729285522; x=1729890322; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VAdpzG3RySzRR+BpDXRIBKWbJWwnYxQ+QKCARLrraoQ=;
        b=fUDEIHnifLkQ+Uf/mRyYhgzbm490b5iydWPpPo3elaitTvbSnkZvBt8EGh5mN2NOki
         3MKAgZzfOkGwWLb/dlstPNRcd9UNmkOt8wAB9atGuFtUJKc5119nPNhNpkS9BgqCGrVc
         rXoSX2rhIF85GVK360CBb60q/nn4VfK61GeBEptn9h/lzweh4xtrRlNMi0YkeZ12w3l0
         50wFlAdsjLQjjBpqUW+fsgIKdr+Bzf1zg2sbIwWptAkHCNNvNCeG6kRilksiFhkl0j5Y
         OJWBkwT4BKCiYwpRikmCJEGa1OYKxIQ0tiHXS7tTEB6CLeugQPk2kuZaIDzUp15vft7c
         1Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729285522; x=1729890322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAdpzG3RySzRR+BpDXRIBKWbJWwnYxQ+QKCARLrraoQ=;
        b=Dmuuhk/pJqQUs+nyba2n9FWm3eS3e+tzCTqwNcWvoko84MwPbu2sW/Mm/V/aoHrj2p
         MKyaLVL+/mHi2LGePCnl5BINtJpPIgTn6K4h0YL1pGLD+tlRPIwVAliqayx/eikhjQU/
         4kgw0xH6f6pcwLIExyzhxrsXx7fvzE+5incJ6AUSkDd3DHIdp3AH5gdu030aAcJoObVt
         F84lbxLqexGcXEvDC5nA9cAvkRTBSwHatLZuw1k9E/rUgx8gzrW4Mejg66JIAPjvhnna
         8dHbA6dPLKZPqfTx2EJlu5379dbqBRUgemJdb68PHJASSVlAP3cowJS7TqINUumxv4tE
         sRoA==
X-Forwarded-Encrypted: i=1; AJvYcCUwoGplYHKISZa9YlgpaDXYPo7cEsPc+9PC0VIwmiB5IaS0ns4lXVMMoVhBXI+uhkQB1JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytW0lL9d3O1wBVhRUPI9t1Olxuw8wO//1Ouo3NxB/jaQhGv+mv
	yIvXtF0yDSOxTUKHB5Aq6r5ObsuanjQq5uToisayt/X2kJSH839yRMCLSxea6CQ=
X-Google-Smtp-Source: AGHT+IGa6ORfNB9hwxNrBewJTnIoQXLrqrhWqAP+7bpIv/7GRc13aVOUbY50sjjUSGhi95oXa4Kf+A==
X-Received: by 2002:a05:6902:12c5:b0:e29:f50:f69d with SMTP id 3f1490d57ef6-e2bb12ef9bcmr3918689276.23.1729285522546;
        Fri, 18 Oct 2024 14:05:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb03eab78sm450917276.60.2024.10.18.14.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:05:22 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:05:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxLNj59mKfZubiY/@nand.local>
References: <20241017112835.10100-1-algonell@gmail.com>
 <ZxFyKXDCJkRZYYQY@nand.local>
 <ZxKSFBl_pV2r99dY@void.void>
 <be0c95ee-1d9f-4e97-9710-0ceba9c3aaed@app.fastmail.com>
 <ZxKi7qn6tEWyBXsd@void.void>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxKi7qn6tEWyBXsd@void.void>

On Fri, Oct 18, 2024 at 09:03:26PM +0300, Andrew Kreimer wrote:
> On Fri, Oct 18, 2024 at 06:58:48PM +0200, Kristoffer Haugsbakk wrote:
> > The code style says that redirection operators should have no space
> > after them.  See Documentation/CodingGuidelines at “Redirection
> > operators”.
> >
> > --
> > Kristoffer Haugsbakk
>
> Thanks for the clarification, will address this one as well.

Thanks, both. Kristoffer -- it's fine to do this in the same, or a
separate patch in the new round. Thanks.

Thanks,
Taylor

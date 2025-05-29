Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3F23AD
	for <git@vger.kernel.org>; Thu, 29 May 2025 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477884; cv=none; b=UvEJ6OfMKOaqegnHpfNF+j7TniveZtlufFKqSZ+ZSzCB4mKhU9zGIz4SD9G/oRjOPhJlOHoaB4FTKoYUq/lBS370crwZp8uWkcxb0oq5fDa+i0xQaX+jR9r2/xjFwKzp2wcssczqFoeQjN+MDNjU2+JDz6Acf7Qyy75H+OlBjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477884; c=relaxed/simple;
	bh=6oX/v32jJmHYt1iFs8f/ERz+NcBh5EvryaZX8V3+++I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lO7pBRLbhHp4TMV5Dg58BZsiFgSofU2mVaOkFmAHVMtGSpcpUpICrU4OReuIF9a6nln5qmNVI78DRUBsrvtF8DHBqaFu2qho+ThHZYqJLa4CyxMcoTyAf0nmloO5iGy2PtpI6oJm9zPLsrONr6TLP4AU449LEF8YFr1X5+dBQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ozBJJXDd; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ozBJJXDd"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7d7f7151f0so381822276.0
        for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748477882; x=1749082682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tRbrSivYqqKXEHYvzLpqxiCC8LcXyskVnGArteXcJE=;
        b=ozBJJXDdr8j/TrSbR+ipcUti5chRGVZFklRCkAA6MoMYgxom/9i/Znm2gFsT4XVcBw
         m7Xv3qrNbA+UI5wcTl6jk4mzMo18IXhrEQpdWWRFKrKCN3tNF6eOBEjxkrCtyl++I9PI
         aTDv+0aJey0JKrff9oBkz848U0u3FQsoeD+Ifbhu+Pq5eah3pbT2Y+HN0P/Vj3C3mPhk
         WXGG124J6DHvDamiPi6bZUk32c2/FjciDoAJBr0f8F5A984ahfu0xdrgv1aXaFoNhucs
         oeekVMdPR0H9H9cPVKfKyjApzS0dClbt59R3pjEfUxcOrI3qtAZnMhPBhKPvobezHoLe
         6aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748477882; x=1749082682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tRbrSivYqqKXEHYvzLpqxiCC8LcXyskVnGArteXcJE=;
        b=qdXBWuKzDt8xgIX9yVqtDHFE/c1kDJ+BTNPV1D/xxBUt5q6HQ7heQKxKVi6s5S6BNi
         3HA07EAa+sv52Spa15YHVvQJsiqC6as4n0YvLnhoMglgebqoOO+9BNz0VBvNWFJ5H8u4
         n6yhkTrGjzLhoIyv19bK8OVDXe3iJdTBCtAM3H6Knn6ObXncDAYC6p10KcOFutFneNO4
         8P4YNFccecn1GUzNosgvBOjESKJ0JMmkp7qRjsdjBiltDMa+32ZNDrBCi9q/iujaBrPD
         tPOs+9rizFv7CitoNVqKiP4vWkbBMWHjY12v04AhUuv/HmDqPDn9f94QSJ1rDa/WR004
         JmWg==
X-Forwarded-Encrypted: i=1; AJvYcCUyH+Cp+GD4JlX8V6fFpwm8FUrb+4s+YTQx9GeEm93wxqcQDsA9dd6uGi6naR/CfQRQfC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyv4J9In2m7xRT0j2axIAdgV6/DGWTmT35wyLxVP8DeNggoKca
	45JD01w6w7J+PpYp3RtRsd6tTi+Bdb5jRcm9mSLa8NM8+V0grU+AFjEz8hwTXWDk+N4=
X-Gm-Gg: ASbGncvJ/0YzwKxMIkUf36KPZ1ApgmlVjlEJRR8SaA4uTR8tFUFOhO5F0NDLLx3j3E8
	oKL3d26vqDJi90IFTVGM3/0D3ffyKr6fdwWnOUmiqvWKednq/6wgFblA4cX1pP2bH+DIYGsJBqj
	xsURejPVP0LjEQUxm/sTSHKL9tklLS930M1Dv6/SKgKgRxY+WKJzi5wNrJ/5XiXkghhvJahmX3n
	JXrqA8zfUT4Jm3S4+AsTGSyOCaGUaqOCDiVccqehaa0DsBKRtDXi9OBtucx0Gp8SJPGJbR98F+u
	PIIpnhy6rRrrTpkEou1lanutv6HL3Yu4XfkO+5TW1Za2I9Ye3xX/E35KprYA7KuMHDNKMim7g39
	mgr5nj6YDylDzhDg29PoNtH4=
X-Google-Smtp-Source: AGHT+IFX3yyt3eRikhG2/bsVws9T5UvLfxYV+P3BQEhhuZdpgYKmDqVdT0ZRlnWJD+6cl2J7WjkERw==
X-Received: by 2002:a05:690c:397:b0:70e:7503:1176 with SMTP id 00721157ae682-70e750328a2mr127314867b3.4.1748477881830;
        Wed, 28 May 2025 17:18:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8ad26154sm544727b3.121.2025.05.28.17.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:18:01 -0700 (PDT)
Date: Wed, 28 May 2025 20:17:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im
Subject: Re: [PATCH v2 10/13] pack-objects: refactor path-walk delta phase
Message-ID: <aDent08iBbQrFWIB@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <622439d78557d94da899d21444920c27768d3c67.1742829770.git.gitgitgadget@gmail.com>
 <aBqz+VfSvecJdWHw@nand.local>
 <7ee3884e-b629-4b59-8e9a-a9a56abce786@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ee3884e-b629-4b59-8e9a-a9a56abce786@gmail.com>

On Fri, May 16, 2025 at 12:27:29PM -0400, Derrick Stolee wrote:
> > I imagine that "start" here is setup for the following commit which will
> > parallelize this task across multiple threads, with each thread starting
> > at a different position.
> >
> > I wonder if (as an alternative) we could get away with passing in a
> > (struct packing_region *, size_t) pair and drop "start". I think this
> > can work if you pass in the result of adding whatever the value of
> > "start" would be to to_pack.regions here.
> >
> > That somewhat hides the fact that this code is meant to be run across
> > multiple threads, but in a way that I think is worth doing. It lets the
> > function avoid having to do things like:
> >
> >    for (size_t i = start; i < start + nr; i++)
> >
> > and instead do the simpler:
> >
> >    for (size_t i = 0; i < nr; i++)
> >
> > since the caller already adjusted the regions pointer for us. As a
> > side-effect, it also means that the call below in prepare_pack() can
> > avoid passing a literal zero.
>
> I generally avoid this kind of pattern, because it makes it more
> difficult to understand what is going on when debugging. The cost
> of adding 'start' to the index seems low relative to having a
> consistent indexing scheme when accessing from the "global" list
> of items.
>
> This only gets more complicated when the threaded version iterates
> on a "consecutive sublist of regions".

That's fair. After thinking about it some more, I agree that enumerating
[start, start + nr) is clearer than enumerating [0, nr) and adjusting
the offset at each invocation of the loop body.

Funny enough, I applied that suggestion in a couple of spots in one of
the incremental MIDX patches I sent recently.

> > This is an extreme nitpick, but I think that "/**" (as opposed to "/*")
> > is preferred, as the former is used for Doxygen-style comments. I feel
> > like I have seen Junio comment on this before, but searching 'f:Junio
> > "/**"' yields a measly 83,000+ results, so I am unlikely to find it ;-).
> >
> > (Not worth rerolling on its own, but if you are rerolling anyway, which
> > is what I gathered from some of your earlier replies, it may be worth
> > picking up along the way.)
>
> I'm confused. Are you saying I should change from "/**" to "/*" (which
> is the opposite of your preferred statement) or did you misread that I
> had used "/**"? I can't determine which statement is the intended one.

Oops, this is a typo on my part. I was saying that we should prefer "/*"
to "/**".

The "/**"-style lives on in v4, but this is *extremely* minor and I
don't think is worth sending another round when everything (of what I
have read so far from v4) looks good to me.

Thanks,
Taylor

Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEA1E5B6F
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906769; cv=none; b=MJydup/MroP9oRZb1rnUndyyazngw9WzXm1sF45z0jqpJN7QizRL7bk5japIca5sir5lNpsrgyrjfV5aw20BdEqUw21R6uN5PdL3cmtdBVeh0CnjJB8g6Zo83eUaJOgJPPGZpJyO1Fi9BQTmoaWp86TCG+3fqJj/Gsd+uLnCneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906769; c=relaxed/simple;
	bh=lo8RxKUL2XBHrMhDix0qhdJssQ7zSePczzbR+N/SaDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq8mcLEmKBKJp+Uz4W82ClDUfADLZeoLW2bWP+OcxAyLrIT4L8RHhjbZ3EMCfSGfF05fwoyCBlvmhPhdaXuzZIEWnOEn3+KcwCrKLfI4vZrhYh1qoPy0HvS9zILbTr1YkrS1B1pkHsi5H/orWainL/UWPqzt8iDD26i7xJYuvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFyCfcJz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFyCfcJz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b21006804so16575585ad.3
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756906767; x=1757511567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8opgXGigDB/7eo/cxi6dg4RQju841sJWE6SOXhgdR78=;
        b=SFyCfcJzof8chVuV2NxQOrBYB5G70ai1elrnbyOD2P54vRwawKv7O7L2Dh8OjIMrrJ
         nOPIaWTg1yMuF4A9NIZFDlIUjGqLoskjJ0Erof/ILZ1qkds2ism01KyFHXy5b4tVkpop
         aJSd/VFDEG2dTvd74dGa8xDYXLChPV0snZ+IpXzDRRK9MNKi8WmUX5762DsDkvT7yZ8R
         gazBvzZq2aRICuHZKrIYpv5Qdm7hmuEtv3ah7UXjPwOj74beTZn+iRw28y1He68lupd6
         qyWxprXKtS1wnAIgO4UBvrfZHuKgLB9meWxBuF/dDaFIFH29YGvHn1/bvhNlYVXxUNcc
         UQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906767; x=1757511567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8opgXGigDB/7eo/cxi6dg4RQju841sJWE6SOXhgdR78=;
        b=vYg66P62baIX6krVbG88GFiBb9K1tEuHqq5Y1jpLr9Sff8kEk4bHv9xTnPVKACsYe0
         +NCO6SG97JBNZgc+emazh1RlyJPn+qfJ7/oJF34zgJybKBC7fnMBQI5VDMiWr3sZm06E
         7x3/601c5aKO0Kziz9SssLyVUolritMXT2p2MTw6VelKQPZdBx4eiXJZws3K5A6yMM4D
         FzJPLIO35pbETPG0jgoc8/pUZ8jVZbkuGM2GU2bgBBnA7xQrKbErPas4rvJzXwevpw5r
         6SRvJfNihTHo5hN0AoVuDOhYyZzU4EYUeOKL/qRJQ8Gysh3BL+ecOUA+Q29MzdLsTHUL
         ozSQ==
X-Gm-Message-State: AOJu0YxV0bUgUjPz2DXGWdaB++SVLSwv0PCRWdeN6xVmUSuB4ulDUnEw
	HcRcM3t3S3ad1PA1wWQmFVQ1enWxIA9FahtFZPEaGg2r9cEaS5MFcFOc
X-Gm-Gg: ASbGnctJbRp9Zv5cvB4RTHPop2wsl7d4uLHnwBnn9TdDO1Uq69W5vkFggGQR56lnCaK
	jjx9LFcdrjRANfuAskdzZ1++n8cH4hLO9J97j4/qYjwTbzzUViyKclO3w6NRyYQ3yDVv7GBafq1
	ksGDCaO2qEvty/khOLp4LmByZBaY9JEWnvLBmKpkov6yNyKqVVDNIFimxHsDjEaTdWwi3Hd2qxO
	icocuQACT2gFVedPHi5ap7Uk4fKZCEmuenjQ2GwOOTxwoxuqqq556NNqJ7S4dAaeeK8aWKl6rYV
	TdX0EqM9Y9qdMh1SrHm1QMR/AbJF4bWRbwBb5nkfF0j5eFF3Qps3kMkA3O+3vqc3KNfRXEOHn06
	9N2TT30HvXGL/r1dNgUQ9I3JirQ8L
X-Google-Smtp-Source: AGHT+IHWuKeZwJL1dHyl2dXW2tgQSxdr5IGRthS3763o562FKtAJz9B9eRwCQMnxVhRxim2Is6vH+Q==
X-Received: by 2002:a17:903:38c7:b0:249:2d84:f416 with SMTP id d9443c01a7336-24944b766eamr192359715ad.58.1756906767115;
        Wed, 03 Sep 2025 06:39:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-249066e042asm164093195ad.146.2025.09.03.06.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:39:26 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:39:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/5] refs/reftable: add fsck check for checking the table
 name
Message-ID: <aLhFFFKOo4CtVJJy@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20250819-228-reftable-introduce-consistency-checks-v1-2-8b8f6879fa9e@gmail.com>
 <aK3fHRMFiRBYNiJE@ArchLinux>
 <CAOLa=ZR43JYu1ky_HF7nC4xkVe6B+fMWTNK+sczaar_8YNcd8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR43JYu1ky_HF7nC4xkVe6B+fMWTNK+sczaar_8YNcd8A@mail.gmail.com>

On Mon, Sep 01, 2025 at 06:33:24AM -0700, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Tue, Aug 19, 2025 at 02:21:01PM +0200, Karthik Nayak wrote:
> >> The `git refs verify` command is used to run fsck checks on the
> >> reference backends. This command is also invoked when users run 'git
> >> fsck'. While the files-backend has some fsck checks added, the reftable
> >> backend lacks such checks. Let's add the required infrastructure and a
> >> check to test for the table names in the 'tables.list' of reftables.
> >>
> >> For the infrastructure, since the reftable library is treated as an
> >> independent library we should ensure that the library code works
> >> independently without knowledge about Git's internals. To do this,
> >> add both 'reftable/fsck.c' and 'reftable/reftable-fsck.h'. Which
> >
> > A design question here, we name the "fsck.c" for the source code but for
> > the header, we use "reftable-fsck.h", it is a little strange. Why not
> > just "fsck.h" instead of "reftable-fsck.h".
> >
> 
> Since the reftable code is treated as an external library, all
> 'reftable-.*.h' headers are treated as headers which expose APIs for the
> libraries users. We would have defined 'reftable/fsck.h' if there were
> internal users of the 'fsck.c' code. But there are none.
> 

I understand the design. Thanks for the explanation.

[snip]

> >> +		uint32_t rnd;
> >> +		/*
> >> +		 * We want to match the tail '.ref'. One extra byte to ensure
> >> +		 * that there is no unexpected extra character and one byte for
> >> +		 * the null terminator added by sscanf.
> >> +		 */
> >> +		char tail[6];
> >> +
> >> +		if (sscanf(names[i], "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x%5s",
> >> +			   &min, &max, &rnd, tail) != 4) {
> >> +			err = report_fn(info, cb_data);
> >
> > I think we could just pass pointer to avoid unnecessary copy operations.
> > Besides that, I think here we report two different kinds of problem. But
> > we would give report the user always the same message `invalid reftable
> > name`. This is too vague.
> >
> 
> Not sure what you mean by 'unnecessary copy operations', could you
> elaborate?
> 

In `report_fn`, we would copy the `info` value for each call. That's my
meaning.

Thanks,
Jialuo

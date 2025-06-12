Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8216F288
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763894; cv=none; b=ex9dbYrAW0uNGx4NaM5NZiZ963yi/c9d/rhGwz8OKUMkzaFgL4FDNP8OVr402oyCAqpIpwIVc2r29R3o795KytWRbpJ4xELuGwLIFmhgSX4nJScx32qLnue/tHaWl1Wm8RM/3mcWoVCaAOgOZq6M1JMuRL04a6hEfn/8/4sVRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763894; c=relaxed/simple;
	bh=XCmJH6dP0Is7+CfM+NZx3E9Qasf//tf/NeC/j7ZsHNE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8iLqXUGYTCJbfVbRAaPjxxQj5zlk4GcwyKX4yZoUC5c6sKQgLNvaqdB4jj9HlbWl3okerp9IRaOezjxbwz27FMSiv1iH1eXig2HIlPFhWC2lkF0rG44ikIvnqLppJvROiqiN4x3czVh1Z6PpSqBmN/tKpxT9rFByPWPHqtHhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpI1fWEt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpI1fWEt"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so1247181a12.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749763892; x=1750368692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ekyu6iuZkI+5h6bx9gTl4atZQ0zel1mWWOKTHEBKagM=;
        b=CpI1fWEtEetP4Uc5ezlO+MguT9zd4F7kcekGZEWq20yUZgrKmsMbh1Oo8ntg7dsyYo
         U8XHzSq7KFk/iChk5M8XfWs5pN2dQnxD0gT1BXBJdcqfjbG7l4GZEIxk9Rdyd2eKt5lI
         sPyjtA2El7kIjAa98KyahzWdazA0A6Jnm69w+QPULdFa2/xqFMlZ1aLxQ7jMBjaaRtsa
         MLki3bzO7Nwk/kfnRRgJgb2x+8Ci91l4jPebtk/8usJ1Ft9ufpe7UK2VnFc1s9OKTwuj
         Ad+k0hpPHkkST3m5Pfmjtrw9pHSxujusSTqs9k+ziozY+YFASuVpNNTpGpPgB6/MPIIg
         poTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749763892; x=1750368692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ekyu6iuZkI+5h6bx9gTl4atZQ0zel1mWWOKTHEBKagM=;
        b=NnrS0bQVsyvCByhKxUsZ4tf2nc9SF9GtknZWO1AA+xUrG7VT4xiNWpzIzbbyMup/My
         cCLNoJpHxNIcZLHJ/9pudV/nVe5ZunCqQWchD5Mas2sAGi1+CV+2/pky03KG+jGfs9Zh
         gIEGmRog9p1HqSv7+dLd1ixTKsgDi5QqfJPGN5XTzI3w2/AWyiPAwmkJR+S8BM/iqAaH
         TM4CYWNnCPlFml3M6Zr9vC9Ps/pOd3v3v2bKmqWhxrV0Mph0NvzGOGnFTCGQgllwVltD
         t2QdgYsZvDgTP+K9ZH0G7X6KRuxqjwSnUWy7UVpi0hmYsuuzA80J/p4ZY2i4cKJXg2sN
         mxTg==
X-Forwarded-Encrypted: i=1; AJvYcCVaDK1xkaT8FqO+4PrCbwqYeG5W7X0QWNxin11mG2yBdke5NagJXy3OcI10kRLNriz6zRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXOk6UDwymd9a5efTlzvijHGqs59FKdnlnOmamprMFZTmSkMw
	5dghlRsqSq0pzzQ+oKw13v+HiX2kIL73lbewFR7cujDJ6lRVDrXyxAEp
X-Gm-Gg: ASbGncsm08dcUFdqLgT113GO/ydvQd74O3tnmX+MR4u7e+dor0kADTS9l44f3faYH2F
	9JHTeixNluJqQ0ppBBwtxC52e+H7aSDzMswP6MTFoLVv8gRACH2GUmkAOcoZvD3fL+UjMhPf26x
	tYpCgFGxGU/Z5NvMWAkL+iO9GSA22rxWnpwPT7LagYketRyMqRzoPmx5YVtfaoZJrIC1rK7+vBm
	SPqCjjn0Rc/cWlhQQ0dWasYhz5KmSI6p4csWezRewB0pcdiLjsisv85gna/sGXc5oUlTCOgnFfZ
	sa/ODU415HOgLXAjBLzg0XJ2bCy7N5jpo0M5gTnfgbrgvKvqNmHxeSGPMZa1mu0ouD7OG5Lmm9S
	4Zf90K9WCQ5vOFbN8SYU6buNwMJiEUTTZ
X-Google-Smtp-Source: AGHT+IEbyPYxKt3H+msxiyHg0H9Zx1iIV8YXAxtWepWV0P1cuFWx0xa2l9H+3xOLCS59v2hnPSM/+Q==
X-Received: by 2002:a17:903:2346:b0:234:a139:120d with SMTP id d9443c01a7336-2365d88bf30mr7620105ad.7.1749763891798;
        Thu, 12 Jun 2025 14:31:31 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:8dc3:5851:1e44:aea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de783b3sm1822025ad.119.2025.06.12.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 14:31:31 -0700 (PDT)
Date: Thu, 12 Jun 2025 14:31:29 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Brad Smith <brad@comstyle.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] config.mak.uname: update settings for FreeBSD
Message-ID: <p75inuvm6uf4mul7gty4jpwd74namlgfifkqgwuwzf6sqrkit5@zkimsfgxatmc>
References: <CAPUEspguEY+e-J0dMA2EdDgu=t4fK5ASS13Jfp_Mgwiq3Rtd0Q@mail.gmail.com>
 <aEsE8S90fJSr9Or5@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEsE8S90fJSr9Or5@fruit.crustytoothpaste.net>

On Thu, Jun 12, 2025 at 04:48:49PM -0800, brian m. carlson wrote:
> On 2025-06-12 at 13:52:03, Carlo Arenas wrote:
> > On Thu, Jun 12, 2025 at 12:36:46AM -0800, Brad Smith wrote:
> > >
> > > FreeBSD 6.0 has memmem().
> > 
> > but AFAIK it was buggy, uncompatible with the "standard" and
> > didn't perform that well, at least until FreeBSD 12.
> > 
> > assuming that the system version is indeed faster than the
> > one provided with git (which should be true but worth testing)
> > then it might be better to only enable this for later versions?
> 
> FreeBSD 11.4 (the last version of FreeBSD 11) went end of life in
> September 2021, so nobody should be using it since it hasn't had
> security support since then.  And it's even been functional (but slow)
> since FreeBSD 11.0, and 10.4 went EOL in 2018.  So users shouldn't
> actually be experiencing any actual functionality problems since then.
> 
> I don't think it's a big deal for people who want to use an obsolete OS
> (which, to be clear, I'm not encouraging) to tweak the Makefile knobs a
> bit.

Note that my concern wasn't about having to tweak the Makefile, but with
the fact that the system provided function would behave differently, and
there was no attempt to see if by no longer using the git provided compat
code, there was actually a performance improvement.

It is true that in our codebase there are no calls to memmem() where the
needlelen (the fourth parameter) could be zero, and that would result in
some of those old versions returning NULL, but it would seem to be safer
to only use the system provided function when those issues are no longer
a concern.

Carlo

Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513F22A7F8
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750059; cv=none; b=l70yxCt7c/G778HSzIN86PghOtpxrtwnCi3zQJ21I/nTVA6Xwlz/kSrZj3ygyIKq1WRMxJ2spuREMskdLi60Z9OP8Vs9+U5LCf9IXn8/MgTAJbDeaE/RbKvjRdv14P5CI8yDeDnUrXwMIdKUBFKzfHRtOWxapVWMC1cCGmBwgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750059; c=relaxed/simple;
	bh=FdrX1IYBGKfInkwsCCSN5lYqFjffvtehUvl8tyDFAH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUMrjr8HcDS6u4rTnlMX5nAtcpFKyH8XJ9H5J4/esDlMla44/4kIb9w4AwUYgKhwMHDdFrrnkvMova+KJE1aoWPBvlTSGo26lGlsmDqvUwkHiZ4alzgNG1FOmVj45sgwNbl+ZpP4PrJz7DO6j/f6UlVwV91dgnrwmekPhQgmJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr9rxmNH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr9rxmNH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f05693a27so21892755ad.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 02:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738750057; x=1739354857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cELNFp0FnXsgjgQLMFuQ7wPTV06ntYldXZjNZ3Bnz5Y=;
        b=nr9rxmNHazKllDEDpoeVSOgGAsSmvvhqWBIF0RCSGjwe5YKlCk6tYTCVgrcMqPPYzg
         h+hTB5CfJ0pi/5D26yLoear7B9KHHcQXVZeqRplMlVbZFa/XgGl52hY6zV6+T2z6X/4o
         v4c2d4czdJ6p90EUU7HilbNdZw6h11p3ffKydI+kNfw9yPhQlRq9zwMIoEyhy19GMOLQ
         Me1pw7sNAudNR5xpibA7HRq9RerTB2bDrBf1rc70zYm8p/z5c2Gx64AaEZnlhaTaI/K+
         FcEtLGqv5hl37SnTpqDXMyGl2EzQcB+aD36Uhe+F82uXlYzFme5JQuvO3qk3rCfPoTJY
         8KJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738750057; x=1739354857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cELNFp0FnXsgjgQLMFuQ7wPTV06ntYldXZjNZ3Bnz5Y=;
        b=gxqupas6AgE0L9Lnd3Rzp8jdJd5ty/w8R27qVojKi++g5kZDAjlR8H5HjzuhPe+cvW
         +UNQ3vl74VYSlCsZwiCOxvy5ikY+KYIV0RIe6S9juT3Ic0g/oByhtliYENEaEsmLPOpy
         NOyDfUZTRnu0ebHs6UNEoiUpP80J4Ov/l8lwpDOOk0oDspX8bhUS8Hf9tJYh2/2Cyyye
         2mNR71kJwWUdGoM+XUjYXRht+T2Rgz5yCj+eKASQalZxHj8wTTbtfWDKWC2dduHU1Got
         P/aJPqvNbs+68C+7wigJ8YVKrm5Bz6nr6vN43GU18dG2Bm6/nMb93OKLmYSLxOOp3cto
         /ZYw==
X-Gm-Message-State: AOJu0Ywa/6oo+u6WQqB8DKCn4TBwPshOhcLenSycfspyIHbmmlHAlTiw
	DO3vNc0tiyX344S3dF0+r/cjL9oIVFJwy65qrtp6bup9/YmvOrD5
X-Gm-Gg: ASbGncvvS/Lvthk8nmEbiyazU176GW/aFwx/WZxVlJhLS7VQfM1C2R088UVG4xaA4Mq
	zsddbvuGZ0ZzsRJ5dkjy/R754VBSIuK7IgESzlrPibry3kl11D58ajRPWzj9syO66lE9Dst+DzZ
	gMA5Ga8SwBTACEt2qbdv/OGl2jxg0qH2yBdDpv2IWdgUbe3o3VcnLvuYFcXf3/05AqWDXTUxNMl
	w7D/VRSmCgWm3sgYenhk1jqtmrBvgOD9g3eLJ1WgMlSDaUawsLUy5Vkjy8o+5GvQnqbmg==
X-Google-Smtp-Source: AGHT+IFZ7fc+dcTwP13CzCB4/KRLzXHlZRVlpbIsQyjOBOt1GzKnes8Sb9agsAy44NymcL9yfezJMg==
X-Received: by 2002:a17:903:84b:b0:21f:6c3:aefb with SMTP id d9443c01a7336-21f17ebab89mr32229065ad.35.1738750057255;
        Wed, 05 Feb 2025 02:07:37 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de3320fc3sm110291315ad.251.2025.02.05.02.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 02:07:36 -0800 (PST)
Date: Wed, 5 Feb 2025 18:09:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 5/8] packed-backend: check whether the refname
 contains NUL characters
Message-ID: <Z6M4zHAhA4jZBdrj@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7EkDwEsxuLJzn@ArchLinux>
 <Z6CA9qCLwMnOsKxR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CA9qCLwMnOsKxR@pks.im>

On Mon, Feb 03, 2025 at 09:40:22AM +0100, Patrick Steinhardt wrote:
> On Thu, Jan 30, 2025 at 12:07:46PM +0800, shejialuo wrote:
> > We have already implemented the header consistency check for the raw
> > "packed-refs" file. Before we implement the consistency check for each
> > ref entry, let's analysis [1] which reports that "git fsck" cannot
> > detect some NUL characters.
> 
> This paragraph doesn't quite parse. I think it can simply be left out,
> as the remainder of the commit message already explains in more than
> enough detail what you're doing.
> 

Let me improve this in the next version.

> > "packed-backend.c::next_record" will use "check_refname_format" to check
> > the consistency of the refname. If it is not OK, the program will die.
> > So, we already have the code path and we must miss out something.
> > 
> > We use the following code to get the refname:
> > 
> >     strbuf_add(&iter->refname_buf, p, eol - p);
> >     iter->base.refname = iter->refname_buf.buf
> > 
> > In the above code, `p` is the start pointer of the refname and `eol` is
> > the next newline pointer. We calculate the length of the refname by
> > subtracting the two pointers. Then we add the memory range between `p`
> > and `eol` to get the refname.
> > 
> > However, if there are some NUL characters in the memory range between `p`
> > and `eol`, we will see the refname as a valid ref name as long as the
> > memory range between `p` and first occurred NUL character is valid.
> > 
> > In order to catch above corruption, create a new function
> > "refname_contains_nul" by searching the first NUL character. If it is
> > not at the end of the string, there must be some NUL characters in the
> > refname.
> > 
> > Use this function in "next_record" function to die the program if
> > "refname_contains_nul" returns true.
> 
> Yeah, makes sense to me. NUL bytes are invalid, and nothing good can
> come out of it.
> 
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 883189f3a1..870c8e7aaa 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -494,6 +494,22 @@ static void verify_buffer_safe(struct snapshot *snapshot)
> >  				 last_line, eof - last_line);
> >  }
> >  
> > +/*
> > + * When parsing the "packed-refs" file, we will parse it line by line.
> > + * Because we know the start pointer of the refname and the next
> > + * newline pointer, we could calculate the length of the refname by
> > + * subtracting the two pointers. However, there is a corner case where
> > + * the refname contains corrupted embedded NUL characters. And
> > + * `check_refname_format()` will not catch this when the truncated
> > + * refname is still a valid refname. To prevent this, we need to check
> > + * whether the refname contains the NUL characters.
> > + */
> > +static int refname_contains_nul(struct strbuf *refname)
> > +{
> > +	const char *pos = memchr(refname->buf, '\0', refname->len + 1);
> > +	return pos < refname->buf + refname->len;
> > +}
> 
> This can be simplified to:
> 
>     return !!memchr(refname->buf, '\0', refname->len);
> 

This is very nice.

> Ideally, we'd be amending `check_refname_format()` to do the checking
> for us. But we can't without a wider refactoring because that function
> gets a C string, and C strings are naturally terminadet by NUL
> characters.
> 

Yes, we cannot. Actually, this is a corner case. NUL character is so
special.

> I think that adding a new function for this is a bit over the top
> though, as the check is unlikely to be useful in a lot of places and the
> logic is rather trivial. So I'd just inline the check into
> `next_record()`.
> 

The reason why I extract this logic into a separate function is that we
will reuse this logic for later packed backend consistency checking. We
nearly use the same way to parse the raw "packed-ref" files. So, I don't
want to repeat here.

I will improve the commit message to add the motivation why we need to
use a function instead of using it in the inline way.

Thanks,
Jialuo

> Patrick

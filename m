Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD695661
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719625989; cv=none; b=FWuBOOLkWji9WIGfXvT0nY1FaVV1CAh7bBmHTRCCBXv/4jKlWwi4sPGP7cgv9SGM7WFq7NEKXwt7WqatcBwWLtc3jcMTQ+n04NVeBEjo2UGbV5pJeJDE/kH5Tcpo0lckK8wFkbWeAOKf0LgMdnUtntOLaKT7ZhW0rXqWt70tYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719625989; c=relaxed/simple;
	bh=bF+7yjuHfMY4Z3Og3kNGsd334Loq0MU6zJ1TFJKqyEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDUdazBchfxM2pDUk5qW4J6lEbrcwgjfODeJIKPhT/q+YK3SIA38UmqtqxDbDzZWlSLKfM1YNPEP6ixhrhFUU/SqHyMjqdeyP0JSlTLrLWN3RXsqjjiJrCbiCRqCv4UKFfBq3BTRuTpB+nlP0DJWN939Kl0S5ZC+X18Huei5tEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5Sf1Imk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5Sf1Imk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6fdd947967so117144866b.2
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719625986; x=1720230786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSd/f0IlrsqRsbRqvvYgbo5670J5T3sfZMOk5bDD2oU=;
        b=R5Sf1Imk9qSFGjXzfGz16dZtRkqqCR9RA4kZW2QBtbWIOnfHPdwW7G286w5fXLSjYl
         38Pf582e4N5fcgEsx+GFhKOkt8mh1IwkmUQFZDvLD9Ky8PTQq5z8HlVOXf6s8guQopjt
         YZ8mQ/lC5kUpuxh0CSnchvQAsY4MXOJ3qALIxBr+fPYtQHUtFw+aI1jhtNL6JNrjatYC
         7cKaXINn4mIrsk2Dd9e7CoW6dH4WmIZi+YMRlekE/RMlCaEWPOM83ZMNWJcx6GeH0SPw
         F3HKSVPuz+QQXOf+/0E8FFya6D9XRrMaNsFd5DrGjt0xHU5a15VFHTLSvFgRPvXi/sbo
         fxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719625986; x=1720230786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSd/f0IlrsqRsbRqvvYgbo5670J5T3sfZMOk5bDD2oU=;
        b=I8AXU+UDNuYmVn94qt68N5AF+ohDGYmCSP42La/JZAIFrcQ5ZNV3MfeS3J4lzM/fQQ
         ql4tkqMfSOvVKBxm8+2iTJ8crDHE3Sxf2RQ0UcD/0EzOD1VVM2twXoNQoXFesos/3yK2
         mKhrsyjlbKI5sFzsTQuLlJenkpa+qsQzSZAXBIbp6C6Rmb2KbkbBRCvfSExUpLknxE7H
         UKmNq+ptlG61QmZme8GnRW9pKTspMd40ALEOJEuDiyK8pVmSRwjiwLeiXlQfZzFmN4d9
         zFcmSqSpedE5UYc25/cpHll9Pl6e8A2lMmyke+z8ricgjq7k4VR0X+10V1gldG8Z3C6x
         9HSA==
X-Forwarded-Encrypted: i=1; AJvYcCXcZdrqC1GBfw4SplqvL+HiK1Ln/7JB0rWSParvtxAihJgRF+Sjjg3ECcACIpqLj5dRslOEp8Fvt28a42hKIIqHngje
X-Gm-Message-State: AOJu0YyeNcCcugNsf2JSof0K0t/HyW8ak+VuVud3/Ys5+v42SidvjH5r
	v3NqytFsWVxJfO+SbV8CQ3KEKkcqEyAPLlVct+kC+1BIZhT7iHko
X-Google-Smtp-Source: AGHT+IHyFfCNnh1L9tgsDmM5FwlSn4eQqXCG4E1OYBjFKaQOTjgP0KjqnN8SVuKQkCy9E9ZYhUNmQg==
X-Received: by 2002:a17:906:9c85:b0:a72:8eb1:874a with SMTP id a640c23a62f3a-a728eb18931mr797989766b.22.1719625986323;
        Fri, 28 Jun 2024 18:53:06 -0700 (PDT)
Received: from sita-dell (static.133.162.46.78.clients.your-server.de. [78.46.162.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab090590sm124358466b.183.2024.06.28.18.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:53:05 -0700 (PDT)
Date: Sat, 29 Jun 2024 07:23:01 +0530
From: Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Emily Shaffer <nasamuffin@google.com>,
	ellie <el@horse64.org>, rsbecker@nexbridge.com, git@vger.kernel.org,
	konstantin@linuxfoundation.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <Zn9o_UCjtf9MuwvH@sita-dell>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
 <xmqq5xug1qrf.fsf@gitster.g>
 <20240611063123.GB3248245@coredump.intra.peff.net>
 <xmqqh6dzy0mr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6dzy0mr.fsf@gitster.g>

On Tue, Jun 11, 2024 at 08:12:12AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I think they serve two different purposes. A packfile URI does not have
> > any connectivity guarantees. So it lets a server say "here's all the
> > objects, except for XYZ which you should fetch from this URL". That's
> > good for offloading pieces of a clone, like single large objects.
> >
> > Whereas bundle URIs require very little cooperation from the server.
> > While a server can advertise bundle URIs, it doesn't need to know about
> > the particular bundle a client grabbed. The client comes back with the
> > usual have/want, just like any other fetching client.
> 
> Yes, a bundle being a self-contained "object-store + tips", it is
> a much more suitable building block for offloading clone traffic.

[Adding mricon to cc]

Apologies for jumping in so late...

Gitolite supports this out of the box.  Just a couple of lines
change to the rc file and users can just run `rsync` (still
mediated and access controlled by gitolite) to get a bundle.
Admittedly the first call by someone may take some time but it
*is* resumable.

See [1] for details.

[1]: https://github.com/sitaramc/gitolite/blob/master/src/commands/rsync

Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBEC41C64
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255764; cv=none; b=IAgsaZRm2/cKIPIVHuXWOkgxankNdDO083EQvCJBIOko27QqgKFkUQHfpXbJum7PuzYWaw4O9CGLbPDFNUivE1m/oC5gsp7HZvVCuM9TcRi8qUqPQyvsWTpsiSDsulxML0Ix+NxEZIg5Gn5B0ACg1lXEV/sELJqAF8bZzGnbQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255764; c=relaxed/simple;
	bh=BXUgwVqPgrv7ehewT6bTZr9fz+mWJj+zgF52XmEsK7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+g5DmDyH1PzJQnYDzvv4l/F3FfqE8e0oRQKOxU/8xMOx6/yWZavx9mKRWDzf953wgUA80B1H1bTAUfrUqOPi9XnkIw7seJNOd6WxPmi1DR4YI/y3qwSjyZ6oNz17g/DRHIV6eno33NWmXdnwswxoHuhbgC3x0fuNvIeFgZtPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en4izyip; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en4izyip"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad52d9be53cso285852666b.2
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255761; x=1748860561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tdin52J04ij7RJ1WTrN7KKzIzzFZXnVxC9MBUsUh0nM=;
        b=en4izyipZLlu9uco5alydUhNErdoQMQjlPylULnVVGrIhMnwKUZQDrAitBD1ZgZgcS
         DRKv9T/yGLvdlVuqGKRYrbFC3VqND65leb6gviTIVaogsQVyCJW9gi7bJIO+q/gWICJD
         peayCQVojMW0tzhpLxSC8J9D6Ld+X8ZPAyHoqq8ZKlUCLXK2PflRuUxhUJwdgy7Ouu+R
         QeZ07TnMCxcBErJoWgfpdu5ZtfdsOjjCNx4buyA7KmMCmgmZRWF/HH2029X+U2zc7h1I
         pAgRPptruRYudoFw/yzbREmxafcxbILkobdsBHAwHgbSaZnkKOq7M/Zu0Vsok2udo1HI
         2jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255761; x=1748860561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tdin52J04ij7RJ1WTrN7KKzIzzFZXnVxC9MBUsUh0nM=;
        b=EQtG20B7i0D5IFiCPkTjXVQ3Ch2ZVD2JXHOYO0+EjbXdBK5xYjOBFBZp9G9LU7v7l3
         rEBlA+xmUUF8wC4Ie+CmJqsVl7hQ0XI/3PYPUp8x6R0nH5NLgX9/MJFN+NrCmCWaSM/z
         hN1wM4hJv8VkU92Ylh9CCvxC7C4eCaEVp83dpPV7UOa9YO4xvl3mB8WphafEHBOVShxr
         Dx5y/wazSgdc3xzLPitg8W2SA/mNt8S8nqMFNHSXojF4MkpyK1sm3A3nAP98FiQhUOrr
         9shukkJoBk7JIsab1WjjuX6QmN59VVkgtVxbzR+VtuVhS0CKp2x+sPAsPeVuCeSxaW9L
         6oRg==
X-Forwarded-Encrypted: i=1; AJvYcCUhGw3ylH3WUzea1Iqt3bpjSqMHISa0uMDsinARwHBDADg7Ok6I3H/G12r61L2Q9OPOn78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3aQvrWdx/U3vxJ8TqIeg6KWF6Ll7M07PpHJEQ/+22ZMSi0oE
	javRqmlIERgOmlEHMcw2OaeA8cKYH/moUR195iMxRPd5sOde7WUJYRJkXfS8au2piJdqoopV6xI
	ZkmEbEj7eJ+Y3LldvIoL4WhEYpEpzyh8=
X-Gm-Gg: ASbGnctDfpdalOv8f5HJCRYLh6abHN5Nx8hInuif6DNj5jic9gPLyUIYpTI9GdJzbLn
	0kIMAGqjkP23QaeQr2h0Mc2ntec20w3R82pvTqknQjZq8SxqG/lIReLRyLjI75AS5L0nIcf13+X
	jdEIL8bKZYl0TsppVBTlYJRvfO5JiB2NCnrxE=
X-Google-Smtp-Source: AGHT+IEmPWjqfLKRDUwziKxLEX0ttzi5qSbVQOlcYHTLLtf5IsMZU6Z8AX6schSWlV1PN79i3ikpZJ1kwP0UyADrk4I=
X-Received: by 2002:a17:907:96a8:b0:ad2:48f4:596b with SMTP id
 a640c23a62f3a-ad85b0d2377mr778360366b.19.1748255760894; Mon, 26 May 2025
 03:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <xmqqselxtfyf.fsf@gitster.g> <CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
 <xmqq1pthtbdg.fsf@gitster.g>
In-Reply-To: <xmqq1pthtbdg.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 May 2025 12:35:49 +0200
X-Gm-Features: AX0GCFvUt6hpwlnfmZ9R5EdjAd5COAns9aUvyAAE4OQzNqzuFNquhqytkkZtZtQ
Message-ID: <CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 12:58=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> The fast-export stream produced by the code with d9cb0e6f
> >> (fast-export, fast-import: add support for signed-commits,
> >> 2025-03-10) used to identify a signature algorithm "sha1", but this
> >> new version of fast-import lost the support for it, and will barf
> >> when seeing such an existing fast-export stream?  I am not sure what
> >> is going on around this code.
> >>
> >> I am not so worried about the other case, where the stream produced
> >> by fast-export contained in this version may or may not be readable
> >> by an older version of fast-import.
> >
> > I certainly can't answer anything here as I know little about
> > signatures, but your comment brought up a different question for me:
> > Given that d9cb0e6ff8b3 (fast-export, fast-import: add support for
> > signed-commits, 2025-03-10) isn't part of any release (not even a
> > release candidate), do we need to have backward compatibility with
> > that version?
>
> I think we will lose all the credibility if we said "that's not in
> an official release, so we are free to break early adopters", once
> something is in 'master'.

I agree that we should have at least said in big letters that the
improved support for signed commits in fast-export/import is very
experimental and very likely to change in the future.

We could still do so. This could give us a bit of time and flexibility
until we agree on and implement something better and backward
compatible. (Hopefully the v2 will help us move forward.)

> As some corp environment are know to run
> 'next' and indeed we do encourage more folks to do so so that we can
> catch breakages before they escape to 'master', I actually am equally
> worried about things in 'next'.

Yeah, right.

On the other hand I think it's fair for us to experiment in some
areas, at least when we document that we are experimenting, which
means that running 'master' or 'next' and blindly using any feature we
have just added is not the right thing to do if people don't want to
be exposed to not just bugs but also some possible backward
incompatibilities in some areas.

So yeah, we should definitely have said that we are experimenting. Let
me know if you want me to prepare a patch to add such wordings on top
of d9cb0e6f (fast-export, fast-import: add support for signed-commits,
2025-03-10). Otherwise we will have to be backward compatible, which
is not ideal, but might not be a very big issue either.

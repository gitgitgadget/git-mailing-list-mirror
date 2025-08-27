Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16D194137
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259880; cv=none; b=hxhCn83R/zdXu76qDs8D/O30lz6HRjxfCmFDouIIQIFScx2tUDIOvI3nplT3rvpXht8tpN/UjzEz7Y9Q54pvKdKuguzzfNocEX0PJ6c6d3eIaUahAaX+Evf0UWunc708J/3uUDTIcnn17YJemx4u3mulmks0DEqf3HFGLbusqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259880; c=relaxed/simple;
	bh=tAwqHnuzIBwAp9aFz0MZ9YrMvjeIxx/FzF+xdnw3aac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfcd0ptQjuw546IsYFJ/vIrjl0BRpiJ3501CRRLqM73RJEgGCSuKjontM24C4mNLL3HS6MBNFDruBgjoKn9g/bweK2OKvq+BvkNJ9T9JmBUT+3xM/V+I3QkiJZUWQjlpAIqJriYkhIuA1iM+DcbkOBHAReQQ7vdW2DoNejKJ8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Cu3mX90x; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Cu3mX90x"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88432e60eebso165667839f.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756259878; x=1756864678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/RiiEKsLF4zuIb5muQdgQ9yL9S7GS4wi4qt0+FXEZ8=;
        b=Cu3mX90x3uavMOkDuV0gn+s6cgpTAuGoTnG2Lke6zUKYHMBIkLpdM+hbiGzopDwMqn
         REx8pWnv+RVK4WjY7XehZpngZHcBz8n5iyas9ItpSJcOweecZfeVi97jpJjFJQ8wtY+X
         faBarGEQPGG/fWAQTDkJqGXqjtS941a4lFwoHO6BxZWv6W9x2rcVEThOWUEQRhGN6af5
         W4N0Fqc6h+c0/T9Ro2NLL3lezLiC6sPCYTsj8H6CrAoBT567iIfo6qqp//GLnp+3rB2D
         0+aaPlTqgB71b6GE3oSpM8y3de52FFLXTT06gebL/hOYTYFTFIB59iurZ/tp/YzeTHdR
         V9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259878; x=1756864678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/RiiEKsLF4zuIb5muQdgQ9yL9S7GS4wi4qt0+FXEZ8=;
        b=Dkxt84EIYJe8uwN9ww1lAdMfeoDjkFSMnPROb+V9komWC8fjEygVu7/i0u13GySMv3
         aDww0TyVai5zw+NZ0edzSg6jvGFSXDI5DcqGOduwqEuTwuMkLvNgrznr913tpvb95Fme
         TSzL0w6wC4nK3lrmrQyIA1T6lxPB1Tta/JQJjIEKvowAa3KoJHdCR8K5fZhVNw6U9cZ7
         Kh2h5BZP+vW6m1MBN6ZJnLoO9Zbb4GRzsTa2wRojhPCqhKjLYTR7MuWFagMujxf1lZOl
         Y1jwaCyWWTgZCdNPEo3DUtlUA3hSzybZIk3Nzq2U0aarzzS9zZ66fKf/7YY98VyRoEVo
         9tvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1JPgQepHV/myIeG7Jvk3gjCt+y5AVcitIS2qHnPhCdOypq6xfqUfRaosU+z60klOs5nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GSEHOVQ1OqSQmjNSOm8jXh4dkikioEvg0kxr6CeuIpIACquv
	4Bm4IU5JnFDCLudzpu1inPpHZcjXehQlM/lEJLD9KBJKVNPn94IMLJ1JbhSmo7Sfkl4=
X-Gm-Gg: ASbGncvJsW3R+XERlG3fTVSODOLhp4vUZfpd2ZZumbo05vMJl7X31qG7P8lwkAFt4Hu
	bIwmCVDSjb3EV3YOI1+BDFNUXIj7Jyy7ZmOIrz9KiGFYhe0WFriSIe7QrZ1ehJxWDnXC6M7O7wV
	RngL2N6Nl+/scd87bGleg71iIhR8m46lvSEKIFndjRZz9xe7kT1bSV0w4SVJrj/YGhtjg71aJe+
	l4vdA9DTFxUKXj4kCCLunKUoL1jHbkAUMAUHx04zV/40AguF+fJqOZyrlseQDyaAoxocer0m4V4
	gwH5EFBjfY5fPCurZHbR47x9On/Ft74pPxa7E5pyc29DNcMGpmFD68Y30VlXKDCZJQ0VR6iIrgQ
	dc8ao30XHcrnj22hu1HwwhBNZnY/tQKNpnrA79TIySEQcIUSCjjpcIPlfufohiPIsk4TJqhQ+gt
	fxLMjiOUC1eFcwlni5/JeH7caTfQ==
X-Google-Smtp-Source: AGHT+IEKqbKBiPY3yWTWds75o50AjSOww9NeaqPe/58ObA1V+PSoCJpoNpQ0AD8DfndOJAwsXAQZQg==
X-Received: by 2002:a05:6602:2b92:b0:886:c53c:92d6 with SMTP id ca18e2360f4ac-886c53c97bbmr2267418739f.18.1756259877863;
        Tue, 26 Aug 2025 18:57:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-886ef2be3e2sm179730739f.22.2025.08.26.18.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:57:57 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:57:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: rsbecker@nexbridge.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Brabandt <cb@256bit.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>,
	Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aK5mJI1NfVQDmDXN@nand.local>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
 <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
 <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
 <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>

On Sat, Aug 23, 2025 at 11:30:26AM -0700, Elijah Newren wrote:
> > The assertion in the policy that Rust is easily interoperable is incorrect.
>
> Are you mixing up interoperability with portability?  Without further
> context than your email provides, it appears so to me.  Rust code can
> call C code and vice-versa within the same process without huge
> amounts of serializing and deserializing of data structures, and
> without what amounts to something close to an operating system context
> switch in order to ensure call stacks are as expected for the language
> in question.  To me, that means we can call the two languages easily
> interoperable.  On the other hand, portability of those languages is
> about whether those languages have compilers supported on various
> hardware platforms.  The document explicitly calls out that fewer
> systems have a Rust compiler than have a C compiler, and that Rust
> adoption would thus reduce how portable Git is.  Are you referring to
> this lower portability that the document itself also calls out, or are
> you pointing out additional issues with interoperation between the
> languages on a platform where compilers for both languages exist?  If
> the latter, could you provide more details?

I think that this is the main point from my point of view. Yes, we are
strictly worsening the project's portability by adding Rust as a
non-optional build component. But it is *not* the case that two Git
clients (one hypothetical one built with Rust components, one existing
one without) can't work on the same Git repository, even including one
on the same machine.

Forgetting Rust for a moment, I don't think it is a realistic goal to
have support for all platforms that could possibly want to run Git. I
would imagine that there are platforms today that cannot run the latest
and greatest version of Git for just that reason. My hope is that
whatever version(s) *are* compatible with those platforms are good
enough to support the workflows that those users need.

So my personal feeling is that that (not having a 100% portable version
of Git across all possible platforms) is OK. But of course that does
raise the concern that security fixes will be more difficult to backport
across a hypothetical version boundary where Rust is introduced.

To that end, I would note a couple of things:

 - This assumes that the Rust code has the same security vulnerabilities
   as the C code that it replaces. I don't think that is a given
   whatsoever, and I would bet that emperically there are fewer such
   vulnerabilities on the Rust side than on the C one (in fact, that is
   one of the reasons that we are considering Rust in the first place;
   brian m. carlson explains this point quite well IMHO).

 - If there *is* a security vulnerability in the Rust code that also
   presents a vulnerability on the corresponding C side, I would hope
   that the project's track record of generously backporting security
   fixes would suggest that we would do so in this case as well, despite
   crossing a language boundary.

   On the other side of that coin, if there is a security vulnerability
   in an older version of Git that isn't present in a newer one
   (regardless of whether or not Rust is involved), I would imagine that
   that we would write security patches against an even earlier maint-
   branch and forward-port them up to the most recent vulnerable
   version.

So my impression is that the main contention here is a concern that
worsening the portability will make it harder to push out security fixes
in either direction. But I don't think that's necessarily the case. Even
if it is, I would again hope that the track record of the folks on the
git-security list would suggest that we'd do the right thing and not
abandon users on older platforms the moment Rust is introduced into the
codebase.

Thanks,
Taylor

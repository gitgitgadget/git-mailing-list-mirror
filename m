Received: from cloudsdale.lanodan.eu (cloudsdale.lanodan.eu [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1CF163
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755984256; cv=none; b=qGT6Oa8jrPobz7IyIpnoM1PFqMeVDXd0KKLtFEv6YfuusDF2OGFGjoJjahUVo2fIAWYgDRrId/5fqlymk/kJpFp2u+NaeDbAp0jA/uZKodatuA7t+NWEcaS6AYWwRpLFu1I2KM19jfwozJ8xHUaeWEGX+25i3qjMpYjDbv2NGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755984256; c=relaxed/simple;
	bh=8IqwnMrQirt3YxhJaIBtAnhaUIrBVAxek9WjD0/Twko=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3WQ9McGpPqYlOuX1lZeBjUL2+L4LfozAgnewnlZSIrZOOTG+Xi9UHaoHhLUKoHGWttZDQ7L0ddCvEwE2Rn3HpgE89G7P0+y7krXwyD5vPsmgo0aUQRt58W1aJcNHGKcm4KQkOwsjxLmeLSRyY8mLvl0QwBxLsx6mD6KFvBkEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.lanodan.eu (OpenSMTPD) with ESMTP id e38035c7;
	Sat, 23 Aug 2025 21:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=date
	:from:to:message-id:references:mime-version:content-type
	:in-reply-to; s=20241213_132553; bh=8IqwnMrQirt3YxhJaIBtAnhaUIrB
	VAxek9WjD0/Twko=; b=SfTtURfPTtg4G/d6yMpnf/CSE7v3xa10Iav2p0Ji+oDM
	6WpRrzdHTPJ3gsf2ZXx8A7b2LQCncxbEi59uJuMabQezEQlc34lhPa8w/vv/z1vX
	9z0vf3WXT2T1f6jND3MsI29k9DWDqPL0/sCdEw42QFSDY2whe82oLqsG9mXVp9TG
	1ogvUJscrQGBswyjSFNvh+tQHpR2YhD1Gf27l+8aPSq+3zRo/pRHYVL9QKj+s83+
	2CqWimeIEjlbmW7Be6HbR/ORi0q3kdCNBtkkjmaS6ZXxtsymDVMFFYa6bG3QYcfe
	b34ajlGuCFsRfX/Fc7989hIomTrMjB6Kg5R+3S2RMWUc8blYb/+lOXX2uZFiyXXu
	REYUbvun40PdiEeBUwJDihShSS1YHKIifDQt+SXAr+ZPcOH+IDKDnVY03+KxRmcL
	bKKWpRx20OANMabgb4fpqVX3UZjt0a8n8VYJc/8/FOWHOhNUf09tw9xKZzmBXd3o
	bWXnZxJAM0tDG3aTijXjX/RO/BmJNEWV3hfh8ikp1FDbgSGM0unly8F+T1fvaWKR
	jPqlyt+AYSwtbcX0xVBiRgH8cUUOyJtmjbIdoNBoQzt7C79j0egEjKaSS0Un8ztq
	LVEWcAYLHs2ckS7EChLF3Xt0Cx3jPpaUwLJnxD9HL4hULvL7g9gdl+1wiaw8dyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=date:from:to
	:message-id:references:mime-version:content-type:in-reply-to; q=
	dns; s=20241213_132553; b=lcsHeNRN7ftOz7yUe/JBQhgXfsNo+r7KawJ+7Z
	tsHJ7aWIS9hS0j8f3ZpvNjLj4A7ag6yi3FIZmdk649h9X8AOAzwHBvFPMRODuqXR
	moDZFct5ApeBoYJXK8jcCDSY3pcWUVSehGmJfWxnZ979eyNXm7JixUyEL2DR5X1D
	wAO8iaBAtdELddarlcnZRf2Bdssl7yM0vmVXaIakYQyUAJDIhBU9bx69KO+0SioF
	frSblfZtsYue+wzudOnBwtap5dWsl/NEpnN/hy+pNsNATtsl94k34yUsi+pJ+ICM
	aBBReBUAcYS2pTDt32aeSW3IwHZ8FCQygtLwBQ46JZH1eZPrH962Wd3nKpLxHhjY
	5ilz9oTQhF5moS9ZvJx7PW+/zH6GnkboiPJML2E7kDyVeXlnaOfcNCmItWhBOWlz
	FzM6vCJoAkYaPcU3qSs56AKfI+GzIfYY6UJ21A6i4mBLwwCIGTkMtGVoXwXAtEun
	tiIcNCx+/K0uEdIEFhx0Mb24XxyF2iSs/GJg7q0mj9ki+T2J4XrZBoFf2X72JFby
	gyRYSBKfNQ1IuPhcdi2J7LykuqOkTIIGje82sw6/jsrFQiwHQLdvkWCz7RGvqiwQ
	C5T+IaPGl2AcsFPKnD7ntQYl85QTt0HEco2qvbyO3NfdwnSKN6IRa8ax8I8fLo4S
	WJhOg=
Received: from localhost (cloudsdale.lanodan.eu [local])
	by cloudsdale.lanodan.eu (OpenSMTPD) with ESMTPA id 00171c7f;
	Sat, 23 Aug 2025 21:17:30 +0000 (UTC)
Date: Sat, 23 Aug 2025 23:17:30 +0200
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>,
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>,
	Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aKov6qwXzrn7TCH6@cloudsdale.lanodan.eu>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
 <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
 <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
 <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aKoVcVexWi212pAl@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aKoVcVexWi212pAl@fruit.crustytoothpaste.net>

[2025-08-23 19:24:33+0000] brian m. carlson:
>On 2025-08-23 at 18:30:26, Elijah Newren wrote:
>> I don't think that's fair.  A quick reminder on the history: There was
>> lots of excitement about potentially introducing Rust two years ago at
>> our virtual Git contributors conference.  Taylor formally proposed
>> adopting it on the mailing list a year and a half ago.  And at Git
>> Merge last year, among those in attendance, there was broad
>> significant interest in adopting Rust with unanimous support for
>> letting it move forward among those that were present (which, yes, we
>> know wasn't everyone).  And there's the three rounds so far of this
>> patch series.  At every discussion where you weren't present, someone
>> else would always bring up you and NonStop, and point out how you've
>> been a very positive long-term member of the Git community and how
>> Rust adoption would likely negatively affect you, which would be
>> regrettable.  We waited years to adopt Rust precisely (and I believe
>> solely) because of your objections.  Josh and Calvin even went the
>> route of making optional not-even-built-by-default Rust libraries
>> (libgit-rs and libgit-sys) when they wanted to add some Rust bindings.
>> If years of deference by other community members isn't considered
>> taking you seriously, I don't know what is.
>>
>> I agree that it is disappointing that there isn't a clear way to both
>> gain the compelling advantages of Rust while also retaining the full
>> current extent of our widespread platform support.  It's doubly
>> unfortunate since you're such a positive contributing member of the
>> community.  But not allowing us to ever gain the advantages of Rust is
>> problematic too.  So, a decision has to be made, one way or the other.
>
>I think it's worth saying that I do appreciate your (Randall's) positive
>contributions as well and I would love some way to continue to support
>NonStop as we adopt Rust.  To be clear, I care deeply about portability:
>I have owned PowerPC, UltraSPARC, MIPS, and ARM hardware, and I test
>many of my personal projects on at least Linux, FreeBSD, and NetBSD.
>
>There is an alternative Rust compiler, mrustc[0], which is written in
>C++ and that I have played around with to see if it could meet our
>needs.  I've been very busy lately and haven't had the time to test it
>out fully, and although it will likely require some upstream changes for
>static libraries and a compatibility wrapper because its minicargo is
>very limited in functionality, it might be an option that we could
>leverage.  There will necessarily be work on Rust upstream as well, but
>I'm hoping that mrustc will at least open doors for us.
>
>I also think that Rust is becoming a more and more common language in
>technology because of its interoperability with C and its memory safety.
>The support policy I wrote up explains why there is an increasing push
>from governments, security professionals, and the technology industry
>for memory-safe languages.  If Git is to continue its success and broad
>adoption, we don't want it to be labelled software that is using
>security anti-patterns, and we also don't want it to be a CVE factory
>like libxml2 or ImageMagick.  This is the reason I ultimately started
>work on the SHA-256 project many years ago: I knew we'd need to do it
>for security reasons and that without a more secure hash algorithm, Git
>would eventually be dropped.
>
>My hope is that NonStop can find some way to support Rust because I
>think it's a compelling language and NonStop would greatly benefit from
>the wider variety of software available.  My sense of previous
>discussions was that we do very much want NonStop to continue to come
>along as we support Rust in Git and that if there are ways we make it
>easier for both, we'd want to do that.  That's certainly my view, at
>least.
>
>[0] https://github.com/thepowersgang/mrustc
>-- 
>brian m. carlson (they/them)
>Toronto, Ontario, CA

Hello,

mrustc isn't really a alternative compiler, it only serves
to bootstrap rustc+cargo from source code rather than binaries,
you can't really use it to compile arbitrary Rust code.

You'd still need to port LLVM and rustc.

gccrs would more be the alternative compiler but it still seems
to have a long road ahead of it: https://rust-gcc.github.io/

Best regards

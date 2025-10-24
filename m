Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E131B85F8
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270754; cv=none; b=FY5cBlbYHMX9KvMjB0e6zZj+ekM1mYXSRpJQSLTptFQpU5pIgD7HyYcIXAvtaRY+1J7BqakqhEvj3SxtPhDCMCcVikWGa+IXpLZtTk0+KOBhzR1bbOc51+R301/KAcqeTUc7JKH1hTMu43pTmcTOh1oXZO5mYRnWrQDpBhjgTC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270754; c=relaxed/simple;
	bh=/0x4Q2kU+HxXZAN/Z0aUdv/4KPZBC29YBQU37MjoguY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO4tkMbauQqx4aQult9vfBqfLJ+ZCFO0hr++I71+TIzoL72ct2FJQjBXFF0TNZZJfMit3K7elVzu1C5xMsjv+b34jVnkuiaJGJnpJI6xsP+O1pKvmT7Onb3GgAWCHJoyKlO7dT3od9zrMwZX6zQsfGmRLm0nnqg09Xmk+MDueZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KYFoyPA2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xvjtaERL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KYFoyPA2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xvjtaERL"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 712F114000D7;
	Thu, 23 Oct 2025 21:52:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 23 Oct 2025 21:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761270751; x=1761357151; bh=9wIrxHLjk5
	GAcLSn2TMv+siokuylJAj1hWWx9YmdrVM=; b=KYFoyPA2tKLDzkCoeawmVI6seE
	TbOL1JBDbMAnKkrUSYdHgQkDJXfVE8cKVdXSKPe1rKi7Ah7M8BuvMWoEhY6u1E94
	0tUG8u3oxggabjZ9q6dJDDCBC6KwkVaRu/j2I1YQ0w/U+7GXmfaSPR4GucYgUbGC
	NlollXGOxkVcTAzK0o24Yg/I0G3h1lKGePVDZETf7ex0mmdbbMefhOlmqPU7pTvW
	wBfcLCJ77FycfSqj/GJJyawZ8d2paXCwOFrjBxp68S0riwEjL6uMN7NRN8xwjlkY
	jx24of2eB4Xbwt9uI/76CeR7pxuwMkkRT47As/8gP80x4DuC8RcLujVvH0UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761270751; x=1761357151; bh=9wIrxHLjk5GAcLSn2TMv+siokuylJAj1hWW
	x9YmdrVM=; b=xvjtaERLrRnsQXCvqWsC7JG053TQGwtiPXklVrfmzVByHQfhe8W
	t41OSeowS9wlDK7Hj7em48IRdMWDtghuW5MN3NGE0eUAGr+RXovVRZT4INkKZhEY
	m22pGN5p16quuOcjWB6RD+GEC8mej1d6El34G9HtMUfX0I3zdv0iuvx6cI25CDEn
	KBAI4+BZHeYmwF6aCdqcGx8qwEFz9jtp0iX18GJc0FqgC8e9+4Ei8fTsXgry/E5S
	nwJFeMMpMpJvdWlUuanS8qI1nUq3uzj5q1bBpPvcDw57BKYpGu98Qvyc4e4ecvxw
	kv9f1NQ8KdhJHxaDJlMbtCZEU0Mu7m8Gezw==
X-ME-Sender: <xms:39v6aA8R91ZcGvW9SmaV2EAFKJmJqqgk8KTx6qILoqKXiVEJ3os2sA>
    <xme:39v6aPt9iB_9Wgp4osV4gJsS6C015jknua4DFb9MAESNG9eGmixwS6FAj2KzDu0VU
    zu0fV6B--zW1mtLJd3dwLBCh7X8F-bCvK45ckGoZhSOvlaMXsxuNA>
X-ME-Received: <xmr:39v6aLAzm0nxbXuGsYfxaucIh1J5P-K77WyqyMaqJVGqhaKSsG_C3-kJLf57uR7NWZjbROFBXccE-0NahM_5LBTAUHSjByZBBd7I07Z5M8_0uZbdaUIv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeektdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpefgveefveeihfehhefhgeethfdvffehfeehue
    elheeiffeuvddvuefhveffiefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    egpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:39v6aPUv5eYxmTSudZt3jHjvAuYY4V8UQ-apko5fuFTgz03v9BmRHw>
    <xmx:39v6aBC_yJFyzaAwf55Dby39rbxokqRj_RHNJTQ78LJn-r6BLj3ecg>
    <xmx:39v6aK8HeL-axtqZw2wew3C9rofiWvX2ILUYIlDxBnFBHv61MM9Gcg>
    <xmx:39v6aAGTQbyPyLcKfZMfkbDe-JdWwj0OE07lxyo75Zf6IbgIGRWJtg>
    <xmx:39v6aCbJpF3EVmwNkyk4UH-HD91X03WZklinOcjkvy25XkX9n4Z9v5v6>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 21:52:30 -0400 (EDT)
Date: Thu, 23 Oct 2025 21:52:29 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t1016: make sure to use specified GPG
Message-ID: <aPrb3QGTNE7IBClk@teonanacatl.net>
References: <xmqqsefq7947.fsf@gitster.g>
 <aOu59eVs7tK6pCoF@teonanacatl.net>
 <xmqq1pn85f5i.fsf@gitster.g>
 <aOvz-ac8JTCaRwIm@teonanacatl.net>
 <xmqq3479tk78.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3479tk78.fsf@gitster.g>

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Junio C Hamano wrote:
>>> Todd Zullinger <tmz@pobox.com> writes:
>>> 
>>>> Interesting.  And well-spotted.
>>>>
>>>> This _does_ seem to resolve the failures in our CI and in
>>>> the Fedora build system.  I was able to run a few test
>>>> builds.  With this fix, the tests were successful where they
>>>> were not without it.
>>> ...
>>> FWIW, GitHub CI jobs are failing t1016 at the tip of 'seen' (which
>>> has this change), but only some and not all the jobs, which may
>>> indicate there are timeing-dependent flakes involved.  I didn't dig
>>> further, though.
> 
> Let's merge this fix down, even though it does not seem to have
> any effect improving the situation of flaky tests here.

Sounds good, thanks.  It's the right thing to do, even if it
didn't clear up the issues which led to you noticing.

-- 
Todd

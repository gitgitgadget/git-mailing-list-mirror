Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BC15886C;
	Tue, 17 Dec 2024 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411112; cv=none; b=pA+aDgLSs9lc0+jKPou3m6dk2NXkrsGp0BnRGXljpwcUlwHMws+qunNU1XD2+WTnkhimay27x9wPU9q4bpy35EpBOOujNpOU3zj1JbiaSdpQ8VrRdHZuALLV4iaFyT+c2jK70EJ9qAxUl2NLR03Tom5SgigRFd0enEO/cF7oCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411112; c=relaxed/simple;
	bh=eSC9AqU8iZGJDseE3EQmRMYmjKSxn6LiqmyeI70apPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+sws1ZCcYCXeCJL784G3n/dbjM/I9f1g7xcpEwYfFlWdaijvcZyaFZakwlO89by8EzWOe719bylb+w2d3bAONrA4zG1Kj4QMN33Algzhfr9e3lr8kOCeez62QCwIMuyX3fixI9uc7mSimu3poBCfJwtEkATCR2qSs1HNADpTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P8747aBW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NAzuENlm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P8747aBW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NAzuENlm"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D71A51380136;
	Mon, 16 Dec 2024 23:51:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Dec 2024 23:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734411108; x=1734497508; bh=bOwUzCclSw
	/45B9+MHKTMLfwGt6ajFRIpr2a7uRmhao=; b=P8747aBWQsc7rf23dl2y8UL+6v
	qvZye/JUyBXMbkapzcJhacpBSeH9W4CJqETiDOXeSmmSMYUhdkE9fLUjriz/dEnH
	pXCr/Nmpav5wHurdePGa/H531VjjGsS7/GCcEz6wlJijLJs9BsE8Eva1tdHvSvk/
	0dh6JRpTMhr0rNUabA0R8OJ2ndk72Ww2RGZu599FGZIL8Q1IhhROio+ykNJFEc2X
	6a0URQHuT5kOTlpZZXAom9HxSPR8U+YKHTZ7y4IdBf1sqq43C9mhzOdx5ck2dsAm
	TSiWxzSwiN7XiTq1vNLbOs3j9P+71KuhaafciSe/zOPc9ctsrX5C6Sdq+4rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734411108; x=1734497508; bh=bOwUzCclSw/45B9+MHKTMLfwGt6ajFRIpr2
	a7uRmhao=; b=NAzuENlmZU2fJVTo0gjxOldmhWkelHzRZyPxLs09V7c72PL4NiD
	NuDyIepun3yIFMSgxs1kDp/oOteyCligYjZtncl5c5OiAQ2HEcYS3TSd0WrZWYtU
	1A/aOLiVOAZ444nD8BPbSY3yo0L7AQNhf4FaZmIdQr+FC3UECveHoR0cKqIewPZ1
	Hltc8EVl++lf7Tdd2OZPfYRhnTs4FKbyFgsAbB3s40P77xn2L8DCAtY/wc5JhnRH
	1H/HggA/k6eDjKPGhF14dZizwiMqneP0oSX7MRMMDFEiTHwsBoK4ZMOvTVXztkte
	WoPqAsrJP/GLv4nT1yuHsXnN1Qxj8D7+kRA==
X-ME-Sender: <xms:ZANhZyc9Eslcl0c9E6s26ErewL0yf3SAzpo0XzLXDkvD2faIHUVs6A>
    <xme:ZANhZ8Mvn3ncBjGxpSNru9Ta2jGknekplg6E1_iTK1tx6vK9EFeUgjyyZIwc-_2YM
    _fuJc6wC-vc2wu9Cg>
X-ME-Received: <xmr:ZANhZzjg1OaMOZwe2-TqtStg3NQX9mgfrzVF0SZD8laOdVBnOBv8to6ibR_uUWV6SrGqXVzZ7uMp8HtZtTTpJ9_fUI1jqBYWWjBu_sw9R-Wpsag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpefgvefhuedtveffgeehfefffedvjedtgedukedvfeeghfff
    ffduhfduuedtffejhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohhoghhlvg
    hsohhurhgtvgdrtghomhdpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithdq
    phgrtghkrghgvghrshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgv
    rdgtohhm
X-ME-Proxy: <xmx:ZANhZ_8zmRJYkx3ERNhZ8eag2RWckivqFzcPKvhLHrkvMrJAfnBqhw>
    <xmx:ZANhZ-sBSt0RG2ROrVYNdz9kEZqL7J-iF5vr9clOFSt-qDKlF986Yg>
    <xmx:ZANhZ2GPxsWXNpnV_oqAWjIOe6OHZzLAz7Fg4Qv_ofutMQqddAoZRA>
    <xmx:ZANhZ9PDZVgraZEwi17NaG077rn8uXF50USpG67UVsJgSr1lJzK6Fw>
    <xmx:ZANhZwWV8SraMePJPZ2_cdpe7MJG2egW6y5hHwUYfzP1KPwjO3ah2Blm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 23:51:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ac855e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Dec 2024 04:49:59 +0000 (UTC)
Date: Tue, 17 Dec 2024 05:51:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
	'Linux Kernel' <linux-kernel@vger.kernel.org>,
	git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.48.0-rc0
Message-ID: <Z2EC9rq3F0rTljff@pks.im>
References: <xmqqfrmn4hr9.fsf@gitster.g>
 <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>

On Mon, Dec 16, 2024 at 07:07:25PM -0500, rsbecker@nexbridge.com wrote:
> On December 16, 2024 1:15 PM, Junio C Hamano wrote:
> >An early preview release Git v2.48.0-rc0 is now available for testing at the usual
> >places.  It is comprised of 446 non-merge commits since v2.47.0, contributed by 66
> >people, 26 of which are new faces [*].
> >
> >The tarballs are found at:
> >
> >    https://www.kernel.org/pub/software/scm/git/testing/
> >
> >The following public repositories all have a copy of the 'v2.48.0-rc0' tag and the
> >'master' branch that the tag points at:
> >
> >  url = https://git.kernel.org/pub/scm/git/git
> >  url = https://kernel.googlesource.com/pub/scm/git/git
> >  url = git://repo.or.cz/alt-git.git
> >  url = https://github.com/gitster/git
> 
> Did I miss something about GIT_TEST_DEFAULT_REF_FORMAT=reftable being removed
> from the test suite? That was available under 2.47.0 but if I supply it now, the tests
> crash at git init.

Nothing should've changed here, and a local test run with that
environment variable works alright on my system. Could you please
provide more details?

Patrick

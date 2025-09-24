Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375FCA6F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721649; cv=none; b=MN14eTB4GjdNJnnZYLLOkaFQMFRpdptTc/7IBUPDFJ/VNr+Wm4LoGnm1fxvVy+FZ5MKWUJH1r8jlH9+I8OvR+KfZ5HUabzTwN6p189OXlQsNGJrmVzPT4kbPs64vmNcLJGC/2srYCydShVcyctgIjjdaXH82nOFgo+hqeODmbjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721649; c=relaxed/simple;
	bh=iO56PQLzZPB8+/i7UdaaVWwqZwiSI4YftmJaQxAQqfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq2F5gBeYjyQbq41rHP7xlQdiwXzS51AzeGIU7yigr6QvbqlrZG4FIHxRsu+cHb9Uv9VH67AyP8FsViWEVjW/c2K5HuYEBmNZJOmO7ONQ+gpOHRYVju/UKXmPguhgX+lNUcJS/XPPkiE6Io9F2Ojc+Y8Bt8eREHSg+Zvej4f2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kgOSiYja; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nbKD6dav; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kgOSiYja";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbKD6dav"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CB897A016A;
	Wed, 24 Sep 2025 09:47:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 09:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758721645; x=1758808045; bh=/UMZArfbEH
	q8y4CueiLThfWpER3EwmifNNOfYZKYGL4=; b=kgOSiYjanBkj/5gNqN2fVcV9jk
	/cYDCAh6PYXik8UukADoRgbAcF+Zn7tKLTpLON2ALqXvH5DD1NEDTO+HbpxQtcb4
	8GG4J8oVVr4yYWQmYcMXDbzxd1N2uflgjYReQgaiORKW7USEzDY+ybKX7q6rsxQe
	ZuuGhNQa3bZHDbgThvB8f8C+QzNxUT57ZxasJwI0hi4k08CrkRbxfd+nuSzP4X5D
	F0yEa2cKFEOR+jivXtz2Pjze8CPixSpxopygqjc4NaDuJxVxoGZzAXD+ah0WzNvA
	3gdZdO6FrZ+624He8/xwOaNL61bJlEPjfj2VpcuvotGWK73q2pB5gKJkl2wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758721645; x=1758808045; bh=/UMZArfbEHq8y4CueiLThfWpER3EwmifNNO
	fYZKYGL4=; b=nbKD6davt1L1VGEOCMkDrN78Wziffr2ZnqW7+8uF2AN7LqOzJ4m
	OCI0PCzPugrFirxwuLNEzhwvYLCpy+vMLbG8boMkzHYNeKJmkNBxnZ2RKu3LZ91K
	qFv6KXH4k4ntmXubmhHFpTPpsGX9TpUUY0jHfXR7G01tVN24LlHceAjLNm++ulQj
	P8CnUexKXqPd0E3Q7CKCVrtmzG6yinj2kc6J21VabnuVYvdiVKrRieyO3JTw1Z6n
	jADC/mIz1yZWM6u4kuunsU2i+f1e8oD1r3/ghfH95mDfNTnm1Xx2RQ6Ihmo2llch
	exh10w2xo61NCwvOAb0P3btqio/9kxVRNzA==
X-ME-Sender: <xms:bPbTaBYnJY-4Ee4NHsM8F35dvvE7MxnLedWrfl8SM69KTZLLQ3p1nA>
    <xme:bPbTaEzoF7EGCRazVa_QBN5tYnzh42zW3g6qv-FGK7-EYE4CayEF9Aj_eLLJ4cywq
    e6-_aYPr18SsTQ2eFsL3BXIy35tHe3LskKfUmoJ0KV0yp14AH-ebw>
X-ME-Received: <xmr:bPbTaIbBrTLJzVsmJPwZvE4iE7zYnTv83IWWbxmyf5JwNlfKdvyfLzJDB5Gbep6c184GzGw8ugC_mPN-a_dbu5CqDcFB4y8gsrmJ28xK9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgr
    mhesghgvnhhtohhordhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghonhhtrggttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrgh
X-ME-Proxy: <xmx:bPbTaNzeltJkDyRaviRS628uOvcONBC1Egk7zpxEh6kdNKJXL2tEKw>
    <xmx:bPbTaJErDR7LvePoj9sCj-PRDk9Y_q0-YFyt7PtYrb7mIl3lio3xmQ>
    <xmx:bPbTaNz20qNb2mQRsPAz7bE-bs06K-OFL2dIXNmsKra-beI-CJxckQ>
    <xmx:bPbTaMPIlzm2cZ_uWrhsn5u86FbhU3K1Db-ljx56d-AHm8AnWAfwGg>
    <xmx:bfbTaD7t6ZZQ1kqT_QPfLJxRSSmZIJlLX2HCcev2xOex6cp2la3RMmpU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 09:47:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08269a83 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 13:47:20 +0000 (UTC)
Date: Wed, 24 Sep 2025 15:47:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: LTS "lieutenant", was Re: [PATCH RFC v4 7/9] BreakingChanges:
 announce Rust becoming mandatory
Message-ID: <aNP2ZWMbrbxa6ZFn@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
 <xmqqldmmqa1z.fsf@gitster.g>
 <aMfwGHL7dh8dk2cQ@pks.im>
 <xmqqsegev4jp.fsf@gitster.g>
 <aNIw23JzQE1vz2JD@pks.im>
 <61e4895a-415e-f2ba-97d7-23aa99334191@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e4895a-415e-f2ba-97d7-23aa99334191@gmx.de>

On Tue, Sep 23, 2025 at 10:53:02AM +0200, Johannes Schindelin wrote:
> Let me propose an alternative, one that is much more likely to be accepted
> by actual Git users, including professional ones: How about assigning a
> trusted, prolific Git contributor as LTS maintainer? One who is deeply
> familiar with the Git project and can, if the need arises, help the Git
> project steer clear of unnecessary conflict-making e.g. via
> intentionally-incompatible bug fixes on the non-LTS branch? Kind of like
> the lieutenants in the Linux kernel project.
> 
> Naturally, I am thinking of you, Patrick. You have demonstrated diligent
> work in the Git project, are highly trusted both inside and outside the
> Git project, and you seem to genuinely care about the long-term success of
> the Git project.
> 
> An additional benefit of this would be to have a dependable release policy
> for older release trains, just like other projects have. I have heard the
> desire for such a policy many times.

As I mentioned in another part of this thread I think it's still a bit
premature to talk about how all of this will play out, as the potential
LTS release is still at least a year out, and then it'll be probably a
while before we actually need to care about handing over to an LTS
maintainer.

That being said: I already mentioned somewhere (please don't ask me
where, I don't know anymore and the threads are huge) that I would be
willing to do this. It certainly is not the most glorious or joyful
task, but hopefully this isn't too much work? Maybe I'm being naive
and will regret it.

I certainly don't insist on doing it -- if anyone else would feel like
they would really like to do it in my stead, then I wouldn't complain,
either.

In the end I think we should discuss this more and finalize details once
the LTS release handover becomes more concrete. Right now, it's still
this distant thing in the future, and who knows what projects I'll find
until then to fall into disfavor :)

Patrick

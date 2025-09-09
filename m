Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC1253F14
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408461; cv=none; b=TLtFa8U7i7rssO4ujbJVPwcrPMxEtPuURR6Kn+lJOYVNTNnxI+5P3nP8w7IxnaQBShs//HOvqrUCBW7EbfFh7adIxr5Twe3NTcQ9/65di0bxpyKsrHYfCwLbixTKM9x067ya0dA+2YKH4LpxAjiIKbl1LAqr4MoBZF3z/Bpsof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408461; c=relaxed/simple;
	bh=tIMKqvT6KBkVlKFRbMIaVX09gH5DAcXe2xMVM5+Zd38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6sbJoFR7AClzoY/79e3NYPuo0GAJMS+kBo3kIlTM75Oe+7spf7CvlTkxq/e0hTNJPyOxtPrjFD+k7ofyJxTKeDnNNdrxFuUg0vlSG9+V0AgwRsGEwG+wXBL3A6BS6pSBvEZyZK6DwfdvAEZxzl+M7advhMi/7X4Thk8KAjU2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Re+4pZK2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N16F6Cy7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Re+4pZK2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N16F6Cy7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B27BFEC0188;
	Tue,  9 Sep 2025 05:00:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 05:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757408458; x=1757494858; bh=Hu8fm9hq/x
	QlXs2QnLcDd8JNoznqE59mbBevs3uwprA=; b=Re+4pZK2wVdqyzD6ZEslLOrlEp
	nit6DIkzZTvpvnfWs+dhTCnsPI5xXCCjwHVxPQ4qkSeG51u0OnlIbdLZ09rB4UDI
	XWKa5U92/mVzWdXWT0kCy3VQAts0oLTyqqoHjiVdsd8DxYnCIcBvvG7A6BSInbhY
	WiKHDAvIgU2C2GEvnh+ohn+7HyqhbhXO3Q0Zo+wmz59BYotwRRJnGiHGbft1F1l7
	rMTzc0RBxmCNlCgLbVHx+NDsX/fi/Qyc8BZWxrYCNHds82PYMp9WUl9BW/yPRRtp
	IT7D4vDsc5G8mVnEDi6D3HBAO2czEgnU2yc3ySO65AFlaSkPhKYLqJVE/YjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757408458; x=1757494858; bh=Hu8fm9hq/xQlXs2QnLcDd8JNoznqE59mbBe
	vs3uwprA=; b=N16F6Cy7CJk8or0fP7WKuPGQTXN3Fnd+OSGAsJ/X6JGBXTGURPY
	+uP5C4nIiEVOJ3Tp9HyaW7cAUDpTAOQSrDN8qE504sgjiUGX5VBSmFzSlxSWH0Ze
	EkbG9iitXTbdq16rQ7sMbRxDNXFIUVJ/hYcSVL/ZTJtbrgfgOl6EDPrer3SiXWX/
	lYJ2ptT8zD3sj/MN6h3X2meTXA0HI+PF/Ut1x7RMoVcmqspmbClUq/4jjvBJg0PO
	JLpTAU2c95zLp+0PRJzdALNNWPUeLKzqxN0J7qH5rmIIf7hBxSx3FxU7nEEdd7br
	knsgCgl7dXZZTDPwpp78dTudk+JS0JovKzg==
X-ME-Sender: <xms:yey_aDZWT1KsWNqoH8U25M04Od0rc3tmNIEFUqED1YOaxd1BD0gElQ>
    <xme:yey_aOFxqhQD-GovFFoj6U5-tizYDlmC2eFMHQQZDZGKYmtJMX6OPi9o4Jv47z9Du
    x9FZAiylBnEe5wW_A>
X-ME-Received: <xmr:yey_aCakwzhrpEBgm3oVSqX1B-RZjoGEpfBkn3nskhYwEJ-WDqKT30jmqd_gpsxx_QfvSBGF7jQk8xxKa9cI98tyXQd7GgK5WzWJWKiovVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnh
    grfedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnug
    gvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:yey_aCzg7JOyKaa_1FBBhD3kCA7gBVWTGt2MHcA7KKAVdhHvwk5vqQ>
    <xmx:yey_aERy1XZDJ-BQGIt2Yw3-t5KSV0LRHn00Xgxb1zdhpUdDjO-dVQ>
    <xmx:yey_aPIn-z-WVWGbWG-RnaeFK1O3i62EXkN3ZRu95Zu9jwBtdriFzg>
    <xmx:yey_aLV-XVUjW3jX5O4s6LsUWnmPZOjUzYc3sHNGdL77OP6jpZnN8g>
    <xmx:yuy_aNNisYXNvw2WLgMmuuZUiigyG8TWmxAzoJpPmEm3Mjnd73iCQVX9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 05:00:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7bd2944e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 09:00:54 +0000 (UTC)
Date: Tue, 9 Sep 2025 11:00:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] replay: add --update-refs option
Message-ID: <aL_svO5Ils8r9DkT@pks.im>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-2-siddharthasthana31@gmail.com>
 <aL6n8KEHSDii5Wd1@pks.im>
 <c7615356-04cc-47e2-a894-4d24e416e4ad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7615356-04cc-47e2-a894-4d24e416e4ad@gmail.com>

On Tue, Sep 09, 2025 at 12:28:29PM +0530, Siddharth Asthana wrote:
> On 08/09/25 15:24, Patrick Steinhardt wrote:
> > Is there a strong reason why a user would want to update refs one by
> > one? If not, let's not add new code to our base that does so. This is
> > known to be inperformant for the reftable backend, but also for the
> > files backend in some cases.
> 
> You are absolutely right about the performance concern. My thinking was to
> provide a simple mode that exactly mimics "git replay | git update-ref
> --stdin" behavior, but I see that's not worth the performance cost.
> 
> I will remove the individual update function and only use batched
> transactions with REF_TRANSACTION_ALLOW_FAILURE when needed.

We can still extend the functionality at a later point if we discover
any use cases for those.

> > > @@ -319,6 +355,12 @@ int cmd_replay(int argc,
> > >   			   N_("replay onto given commit")),
> > >   		OPT_BOOL(0, "contained", &contained,
> > >   			 N_("advance all branches contained in revision-range")),
> > > +		OPT_BOOL(0, "update", &update_directly,
> > > +			 N_("update branches directly instead of outputting update commands")),
> > > +		OPT_BOOL(0, "update-refs", &update_refs_flag,
> > > +			 N_("update branches using ref transactions")),
> > > +		OPT_BOOL(0, "batch", &batch_mode,
> > > +			 N_("allow partial ref updates in batch mode")),
> > >   		OPT_END()
> > >   	};
> > So I think we should reduce this to only accept two flags:
> > `--update-refs` and a flag that accepts a subset of refs failing.o
> > 
> > We might also want to make this something like `--update-refs[=<mode>]`,
> > where `<mode>` could be "allow-failures".
> 
> 
> That make sense. Would you prefer `--update-refs` with `--allow-failures` as
> a separate flag? I am leaning toward that since it's clearer than the
> parameter syntax.

I'd personally prefer `--update-refs[=<mode>]`. The reason is mostly
that it makes it easier to discover what flags are related to the
`--update-refs` infra and you have to worry less about catching any kind
of incompatible flag combinations.

Patrick

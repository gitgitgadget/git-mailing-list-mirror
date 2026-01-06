Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9851C3BF7
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682422; cv=none; b=PmR910H0/E3nSzpSjXbnH3z/CRAokB+dLa6jeXW9KttC+9Kmh4xh+/aG9cD7Qj6v1JyYPEw9IRikWBVlwEhP4b+of14uLjsSRft3jKzGfkaUBq7E1a2mg6yOGQQwC5yg+2vQmcHdRtt3E2ZnfccId5IyubABGck2CmAy3Wv+kNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682422; c=relaxed/simple;
	bh=f2aM3TccC7Qi6RG6w4rpB9avNvK3pXj0czxAOZJh1fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWP5yyZOCDWE8YkUtPxj9HAWFIRJvHF9loZR4nnQr1d8XTbHYUcX52oxEcR6N6VJwnyM6ITI/ZSgMAZ68zl03KRxO7JFZ6mDjU+bH7qmFRscLmkcADNlLKy6A4+yghc2DTtsmxcupEmPTMXIEylNWPcyVh29MxwBfZ4C9EdXvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U6IDDmA9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mUgvBh5Q; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U6IDDmA9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mUgvBh5Q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E6567A00B1;
	Tue,  6 Jan 2026 01:53:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 01:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767682419; x=1767768819; bh=Pac0C7S2oZ
	NOvX/y/AWh+ARmbH48cDw3E5Tv6nx16/M=; b=U6IDDmA99D0BeiryxU+qY+1/mA
	8rhUFAT3aIU4M7VudtqpM4TXgaUCmJbkFRgKxC5WwLBmWAgF3Z2rMPAQAUVyQhmd
	MGy/x1BmKgVc6j4gbenj8VUKRjIg2EgA1qRKxRdLrUNNxfv6OZ2T8akNSbSlN/wz
	WnqrOXp5+XTdT/xyckXYTleqwL4glfV19hXW74wVKUfm+l/YERtry9qBnxm081+W
	zI8UZc4KIgo9LBs4orKiiDNmQE2yy6S+kE+oXciisKNRFCCYBNctpYBMt3xDZoml
	PZ06mSu7Ljde/yvd6tKGSq8/iHWu8FX/56u81MGFQRkrImpLajt+sfIHT3Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767682419; x=1767768819; bh=Pac0C7S2oZNOvX/y/AWh+ARmbH48cDw3E5T
	v6nx16/M=; b=mUgvBh5QsE9gHPAINdwr6k7mgJlWdTh/YvHQxTEAskto/CcvcHv
	6LebKMtoXScqtg3nA95FQ5tsVWYWhtG4BO6Z+mBQNOEtDR6HkizUX3OvetlYP95I
	53VqgMPj1goulHMlEU30zmjrLMDgF+kEzy9USrA7kQS2A7VrcWm0do5PufQogjnK
	1TWXIZYCBV/2293aONwZ85leSfOcTOLjn0Z2C+TndR3sTjjizqdap14LDlNBIqI3
	RfzBnA9m8byb439kMDWLLjg45QSofQbLbxqfq+Nu/F8co1bvGI2Hez4XLWJBYQB4
	BvzFRj5tFwKoOF9VH9jwhDFBpNrSQPhi5Og==
X-ME-Sender: <xms:c7Fcabf9cqi4gtPqvlIJo8YCbceJlWtUwWvyHnHwXj8uOUKeotlnGg>
    <xme:c7Fcabx-hg0WJXveo6qahxZd6TsLfCjwu43KPaA-pcqGw8GVDesagYVDd1h-aVCGG
    g7OnfDdmn8wQAgbGW2OBkDZoFaTOk9u8moGAlEMO8AwxHo75-ZE5A>
X-ME-Received: <xmr:c7FcaRHskE7bdS-I5T1OYeC2UK1ptJSKVPULDsXNqM6WoyQC4uM7ixLGAA-G_04qw8n7efn72EC6mZaRXORY2gvXmEy9hw8ewOB6EMqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhfihgtkhesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:c7Fcafz-uLJqlSHfDsL37SMU2At8qhhfOaeSyzBuYsFcDyBSHnSErQ>
    <xmx:c7FcaStHwTQf07fuWRvvtq4Qx6kE-hyEuuolfDThkped0_zcTdOCMg>
    <xmx:c7Fcac0Cy4mfCeM6GMQh291SX_JUUj0V9fvX49caSgW0f-FdNEIcvw>
    <xmx:c7Fcad9FHYa4TbtoTKdXY8LSj-i-5a68IBHHdMwi49GUteZGUGbmGw>
    <xmx:c7FcadUmIJL5Ffz-Vr7ULuF4mtOi85pAzxGEevJ38ASUPOhAvAoMAUfO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:53:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b5ad720 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:53:36 +0000 (UTC)
Date: Tue, 6 Jan 2026 07:53:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin Fick <mfick@nvidia.com>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <aVyxbqk-2QQIgDXK@pks.im>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>

Hi Martin,

On Mon, Jan 05, 2026 at 11:45:41PM +0000, Martin Fick wrote:
> OK, after discovering the strace -r and -T options, I have determined that
> the 29K writes were all very fast in themselves. However, most of the
> writes seem to follow each other with no other system calls in between.
> This explains why it looks like the writes are slow, even though they aren't.
> 
> If I tally up the time between the previous system call, and each write(),
> it adds up to the bulk of the time (4mins out of 4m15s) that it takes to
> pack refs. This tells me that no visible I/O or system calls are the problem,
> but rather that the program itself is taking a long time between writes.
> I very much doubt that this is heavy CPU time, but rather I am going to 
> guess that this is hidden system time spent accessing mmaped memory. 
> Could it be really slow reading the packed-refs file? I can see the 
> packed-refs file is mmaped() before the writes start, and then 
> munmapped after the writes are completed. If I had to guess, that likely
> means that the packed-refs file is being read in small increments by the 
> kernel via mmap, and that is what is making things very slow over NFS. 

I wouldn't be surprised if NFS was the culprit. At GitLab we found it to
be a constant source of issues, which is why we eventually sunsetted the
use of it completely. Do you use any special flags for mounting the NFS
filesystem?

> My alternative theory, is that each ref is being looked up via a binary 
> search, but I don't think git does this?

Did you try using perf(1) to profile the process and generate a flame
graph from it? That should likely make it immediately obvious where Git
is spending all of its time.

Patrick

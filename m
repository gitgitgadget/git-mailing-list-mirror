Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F98468C10
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619578; cv=none; b=luGbt0eHS2Ii2/C+IzTJtd9uPlIYzeUE7MyQPUsS3iu0tgjMomDnVFZlBbZ5Nmyj2Q2UT2etw6H13pUBR1cQUex77kVqComBckiSK+j46M7iofPReiwxubcoMaxvuwpgxhgAlBjrblekuCzBXkuA6x7IDKYyz6pe5mbnz7BzDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619578; c=relaxed/simple;
	bh=uknu0zkqL7R7TJ0I1h78b4wyxWnQGq65pqBlka2g7hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2c6WOxt+fXqqUthJi1VLb7mVwDJfEIQskyqrYNmU5O9Zh6PQYzLpOWUR2p3xcMXZwmT52CTrUBNIWGnYMjNX6uwL2PRgyz+4WUOcG6GoGAZT0JI1gMfWbsZtDOU4Rq5ZEoALhw42GE6rpCDjxmI+8qpvS19RRtOAIKWqqHpDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GeNjegW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnOMEafa; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GeNjegW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnOMEafa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12E5A7A0071;
	Thu, 13 Aug 2026 07:12:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 13 Aug 2026 07:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786619572; x=1786705972; bh=2Y5EyhBhDC
	ByYCJlxMTcmewH+B0JpOMhcPN53ba8LSM=; b=GeNjegW3a5o7nuWngFnnwT+DFE
	/PLD/kGSB9swiVAJNVYPPzLL1CH4l3s6Sco36yH+mflr7Lz+WmCxgnEoMDiRDR/P
	6njrkMxWwHmsp2phKUpbJ/9gEeeGLivM7+z9BTm89jd9Iwog1W9Kjkfg5jz4x0L8
	zqt31m79LLWbz7Lsa8jybJw8jOQv/bxEJ4ASUh7EdEvhilKnHYsK66y5Rwy5q4d5
	e+Juoz3Ju5Z5hu8JkqQe5pJ/P79I6MHoAgFq+8SJtujyzvoTjEXJjwnqq7qO6Ma7
	Y08RrkuZ5hktWXHcfETDs/a1snDr6vGlBtkGTh+9cw4ZiGM5RWJVxKuXcPyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786619572; x=1786705972; bh=2Y5EyhBhDCByYCJlxMTcmewH+B0JpOMhcPN
	53ba8LSM=; b=EnOMEafaDXLaStG96xR3Vmd9JgO8hcJfO6nsCUYuJJ0Ad6fWubJ
	UaLHHYnyLiGmwCyXP+ikzGqkqhDoQq6eCNBS6QGRDebrzLpw6aHrzGlOC36pBPLl
	boimtxnlYOPIkbEScVLHso7XGzoHtePkGvrq0eAINC8O/mccu485crnu7qUxT3BQ
	TAwtgpPPGS0xoed+IxcjtFB8Ju2r/KNwfxzY/9hX1s3e7hHETe0Wp4aKETyFs77w
	kzCli68ATnJRwk/duFV/1CFbj19jX6T9NpG9orMT2NGIOfRr94UWAFDrjJrWG54+
	a5daU2VIOsYti3InHZPCMpjSU9V9CZLDAdA==
X-ME-Sender: <xms:tKZ9avhsMlV01VDNcNxi5_4zNXVoRQD58XL3Yhm_BoqWfbo_vUsL_w>
    <xme:tKZ9ajct0coqjXSbyGCxsBvgM0ULf242YZGBILpCsUGaav-tD0-5IHWbB1dhTkcol
    RWnMNnuP1q8OUZc-a2hxK7zMxup83d52i59enSG8bQUNGPiF39AMWo>
X-ME-Received: <xmr:tKZ9asey4d5poIiQPONex1w__jVsNfkAZe75I8j7YwS8qs9719wlH3dC0LrgteGtpoLTJM8rwCNNDX48W4CY0ibKA6djcOAVoEHVzNbrMcyd>
X-ME-Proxy-Cause: dmFkZTGh6v5te+HWt24GQks1aUsICADib9Nk/2ZWjfuMdNJX9OR6uQlkcV0AOKbBRtCCuy
    Qk/SYwqzKJSFPqkdUg3OLfBsIk0swaZ5xW9oAUA2j0eW5sF8OaeZXUtLoqUQTD5hE0ZnJ0
    iW5jGLsvxUo9/bwz+wW+iij9cHt/LDCxVhyqSII5dRbJ/R/hQ0Vz/10uHpfcwQCM9rzZVV
    YD8VA+gnGFskEs2RSZ+/PrYDci/42YKyvH+H8for+kMdO4go96lbRkDIad1b+m8N1W5aF9
    TODD7spZ1KU3HE+4LG4nRGvX2a9veNEYjGZAxo5qJW0vqSt0LpyWWvj6QNZ2axLk3jZMkg
    +vo/jcnRS1ADEvdQfmycZWBQv7IPmiwnfJ5vJ7HPYKoBMtjFARz6wsJozWBQAE+B14jzOK
    VC9FRDQVCltbLG29m7G8xEqFeTse7lniA0FrW0Ng0h0T5OUAR9PApAurRWopQIeF7A4JoV
    //QSRJqaFVuBp/iXze561sQfQRqf9uO25zHTaY45YE7mwTuFPBrzxPez+xp+/pR8sNMOWk
    LUcGQAfkUPE+d5eLvanjIPDxcEfDffXnjPXO4W2Pw+Gjlb6rAj3qxvnlHBivMxFgQqv++c
    pORFnyHEjk0NZO575QrVLDw2gPHl0n/Mki07Huzw88b+gVXwot37UULWoAbg
X-ME-Proxy: <xmx:tKZ9al9s9vYD8tZs-7Vsj8_zlL1d9bh12NKCkwrhkHljt-yymO36Cg>
    <xmx:tKZ9agn6PkDkIkFkO1oJ23Gi5F7bwxVerU2WVVjaOrhLGyGqMaoe7w>
    <xmx:tKZ9av8MUkgPMPnYMma0CDg-8MyeSdT46WZZCa9unB_OyWnzqJt_0Q>
    <xmx:tKZ9ammsgw02CT2hv5RnYbXpHf5wxdLSDryrmfqOCOpYA0548knYjw>
    <xmx:tKZ9an8cxLcpxE3lbEVFnx8k3aO3jvBgtfh2vyGv0ItJg-FUzsh7AuTN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 07:12:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb8bd1b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 11:12:48 +0000 (UTC)
Date: Thu, 13 Aug 2026 13:12:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] packfile: fix perf regression with many packsy
Message-ID: <an2mrUb9DI6Jbj6y@pks.im>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <an1zz02GNqDu-0Oz@pks.im>
 <b4860540-6114-2a7b-e266-d1fc2f0041b9@gmx.de>
 <an2V7S-DkdypsGIE@pks.im>
 <07585246-48cf-2d70-b022-8cb430fe82fb@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07585246-48cf-2d70-b022-8cb430fe82fb@gmx.de>

On Thu, Aug 13, 2026 at 12:42:10PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Thu, 13 Aug 2026, Patrick Steinhardt wrote:
> 
> > On Thu, Aug 13, 2026 at 11:20:11AM +0200, Johannes Schindelin wrote:
> > > On Thu, 13 Aug 2026, Patrick Steinhardt wrote:
> > > > I wonder whether we should slightly reformulate this and rename `is_new`
> > > > to `accept_duplicates`. Because ultimately, that is what we're doing
> > > > now: instead of ensuring that the packfile is unique in the list, we
> > > > just don't care and just append the entry to the list.
> > > 
> > > Hmm. I don't quite agree, we're _not_ accepting duplicates. We know that
> > > those packfiles _cannot_ be duplicates.
> > 
> > I know that we're not, but this is only because the caller knows that
> > the packs are new. Seen outside that context though the new parameter
> > really just tells us whether or not we want to deduplicate packs or not.
> > 
> > Anyway, I'm splitting hairs and I won't insist on a change here.
> 
> You do have a point, though, `is_new` is too narrow. How about
> `skip_dup_check`?

Sounds reasonable.

> > > > An alternative would be to use a hashmap here that tracks the packs that
> > > > have already been added. It has the advantage that it also covers the
> > > > `prepend()` operation and that callers don't have to be aware of this
> > > > mechanism at all. Furthermore, moving preexisting entries to the back or
> > > > front could become O(logn) if the list was doubly-linked. We do this
> > > > operation quite often to re-sort entries in the list when looking up
> > > > objects.
> > > 
> > > Indeed, that was my initial reaction, too. I was well on my way to start
> > > writing a hashmap-based fix when the AI assistant pointed out that no
> > > duplicates could possibly exist yet.
> > > 
> > > > Overall though I'm not quite sure whether the added complexity would be
> > > > worth it, see below patch.
> > > 
> > > Wow, you got a lot further than I did! And yes, I agree that we do not
> > > (yet?) need to deal with the added complexity.
> > 
> > I may want to pursue this patch anyway, as I think that the reordering
> > would be sped up by that change quite signifcantly. And that would make
> > a difference indeed when you have 38k packfiles, at least when you
> > assume that objects are evenly distributed across all of those and that
> > we perform reads of random objects.
> > 
> > I could do that tomorrow, and in that case it'd supersede your patch.
> 
> I don't think that it would _quite_ supersede this patch. Sure, while
> searching through a hashset instead of a single-linked list is faster, it
> is not as fast as skipping the search altogether.

I guess that's fair. Let's move forward with your patch for now then.

Thanks!

Patrick

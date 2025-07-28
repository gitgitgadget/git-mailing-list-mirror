Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAC2222A1
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713808; cv=none; b=tXf6j54Sypx9NuiCxpxl1uLHbDwW36YiC9QwA4O/+sFOAxaDw14bfbCWCWxKP/cBtorvyiH5FYWtzmKdiVsab2/2kUc2x379+aRq/zqb8xo0Fv7vgT7Nw4GzAdgUtdipgpVQQmxKj/Fnl6t4lHfuB0F+s3UBbqknL2IykmyJarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713808; c=relaxed/simple;
	bh=3KC8xrku7TXL3GsE+WtefE8B+v80codpsPtWYMNgFGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MotXZ4iQQ7wuPsE6orfduaegn2/zlUL5C9RIoEJNgqwvUw//g0K8QuC4dSG/EnyW5Yt8VtnUTdIB5qFps4CKLu5v4pibyxN4C8ZkkxOcGGvOQa3UE46wg505dHSs4PC3yjjAuj5PsTrKEVENoNvEZph/hOStS4b1MjrJ7iAqm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KmM8FJvS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGX4HM4O; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KmM8FJvS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGX4HM4O"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2D87140009D;
	Mon, 28 Jul 2025 10:43:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 10:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753713805; x=1753800205; bh=QyqCiza8va
	dXk1hWnMa76Lon3uhCfSB15/cPLBsDbns=; b=KmM8FJvSpdiofIj0ACMXzsTVHC
	zR7rNzA+ek6B/luru78XzpZH4HdGfByDUIGVWzVb6Sdw5RJHkbnxwuFhYzakmRVG
	O6jbDMn6Mn2p5d9DmJVDAbM7DDIiiCFDz+yOoWmvKWDqxPSxl7f5jXI8UO7kK25I
	SwqjSN3x2kshz4NrpFzgl703BYwetAd90KEeqpI2ls1x5J2nuY619esaNg+IwSUt
	WCEtIdH5kB41pMQ8ziZU/n1rtDJsHBdY93Wk/TIF/2s9edlvpjNWZe/RRCUxar5X
	N2mqk+dQEwwW30CYWEIPDULetyFEzj0iS1qvGE91CJwIlxyT6/iQmkwXMoEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753713805; x=1753800205; bh=QyqCiza8vadXk1hWnMa76Lon3uhCfSB15/c
	PLBsDbns=; b=cGX4HM4OJVNNKYP33Hp3UUHyhJEQz46usfcWD+YUtAz/bcIJfnT
	3v0DpTa38gV419GvdKaKXc22b1UWfeLleSt1gkfi2o9mBtdtrxW4sYj1B/11Q7Jo
	qw/6RySHH1JI9a8Q8nJk633W9GypG9Gz7pJFAuh/GqpiDEaqLPWzJE+fhtHD0mlT
	UGo4c/68VXkZ1MlXqkhhrspQ5O8gPw0fvUDASYvIkA/pPmWmP2qC8lCJ2N7ONW+z
	sX54Q+kUsKQzv7Z8tOVguMc0QmIS0TP9p/BqBWGLM5LhAv4hC9tYctzcwp6wvj89
	R7daIVYegocF9mFDiXEFxrSui2fZyTeaIDg==
X-ME-Sender: <xms:jYyHaAbAmaZtIfmKpfRtXLfwr0DIl53Qcbe7o4JqmC5w0tXhFV3SLQ>
    <xme:jYyHaI8CyDaIBsmgUpds6Pjy10MKfB-cJOabMcy4qJZ_h5okbHr272v2tNagTN-Xe
    0WLvIbiJiuRKcDKiA>
X-ME-Received: <xmr:jYyHaBb_-PG44yFth0nLrWm3FbY-MmIiVSvizJj1bC6_d_CtoTzWntcgm3X7QVhn5oxvvAgPjDbnxr48oz1o7FEqL1bvRalbhxb6ZWMD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jYyHaMM0L0DZZvE_vfl9_u0m3JI58B14EOamiE8zhROmBIgmyfuBaw>
    <xmx:jYyHaNAIks26O-a3rQfGugRhLp2uFDzRa6-4Kx6MNnCKKKVVK33-3Q>
    <xmx:jYyHaDL8sq77IqKCxrU3CLOSvDa3I0kZNFeXCe0VFwOqHaIPOFNJUA>
    <xmx:jYyHaGNIS5kjOChv_ZpT8EfqseL3S4Nds8JMpQkmCREe27enDbB1Vg>
    <xmx:jYyHaJMXlJSAxCxqqhKhYEhTlzEAOnZo3mSGbS9scXz4sApkC2L6ZA3Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 10:43:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 94a26f1d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 14:43:22 +0000 (UTC)
Date: Mon, 28 Jul 2025 16:43:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 7/8] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Message-ID: <aIeMgE-11UnAJINI@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
 <20250725-pks-reflog-append-v2-7-e4e7cbe3f578@pks.im>
 <20250725113610.GA3015361@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725113610.GA3015361@coredump.intra.peff.net>

On Fri, Jul 25, 2025 at 07:36:10AM -0400, Jeff King wrote:
> On Fri, Jul 25, 2025 at 08:58:29AM +0200, Patrick Steinhardt wrote:
> 
> > The `REF_HAVE_OLD` flag indicates whether a given ref update has its old
> > object ID set. If so, the value of that field is used to verify whether
> > the current state of the reference matches this expected state. It is
> > thus an important part of mitigating races with a concurrent process
> > that updates the same set of references.
> > 
> > When writing reflogs though we explicitly unset that flag. This is a
> > sensible thing to do: the old state of reflog entry updates may not
> > necessarily match the current on-disk state of its accompanying ref, but
> > it's only intended to signal what old object ID we want to write into
> > the new reflog entry. For example when migrating refs we end up writing
> > many reflog entries for a single reference, and most likely those reflog
> > entries will have many different old object IDs.
> > 
> > But unsetting this flag also removes a useful signal, namely that the
> > caller _did_ provide an old object ID for a given reflog entry. This
> > signal will become useful in a subsequent commit, where we add a new
> > flag that tells the transaction to use the provided old and new object
> > IDs to write a reflog entry. The `REF_HAVE_OLD` flag is then used as a
> > signal to verify that the caller really did provide an old object ID.
> > 
> > Stop unsetting the flag so that we can use it as this described signal
> > in a subsequent commit. Skip checking the old object ID for log-only
> > updates so that we don't expect it to match the current on-disk state.
> 
> I like this direction, but I happened to be working in this area
> yesterday[1] and noticed something interesting. You're effectively
> replacing this removal of the HAVE_OLD flag when split a symref update:
> 
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index bf6f89b1d19..8b42fe18901 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -2493,7 +2493,6 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
> >  	 * done when new_update is processed.
> >  	 */
> >  	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
> > -	update->flags &= ~REF_HAVE_OLD;
> >  
> >  	return 0;
> >  }
> 
> and then later we get the same logic by checking for LOG_ONLY:
> 
> > @@ -2508,8 +2507,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
> >  						struct object_id *oid,
> >  						struct strbuf *err)
> >  {
> > -	if (!(update->flags & REF_HAVE_OLD) ||
> > -		   oideq(oid, &update->old_oid))
> > +	if (update->flags & REF_LOG_ONLY ||
> > +	    !(update->flags & REF_HAVE_OLD) ||
> > +	    oideq(oid, &update->old_oid))
> >  		return 0;
> >  
> >  	if (is_null_oid(&update->old_oid)) {
> 
> Which make sense to me. But the weird thing I noticed is that when we do
> something similar for split_head_update(), we don't strip REF_HAVE_OLD!

And we shouldn't do that, as in the next commit we actually build on
always having `REF_HAVE_OLD` set for reflog-only updates. So I'd argue
that the problem is actually the other way round: when splitting off the
HEAD update we must resolve the old object ID if `REF_HAVE_OLD` is not
set.

> (For those not familiar with that

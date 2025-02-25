Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB011F60A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469193; cv=none; b=lfOXzJdn9TD1HyIRf66XaZtvfKg2LNgtl9g5430yr9vnTSihDbax+tLogiRCPOFkhr//1htc0lGH5Q8XO26o8aLcHLZp9I6JxHjphsamhw4hC3ai9axABZH8w2wwd9aBuaBWXfYj8guqyLtuOZ4wfz/UsKbjOrNi2FpQ6vGZCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469193; c=relaxed/simple;
	bh=aME7dVNDcYgzWrfpfDwpVrJKtW6oti2xk+fT+148fxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM83zG0+zAOVWI4A/J2KVkKi9B4L9iJUkE2bhg/1xMzDiAfFZd39+TiNRqIz51BuZ0iaiRLZwD6nINcCoFNJzv4kRjvg8NLQhwO61H/VVRv/cFEJTUkBMyLGxXN2WIrCvX3FcszDvVjsogbdHqnOq9fOA24Iq3owjvi9zXahDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l40JB6RZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qU8+Bwn9; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l40JB6RZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qU8+Bwn9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 652EE254017D;
	Tue, 25 Feb 2025 02:39:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Feb 2025 02:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740469188; x=1740555588; bh=1jP64N1h+K
	6G4YdILeek13vuTiJ4UayBmE6J5PM7Rew=; b=l40JB6RZuG6JA37QHkU3IJQU4P
	1USeS2rVt40iTQj5w8IMMakmSvWd4ODqmqVu6xFCIh0JrRV8V5MmFe8M2He9AnJI
	CutkLh1zyJMSgDMtyhL96ZkdevnuqkCX5pwn1OzbNGfgfvcV38fiO/uGcVAY95m2
	SGmc8dopzlXvOFhvbrMi/9VwRTS8lIopatHrlEXkSCG1wCBJzBbS0PqneqFLDo6D
	1N3orsfyJNBjG7Eyx8gss6P0UTl9QjsH5GzQW364fCSyRu+9wEl9xdWz3eAUU6CL
	75E67kFC/YXNA1uOKXY3fCSlkGG7Kbww/G1NOkkcs0Ay6M+vIej0KNvBoRLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740469188; x=1740555588; bh=1jP64N1h+K6G4YdILeek13vuTiJ4UayBmE6
	J5PM7Rew=; b=qU8+Bwn9U9c3OBGZOOlRPD5jK4QvjTl4TRsjGgttwtkOebCnsaX
	1Lt05QCD/JrnrGQ91V85mxxbvkDeRKlKTraXkV/pc2OrFEdm0YVmawO4y5owq9CX
	wB7p4PBfKni1LnDcI7oFIwSlUmiV9qMMxyeAVZFb4dPjWAG6RRz92alMpOGfVtC6
	2Z7v67CMNxSaLC/CwJ8bNEsOLfKiOt8s+uJD/LbhgoVmJ4aTpbtJYsshoO5NYR1c
	6EZe6WX2T/MxhBSCWqGyovZC5grFJgXRQoMOyQ5eDprSzqe0SECJvo22awJbc/YJ
	Dw4Pdr5bUw2aoiLFuWsitHUkF22OTVu9wgQ==
X-ME-Sender: <xms:w3O9ZxGQF_U5j5ATDm2wQZlVQGmgo9P61qbe9lQVaQu3icf6DPdKGg>
    <xme:w3O9Z2W5GVzOKDacCv6zR5sjFr60q-8fHNGyTMdhxI85QD7bwRLQb7MV0KzCzDWed
    XvfGfCyGsZofV_qrw>
X-ME-Received: <xmr:w3O9ZzIGAcr05N4kODAmWRCVd_TAa5RYBPfj1bjXkPvVpJ4FPpkLwBf1lFwKGNzqVA7TvcbJ5vrcfBI0RJIqejuQwx6e_O-poTUtI4gx0osJbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:w3O9Z3H7-0Q5uQy-nqi_Ke-T02wVHp_FYdwckbscnvoDLOCwt6zzvQ>
    <xmx:w3O9Z3VZocluRQ4BtcMin7W5aLn3teR0Q-kM5AeW5roR1DK2rC3VuA>
    <xmx:w3O9ZyPR1D5I88FB037mVPkhACfJBKeRg0PXB4titT5fXSCfFLPL8Q>
    <xmx:w3O9Z20PZI01hm1y8De4ehSkEk8txSUTwg-ShmQ6Mz0vdHcEJ3obWw>
    <xmx:xHO9Z-FmKGqApQW1BrRv-2PeLTJQH8d31wmUEtMOy_8haLJKpwmjUk2J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:39:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0af1fcb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:39:42 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:39:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 10/16] refs/iterator: provide infrastructure to
 re-seek iterators
Message-ID: <Z71zua2Aoq8DC6ve@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-10-e696e7220b22@pks.im>
 <Z7xvWPjHjppNp167@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xvWPjHjppNp167@ArchLinux>

On Mon, Feb 24, 2025 at 09:08:40PM +0800, shejialuo wrote:
> On Wed, Feb 19, 2025 at 02:23:37PM +0100, Patrick Steinhardt wrote:
> > Reftable iterators need to be scrapped after they have either been
> > exhausted or aren't useful to the caller anymore, and it is explicitly
> > not possible to reuse them for iterations. But enabling for reuse of
> > iterators may allow us to tune them by reusing internal state of an
> > iterator. The reftable iterators for example can already be reused
> > internally, but we're not able to expose this to any users outside of
> > the reftable backend.
> > 
> 
> Out of curiosity, is there any benefits for reusing iterators for files
> backend?

We see a small improvement there due to reduced allocation churn, but
overall the benefit is more limited there, as shown by the last commit
in this series where we start to reuse iterators. The refactorings may
unlock further optimization potential by reusing more of the iterators'
state, but I haven't checked for the "files" backend.

> > Introduce a new `.seek` function in the ref iterator vtable that allows
> > callers to re-seek an iterator. It is expected to be functionally the
> 
> It's a bit strange that we use "re-seek". I think we just want to see an
> iterator. Isn't it? Don't worth a reroll.

Well, it's really only relevant in the case where we want to seek on an
iterator multiple times because we already seek when creating the
iterator. I'll reformulate this slightly.

> > @@ -368,6 +381,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  	return ok;
> >  }
> >  
> > +static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
> > +				    const char *prefix)
> > +{
> > +	struct prefix_ref_iterator *iter =
> > +		(struct prefix_ref_iterator *)ref_iterator;
> > +	free(iter->prefix);
> 
> Here, we need to free the "iter->prefix". We don't know whether the
> caller would call `prefix_ref_iterator_seek` many times for the same ref
> iterator. So, we need to restore the state/context.
> 
> I want to ask a question here, why don't we care about "trim" parameter
> which is declared in the "prefix_ref_iterator_begin"? From my
> understanding, we may want to reuse "trim" state in the original state.
> So, when we want to reuse iterator, we only consider about the "prefix"
> but leave the other stats the same. Is my understanding correct?

Yeah, it's correct. I couldn't find a usecase for also adjusting "trim"
when seeking multiple times, so I didn't introduce this functionality.
Let me mention this in the commit message.

> > +	iter->prefix = xstrdup_or_null(prefix);
> > +	return ref_iterator_seek(iter->iter0, prefix);
> > +}
> > +
> 
> > diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> > index 74e2c03cef1..3f6d43110b7 100644
> > --- a/refs/refs-internal.h
> > +++ b/refs/refs-internal.h
> > @@ -327,6 +327,21 @@ struct ref_iterator {
> >   */
> >  int ref_iterator_advance(struct ref_iterator *ref_iterator);
> >  
> > +/*
> > + * Seek the iterator to the first reference with the given prefix.
> > + * The prefix is matched as a literal string, without regard for path
> > + * separators. If prefix is NULL or the empty string, seek the iterator to the
> > + * first reference again.
> > + *
> > + * This function is expected to behave as if a new ref iterator with the same
> > + * prefix had been created, but allows reuse of iterators and thus may allow
> > + * the backend to optimize.
> 
> I somehow think we may emphasis that we want to reuse some internal
> states of the ref iterator except the prefix. However, I am not sure.
> Just think about this.

Yup, I'll improve the comment.

> > @@ -445,6 +460,13 @@ void base_ref_iterator_init(struct ref_iterator *iter,
> >   */
> >  typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
> >  
> > +/*
> > + * Seek the iterator to the first reference matching the given prefix. Should
> 
> Maybe which should?
> 
> > + * behave the same as if a new iterator was created with the same prefix.
> > + */
> 
> This statement makes me a little confused. I think there are something
> difference between `seek` and `begin`? For prefix ref iterator, we will
> pass "trim" when calling `begin`, but for seeking, we don't care about
> "trim". Although the prefix maybe the same, but the internal state may
> be different.

Here, as well.

Patrick

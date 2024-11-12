Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E020BB5C
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402352; cv=none; b=Lfm7/xl3QPnY0OXE++4he0WxnIf5m5vOEKMWsWgYF6gw8F2zrV9jgVLOVxfFAw8LYY9DobiBPdxKo6juTCVJX+6J8ybbxN0OB8zVoWpkN/9tM8mf6hREx+A2zzYZtKpbtRR4AX20TLCS74XiZoPLZxaDA+RyxziSAjeY5GEuFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402352; c=relaxed/simple;
	bh=ozBfzkS9ZK8wEnZxFOxlMeJxgfnWrtCTFaT8SK9iPl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtPjRBU7Q1y7hzb6VHlLIqNyTMZWxgtLBsbmGJ9llu7LepXgkwr1FufI9JFdcq9J5ZMG6nySXS0Ksu0g7MJAlYLwU5XaGB72y+f840rZPZpg6Ggjx+XhdaAMQ46+OJYLTsEnLaBS6tMBwnIMdtQqKZOsRJSXrPdpMO7RTOSIrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rR+DJIK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MtOfuoB1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rR+DJIK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtOfuoB1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0EA962540143;
	Tue, 12 Nov 2024 04:05:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 12 Nov 2024 04:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731402348; x=1731488748; bh=wz/yvK4tj8
	A3oYgX5r7vEgboizSNrAFF8SPmku4z+bE=; b=rR+DJIK3fDKhAZ5ZHIbyW5kD69
	0jEAWcuNGJfTAKy/au1ptXw0WjnB33tTnl2AX40sZfL0NrJdfMhIBUTYhEqHeX2C
	0P703vmyZzhDgGQvA5j+Kjo1DmwC7pjG7UZyM5y8SJJV3w8X8pcfA+wjIzrMnTGP
	StlZk9v7IQlua8AB5XShY4kMAQC9ap1mWQMEp4WF3Ejzpkw+H240smRIxnvNn9a+
	Wo8TmoJJxPc2vs3XH+3nApHBrZU+3vdCPbc+lgS+9CDdWo+rR87tG0BnJNKlZ1g1
	uFanlgMneaExZc8VWXrrtj59igP1Ll6BO11s2IT4ZuM9KViGnRSrn1V7eSYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731402348; x=1731488748; bh=wz/yvK4tj8A3oYgX5r7vEgboizSNrAFF8SP
	mku4z+bE=; b=MtOfuoB14lUJbtRifgVw55Ac2iA4+s+27vi/gLthkQB1yRDa3RK
	QW7a6DskSOJKXosZGKVwiIKff+9OtcNjvx54xtpCKpwcN7DUendn0rTow4k/Q5ZQ
	T396tyx9kUwdnOxC8QNrEC50nyzYkajPIMN+ZcbN5xD3t4UhOzynfGYP+AwEH3nc
	p4eyovkXuE42K7w0NriE3cnzcdgJjPse18TinA43RYhNr23Gv/Jxt3CDHM0pwkUm
	dhYjIsj6Z1qmKOzaYPiQDRxmCBVScc/QXwQ+hijGWpoqN2/7rX2NBXJgb0KI2uLX
	UvlQG1dGfcX3Iwrm1rAdmSNNtGYQYhzj3Rw==
X-ME-Sender: <xms:bBozZ8txnt0hRUo6LCJ5zH0bBmd8cciJfFT4wxh-M1DK9aZLobq4Iw>
    <xme:bBozZ5fxzO_PYHkAhkuZ6N2sHZz9FFkScc3TfELET9OQlTES68odmyLXgcVWJmJQc
    WqyZsB5nZJpb6uJlA>
X-ME-Received: <xmr:bBozZ3zf5Nt3ELOSXcZAEXizASU4RzCnX1HINIrRBfrt2X1JKILc2y4jpc1TUiuYJ8f4oScSARhH5IuMnW1QiMeCA8OYcBh7jmH7hl81CFWj_Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:bBozZ_P7bxSkI7ebpN9qqeRKV3R2AHqOG-2oLTfNANv_UGnFHYfIzw>
    <xmx:bBozZ89cUoq3SP7BS57xXagN7kCN5QwUK2Kpf-RrlXdl0zXWPemeng>
    <xmx:bBozZ3UaLnZYozQ_Wf3WD_3pyd57SWJ0kT8gPbXpeiIXTlf2bm0axA>
    <xmx:bBozZ1fz3wmD3JLC9u_qWKHrM9QeMme3Bqgs199U4Rw6N_T2SINqnA>
    <xmx:bBozZ-KU-LNbEDbAIcanmLbQcAJImo3_moTToqsD-ssjcFuf5mgpE72u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 04:05:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4935911d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 09:05:12 +0000 (UTC)
Date: Tue, 12 Nov 2024 10:05:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/8] refs/reftable: read references via `struct
 reftable_backend`
Message-ID: <ZzMaY-lqwKIak7Y3@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <cover.1730792627.git.ps@pks.im>
 <1b50655202f311c6a6ded61d4d50b1f287761d84.1730792627.git.ps@pks.im>
 <xmqqed3g6hg1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed3g6hg1.fsf@gitster.g>

On Tue, Nov 12, 2024 at 04:26:38PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`
> > as input instead of accepting a `struct reftable_stack`. This allows us
> > to implement an additional caching layer when reading refs where we can
> > reuse reftable iterators.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/reftable-backend.c   | 110 ++++++++++++++++++++------------------
> >  reftable/reftable-stack.h |   3 ++
> >  reftable/stack.c          |   5 ++
> >  3 files changed, 67 insertions(+), 51 deletions(-)
> >
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 4a28dc8a9d..230adb690d 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -51,6 +51,50 @@ static void reftable_backend_release(struct reftable_backend *be)
> >  	be->stack = NULL;
> >  }
> >  
> > +static int reftable_backend_read_ref(struct reftable_backend *be,
> > +				     const char *refname,
> > +				     struct object_id *oid,
> > +				     struct strbuf *referent,
> > +				     unsigned int *type)
> > +{
> > +	struct reftable_ref_record ref = {0};
> > +	int ret;
> > +
> > +	ret = reftable_stack_read_ref(be->stack, refname, &ref);
> > +	if (ret)
> > +		goto done;
> > +
> > +	if (ref.value_type == REFTABLE_REF_SYMREF) {
> > +		strbuf_reset(referent);
> > +		strbuf_addstr(referent, ref.value.symref);
> > +		*type |= REF_ISSYMREF;
> > +	} else if (reftable_ref_record_val1(&ref)) {
> > +		unsigned int hash_id;
> > +
> > +		switch (reftable_stack_hash_id(be->stack)) {
> 
> So, relative to the original, instead of relying on the repository
> and its knowledge of what hash function is used, we ask the stack
> what hash function is in use and use that instead.
> 
> > +		case REFTABLE_HASH_SHA1:
> > +			hash_id = GIT_HASH_SHA1;
> > +			break;
> > +		case REFTABLE_HASH_SHA256:
> > +			hash_id = GIT_HASH_SHA256;
> > +			break;
> > +		default:
> > +			BUG("unhandled hash ID %d", reftable_stack_hash_id(be->stack));
> > +		}
> > +
> > +		oidread(oid, reftable_ref_record_val1(&ref),
> > +			&hash_algos[hash_id]);
> > +	} else {
> > +		/* We got a tombstone, which should not happen. */
> > +		BUG("unhandled reference value type %d", ref.value_type);
> > +	}
> > +
> > +done:
> > +	assert(ret != REFTABLE_API_ERROR);
> > +	reftable_ref_record_release(&ref);
> > +	return ret;
> > +}
> 
> Here is the original that got replaced.  Since ...
> 
> > -static int read_ref_without_reload(struct reftable_ref_store *refs,
> > -				   struct reftable_stack *stack,
> > -				   const char *refname,
> > -				   struct object_id *oid,
> > -				   struct strbuf *referent,
> > -				   unsigned int *type)
> > -{
> > -	struct reftable_ref_record ref = {0};
> > -	int ret;
> > -
> > -	ret = reftable_stack_read_ref(stack, refname, &ref);
> > -	if (ret)
> > -		goto done;
> > -
> > -	if (ref.value_type == REFTABLE_REF_SYMREF) {
> > -		strbuf_reset(referent);
> > -		strbuf_addstr(referent, ref.value.symref);
> > -		*type |= REF_ISSYMREF;
> > -	} else if (reftable_ref_record_val1(&ref)) {
> > -		oidread(oid, reftable_ref_record_val1(&ref),
> > -			refs->base.repo->hash_algo);
> 
> ... we have access to "refs", which is a ref_store, that knows its
> repository, it was just a few pointer references away to get the
> hash id of the Git side.  But of course we use REFTABLE_HASH_*NAME*
> to identify the algorithm at this layer, so we need to translate it
> back to the ide on the Git side before asking oidread() to read it.
> 
> > -	} else {
> > -		/* We got a tombstone, which should not happen. */
> > -		BUG("unhandled reference value type %d", ref.value_type);
> > -	}
> > -
> > -done:
> > -	assert(ret != REFTABLE_API_ERROR);
> > -	reftable_ref_record_release(&ref);
> > -	return ret;
> > -}
> 
> There is one thing that is curious about this step.
> 
> It isn't like we teach stack what hash it uses in this step---the
> reftable_stack_hash_id() could have been implemented as early as
> 59343984 (reftable/system: stop depending on "hash.h", 2024-11-08).

In theory we could've implemented it even earlier than that: the commit
only introduces the reftable-specific hashes, and we had the
Git-specific hashes available before that. Like that we wouldn't even
have to translate between the different hashes in the first place.

> Other than that this step introduces the first caller of
> reftable_stack_hash_id() in the series, the remaining hunks of this
> patch do not have to be part of this patch, but could have been a
> separate step.  Not a suggestion to split it out, but merely an
> observation (to make sure I am reading the code correctly).

Yup, your understanding matches mine.

Patrick

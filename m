Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82607361652
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846242; cv=none; b=Anb6wbh6LX1a2PCY9tC1bTmGr+lgIysu8DWpjxtMXOYbnpNNPbpCI7Z5V2IzWh3PYUg04eSBai0+Ufbba5+MGYnRjxSd3/G/IXyZhUay4jH501tlEPUXEyj/KYZrd3A/BY6x17av3KYJIHO8mwKt9fsyAy6vM+Nyk1qiPFBL7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846242; c=relaxed/simple;
	bh=vd1C3ljKPlxRbtEbBdkmwobklaadYM8ApRPtILzixs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG5qvyaiDFx0ya5oPY3/e1VDQyeU/TsV8Fpn66aGs79GvaPO3AbHQa+BkHMR30G9Ogw02tchv4QTpUCmttpvPp2lrpu0eDGmXuJ0SYm3CXw+3sYtOqHQxzzN4xAwNw9nAxIV2JyMYK4dXe+s58sZJ6SBI+vRntEbsZSwaMkJYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b7G036Mm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEvIrfVo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b7G036Mm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEvIrfVo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B326314001F0;
	Mon, 23 Feb 2026 06:30:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 06:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771846240; x=1771932640; bh=AxScHTwQOV
	zyfgQfj3zxuNLS8MbmcyqmM1TFNoyhk7Y=; b=b7G036MmtDLu+BWQw8bo6dBZGd
	QvXdDwJnEOtChcNpYW2mhX68/Tw7e+uWiliVPSUCb3pKo6/fvE1yLAxsq6Kpu5pG
	oJ8hSHEam52rd98i8oknZdSM0GBEfsznNjXNCIC38U7tYg8Oj+JW8fnPe6oZVEOx
	yjkGx27r50ZRCIzKE8UNA/uiILKYv0VGN8ZiF5ZW7Xay5Yq0y+HW6e7QgxfgZq+a
	DmOwl3C7wK/wB95rpVpqEYzLEZ0zjYAkwj9gzXucnJLSgji3tVOl55pPe9qeIzLF
	KGXL5HolmymqQTlt54R9Z2y/INT687iZUX0CU3pkzKAfC+J9ANHH3Sm0l6lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771846240; x=1771932640; bh=AxScHTwQOVzyfgQfj3zxuNLS8MbmcyqmM1T
	FNoyhk7Y=; b=gEvIrfVo4Zbg08VPW4dlwJwrDtP0xsGIMus6avrOsuoO9S5o0Ev
	r7sQ9n91YL7BUJZ9TdezpwKOD13An1M6H9uXyCEJuMPjSc+aec6Yw4QkVbngr5om
	6Qz0TlQHV/nJ/dcp21lHNF2kN51hqMCM8RJP9t7oYVAqWplAy66HlvDaQ/M/YqjS
	fVTX+63cFiuZmjYa82QDAidCgNGMKMfuCeOJXfDSXIQ7imFU+PIHR2zWUIIg+/xO
	06YsL/VKvfbbOGpI4dWZenyCzEQr9zdPYpPI6I6J90VB78zaSAOwDKbd188dl8fH
	46VZvGI3/Oi05eKuolilZrq+YmUCXLevi5w==
X-ME-Sender: <xms:YDqcab4jAsT6LdgOsnpmlRn_z1jml_buabT8DuTdXNUqO6eVJudLnA>
    <xme:YDqcaX6sXHsql3aDa_eLl6HDoEezQsGGve8AwD96jxQhUjTcADuYJQWBvCeJ_w5D9
    hvSaoV4DRjodxzw0fVpjN8pnALsqaYS0bJgBwjqetQbj284-T8rhw>
X-ME-Received: <xmr:YDqcaXezgH8iPu3oWhzTu2ljSaxkG6zXX0iRosjNGdHUOStHN0VeWysAS_LDKVNIgZC6KSzm3Z_iRhp3m6mbk-UQXdTMFokzzE0C-ZPj2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YDqcabBh3WdV13HQ--L31VjiPOcbCdWrX6R8g1DobwLdGxLVh2i-IA>
    <xmx:YDqcaa_th3o9PasRjJpqL0fPpYlwOlJk15lZQmF5PGuYvVj8Xcy01Q>
    <xmx:YDqcaWK7VXnJTTWpOnVSXKeE5FXbl0QI6zcx4leoI7Bero8U_M7Nkw>
    <xmx:YDqcaTjoHfIJu2SI6P091N8F7qZ-0jAHRCWGnAQQSJNDJHL5kfhxBg>
    <xmx:YDqcaY9_jOlwwQpMNXyhVygFEx5AoE9DeciSAjNWFYbd7H1cEquHunSF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 06:30:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f632c14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:30:38 +0000 (UTC)
Date: Mon, 23 Feb 2026 12:30:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pack-check: fix verification of large objects
Message-ID: <aZw6W_BHoYiC9RYl@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im>
 <20260223111120.GC215364@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223111120.GC215364@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 06:11:20AM -0500, Jeff King wrote:
> On Mon, Feb 23, 2026 at 10:50:43AM +0100, Patrick Steinhardt wrote:
> 
> > diff --git a/pack-check.c b/pack-check.c
> > index 46782a29d5..6149567060 100644
> > --- a/pack-check.c
> > +++ b/pack-check.c
> > @@ -155,7 +155,7 @@ static int verify_packfile(struct repository *r,
> >  			err = error("packed %s from %s is corrupt",
> >  				    oid_to_hex(&oid), p->pack_name);
> >  		else if (!data &&
> > -			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
> > +			 (packfile_read_object_stream(&stream, p, entries[i].offset) < 0 ||
> 
> And now this change is delightfully simple.
> 
> > +test_expect_success 'fsck handles multiple packfiles with big blobs' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		blob_one=$(test-tool genrandom one 200k | git hash-object -t blob -w --stdin) &&
> > +		blob_two=$(test-tool genrandom two 200k | git hash-object -t blob -w --stdin) &&
> > +		printf "%s\n" "$blob_one" | git pack-objects .git/objects/pack/pack &&
> > +		printf "%s\n" "$blob_two" | git pack-objects .git/objects/pack/pack &&
> > +		remove_object "$blob_one" &&
> > +		remove_object "$blob_two" &&
> > +		git -c core.bigFileThreshold=100k fsck
> > +	)
> > +'
> 
> I like seeing this much-more-specific test case. It does sort of become
> a noop if we fix the iteration problem, though.
> 
> A more concrete test would probably be something like:
> 
>    1. Two packs, $X and $Y, both contain the same object.
> 
>    2. The object is corrupt in $X but not in $Y.
> 
>    3. Running fsck detects that one copy is corrupt but the other is
>       not.
> 
> Right now it may or may not fail depending on the ordering of the packs
> in the MRU list (which we might be able to tweak via mtimes). But
> hopefully in the "after" state it should deterministically complain
> about $X.

Yeah. The problem I had here is that I'm not sure whether we have any
tools to reliably create a corrupted object, e.g. with a hash mismatch.
I'll have a look for v2.

Thanks!

Patrick

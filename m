Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502412C0285
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731305; cv=none; b=MX8hKvh2HIfK4SZY4qoUfyq+jw+7FBBAVHlV7zOptXUtmzxMg997xKxhjkY2Hz8yPZVKtHLw/P4YtYCGDcU3TgI00tAUY1h9d5KoBG4bN36C+EQyTE+tcnc9wLWHlA3b2lbsWlC70xpC9nTLPnNRPMf62Mr/3f7m/uhzM9I9l+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731305; c=relaxed/simple;
	bh=nx4f6U4h+8wF12GpoRmACwXqttHCcAtxOKl+VIY7PBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl0lobVo7ymdjjQA0hze2Hs9dMvhTkho3/N+kD6T9O2RZTTHWLauPvSxmaUYbMG6vPgMVdcKPDJygCidyEdhbbxXF7UNQCrLvpnGbNltVNYtlybrs/Rj6kpkTmAbHEvWiaXYH61X2INlBBJmnLztH2hfRSDFRP7DiiBK8u8h3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NXo9loOz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uHjM1nbo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NXo9loOz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uHjM1nbo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95B541400320;
	Thu,  9 Apr 2026 06:41:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 06:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775731303; x=1775817703; bh=J39WIJXxtC
	z2z92P1Oq3t6d+t9Mx2Xgo1V07lPqSxFA=; b=NXo9loOzcvjYmmh7eEZjzMlfEE
	arHGAmgIoy47cTSVqHMD57vEoVMh/YVt8/WUC3Jx+S+zjzMuHzFy/NjAR8LHts5V
	+kNKU9pX7cbFndacQjLmibPlEq0xX5PqMCnFKqHsHb7UZTQoo3iI4h5YQk6aTRhp
	IoHtIP5xPqW19LLAZc2D9rHdSWDGHdv1uUbZX+cgdxqsdLWysolkCkPENlqY5bZV
	2bjpvT5IGMSES9BDdWMpQO2XLrt3BOR7KO1RI9Z6acBV4rhqzZViOI5cLYp5QR++
	eQKBM88Ayj/n9sg4HvEkOLbOQfi/QSaYSeBFll8IneBkXKDRao50Dc0O48Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775731303; x=1775817703; bh=J39WIJXxtCz2z92P1Oq3t6d+t9Mx2Xgo1V0
	7lPqSxFA=; b=uHjM1nboBmGldCae8b+ldORvvP+n+XPSyIr6PHuuP/iZVq6m2O+
	0qWJ1atpyXn6gNNGeeGT7z/BLPuVvAG1uTPxpimz5avHtqT3NFX6srsMTbCI5e6z
	TLMaRG1JEdZiFFBKR+zutuVWDAeeraqb2sOkrKOcEv8ncpcA2bkT0f+jx1iN8orG
	+22IGNAoP0JulKnG1+4XtWyS//vpeCls9WfmVyn+i2wGBy8sjJP/bd3W9teO9AXs
	tSe7U0mSQCkMVjAI3r9OV+Nd2MrfSPPvYGWRjJwvDKmFy1LgaBgSpGnHte9YsVlc
	/RVo/D8s9ZKwApY//07PEvAhP9v1/tYWrPA==
X-ME-Sender: <xms:Z4LXabcnMPVEuZki6F288TmF8NP_cdW7-FIdnLeehuBbrxpIOE-BAw>
    <xme:Z4LXaYMTElu7aMgKPBjJuIZpslPRaHkRERWhPM3fkafq5U8_QljPYHvqkwPtN0exW
    bxjdJq7hNUK5dz6m6Mvo-xuUQ1xMyONj5afONUUzBtDgdEli7ahOg>
X-ME-Received: <xmr:Z4LXaZgO6AjHeLAs_uGUSwZbp2Er8KDnHSZVWbyn6hU8bOqf7iyzXy16dQJWlpNZ6ajvGm8Y_2R782At-CI4xgi94mkkylBMGS5dJu7ihXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddviedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Z4LXab3UKmVJvW_7yO55gBglV27LXaKHFhIW4PnfUb06slptcbIRow>
    <xmx:Z4LXaTiY2z-7t2Rqz6TLwhftiK4fExFVDD9nYrtmmX7gB-aNTOuWvw>
    <xmx:Z4LXabdteK3ggx9Uzm3xj3O707BVV7GzM0tHI260EFPBqYPsOKyq5g>
    <xmx:Z4LXaWk0eG3IJRbixPiCxLz2fiWdHpY5rFT-TyD5dhvTd34axYbczQ>
    <xmx:Z4LXadBiHjOsxzZaytv-Nq02catgSlOY9CngCEvKu72xs3yusxLsrtp7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 06:41:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49e437be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 10:41:41 +0000 (UTC)
Date: Thu, 9 Apr 2026 12:41:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 04/17] odb/source-inmemory: implement
 `read_object_info()` callback
Message-ID: <adeCY8QyvDnQdJU2@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
 <20260409-b4-pks-odb-source-inmemory-v2-4-f02b4f1c0f13@pks.im>
 <CAOLa=ZRwv_NYqtNyvhi=5auLhVx+FDbt+RP6Kj_ZqjF=VsefyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRwv_NYqtNyvhi=5auLhVx+FDbt+RP6Kj_ZqjF=VsefyA@mail.gmail.com>

On Thu, Apr 09, 2026 at 05:40:01AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> > index ccbb622eae..12c80f9b34 100644
> > --- a/odb/source-inmemory.c
> > +++ b/odb/source-inmemory.c
> > @@ -1,5 +1,57 @@
> >  #include "git-compat-util.h"
> > +#include "odb.h"
> >  #include "odb/source-inmemory.h"
> > +#include "repository.h"
> > +
> > +static const struct cached_object *find_cached_object(struct odb_source_inmemory *source,
> > +						      const struct object_id *oid)
> > +{
> > +	static const struct cached_object empty_tree = {
> > +		.type = OBJ_TREE,
> > +		.buf = "",
> > +	};
> > +	const struct cached_object_entry *co = source->objects;
> > +
> > +	for (size_t i = 0; i < source->objects_nr; i++, co++)
> > +		if (oideq(&co->oid, oid))
> > +			return &co->value;
> > +
> > +	if (oid->algo && oideq(oid, hash_algos[oid->algo].empty_tree))
> > +		return &empty_tree;
> > +
> 
> Silly questiong, would it make more sense to check for empty_tree before
> iterating over all objects?
> 
> The rest looks good

Maybe? I guess for now reading the empty tree is the most important use
case we have for the in-memory backend, as we only write in-memory
objects in a single caller. On the other hand, `source->objects_nr`
would be zero in all the other cases, and jumping over the loop should
be fast enough to not matter in practice.

An alternative I was thinking about is to store the empty tree the same
way as we store all the other objects so that we don't have to special
case anything. That has the benefit that we can actually modify the tree
object, too, which may eventually become relevant with regards to an
object's mtime that we may want to update. The downside is that we have
another allocation here and need to eagerly initialize the data
structure that stores the objects.

Patrick

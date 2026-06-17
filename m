Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA9A3BBFCF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681197; cv=none; b=rmaHGZIZP1SD+bjK73rFtXoZs0cgRu9bMdjmXtve8y0o3eoGTe7kcGbHFy1snQmTn6RXrOiWwT+MEZH0FfzELB+gCHtvgtO8qmudkdAa+7QSD2Ihv8Iyqhh5DXkTgPvVWsXS07baEWZoSJ1lUG4Ji9LwPvzw/a7NtedtSk1iOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681197; c=relaxed/simple;
	bh=EynDQbgYq9LGWUBHVbWsArkCP35Ige4cLqtzuJYb6VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZrdGlCNFrnJIKCSfP+QL/BJV0VtIi8YglceksXMKb79uLdOqZK3Ypt262Jmf4TjHLnPnna+6MT/ovr6W/JfpkuGhnLfb89JSMuzcFpS2+RLtljJ0UL2DIy65CEjTuGiaei5Q+pbotkQ1ztn5sOqLLIcWNjsvfsdmKQj0kYTxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mTV2FHPb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aZLuCj2M; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mTV2FHPb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aZLuCj2M"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1D767A0103;
	Wed, 17 Jun 2026 03:26:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 17 Jun 2026 03:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681195; x=1781767595; bh=0MGOu1C5ir
	kSrmU9t/jCUXUtwA5lX/ugefqsVdoJoqA=; b=mTV2FHPbU8cC/EOBXK1YLoABuK
	rnXvIbR2wxPX1uRO0ZXdZLxmpN7TvqCufAMNY8gvSfr5zlvFRP8iNsLEu1k6egsC
	lRQyVjeqiPzRLjcfNqQGgr9GhkfekaYf1Akyskk8jRkvUpzYHMjER/y+lG/QW1PM
	fv7dyB7bQ1fCDnJPOMAUH2FdO9pXTKgZ7GLbFnErtYOP9+10MezdR3Yw9HUzoGM5
	F9LMQjzSs2F+5oxkO21FnWtcqn1IUczNcRkXnDlb/IT22GiXCMtzLFY263abkAib
	j3uf15buLOM2sryCJz5pwwUxJ9AMRljmDKeC1kBSoaLRqBxmWVeKKQ4SReWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681195; x=1781767595; bh=0MGOu1C5irkSrmU9t/jCUXUtwA5lX/ugefq
	sVdoJoqA=; b=aZLuCj2M31wBEHbU7mAzU5mHhCP0BLb8uM8IEloIQFaK8jQ/C9q
	eW/hAJ6EuXpZGtkXcCzIZZK6Jsj9pM4L3obP3GSJMCMjmDjmnft8kdHWVP/kwuSP
	dR2Z6r1zMAIJwGy7RJxGW8x9/OnM1xPyxO9xTi/rxfchLARNwmatetrvRYdk41aD
	2gKkMv4+l+8IssQLZenaRt+kVT0FmqtaPkTYVp7ZU2HeyTDgY51qzhuftMbL/IEl
	y8xNUJ9Y3g1fmgLOdtvEI8ICBCsCLCqORJwq0gtWl8lForvlvC60cebryeRdbro2
	rSUMOoX7DzeOaELRlUrl3JoWfl4b5zIbk4Q==
X-ME-Sender: <xms:K0wyaowFtnISLlwfR2JNTzi4QZOuXotI0B0mgKTCwnxVzXUVTVC8OA>
    <xme:K0wyajscXpeCH2RtkkQWK2Qn9fbF-O7jOcBvBoh0TORjQ0bG0eEGdsA5_-nHlGI-C
    DygA1WSxsm5Y3ScL5Xzv-Zm0c7a5z9xlsP7W_Ajb23bnEAyyE8Y>
X-ME-Received: <xmr:K0wyansPUWUAK24qsdh3jwdmWnUouIgsdLEUAr8a3UfSguIaawL0K7J_gfSII7A4cToZg7nTI49XzqRTuQJ_aVyB5zNGaCoWSYmWW3s>
X-ME-Proxy-Cause: dmFkZTECEfqNY+DYlgUZbh7RflGDxPwxWOFQ5FaggYG/JTaQGWGseBdbY2EennpmWJU5DM
    KxxewEG68yBUI2vuij1Y3+6lspL9afLDWMuHN0VbnrayTvmini3Q6HCii7/KargwDnixZ0
    8q0uWF8R6uUK+PpY4I5IeUB/C50XD/88L15pmh51anU1763eNepfGNxiTtlXn9mah7f6Gf
    pyB5yELgoMFEMmWcshpr8EBu4yUyu36jB7pItZlPWc5iVIvNGE6zga8DupPXdYM91deC9F
    oz5em0rcTe9jbinhTg3ltVoufzHARtQKbZ7tIir8aE93KmB/ZDCfLGiBvmNUXwpIQ+X4J6
    GNvSBlmFwUujoC3t1LESAvZNr50vvMdajhr8pcr+1JaCwjFFErARW2feaeshnrfVhw4Cp/
    LHCh1grw8V90VDb6BreFh/GSUMCY2TWoG/eom6j6WmQLSFHm1KPdxAVXAZDOXgFdJW87Vj
    ffkz2/8xeLKrpw0alpeYaZaeiU6LaMHxfxYAWmw9BQ65g4VcaV7Y2NzZssfVqAaZn3VTFY
    VUcSIm0nF4DiH28sNEgLzm6uS03O3T8IoowUhgV6V07DEM9oaSZNUcJLbz8K2bnrhCXC4X
    +BbQod/BLkIos/ooL8GVpDXcn/hjNwBubhvxWvqLEVeDJn4FUt1Yt4LkxajQ
X-ME-Proxy: <xmx:K0wyagOdms-ttfpv3QAuLFLc6VSvdpBY4qrRPQDiH5U8d1JX1djtvg>
    <xmx:K0wyat0HCxEwrjAVLmBOZluOBYoSP2IE_df4Rl6tyWMQsHRalcHtXg>
    <xmx:K0wyakNoEBsrfkAIH7Y2bl262nAwUWNDlPsjLqhra9czv8IDWg5wCg>
    <xmx:K0wyal2gP-nsCjvJQc2JttYPZey6u1LLWHdM7_gvcFFv1O7szmIsaQ>
    <xmx:K0wyajIAXA10FnxVQmfw5QodaXty7bOlAZsFgBwZySX7uZehnR6cYhEl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:26:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f30a51e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:26:33 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:26:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/17] odb/source-packed: start converting to a proper
 `struct odb_source`
Message-ID: <ajJMHcHdtFdHjD8v@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-5-839089132c8b@pks.im>
 <ajG-rP7cRjZa3zJE@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajG-rP7cRjZa3zJE@denethor>

On Tue, Jun 16, 2026 at 04:36:59PM -0500, Justin Tobler wrote:
> On 26/06/09 10:50AM, Patrick Steinhardt wrote:
> >  struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
> >  {
> > -	struct odb_source_packed *store;
> > -	CALLOC_ARRAY(store, 1);
> > -	store->files = parent;
> > -	strmap_init(&store->packs_by_path);
> > -	return store;
> > +	struct odb_source_packed *packed;
> > +
> > +	CALLOC_ARRAY(packed, 1);
> > +	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
> > +			parent->base.path, parent->base.local);
> > +	packed->files = parent;
> > +	strmap_init(&packed->packs_by_path);
> > +
> > +	packed->base.free = odb_source_packed_free;
> > +
> > +	if (!is_absolute_path(parent->base.path))
> > +		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
> 
> Out of curiousity, did the packfile store previously not have to worry
> about changing directories?

No, it didn't, and at this step here it still doesn't. This is mostly
because we still use the path of the "files" source, and that source
handles the reparenting for us. But it will be needed in a subsequent
step once we get rid of the pointer to the owning "files" source.

Patrick

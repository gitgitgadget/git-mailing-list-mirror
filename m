Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509E3DE440
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082338; cv=none; b=Q1e+XtFnrF61sRKak3suEGCxPlEwqM7dmI8B3GPVTecOguNjNNyuRBHZt24vPj6PXyPuew7zodwQjyrML+4q5J0aN4D5n0hxpuHj5Q8lOGK2y1Gue3VQ81eee3AWX4nAO+nTzPeIuZ8+mq8lTiZqhcrYQXR9airKIfvlDyvXUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082338; c=relaxed/simple;
	bh=zudqxM8Dq5IGs9mleBkAvilI3bRXLgTDO1jOyR2CqPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sez9HphDGIPBGfa6VBpxKI1vPHaMOAWZlUgSAZFAQ5CN+6VDhltlpFkCsFPMq3dFZSDOIzuGwM7Fg7Qa4H2ep8awLpKHTsRU/DDALIWqJqNy6KA3Ocu8HQrybKMTPyouo7TnflKMoXn80BLexE98KQJnu9O0XzOXenPF4CoBQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NCXu6sZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCdtF8G1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NCXu6sZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCdtF8G1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B6697A0116;
	Fri,  3 Jul 2026 08:38:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 08:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783082336; x=1783168736; bh=114lUi29Wr
	yuOmUB7pXNBMj8bZHNewqBNlZvicZ47pE=; b=NCXu6sZOoXpKTj4KfWcOh4eCbD
	tal0rZSYVJ16HPfa2I5+gocwwZICE9bjOXsTEjpwXiECcXpOGDXHZOlLfPG08O1/
	FqHjNChP7HwNpjzF++Z41Yc3ixHS7kfQ769L1Tt8NdzmjnktOnPn6oK7VW18To3/
	LO3z6vYabrx+BRPIiRZjgm7R/LxJ8vUkcIqL6kPWBLpMgWxdhbk/tzqliuG5l/xd
	Bj4NpvZdYEfiB9cXQ8+8+SlQGRDELBO9uPzLEIwMb8nEEJ1I67bJk3CJZM8d0/cy
	rM2+1EikRZTNNLvJi0u4//PQ2+m1Yym/bN1ze+u2YyNMl7EDJ9Liwc/Dnf4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783082336; x=1783168736; bh=114lUi29WryuOmUB7pXNBMj8bZHNewqBNlZ
	vicZ47pE=; b=eCdtF8G1mqCBh8XSWPlhIyDfQ6gIS/wQPVz7vJomFe+1l9Y4owr
	auYqZOn+946tFTYQcvJ4sZpjSaFtzMzpntxBVfGgrgsW587bqvROrAUVP3LZBdyZ
	YYLBRyVdifMLOC8RUERsw2Sj2otBcBpEHn9uM7U35W6yn/yvh24jW4U83juCnpSb
	jYg/zufxF+Vk1ni0of5Z0FBjNXqoR1sVGyv3e7p+n+2n9e+rBk4FP4weh6g1YoDw
	GepR2umT85B5d4BqzS72+iNy2ylqaGsol9Z/M3M0JjJetqZjfHIhzhngSDyjneC4
	mXLF2DFDx4vSXPsSXycCEmDq/Yb87mpmYjw==
X-ME-Sender: <xms:X61HaufyS9ZO0MzNbtazTP8p-Y_57Im4_9fhmxrI1qyuAsd9zjT9-A>
    <xme:X61HavrtV2vUYeR8D7Q-fOUoyQ6pnm_QxBdpjrmO2LvtHLdEhtSJJCDAVC7bEDybz
    lZ_GOMD83UEhUPzH6sbUmQI5T2OW--6DT1rX8at2dhyCmeLykHR>
X-ME-Received: <xmr:X61Has73NBdiLtM2lyPBskEeyyiIGsmCUsIk6ct8V4P2bkmNEtyyOvH6Q2XPX-GozymWQ9St4YyOZ3AOmKuVvZB5bfVoRBrT0npRP872Mg>
X-ME-Proxy-Cause: dmFkZTEPL8zYHitx3bVaPOYWUwytKOCoZfVE3XHYMRCdtmC3PS2ogPTqR+e3DrOiYwEKi5
    3Y5z+0R3fBrnmMZWlkj4Z96nBZ98z1hmjvpEdi1dXW8NF9B94eLbo8HiwKSVSYkEFwCDSk
    X/x/oHh+ymNyjAnIxFVku+xKWQmRyR6s8WNj72J7KcoDTykl8NiHlnEQLXH1+vC3Fcqh5L
    he9LsOmG1bNj1lzDI465evPQ0UwOTuYKolSeQ1gCUETRz/dIXztibbpibfV5j98I+Lb0Zc
    2l9DwFBHujtbovLjUAeObsEAZyi2RnGjVdMZfEJseC6X8WMtOvwZ+/+oETvNIRG8BN5mHB
    pGwF9d67mIKEZ6GLnehKWTuybDsCq+AyBBMQx+hF3f4TzPQ2ZLBxBdZfDlEp37DRxMpyd/
    ogj3GqSiILrVwKb3oM7J5EDB8it1iLpymsiPuimZPEzeRKStai9zOu8oZjMY0kHK5Xy+8k
    UHWWlVPIK0Lstt9OSRvfkdUjYuKAFNvHopNSWlobnw1+D7bzjXaTRXOzkCOj9ATMTqlOpc
    NXM1tijU/31QYqFKph3V1VUMpB3gJZAyeaJj8gxVSSxV24HbhBNJQm8wP35+Ztul8W5YX1
    lfpdAVTH5/dcvUf3iRmG4tzdZfgdBDYVc/HBEXTeBdhF11TiXjYdNkt59aQg
X-ME-Proxy: <xmx:X61Haloa43aGO5hQUmn99OrtfFWBVt2PE33zMoHgx1Sgwpiaoau5rw>
    <xmx:X61HauiPuGmY84pgTpFsultq5OCtE5lXaLPF-HEJ0NU7DDovBlhkYw>
    <xmx:X61HavI2UbkBQR1fAEC4Tcv6HhGQplO4suchPfd1zdVEYW0MSMnJig>
    <xmx:X61HauDa3M9MYlMrZBqrGk3nzRkptzdU3RoP8Sj4f4pFOtpEUDv1xA>
    <xmx:YK1HarSHFgw3ZTDYNdevTf_wskVeKgBj8yw4vT7NRIRpNjaOO9o2d7J_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:38:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f1a6299 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:38:53 +0000 (UTC)
Date: Fri, 3 Jul 2026 14:38:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/5] builtin/refs: add "delete" subcommand
Message-ID: <aketWqvDbsJ1VyXe@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
 <20260630-pks-refs-writing-subcommands-v3-2-deb04de1ecef@pks.im>
 <87tsqg2vja.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsqg2vja.fsf@emacs.iotcl.com>

On Fri, Jul 03, 2026 at 12:54:17PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/refs.c b/builtin/refs.c
> > index f0faabf45a..edb7d61663 100644
> > --- a/builtin/refs.c
> > +++ b/builtin/refs.c
> > @@ -175,6 +178,52 @@ static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
> >  	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
> >  }
> >  
> > +static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
> > +			   struct repository *repo)
> > +{
> > +	static char const * const refs_delete_usage[] = {
> > +		REFS_DELETE_USAGE,
> > +		NULL
> > +	};
> > +	const char *message = NULL;
> > +	unsigned flags = 0;
> > +	struct option opts[] = {
> > +		OPT_STRING(0, "message", &message, N_("reason"),
> > +			   N_("reason of the update")),
> > +		OPT_BIT(0 ,"no-deref", &flags,
> > +			N_("update <refname> not the one it points to"),
> > +			REF_NO_DEREF),
> 
> Would it make sense to allow both --deref and --no-deref? (and --deref
> being the default)

Our "parse-options.h" subsystem is clever enough to make this work
already :)

> > diff --git a/t/t1464-refs-delete.sh b/t/t1464-refs-delete.sh
> > new file mode 100755
> > index 0000000000..efff7d0574
> > --- /dev/null
> > +++ b/t/t1464-refs-delete.sh
> > @@ -0,0 +1,130 @@
> > +#!/bin/sh
> > +
> > +test_description='git refs delete'
> > +
> > +. ./test-lib.sh
> > +
> > +setup_repo () {
> > +	git init "$1" &&
> > +	test_commit -C "$1" A &&
> > +	test_commit -C "$1" B
> > +}
> > +
> > +test_expect_success 'delete without oldvalue verification' '
> > +	test_when_finished "rm -rf repo" &&
> > +	setup_repo repo &&
> > +	A=$(git -C repo rev-parse A) &&
> > +	git -C repo update-ref refs/heads/foo $A &&
> > +	git -C repo refs delete refs/heads/foo &&
> > +	test_must_fail git -C repo show-ref --verify -q refs/heads/foo
> 
> Why not use `git refs exists` here? And why use `git -C repo` in this
> test, and `cd repo` in the other?

Yeah, there isn't really a good reason.

[snip]
> > +test_expect_success 'delete symref with --no-deref leaves target intact' '
> > +	test_when_finished "rm -rf repo" &&
> > +	setup_repo repo &&
> > +	(
> > +		cd repo &&
> > +		A=$(git rev-parse A) &&
> > +		git update-ref refs/heads/foo $A &&
> > +		git symbolic-ref refs/heads/symref refs/heads/foo &&
> > +		git refs delete --no-deref refs/heads/symref &&
> > +		test_must_fail git refs exists refs/heads/symref &&
> > +		git refs exists refs/heads/foo
> > +	)
> 
> What happens if you delete a symref and provide an <old-value>?

That's a good question indeed. It verifies that the symref target
resolves to <old-value>. That's the exact same behaviour as `git
update-ref -d`, even though it may be a bit on the funny side.

I've fixed up the above test and added another test for this behaviour,
but I'm not sure whether it makes sense to send another reroll for this.

Thanks!

Patrick

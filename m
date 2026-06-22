Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0B3B3BF2
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136434; cv=none; b=YKjMguo1sCX4U58BjNxmTF55H5HV0Z3oKSIaE8IaN4a6SSmsgJTwLe+EL6MfayDHm5BONJqn9TXIfejrCqZX22XTjjIISecC9JQRvgH8IsmqzR6Z2wS6SV+Ppb++qC0dpIPtjoRn/+SAHHlpejq8/b4A/mpU7rOfpcat1C6IYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136434; c=relaxed/simple;
	bh=VrdlOlWicl7tA0DHeGuYVnD1v2f7sdYx+Ig4frJzzDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9lLuFMYqe4CPGG78rNJxrsMjwpy7t7R/6/5U1jnfFZs9aPaC5+q56wbc/93nK0XCUMBXKDnGL9x219PTlajjADRkyd79+NBTLsZOPkrZQ1Z6+7l016mUkG79aTQgPobfxBNBJcqXM3KYG8qkB4rVLB9NlQLF4/iCwqF73DMGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n9dSLGeK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AyIf1bLX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n9dSLGeK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AyIf1bLX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C9A8140010E;
	Mon, 22 Jun 2026 09:53:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 22 Jun 2026 09:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782136432; x=1782222832; bh=8IeuPcA7/x
	paKlsT32rH2mceU689CHEV4jaP9vANpPM=; b=n9dSLGeKZelVsqkvyn2WsSJ7nT
	4QGmW5fNDxh8XHTlXNVe49rAfcKFa63XYCzcHTqFk3H+jff+zvMd9tnOGaIoiWy/
	6WZlxA1z8nFemNPOh6ug1KV0ICLXbyU05daoQMPvDD7CxqbTK9cAREc9cXgHoALK
	SKfhgEmDy4O/kJmPUV2e0Ml/MRUJ9c2zQqPQwLr0ORasu39f2o7D48lEAokwuAnw
	8x90ud+LvG8Z/x1q4QqszDjZPkXmvE0JWZOUyql0rZQCE6ZN49I6MCvmMRvUU06K
	p1UmIq7/hXJ2mSvUHdD0TVv/HKzRwvx13K1hHjjPm2LqMMLodfkiqtv6FyNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782136432; x=1782222832; bh=8IeuPcA7/xpaKlsT32rH2mceU689CHEV4ja
	P9vANpPM=; b=AyIf1bLX1IRBjzBcWjClxZNhml8cL6F8JAan7japl0N9PkhblGL
	GlTFRs+kljTNSYDVdT4zizWMvI3nFOuzYG/fsQMKP2XHrMXWcqhgKOYuodog0FwD
	rQRfhvcX0YvXp4zuj28bDwABtVbH37oNWtL+0XOupMvuB1KJ9Lp+ZdXJdfBhMAgE
	S5BMk+EyyIyxIBVtF1/TiR0F4rtA/KqEsWTyC/6zWyhGfOOhqMA5W2xVinX5MjEM
	3N9sd/d7owTLRFpvGFvij/kA9prCHTkIw5SklUqePh2HS22Viis3vVs9DA6mdio1
	r8pDNWP0XSeS/lOkYb3zVp9dL4YLHeaLQww==
X-ME-Sender: <xms:cD45aiIFTnVxXOAr4p5x_Y4yhL_f7i9Q-w66p-zV6agmxJ-hYZBfUw>
    <xme:cD45akvJFrDdVXK_bJomA2zP_koBoFYI0Q3wCKUMaxSrJ9wmhhc8Z0CfeLR-sSf1_
    kPAXPugLbVJ-GtbV8aletba1i8htdNvysf1r36Qr15as_ZdwhJBpA>
X-ME-Received: <xmr:cD45avQk0eZy8ZuhIV-uIHBjjQCjnVhkzud6qlIW-mG_OcNKoZsgngxxcoyWJ30AI9YNmueK1lPol28qurjgfnM4liSiYILHGPqab-iSmA>
X-ME-Proxy-Cause: dmFkZTFP9G7rdRNbZW9L/nQfLB8/CQQSJ3r9QGTpBNdXtr+vnVFoiP0HQQ77zN9Q1U8/G5
    1y+EMsZ8tUJ2kAAGBgWnysuE6Llfp55Q9fZDx+3JP+NXf95aMhjH2usWXW84skxsAxjdPJ
    tOJI5n/5JTr6Iy8LxIShuom85vAfPmqwpYsth2iDyz14gQ2XYjKeVM9HdiEQXDxl/Ly4Xt
    FohK1Kt8osB504VDnavu9kd+LSpRBwLVqJq+Vc+osQZv0yrTQwtEljvIE/jc0pjOpUOOtF
    Pd5Yt5KlWy5H3LD/AIoBd+wzxXLaebqof0bUNnHxGh8cJl2RLroO1vEMJn1AzletxPn4ld
    bJ7jqnzhAjsVbbyRBZcwkuyiMzwHKojl6g5FqqPZKwABYBgoCatX+Uwfs4D6YPetWgJe5Q
    RDEBWhN1jkcK4+oqnsFRo+1qU/+svaUJz6+pYo88/CIJKN7ECi1QTqPQzzataJMzH3xek9
    JNh658qIiMahZ4sViBkKPlOaqYP0ExXbqHtsa2MiEgLh6vXVrdC01JoccRsdSD7hwjryAE
    tXidnKCwW3ygyh+JMlPv1zt8SWurqxWsmbpT+hPRzu16m/jYgUjLwJtl7cEKd48g5BVQq4
    qkB93nz8aujkDIpHyxIK+r6+L4yl5PmIyqA3E1TlEvqNhGtBEZfESQZqmDYQ
X-ME-Proxy: <xmx:cD45aqMpcYTDoW2PxlZHysseUoIApMRCj1L5nLQT7YUWyg4CPIKFTg>
    <xmx:cD45akZ6cRqSL-Dj4MOPbtAFq7WfRfaMXBS7b6wTNvmhxPJWOALWow>
    <xmx:cD45akwHnypG4S8CQkwbzgjbG8IJ53yikcQl1o1aE5Ry_Ysj398zpg>
    <xmx:cD45avJJgcNQoIdnSc8R7pihFzlx0bxdSPZuAyb0S9IjWhNbobs_4A>
    <xmx:cD45aql-dPsnldu7h7RLReCRQdNwsuseKs-xynCgs_9_3vH6vVDnt5AL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 09:53:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1b87fb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 13:53:50 +0000 (UTC)
Date: Mon, 22 Jun 2026 15:53:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 3/3] replay: offer an option to linearize the commit
 topology
Message-ID: <ajk-a4a3KSJ2u7Ju@pks.im>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
 <20260622-toon-git-replay-drop-merges-v4-3-ff257f534319@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-toon-git-replay-drop-merges-v4-3-ff257f534319@iotcl.com>

On Mon, Jun 22, 2026 at 02:41:57PM +0200, Toon Claes wrote:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> One of the stated goals of git-replay(1) is to allow implementing the
> git-rebase(1) functionality on the server side.
> 
> The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
> was given. This mode drops merge commits instead of replaying them, and
> linearizes the commit history into a sequence of the
> regular (single-parent) commits.
> 
> Add option `--linearize` to git-replay(1) to do the same.

git-rebase(1) essentially knows about three different modes:

  - "--no-rebase-merges", which is the default and maps to your
    "--linearize".

  - "--rebase-merges", which by default doesn't rebase cousins by using
    "--ancestry-path" internally.

  - "--rebase-merges=rebase-cousins", which doesn't pass the above
    option.

So it's not a simple boolean there, which makes me wonder whether we
should mirror the same interface so that all of git-rebase(1)'s modes
can be represented, as well.

> diff --git a/replay.c b/replay.c
> index 7921d7dba3..5539daff00 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -277,12 +277,16 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  					  struct commit *onto,
>  					  struct merge_options *merge_opt,
>  					  struct merge_result *result,
> +					  struct commit *replayed_base,
>  					  bool reverse,
>  					  enum replay_empty_commit_action empty)
>  {
> -	struct commit *base, *replayed_base;
> +	struct commit *base;
>  	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>  
> +	if (replayed_base && reverse)
> +		BUG("Linearizing commits is not supported when replaying in reverse");

Nit: Error messages should typically start with a lower-case letter.

> @@ -430,12 +435,25 @@ int replay_revisions(struct rev_info *revs,
>  	while ((commit = get_revision(revs))) {
>  		const struct name_decoration *decoration;
>  
> -		if (commit->parents && commit->parents->next)
> -			die(_("replaying merge commits is not supported yet!"));
> +		if (commit->parents && commit->parents->next) {
> +			if (!opts->linearize)
> +				die(_("replaying merge commits is not supported yet!"));
> +			/*
> +			 * Drop the merge commit: do not pick it and leave
> +			 * last_commit unchanged, so its children (and any ref
> +			 * pointing at it) are reparented onto the previous
> +			 * non-merge commit, which the ref-update loop below uses.
> +			 */

One could add a hint here that tells the user to pass the option. But I
guess that might be somewhat weird, as we cannot assume that we're
called by git-replay(1) here.

In any case, this here is the core of the change where we stop dying in
case "--linearize" was passed, and instead we simply skip the commit
altogether. Makes sense.

Thanks!

Patrick

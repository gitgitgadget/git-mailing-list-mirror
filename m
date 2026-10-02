Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84904314D34
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911198; cv=none; b=FpdUOvNFent0tFl/7KqAaSjY3YqlnfLU1KVKm7q3bM2GJ7snEs+jxSKbrHXf+y6IJPx8MMetUcSGSqVWcxAwvVD6+8y9vT68QCHI14zwubiaOqlubCq3rm/zvHhcVWl8zzJWqlckj7FV3HjJ+a12Dnk6Hi6K3BaVnWayCj6XOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911198; c=relaxed/simple;
	bh=UzU4No6En1qH1iUhz8/J6UIwu75+/tF0dwIof24Rp20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVOECqmuCrqrw0WCFm0WLV+D8Cr8OqaWA2Ei0vKKuC/TO/TnCnROjUDWThAzXel57H8VzPN/3vB2nUX92D4Fb8M7wUY0tuRJZSRdOM2yU203YxRwAKvdO2bLirbhfheDk6UXdHP9pFQ/ZRROi6xQo75GcJeuzeuiaIVuyumfkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=XS0PKYFU; arc=none smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="XS0PKYFU"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C5D8E3E12B3;
	Fri, 02 Oct 2026 03:19:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.96.9.161])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6C5AF3E0A2E;
	Fri, 02 Oct 2026 03:19:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Share-Illegal: 3b09d372737df6d7_1790911191654_2116834904
X-MC-Loop-Signature: 1790911191654:3907766854
X-MC-Ingress-Time: 1790911191654
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.9.161 (trex/8.0.2);
	Fri, 02 Oct 2026 03:19:51 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4hwvCp68bmzymc;
	Thu,  1 Oct 2026 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1790911191;
	bh=nYzlvboWlGv6+Wqod2rOEOVtVBLpSlXJM6DMci/Ks44=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XS0PKYFUQDYAws0qcKplvy+v5WkIJN0zLt+4adpofBvPmNT/5HmlyFnVbecPg4J43
	 jvBRTiraA+u2Jv3KzQZk08bww0BjYgwMD+nMdyuRYr2hOFXln6y3C55xBP3RRbtt/r
	 hwDUP6dX2LrvBBZPWeQTUsqCm3n7Fxd6K9lr3FaVBv5eBI+0Me3Fvl8Svp2mDw4IBJ
	 XH5YCZE3eNxxPntvybwx+kS2+WacKw/vil8h3s3usdWINemf1Oj+K66IoNpEfFoYNg
	 ASEf2W5zoDHS8zJaLrbtW8pvNklsb19h19wqQNVzuZ3BqpUEq+N/r7olvta+rOnT6I
	 Cnr+JPWdRcPVw==
Date: Thu, 1 Oct 2026 22:19:48 -0500
From: Nico Williams <nico@cryptonector.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Alejandro Colomar <alx@kernel.org>, git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar8i1Pz3Rh5F8ngx@ubby>
References: <ar5KL4_IKXYbx3Sb@debian>
 <f5859438-f91d-46d2-b80c-25d63937ed7c@hogyros.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5859438-f91d-46d2-b80c-25d63937ed7c@hogyros.de>

On Fri, Oct 02, 2026 at 11:49:26AM +0900, Simon Richter wrote:
> On 10/1/26 8:58 PM, Alejandro Colomar wrote:
> > I use this little command to apply iterative rebases, which are easier
> > to handle when there are large conflicts.  Are you interested in it?
> 
> I use something similar:
> 
> [alias]
>         slowrebase = "!bash -c 'for i in $(git rev-list --reverse $(git
> merge-base HEAD @{u})..@{u}); do git rebase $i || break; done'"
>         slowrebasemerges = "!bash -c 'for i in $(git rev-list --merges
> --reverse $(git merge-base HEAD @{u})..@{u}); do git rebase $i || break;
> done'"

Nice!

> Alas, this breaks down with merges, and it is slow, so I've been thinking
> [...]

A slow-rebase or bisect-rebase works best when a) you follow a rebase
workflow, and b) the upstream has linear history (i.e., they also do a
rebase workflow).  When the upstream has merges then... improving this
experience gets difficult, and the easiest thing to do is to treat the
merge as a single [large] commit and not try to bisect-rebase on the
merge author's branch side.  But if you're looking for a slow-rebase or
a bisect-rebase then chances are you're doing (a), and if the upstream
doesn't have linear history then you accept the trouble.

> I wonder if it would make sense to have a rebase-bisect (bisect-rebase?)

We had a whole sub-thread on this thread about just that! :)

> command that finds the first commit that the branch cannot be cleanly
> rebased onto, optionally with a test command to see if there are semantic
> conflicts.
> 
> So given
> 
>     A --- B --- C --- D --- E --- F (main)
>       \
>         a --- b --- c (feature)
> 
> I'd like to be able to use "git bisect rebase main -x 'make check'" to
> attempt rebasing onto D first, and continue on to B or E, depending on
> whether the merge goes cleanly and "make check" succeeds, maybe with an
> option to try F first if the resolution is trivial.

I linked to my version of this, then Alejandro re-wrote it, on this
thread.

I've used mine a few times to rebase across thousands of upstream
commits.  It works very well, IMO.

Nico
-- 

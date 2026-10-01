Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244C470134
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872561; cv=none; b=lNBclgKZfiSYQ+G0f8vr7v2ObfIgLTJ4A1xazwMhsL8vBgej6+eKW55ULe8kBnqwKIuvViVIkH9omOjY2fyhpGE5RwaK63ZiqbRn3xTj54aLvQEFti88g02vGKXv+G4y9N12s3M1I3uKpIJ3XFhYZcvwF2hgYC1q4YhSdinkLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872561; c=relaxed/simple;
	bh=PHhuI9bFFDYLqTdk9PYUchromDk6rN1WEvAxFvGW2GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvCPRORlHukk3EsLRVIwtR+FINduCEluZabRADUZ8e6HgQnlm6L5yafijaQk2TMRI1meGvZNoJH7waTo+EBqw9MHN/DT06AzEGa71Xr3w+t72MkDCo7Onp1tZTAjQ6/wZ/CHXBcvQhUnF9cWBY6u3jvaffnkgpTNziVF1eRutKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=fGd1Rq/l; arc=none smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="fGd1Rq/l"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9A016801426;
	Thu, 01 Oct 2026 16:11:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a225.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.96.5.35])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 53D658011CF;
	Thu, 01 Oct 2026 16:11:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Duck-Coil: 32a190c02e0ba6c0_1790871062518_891080237
X-MC-Loop-Signature: 1790871062518:2999479676
X-MC-Ingress-Time: 1790871062518
Received: from pdx1-sub0-mail-a225.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.5.35 (trex/8.0.2);
	Thu, 01 Oct 2026 16:11:02 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a225.dreamhost.com (Postfix) with ESMTPSA id 4hwcN54pLDz2D;
	Thu,  1 Oct 2026 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1790871062;
	bh=Y/Y0qyuHEafSJNDFR9bgBc7MLdH0CAI1vaaG0DhWpAg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fGd1Rq/ldE3HE7vzfm5bmXQZJwNxehY909X1WTpiq0FftOnE5y4KX0TOTV6tsejYD
	 jj8mbDZFao2E9Id8x/xuV8OLROBjs95uoiiMt9L2AlmA4c/gDuN/EyG3QbVsfp5+fj
	 szaz7lrhqHChLg8iPFEIlwjVDadKtaSuMjZYPhzw09fOQcd65ptVHMkuUDXmpWfWIx
	 fw5BZ0ngG/NDflizr5byZeTGrMopywgdFTpE1CX0zE+DE3YVitVf42YM+TG3Wbs78g
	 40nwUoixj1exVMrP7WwQJ3i/rw+8LvE5H0KR8WkAXWIomvsRolOgjGDDfEQuVZ1kmQ
	 eqBSbIwRs6UBg==
Date: Thu, 1 Oct 2026 11:10:59 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar6GExDLasWWFajm@ubby>
References: <ar5KL4_IKXYbx3Sb@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar5KL4_IKXYbx3Sb@debian>

On Thu, Oct 01, 2026 at 01:58:42PM +0200, Alejandro Colomar wrote:
> I use this little command to apply iterative rebases, which are easier
> to handle when there are large conflicts.  Are you interested in it?
> 
> 	$ cat $(which git-rebase-walk)
> 	#!/bin/bash
> 
> 	set -Eeufo pipefail;
> 
> 	git merge-base HEAD "$1" \
> 	| xargs -I{} git log --oneline {}.."$1" \
> 	| cut -f1 -d' ' \
> 	| tac \
> 	| while read -r c; do
> 		git rebase "$c";
> 	done;

You could simplify this pipeline to:

    git log --reverse --format=%H $(git merge-base HEAD "$1").."$1" |
    while read c; do git rebase "$c"; done

But:

 - you need to add conflict handling
 - this is very slow

I've tried this before, so I know it's very slow if you're rebasing
across thousands of upstream commits!

Also, you need some extra handling of conflicts.

> The source code is trivial, so I guess I don't need to explain much.
> It behaves quite nicely, IME.

It can be much too slow.  I've a better solution: bisect-rebase.sh:

https://gist.github.com/nicowilliams/ea2fa2b445c2db50d2ee6509c3526297

(The first revision of that gist is slow-rebase.sh, which is a linear
rebase like the one you posted.)

This script very efficiently finds the firts upstream commit that your
branch conflicts with, asks the user to resolve conflicts, then resumes
rebasing.

So let's say that your upstream has 1,000 commits you need to rebase
across, and 10 of those introduce conflicts (assume there's no reverts
of those for now), then this script will ask you to resolve conflicts 10
times, and each time it's clear which pair of local and upstream commits
conflict so you have the best possible context for conflict resolution.

It's like git-imerge, but better in that it's specifically geared to
rebase workflows.

I've successfully used this bisect-rebase.sh script to rebase a
postgresql fork across between 1,000 and 2,000 commits twice, each time
with significant conflicts to resolve that were much too difficult to
resolve with a plain rebase.  I.e., a plain `git rebase origin/master`
produced large conflicts where I didn't have enough context, but
bisect-rebase.sh let me resolve much smaller conflicts with a new base
that immediately introduced those conflicts, so I always had the right
context for resolving them.

PG is a perfect test case for this sort of thing because it's so large
and moves so fast.

Nico
-- 

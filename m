Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C930E82B
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303426; cv=none; b=QAchFIw0CCjUKrQ8hZRtKxDat5heGBlE9N0dWsO+nYe0NGtdUYwqON2khb9liW0SOHrCRqd/nYG93U5Tx906VR+s16lzqpmYnQQv8bdS3rQnUoY4FREWO2O2+31Fe7wg2jrkE079TEQY9elgh9XJl0UwHO7AEdynbG6ArAnAauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303426; c=relaxed/simple;
	bh=V3jW0U/zbM1tjD2sbj+8jIqTTP1QcY9CFfIvqpz5Lng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/n8nd311brdXRbASH490/CQc0rWFymbNtp8+k/hNEkMyWaYPjFkk2faltQjC3VNvg/CPJw6mln4ZI+17He1ubyYyS6x1stBBrPlg2nxpYP0/HvXsNhkzl8dlt2e790ybBCpdh4QbBrHBcjk6BTRlUZETm/iJQPGwLDUjWaJHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=UOfBkh9K; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="UOfBkh9K"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 38B8B402A48;
	Tue, 06 Oct 2026 14:58:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (100-96-12-87.trex-nlb.outbound.svc.cluster.local [100.96.12.87])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E32A7401899;
	Tue, 06 Oct 2026 14:58:26 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Descriptive: 324858a6594a9016_1791298707122_2302347379
X-MC-Loop-Signature: 1791298707122:3062577904
X-MC-Ingress-Time: 1791298707122
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.12.87 (trex/8.0.2);
	Tue, 06 Oct 2026 14:58:27 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4hzfX21xz8z2f;
	Tue,  6 Oct 2026 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791298706;
	bh=PKCbe04VV5bwFgWOQwZRvUbLzdRXIbqqZfq6rw3dZeI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=UOfBkh9Kdk0DkMPCyI5n+32ygUeWGYjwa/i8Sxz+7BOQLbiEO1tbMPJ0TxmhBDR9j
	 IbnCaDktJ5NuutC9oBK3Iwk2h1a96Ku20wwo5hGDTucIfVxXSq1W8nmJ3WSUf0BcWv
	 X6LnM9pzR509qAVNUDwxy4CI5/LYyfhObfgb3LWjWGf1ArXW3FRAqfFCC6Vwqnwv0R
	 f3VPPPAmG1bHMdiIrz5mNB63In4z6d6p0IyMZXUhIZzL2HKyPa3IwoZkgs15XdaHyn
	 1nAMnW0Om+EUJfHvmeT2/aHRK8uXkcI40N1Xk3rDymEP/V7a/DZ9OE1upzPM9czfKU
	 N3aeb/XSTXOyQ==
Date: Tue, 6 Oct 2026 09:58:24 -0500
From: Nico Williams <nico@cryptonector.com>
To: phillip.wood@dunelm.org.uk
Cc: Alejandro Colomar <alx@kernel.org>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <asUMkBi9NG0k6fu4@ubby>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
 <95796d0d-5928-4108-bc27-b7ace4459d2a@gmail.com>
 <asOaLyiJUmINFFFH@debian>
 <asOnp8ed6AGStH60@debian>
 <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792f4d41-bd60-4fae-a426-bd70cbad996c@gmail.com>

On Tue, Oct 06, 2026 at 03:01:29PM +0100, Phillip Wood wrote:
> On 05/10/2026 14:37, Alejandro Colomar wrote:
> > > Below is a shell session performing such a rebase, which hopefully shows
> > > why I need this to be multi-shot.
> 
> To me it shows that we need to improve "git rebase --update-refs" so that it
> can rebase a tree of branches automatically. Doing it manually is labor
> intensive and error-prone (your example output shows it is easy to forget
> when you're meant to be resolving a conflict instead aborting the rebase and
> checking out another branch). In the example below
> 
>     git rebase --update-refs --rebase-merges main B
> 
> will rebase A and B, but we don't have a way of including C.

But it's not the same problem.  This isn't about rebasing a set of
stacked branches all at once.  This is about rebasing quickly across
thousands of upstream commits.

Naturally one _could_ use `--update-refs` with a bisect-rebase.  The two
features are orthogonal.

I've been using this bisect-rebase script to rebase an old branch off PG
to the latest upstream -- that's 10,135 commits in my case(!).

> > > On the simpler case of a single branch, I'd still prefer a multi-shot
> > > approach where --continue only advances one rebase operation, because at
> > > the end of it I want to stop, and check git-range-diff(1) to make sure
> > > it all makes sense.
> 
> Perhaps we could insert "break" commands after each branch is rebased so the
> user can check the range-diff.

The bisect-rebase scripts do stop when a conflict is found that the user
should resolve.  The noise from the bisection's search for that
appropriate commit is not that interesting except as a sort of progress
meter.  Stopping at each point in the bisection where the bisection
would continue is not going to be that useful unless the user could
check if the conflicts are simple and obvious enough at each point and
skip the rest of the bisection -- is that your idea?  But if so then the
bisection will be very painful if the user would mostly elect to
continue it.  That could be an option -- if it works, great, and if not
start over without that option.

Nico
-- 

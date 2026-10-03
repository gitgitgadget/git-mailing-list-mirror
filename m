Received: from glass.ash.relay.mailchannels.net (glass.ash.relay.mailchannels.net [23.83.222.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBC372661
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062253; cv=none; b=PK99b8pCcuxN3MReiMcYTbNFzdg+XaXpt4KUYhLjAOEq6zshOxNuGt+HrSWZQSbLWUvtG4mH7jACV/aF6J4qF+UjcUrWCRWE3gyOhUcdgHffNhJpfo5V4eH/C3nSyuIfAU3aYj3V/V6+j1TFhvwXZ7CXlbqSAoZs1vkCLRH21Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062253; c=relaxed/simple;
	bh=/G0kaBecXrRK+Wv3iDCtIBb9XyYhtPtBPR4dWo1iEkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwWpRxZnyLSfYv1y+8ZfuzC8x2eEDb3DxlaO/qbCkS62LYfv+Q5IBUtwKslx4fwwezbP9jV2+yM65Rit0B3xG+sVBEvJ9ptJr3yZlkrf9pHNHQ9SeEqw6+revSh/tUIyUD94w/GC8NacunNtUo6jo70IvMzsqJ1HN2YSRxaDvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=t7opFO/h; arc=none smtp.client-ip=23.83.222.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="t7opFO/h"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6A7A46268C;
	Sat, 03 Oct 2026 21:17:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-96-9-38.trex-nlb.outbound.svc.cluster.local [100.96.9.38])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4243762AB8;
	Sat, 03 Oct 2026 21:17:25 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Versed: 7086121e4d9fa700_1791062245327_2464733767
X-MC-Loop-Signature: 1791062245327:1961212498
X-MC-Ingress-Time: 1791062245327
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.9.38 (trex/8.0.2);
	Sat, 03 Oct 2026 21:17:25 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hxz4h41mdzWs;
	Sat,  3 Oct 2026 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791062245;
	bh=W/ri64Woei5tBWbhpynL8m6EjS7hIvTWDP3clKrgfbc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=t7opFO/hsvX2x37iY9g371dLOTndgMhqtKVkEnF3/xPt0nicLMgnOAMNpo95sd3ws
	 RAJ59my682mS4F/t6YRhDEVwFM8ox4Q/IL+9CqaB3PI9u8i2qB6klL82KsZjoj4Mrn
	 9l/U2HIH0PGlTElOrDTytvCw0MZDhHF41vdVj1NGsAMYhrA6hPcxDkJQXb83x4Ky07
	 hIxAMuhugZwHvHdGpwFFP4/yyr/uLEJDnZ+oAnoCSONmIgjzYzqp0Eb1LBxv5RNleA
	 Gp4usHlDWTo9DAv81nUFKmk3SON0PoP1p30EF+9ZM9ajjv1z6ZkvYbFCq+q3piQ2l3
	 JuUo+V4wwjc9Q==
Date: Sat, 3 Oct 2026 16:17:22 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ben Boeckel <mathstuf@gmail.com>,
	Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFw4gsn253MQtxp@ubby>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFqLv3hMEE7yEOC@ubby>
 <asFtLJDJliQBPe1c@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asFtLJDJliQBPe1c@debian>

On Sat, Oct 03, 2026 at 11:07:04PM +0200, Alejandro Colomar wrote:
> Since --abort doesn't go all the way back, I think --continue shouldn't
> continue all the way forward, for consistency.

Fair.

> If that's desired behavior, it should go in this tool, and not as part
> of git-rebase(1).  git-rebase(1) is a much simpler and much more
> fundamental tool, which is used to build this more complex tool.
> That's one reason I'm rather opposed to having this as part of
> git-rebase(1); it would confuse about the responsibility of
> git-rebase(1).  IMO, git-rebase(1) is a plumbing command, and
> git-brebase would be a porcelain thingy.
> 
> > If we take this approach then we'd need an option not to enable this
> > behavior but to disable it, something like `--direct`.
> 
> That hints it might be just be a different command.

If this was 2007, and you were writing the first version of `rebase`,
and you had already worked out that you wanted this feature, what would
you do then?  Would you make it the default?  I _think_ I would.

Basically, this makes rebasing much nicer, so why not make it the
default?

Nico
-- 

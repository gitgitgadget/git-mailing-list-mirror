Received: from guinea.cherry.relay.mailchannels.net (guinea.cherry.relay.mailchannels.net [23.83.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621827442
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791072669; cv=none; b=HbV3ZomNvn1esVkz6W+aUi36FJPDmU/wfuSwSm2THex8eiO/EDQfcObw+12hXp0IQEglxEQTf0c6BHZwLAEXG9re4bh8G5yE11As+JXNSNJl8Vx7sIH5OHV+Xkjv2y+LfaoMtYbyfEn1fmySg+l+QzHLoFabHm0VV9c9GMwoaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791072669; c=relaxed/simple;
	bh=4YG2lIIVf+Gntxru3aQb1J4zcv7E0GHnKwy5kG7GfWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAXrS4XCLSNw/iNb45h24sAjJlwh4+pBRvKdIRDqFIfQx5ks4V92p9boa6dyYg//zR14TcK+gt6AU8ruuNFBTuLqWsMlPfnoP4gZncdFPdM6MZOTyoA9UgMMfJkG5nYHmGcJebMreMmqhUkzqAKFU0Pf6NQpYwGbzWnCHqDQi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=iohTPwTr; arc=none smtp.client-ip=23.83.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="iohTPwTr"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EDF0F41E0E;
	Sat, 03 Oct 2026 21:50:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-96-18-116.trex-nlb.outbound.svc.cluster.local [100.96.18.116])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8A62A41EA9;
	Sat, 03 Oct 2026 21:50:27 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Spill: 6e8fb0bd534a7339_1791064227791_2169948934
X-MC-Loop-Signature: 1791064227791:904747358
X-MC-Ingress-Time: 1791064227791
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.18.116 (trex/8.0.2);
	Sat, 03 Oct 2026 21:50:27 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hxzpp5zMMzPw;
	Sat,  3 Oct 2026 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791064227;
	bh=kyN8Z63InXeumQlr3YDu4eyQ7d5E4spmymGkV2dBzqo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=iohTPwTr/NHIpiBiRDleDoKRujxmx/qSxslu0zABE7S8NjZyM0Sf2BdSvg8n3/qmH
	 Msfo5KNgjC6RFFXWAKI0F5gSHIzOWrMoqXYh/wow/5+bUDj/3/4ch1dDFFnehK1NRM
	 aWJoa8jFyCDHUR2nuBMWizWf9+dTsfEamH9kaCp3PSO16slnzHR96j+coF3E1r+ffR
	 H1Y7WLu+D0RQlchcClRnM414358wRY5TC4EXgKlnAbUZDUwLUPFtKM00V+pTAO0Cnl
	 8IRUg/XV+DxxQhInJsbEwG/m/MTggU3tawoztuRxovJfBHHtCmyAXtEqgzVzhikMGX
	 FW0Ir5CGuDVzQ==
Date: Sat, 3 Oct 2026 16:50:24 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ben Boeckel <mathstuf@gmail.com>,
	Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asF4oOejC7CNqaYu@ubby>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFqLv3hMEE7yEOC@ubby>
 <asFtLJDJliQBPe1c@debian>
 <asFw4gsn253MQtxp@ubby>
 <asFy2kOZe7WDy38I@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asFy2kOZe7WDy38I@debian>

On Sat, Oct 03, 2026 at 11:29:40PM +0200, Alejandro Colomar wrote:
> I'm currently defaulting to brebase for every rebase I want to do.
> 
> However, I still use the regular git-rebase(1) for more precise
> operations.  To be specific, I use it for changing history (without
> moving the base), and I also use it for resolving conflicts as part of
> a git-brebase operation.  They seem to me to be different tools, even
> though they're clearly related.

I see now.  Though, of course, if I use git-rebase but don't change the
base, then obviously I want a plain rebase.  But, ok.


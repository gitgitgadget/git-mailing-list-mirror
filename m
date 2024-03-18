Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7628DA6
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751933; cv=none; b=nRRfXRe39Ebu5ytrx9jxM3Vr/WPCxUSTVLQUk8WZS91QhZVXzta9K+ImcBileydsZbczcEuzO5OXZyJiVZT4qDbdgyDzVFBGFm1oFuKwla765ttRtNYPPKx6wIWSjRdPfcoSG+QHFlbabU965pn8qSRyssvqjFPSdqviah6BSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751933; c=relaxed/simple;
	bh=TqopP3xB9/8RZPwnJciTB/nlORuDkdN5zGIN+NhNN68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flmiBA3jPJn94vxNbhbKC6llTYeIjE7K0tgGSGhcuo2akRrwNLeHY6S+vGK2zVIVlAuIn19p/vPkvHQsL1Pv7Ha+zPDQgAURqBELqogZjhEcO8wzojxyQTo/A2UbDmR8d/WfMC29LROnwzubYW/yHIb3OIHMI5Y+iEWrZ3KAn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9022 invoked by uid 109); 18 Mar 2024 08:52:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Mar 2024 08:52:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26718 invoked by uid 111); 18 Mar 2024 08:52:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Mar 2024 04:52:13 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Mar 2024 04:52:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #04; Fri, 15)
Message-ID: <20240318085208.GA604917@coredump.intra.peff.net>
References: <xmqqedcbnhsq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedcbnhsq.fsf@gitster.g>

On Fri, Mar 15, 2024 at 05:26:13PM -0700, Junio C Hamano wrote:

> * jk/doc-remote-helper-object-format-option (2024-03-10) 2 commits
>  - doc/gitremote-helpers: match object-format option docs to code
>  - t5801: fix object-format handling in git-remote-testgit
> 
>  The implementation and documentation of "object-format" option
>  exchange between the Git itself and its remote helpers did not
>  quite match.
> 
>  What's the conclusion of this one???
>  cf. <20240312074513.GA47852@coredump.intra.peff.net>
>  cf. <87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
>  source: <20240307084735.GA2072130@coredump.intra.peff.net>

Expect a re-roll for this one. After the discussion in the thread, I
think we can clean up the code a bit, too.

-Peff

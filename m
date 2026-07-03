Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED82E3C10A0
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078059; cv=none; b=GklaxHaMCsoiIrSbYFlDMAIT0VkVT/luy6EYzmQwp8zYzsA7YlzMfAvxKbK5q3QlG/emb7E90Qe3o6O2yrgIVeLoJthaXd3ctlLO/5cz1CWqnpSR9kH75HcIQ2aELsTAo+bbtdr7AxI7N64EkvZusob5Lzxu6nIvkvwMH+Ly4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078059; c=relaxed/simple;
	bh=WBYy9aISFRColKHt6GkfvWCOxRm9I38KojzOn0qbUWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ1fK2xN8/C112GM501t7m5V0LomeutkIjhLMeFWHdokBlnbcjDuKpv1DoeRPymwOMn3K18zrQQ8W4RsdE9GENXOTJPIUW3z+LhMG4UJGS71h2knkktIYv/Q2YiuKMfSSKfPr6WqdUP9gq18J1LbD6qbkZ9O5CcLSFMTvW9Xons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oC2vaUWL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WumP3A1B; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oC2vaUWL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WumP3A1B"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BCD17A012F;
	Fri,  3 Jul 2026 07:27:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 07:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783078054; x=1783164454; bh=P8cSpCQRDZ
	EVLtayJQ7zJVoe3lNEnByS1+tvYu9SOMI=; b=oC2vaUWL3LgHm/jDwO+ojytY6h
	y8kNvKAw3cCFTqvJ0tO8ILWmi9ltmuH/hdZmQJjzhZ2/8GzsIitXzwOQOgFuI75i
	huWIRVZ3OjzAwnjFf7LRkMi0XgiaGkm6WJ/7telHAI0DhjCFq7NLGHjJJFBAniDa
	elKyW/tlosrFaqvmSpKWRjoFEJTUW9AySdj0r3InX760D2rFLJukSVyccJ090inu
	/cAytNFhnHQPuTPoDQqI7krOND1JtsmCg4E7rvBTeVHKmJAWVajW7oLfYeP6Cwhe
	gP5tV8mxDQcM7z+fOZKnQ/7YY7NtYhDk2k2Ilhxm7QsMwwyzg3MOOQWD0lGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783078054; x=1783164454; bh=P8cSpCQRDZEVLtayJQ7zJVoe3lNEnByS1+t
	vYu9SOMI=; b=WumP3A1BUeY1Hs5sC1vExZw5IkM4z+bGppxMdbWx9hOcLkg46FG
	R1JdL5i5fEHRLMvZmAcKyNP2mFuXBUIT1ei6JYuhNgZMEF8wa7GR22XJcd/b0B25
	sncHv7/IvOslSnJJn/5LeND5H19yNRjz77VpZv0Wao0jSFKurlV48lK+MfS32D04
	iGRLSvx9F0lngsTAFMZjwUORPqvX7iY62yK5YuYEo1WQ50KTlSfEa+YU799wOiNK
	UZoxrE5N8QLbMjVi+Ek8C2OT+Pky1ftX4rOnYxIDpknXKyfgcaEdxlxr+bLEeRhP
	PF8Q6VhHWZLY//ES9Yyf3IMt+gQ3mMY9eKg==
X-ME-Sender: <xms:ppxHavi2IwnaQi5NUHzTJJANkPjoFLH_4eaS9iolWsSTGSmFc4OM6Q>
    <xme:ppxHaiBXy4_SlDYh7OiEQ50bQUcPOgcuWmPaAK5rKRRGzN42wtW3xi2gQdsATwTN8
    55Q_j9k2v77YW83hwHhxtr_-Pw4zNSYrufHCyvjRiOVQI7PJbhydQ>
X-ME-Received: <xmr:ppxHasvOoy97shvWq_V2_VukWna-E-pSPtTlvtNtavdtuaiQ0WDfYNEWcPHAvvql27D4FMSDkFwG1pRisqlawGqwC6J49TFRIdgK4_qurQ>
X-ME-Proxy-Cause: dmFkZTFUH3EXMKFe/q2TjJXSO31Gm+6009hwuY+1CQ/T3pzb0jSEDLBuXP7G1H9igjjzu/
    ByF0toCxcnPPzN3ihujVnZrjEM3IZwGEtlucKjhCRY/K3f0mG8//c89cpqRwEvI/RGmTZB
    oZPK7/WdOc8j7acmF1/TVgzE0GY7CHL6nAib55GU2XMa9l2a3dnCo/EEPFhLBPoKKADZoU
    MaOLn2wbAjpCJsbj/Etwz42qxZjWFpl6GyDpAfcs5V1/7bw0/d6WEJiU9vsNm1ZQqBtTjf
    +6TiIV8wDQ8IK7p6yvcK2RpEC6vxTGfefs/mjniQsFVxvphXiEGPMlcla7iQggYttSFyhr
    w7BzArvu0KxXJZexrYzYjgszd/KOHF1GdFuPOVcU6jqRsg9vcUG6w0LBMdhD//L+KAgS9X
    PNpIFCysXLxWvtvl13/B+4PA39PmwqDZDi5v1sJoj6KAnLlT6EzKgQVZu+28nZK6KL7nZP
    2kuiWF2DNH6IWD8ZhsJ89rpMTZnQEe1OZ22bKWKc14CZwbB+R5vmWu9xhzKs/bhsbN4jkb
    +urzhvDCmOzbPyScrYi6EQwh7yoLmpr7HK3H1BMlThCRm+SQPC6ukVFAiNPUQt4mDsD4PB
    zMhAMO/+4y79OShXaZI751bq+2nIiVB+or3quJvwjL2LsF98SjaFzZrtILuA
X-ME-Proxy: <xmx:ppxHana3h0nri9uzpdpqGfc7NyYXrQXiM95BfZddLJ9PDBS6AUmHKQ>
    <xmx:ppxHavWeK5wmzMdN2YJDcjOiYsZhuPQm-9hM59kFwZb3syl_3xSCRg>
    <xmx:ppxHar631kwL9OVleXKqPQX4lxCQigl-1zKwOP98mfAalvNHpAEtJA>
    <xmx:ppxHaqiiPaPBj5KHmaosOn5sK-dHW1C4mrWizytkexGtEuR7nuZOgg>
    <xmx:ppxHagCsPdwDfgEDGWmeN_3yNDz6Cl_4qdXFgyQvZQVCE6VMGFKUlHHe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 07:27:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3953e1c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 11:27:32 +0000 (UTC)
Date: Fri, 3 Jul 2026 13:27:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/9] csum-file: provide a function to release checkpoints
Message-ID: <akecoptZrCq1PcFV@pks.im>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702080319.GD2029434@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702080319.GD2029434@coredump.intra.peff.net>

On Thu, Jul 02, 2026 at 04:03:19AM -0400, Jeff King wrote:
> A hashfile_checkpoint struct is basically just a copy of the hash_ctx
> state at a given point in the file. As such, it contains its own
> git_hash_ctx which may (depending on the underlying hash implementation)
> need to be discarded when we're done with it.
> 
> Let's add a "release" function which cleans up the hash context it
> holds. I chose "release" here and not "discard" because you'd use this
> to clean up every checkpoint, whether you used it or not. As opposed to
> git_hash_discard(), which is needed only if you didn't call
> git_hash_final().

Okay, I was wondering about that a bit. With this explanation I'm also
somewhat fine with the `git_hash_discard()` name. It's still a function
that has release semantics, but you want to convey more intent than
that.

One thing I was wondering: is it safe to have a `git_hash_discard()`
that is being called on a potentially-already-discarded hash? If so, we
wouldn't have to discern whether the hash context was used successfully
or not.

Patrick

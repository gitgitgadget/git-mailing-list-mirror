Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44368248871
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401498; cv=none; b=gwCGiUFe4OYqMUgeV06s1osExSJd7KQdYxzBAsTLcN2nSkiQkK8FUB6brrznUgiNk2Ro19qUlcgSyIH+eQEqNlzDQTAu6JPx0VvDj1shEHi9J9NEate+Ouw2fqSnnkuN3r+TQkxfL0dysSz5cQnmhekI8R3IPmcGtu+tjbTdjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401498; c=relaxed/simple;
	bh=upFJs/hKDUmw/SW54lFP5+T9k6cuX2vU+UD5I1XeGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9jYh+iYASWOx6g0qB6wY1cr1It5bti03K0NVYbVumllqatW780an8p8kXUs3+Wko91CfzDTCsSr+GrrfbW6eQKW2Ol8dLPWxv6lxeUk+yOFCAp5BV3EpDE2oWsnSg9Dc9X3O1ZHJGEOmSVAG2buYxSzpV8zTdUtQaxf+Hd2cxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dsdpo+gR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dsdpo+gR"
Received: (qmail 11935 invoked by uid 109); 5 Aug 2025 13:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=upFJs/hKDUmw/SW54lFP5+T9k6cuX2vU+UD5I1XeGZw=; b=Dsdpo+gRs+4QCJahFcCcpViF7bJNn6WIyKQdOH4h2MK5RLX1gwTGGkitxkvYxhKJXql64IA2yECJcdHGupkIez4HMEMmzmGi/yQOAd2SByU6Q9xfNiHDqI8Ehc61SqtNJiytH+XdIx+56pWhdLrc6BLnTsDG8Sa63W57TE9zxAl/wb0oOd8LS3XL9N2sk+Wqak0b748Ra4D/rrFTWOZ4RZ9SBBuopL4fPvE/Fr4nODhdnkDRrwVgSKhWYR3CoyaVI1aWs3mqgrS9etyngj4grkOt8Q+HCjs/PSKCeUidrhybyfkk3H8AnXXbqjp1KDAeoP99eq3vGJGqBy5Ywwq0xg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Aug 2025 13:44:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6186 invoked by uid 111); 5 Aug 2025 13:44:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Aug 2025 09:44:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Aug 2025 09:44:54 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
Message-ID: <20250805134454.GA1340331@coredump.intra.peff.net>
References: <xmqqms8fbilv.fsf@gitster.g>
 <aJCBlnHp-db4Nd5w@pks.im>
 <xmqqqzxr88jg.fsf@gitster.g>
 <aJDI16RBR9QKdtW9@pks.im>
 <20250804154129.GC109984@coredump.intra.peff.net>
 <xmqqectq4ne9.fsf@gitster.g>
 <aJIBlIDto33lJEuK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJIBlIDto33lJEuK@pks.im>

On Tue, Aug 05, 2025 at 03:05:24PM +0200, Patrick Steinhardt wrote:

> I am a bit torn overall. We _are_ talking about a race, even though it
> is an implicit race because the user didn't explicitly ask for the ref
> to be updated. So aborting the transaction is reasonable from my
> perspective. But as Peff noted the user didn't ask for it explicitly, so
> it may be surprising if we abort due to a concurrent update of HEAD.
> 
> Ultimately I'd claim that no end user will ever see this happen in
> practice. You'd have to change HEAD at the same point in time as you
> write a new commit directly to the branch that it's pointing to. That
> is, git-commit(1) wouldn't even be able to trigger this case as that
> command commits to HEAD, not to its target. And just to confirm my
> claim: setting a breakpoint in `split_head_update()` and then executing
> "git commit" doesn't trigger that function.

Yes, I think it's pretty unlikely on the client, where almost all of
your ref updates are either via HEAD (because you're committing), or to
remote tracking branches via fetch (and we never point HEAD there).

The more likely case is a server where one user is pushing and another
updates HEAD (to set the default branch for clones, etc). But those
sorts of updates to HEAD are going to be rather rare there, as well.

So I agree it's not that likely to come up much in practice.

> So with that knowledge I'd rather do the safe thing and abort the
> transaction. It requires less hard-to-test logic and feels safer
> overall.

I'm OK with that.

> If we agree on that I can send a final reroll that reverts back to the
> logic we had in v3, which did abort the transaction.

Yep, sounds good.

-Peff

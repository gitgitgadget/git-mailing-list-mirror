Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7215155330
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129670; cv=pass; b=mhhXyMVPfreuo5ST6LeM4GcCrFUjScioJEwZLUozvFEdAU5vALnR3FIS3+46yn06bze3I+R10sRNrD8rTJUHWq9LZSbkKLT6dxmgn1VXp8/+ZrOQ6gX6UfR82Zx0hgco/IdHb/6IGEKkSqZQ5LgBwsi/PhsQ46kCtNjj/DbaemI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129670; c=relaxed/simple;
	bh=BoWZF2tRsQdesOT8cBLRbZWafVCfotrSXH+H4paKDl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t28TmrP1AXUGUdRDbNvayyPyVi6k/KfsDLFvf5E9d5eXyTKi6H+u4AlCjQGdu85OSrCvIEvZNNQ7q4dSyx1U1j5ptV4e0XPjrp9Irmj5FrHwobF1nJfxpe7RGZcbhef5AAljwDu92IcPQuGSf0hefxoBxpYEjBQPYgBgu32g8CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=CkGLGIsG; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="CkGLGIsG"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 90D7D1C1D60;
	Tue,  8 Apr 2025 16:27:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.99.49.173])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EE84D1C3D34;
	Tue,  8 Apr 2025 16:27:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744129662; a=rsa-sha256;
	cv=none;
	b=pzbyC3LTxHs+hJHbi5/27GJtBhdif/e/7/V1Q/yCWc1vST+MgHTMq2sHWMw+4PyejbkMjO
	LFAMU3iU718fN8pdIDyT3EhXGdvuml+6WaECcDpaN4+RSwBMicthlgiRRQaKirB7+dYm2t
	IXz08L/kyWZHbusbQm9tJ5s1tFT8m+gusQzvPiFG+zxKLdTK0aNSTARtkSZfWdAl/8QaR5
	3pKXWNYsH4Y33rKapf+3xqg0pR+I9zq2pi1KduMVgmO8JEnaXgMLaAlfVU7OAwKxGTzzGG
	ou65V0SC6zfL0e/SZ0DSLC8OjWiDdaUBH0pPq6vPBfGY4iKWgzRpayLZJKg+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744129662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=p0QDoJAKRDtIQNKhsrK0LjpZW3ANTTGt0uJFMdzKTIo=;
	b=qw/0IVsp/E0MztcoiNRrAHLARDUhqWmaGhjq4NYcC5hhgx/9FkjYNar7oOnO3vDJc+g1Ce
	wIwAc3EI5a1upO9EJYL8E39Q+u9+nTdzuQnIJ/7pL3HInlkOdDnnclPi8VdD95j9SRT0ii
	ULqber1zVrNQoyGiyX2tqhkLFdHnH8kUhQZFaqJaYnTB21U/EwVDS4qqH4yTgAu0/2R6+P
	Ed6V6bzntITq6ed4f0G5p7xvRg+DnMLKkJo0QUw3eF9vN2fn07r3mC9gqF39Ozh01a8AKd
	96TgCU937BLzrOSO3VBA8vUlqomT1lya0tNG0VSMMDnpVAN/oIgYfOah6RCt9A==
ARC-Authentication-Results: i=1;
	rspamd-6c88b8f79f-fqf6v;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Average: 550d123477647c68_1744129662253_2078630590
X-MC-Loop-Signature: 1744129662253:1592748125
X-MC-Ingress-Time: 1744129662252
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.49.173 (trex/7.0.3);
	Tue, 08 Apr 2025 16:27:42 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4ZXBM06TpJzFT;
	Tue,  8 Apr 2025 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1744129661;
	bh=p0QDoJAKRDtIQNKhsrK0LjpZW3ANTTGt0uJFMdzKTIo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=CkGLGIsG3hKgcKglYLx00YmAiIPlpe8JL0sILNODEAeB1A6NNFMYvEe6fdyTTPsfM
	 Qi0g6vKwFWgDlcsQkXFnD/Nv9uK4BJHKBWWdTg3qEweQy8IK2PmMmgrQBpbxGgwTks
	 O/ruEvv+m2MsI7wSY1YzD34P0nX8479JXxNEzXPKQpqkYxxuvga3SgNLeQthpjLuf7
	 CjRjLYj59unKGg5fSj/RGtv4geoQaUK1teJToOHevxq/g4diJ0dSABLrutnvgDRVqn
	 lUWSEvw86AsWUvS92R0OhyCklCLUpZZBErVkmCpcSYEvHkqCav9DRQgwzqcs/XjuEb
	 WvTXn1YyVvSzg==
Date: Tue, 8 Apr 2025 11:27:38 -0500
From: Nico Williams <nico@cryptonector.com>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z/VOekAaq+n45ex1@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <xmqqzfgrjyws.fsf@gitster.g>
 <CAESOdVC8m6VjQtyVi8O8bLWyJFaq7wnQ8U2kxW6SHnoXpCd14w@mail.gmail.com>
 <xmqqwmbuybhg.fsf@gitster.g>
 <3a5eeaef-05a1-4e04-8bc5-0d023e63f27c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5eeaef-05a1-4e04-8bc5-0d023e63f27c@gmail.com>

On Tue, Apr 08, 2025 at 04:58:58PM +0100, Phillip Wood wrote:
> On 08/04/2025 15:27, Junio C Hamano wrote:
> > Something like this should allow us avoid relying on "change ID"s
> > that can collide elsewhere in the world without having a central
> > authority to assign them.
> 
> This is similar in spirit to the "git evolve" proposal [1]. One of the
> objections to that was that it required all of the rewritten commits to be
> pushed back to the remote, rather than just the current version. So if I
> rewrite a branch three times and push the result for review all of the
> intermediate state gets pushed as well. That is because the intermediate
> commits were needed to track the chain of rewritten commits  to avoid the
> problem Elijah described [2] when trying to follow cherry-picked-from
> trailers. If the predecessor information was stored separately to the commit
> it refers to (in a notes ref for example) then we could in principle
> simplify the chain of rewrites when pushing so that we only need to push the
> final version of the commit and a mapping from the version that we fetched
> from the remote.

One might as well have a way to push reflogs.  But so much internal
history is just distracting.  Half the point of linear history upstream
is to drop all the internal history that no one should care about.

Even during code review this is too much and too distracting.  Some
users commit very often, and for them this would make their work rather
difficult to review.

> Tracking predecessors as you describe is certainly a more complete solution
> to tracking the evolution of commits and it addresses the shortcomings of
> change-ids you outlined in your previous mail. It is a lot more work to
> implement though.

There's also that.

IMO that's ETOOMUCH.  Just change IDs / series IDs should suffice.

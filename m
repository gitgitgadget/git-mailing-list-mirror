Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02D35836E
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592832; cv=pass; b=G1qf3iLUyRkUn21E9cUJytotxWEfy6/kr7TzhzqjOJDQ61BsDueDnyUX/8TxJUHzg/sHEjWbyXPYMdnnxm7I8SSKu6C3hda5LDwlP13NLSkqRFx359KsEpJHvwWoDL4lB9NsVeP6JrKxFhoJmVa6q4B9+lsXfF7p+1NVHH/BdNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592832; c=relaxed/simple;
	bh=IDttAmpaj2L2gZQzrlRG6C4C31Z01jIeLuNsCbMlIdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALHYyw0s1rxilL8SyGeU40Ui1z2uce+OTXvZkNzYx0vitvWqPoSgvb9yNlLmBv4HJ6/98DN9mXfG1Im1Ug5qnP/3jF0Kl19AQC63FXkc1V+n17kJyWMHJMyNphLEtteJCeHJL1LVpXSo/JPZFTFJGJfyzU0nohTqTgp3quqJMRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=ZvbwzD6P; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="ZvbwzD6P"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4A2EF224361;
	Tue, 07 Apr 2026 20:13:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (100-121-211-194.trex-nlb.outbound.svc.cluster.local [100.121.211.194])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C0401225186;
	Tue, 07 Apr 2026 20:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1775592823;
	b=Php4NbC0KU24CqdGQuo8wFtpXL8o6gAosYH4ozoGPqzP1WZaJKe7Nsa4x/LfDGwjUPbhmQ
	mA66/83fi+IfvO8a/Pv8aP0aeW0xkQwhzALxVHV8a21Q4OFeK18DcVVCPOdzUoOzLzuS1A
	Rzvc4jI0JRgil1CE8tUnZBdweYWAbGxugIyg6GGEpi1FM1oOPEy2GDO7Do6G15nrmusens
	s+cPXqNnXpIfLIlghOAEzie2kOEP5NpfCxJDvS1V9eoo6+afCHmI1FwkR7OdVxBiAcQYT3
	UUG2jGkFDXVzjYiQO8TqPGTPruLQux3DQdKdApImpX1f1O/rqcagPHCqHThQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1775592823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/BjGQjatwU/hPmj5g44EdAvAiY/YPQjXAFahkz3drJA=;
	b=H3TZFRPl3FxbHf45FbAS6yyNNIcTQ2oDWe5dDHyWb/2+VcBbADF/wGW5gL6o8wRzLZGmWp
	oC1mo5yJEVvUvuG27IX5ByNmjnkWDlHXN6IxYCtOHc7Q89noxiUxmoFrCIcz0vxCq/yZE1
	toA3S/RHOOjFiq/8uUP6Ga5BFpwGqBoIJfs4ERapqiYtNuGHM+TzF8Xw6SkQF3OZYvv34Y
	fx8ZiESHk3OKV0cJf9GVPVOm1Pzqfx+fq9Jaz5ic9Yoo2DAuqVEs9eASUVNLbhvBMqnToL
	2EtM7Hze+BMmvxT+SIQw4ZH8HqTNPUQzIVRu/kt7upVc/k32FDrPzD0MaKZNMg==
ARC-Authentication-Results: i=1;
	rspamd-7d86dcc447-fwgr6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Scare-Reign: 12131016459ed8d9_1775592824097_1956159044
X-MC-Loop-Signature: 1775592824097:267555371
X-MC-Ingress-Time: 1775592824096
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.211.194 (trex/7.1.5);
	Tue, 07 Apr 2026 20:13:44 +0000
Received: from ubby (unknown [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4fqy7p0463z107X;
	Tue,  7 Apr 2026 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1775592823;
	bh=/BjGQjatwU/hPmj5g44EdAvAiY/YPQjXAFahkz3drJA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ZvbwzD6Ppueku8GERIt/WW7MxMM9elSdaZdmVE5/lDkHwp8ZEUes1ym0IcLf9CGok
	 bOYHdEJeFTirMAdv6zG8WYioyW2dLjVLfujzJ6FfITlqM51uqZprO63eZXDJxo/Z1m
	 sPx71mo34W+QaRwPHSfYfG4IDhWo8OgM8I4FQq68zSM0u/8TdEdNQHh3L/j16bwMKj
	 eTYISfVBGaOUVeJmpZXmPTpVYNIYzTLcNxKnScBChjjfVqR9rBH8EYQe2lkcMRUXD/
	 ke5CQ10gmfRTjS3Vn1Id30fPswx9QALhIKym1D9qnfBe415RuTynZ1+HfppRHADgh1
	 YeY8BEkLTzcCQ==
Date: Tue, 7 Apr 2026 15:13:39 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Matt Stark <msta@google.com>,
	git@vger.kernel.org, ps@pks.im,
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
	Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
	philipmetzger@bluewin.ch, konstantin@linuxfoundation.org,
	newren@gmail.com, tytso@mit.edu, rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
Message-ID: <adVlc/y8HjvSG8KQ@ubby>
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
 <xmqqqzor76nh.fsf@gitster.g>
 <adSO6zPwtFOWBcOw@ubby>
 <68e5a1eb-ec7b-43ca-98d1-ffdf7fef013f@gmail.com>
 <adUoR/T17fKr+YLN@ubby>
 <xmqqtstm68to.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtstm68to.fsf@gitster.g>

On Tue, Apr 07, 2026 at 09:20:35AM -0700, Junio C Hamano wrote:
> Nico Williams <nico@cryptonector.com> writes:
> > Well, I said "site-local" and "for some definition of site", and the one
> > I had in mind is that the upstream provides this [default] configuration
> > for clones.  Sure, authors could override this locally, but presumably
> > they wouldn't, and presumably upstreams would check for adherence to
> > their rules.
> 
> This does sound quite sensible.  What you called "site", I called
> "project" in my earlier responses.
> 
> Some projects do already check that the changes are signed off with
> the "Signed-off-by" trailers.  If change-id or original-change-id or
> whatnot are deemed essential to a project, and are expected to be
> formatted in certain ways, the project will certainly validate them.

Cool!  Maybe we can achieve consensus.  Here's a strawman:

 - upstreams publish (where?) a set of policies for

    - change-id
    - original-change-id

   regarding:

    - commit splits
    - commit squashes
    - cherry-picks
    - rebases

 - these policies should reference named hooks that have to be locally
   installed in the clone (that way the upstream can't just cause
   arbitrary remote execution clone-side) -- hooks that can transform
   change IDs

We should probably also have options for cherry-pick and rebase that a
user can use to provide useful context such as "this is a backport to
...", or "this is for <ticket>" (adds change-id).

Hooks could do things like create child tickets, etc.

Punting all semantics to hooks and upstream policies leaves only generic
things to decide, namely: what operations call what hooks.  And that
should leave us nothing to argue passionately over.

> None of that requires us to hide this information in the commit
> object header, by the way.  And indeed, it is easier to validate
> what is in the "git log" output (where optional header elements like
> "encoding" are not shown).

Yes, for sure, this could just be commit message formatting practices
enforced by hooks.  In this case there should be a hook for extracting
change ID(s) from a commit message.

Nico
-- 

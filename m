Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025642E62C0
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718861; cv=pass; b=WpfCW4bmJOKDqHd+19gg0dfvet8ALC3UUnPuYWVVbuuCumoPgArNNB2+OVW3zxY8fh8xzqhEyEGl2SWbrkF5abEEwkkTdt59P0OptmJgiGMW62KEAfQ3tqPoH7K2/93OXnQm1ziOYlSDAt8Q5hL2UwIuqY49khVjbAJDslXiiqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718861; c=relaxed/simple;
	bh=hgJg1FN11/nrAaIGD6KaB8BHCIMLDRBrg5OLfbLV8UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXHG3DkJQQWjA/PK1amQmueXb7xg2o4mo3pwGKPkQM3QpaN0ZxFF3Y0svoJ4R4pWOGnHaXg/822WBhtkI6B2JQolRMbv8HCkBJyztlCwrMmWsLrq8W/J4akSm3rym+dzNm0JPJarslTlwKILhcq8fEgHJFmr7iokl4jrv7Yaiow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=aYuVvcN1; arc=pass smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="aYuVvcN1"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 20CF64E4C37;
	Thu,  3 Apr 2025 22:13:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a287.dreamhost.com (100-102-82-177.trex-nlb.outbound.svc.cluster.local [100.102.82.177])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A973D4E50BB;
	Thu,  3 Apr 2025 22:13:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743718426; a=rsa-sha256;
	cv=none;
	b=WvkzM6OFXgoy+9x81d6/WRWL1GY1tV5nM4P1EuWjI8UzycSk/bGY92viWeFKRGDgnYSSw3
	lKh2BGH0WLXwdkGS7YUUe3Ia8OXKufsONh4tBFWONJml8aIp7fGPW2isqrr4p51QBiSoGI
	3kYmMldoW6lQdmOk07QzdBloEWi8WJcPSg0lA88aWUPk4dvl1BgLB0hqp3yP0JDu9sIPyB
	1B4YxipTPissUslK5IzlaBAZiX911cXXUkAqPfRqhf3oS28fVYBxgq2hiuPdhJn1/yhfgw
	HEIlq+dqrsJkIjDirbNkwfn5J/CHFVGc5aozmXU5fewrccGzsKnUemUnrI4vJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743718426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zOv9GgGgdIkXTyhUOBXMht/z8mNmmLDrTvFzpLlGC28=;
	b=3RV6Vy3ut+QNIXodiScZ1SJhDJ4ljjaBAbShdUaAjvtonkmbsngbehktWqtbgOaeXuN1Ec
	saqYWIyIiByXYJsyhylH8hf9rd5tTu0DiWYLvHsqlBN/MXKHflFnLcVduL9mSKPO1dKcdx
	Bl539q7GpUJSeLOEj6Ql8fAa6t8DWxOrI0UohlRd2W2sOul93v1qHJwR6Ub99uyrL5Paun
	m1ZywASFCRkXIQc5sz0YcI6WkSzR7Onqge5IA+F6EW6IcSXhc4Ry0kH+pgoa3SmN3d3vhk
	oIUTL3dYVVNit7mBBHBz22OP8Ktt74YlCTXz15MO+wbrUF5Z8FcfptmdjbbAMQ==
ARC-Authentication-Results: i=1;
	rspamd-77c6b75dd6-q8ljg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Broad: 5423a1a75dad889d_1743718426978_434798806
X-MC-Loop-Signature: 1743718426978:1525711027
X-MC-Ingress-Time: 1743718426977
Received: from pdx1-sub0-mail-a287.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.82.177 (trex/7.0.3);
	Thu, 03 Apr 2025 22:13:46 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a287.dreamhost.com (Postfix) with ESMTPSA id 4ZTGGd5PxCz2V;
	Thu,  3 Apr 2025 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1743718426;
	bh=zOv9GgGgdIkXTyhUOBXMht/z8mNmmLDrTvFzpLlGC28=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=aYuVvcN1+WoN/MZNIiH5dE0iTJ1faQo278T6Mv7vfjlqOraAuY43WftH8VicizId8
	 wGISUyLm3E9sfx2TgigtY833wudbpvJBjIQzArqiv5cuCNYZ4tE8HLPOuepOdQiMlA
	 Ao1Ihrnk0k48Lk5JHQHq0qeqTKmKPd8WC2qjBDhXoK1NCqE3iwfuIsVJHHzu4OM7P4
	 4qNo01Hc3VEZxwAxw0Coe7qtwtIayPBrtiXi8gsbxZbn1hWJMi4oZhZNoVjbbMgdjj
	 P4Xsb+coBJRnyYCgm6JN0ogZdQ0SZsBzLn//qlljEP77cCNp2IzQW9fHDbyBoZF67m
	 dbL4OExNVHRew==
Date: Thu, 3 Apr 2025 17:13:43 -0500
From: Nico Williams <nico@cryptonector.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z+8IF67AC8gSouYc@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby>
 <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>

On Thu, Apr 03, 2025 at 03:05:41PM -0700, Martin von Zweigbergk wrote:
> On Thu, 3 Apr 2025 at 11:10, Nico Williams <nico@cryptonector.com> wrote:
> >
> > I agree that `git rebase main <change ID>; git switch <change ID>` is
> > not a good UI, and I wouldn't want it even though I want change IDs.
> 
> Why do you think it's not a good UI? Is it because the change ID isn't
> meaningful? That's correct, but they are also very convenient. The
> unique prefix is usually two letters or so, depending on how many
> "local" commits you have in your repo. That makes them easy to type. I
> basically never refer to a commit by a branch name anymore.

What would `git rebase main <change ID>` do?  I assumed that it would
find a commit `<change ID>` in the current branch and rebase it onto the
main branch.  That seems workable, I suppose.  It would be akin to
`git cherry-pick --from $branch --change-id $change_id`.

What would `git switch <change ID>` do?  `git switch` switches between
branches, but a change ID can't possibly identify a branch since many
commits could exist with the same change ID all in different branches.

> > > And if it does work, isn't it expensive since you'd need to walk
> > > history to find it?  Or do you keep an extra lookup table on the side
> > > somewhere?
> >
> > Worse: since there can be many commits with the same change ID they
> > can't be used as refs because Git can't possibly be expected to find
> > _the one_ you really intend -- how could it?  I suppose Git could let
> > you pick from a list, but that's not likely going to have enough
> > context.  Maybe Git could give you a list of named branches in which it
> > found some change ID's commits to pick one branch from, or maybe one
> > could `git cherry-pick --from $some_branch $cid` and have Git find the
> > commit(s) on `$some_branch` that match change ID `$cid`.
> 
> See my reply to Elijah. There's usually just one visible commit with a
> given change id a repo.

s/a repo/in a repo/ ?
s/a repo/in a branch/ ?

I'd expect many commits with the same change ID in a _repo_, but at most
one in a _branch_.  Except see my other comments about having a second
kind of change ID to identify a set of related commits (e.g., if you
have a rule that features, bug fixes, and tests all must go in separate
commits, which some do, so you might need to have a main commit for some
feature, several commits with fixes to earlier bugs required for that
feature, and several test commits, all related to that feature).

Nico
-- 

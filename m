Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA384267B00
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224685; cv=pass; b=ePuZdl650hy/sF0LZR/P/zJRrblx2bAFZRH9GpZVh0Pe68vMREZxd2x2VI28EWQ0Ljtk0Kt4dk4Bc07JeipSuraKdQaVwOqW6vQ35acrZXgRtzZcIKcJ1omGAODKagcdEUoLwLp/+UTYJ/BtsUT3QxMGn3LOxXEPDgwpMSbZrEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224685; c=relaxed/simple;
	bh=90ea44dyWEup8ZVokKQTK+QbprJV+5hClscpq8GC1Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPuoMXE/0LDA7gcjNq1I3UupoawmW2w4KVXEvlbRLj5pgGcQL7rgC1ysgctbjznKBGzDWN+XBoz3hwbNw9ZXNbcAfrEwfoeo4sW2uIEXYojzGpRd05c+g6/a3zXV9kIgDi8Am6yQ8JzH8Qlp/P0hzwVurti2U9RB7SsRETlE7sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=r2TkSLIT; arc=pass smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="r2TkSLIT"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B43288C4BD8;
	Wed,  9 Apr 2025 18:35:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-99-49-173.trex-nlb.outbound.svc.cluster.local [100.99.49.173])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 431A78C4C51;
	Wed,  9 Apr 2025 18:35:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744223749; a=rsa-sha256;
	cv=none;
	b=L+XjLNLyaOp5hfME2q6mtffFK6rHAGrm3F9swyc43InVT+kll6146LlezVxDQunGMUWzw5
	FReFa0tiqyivV3C7vrhu+le2uyrNiC9DCvj4iK/j9KlY5n4ja3rCsjTxbQQ9DKdVaqYXsb
	a6KIJ5hfJe8MD0u/BUYtcVjPHCMEve/8UQBSK9z5SnUNEvgxK35/6RadE8pHVg7BMck7pN
	N+JlulsCim8yO4Phhla/7QOt0oqTiXaIZ41hWlw/cCbTxgTOI1qWM1SZI5ht6AdEJ7sHkg
	rnqDKUwjneNMmjlUNUBHtiGncEJ6yVvDT4ERS0L8DuJVeIfbhGsn9uVNkgoqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744223749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Vev8XAOv7p4/GbWfWcVgQWKJWuKppO41pO9TEi+b04g=;
	b=KkUvbHpOQdE1rLC8HWIHeo6GxkxNbyWo5WhjoJbpyYICiyQ3hoKERr1aXPNbxDP/4mp4nx
	wlg7b4NenymqQQQqDn1mi1GcxR4wr1SD1l6VVvBIIMl0GRes5ajPBYppPd7X9JGmQUR0kU
	N6/wSou+s5wpdQKlyqdqfIje+dE6Mi7/CJGOU2rBvKD0qs9gYqDcNBC/BsnIwOt1oUCfZa
	OV4VEKilZAbTJnqrPxz6QmEOMN0Gu2WnylgI1mG4box7gKRwpAJtRmvmK74TcHC+V/RsfX
	2fO5mHTjcF1PtwIVOnTFYxxmpPS3DLFNz1dNKaTf8woEcEJuvF5uE/QldhsD9w==
ARC-Authentication-Results: i=1;
	rspamd-6c89d5bdcb-czzmn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Cooperative: 21e793653bfbec31_1744223749550_4060508787
X-MC-Loop-Signature: 1744223749550:1003506226
X-MC-Ingress-Time: 1744223749549
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.49.173 (trex/7.0.3);
	Wed, 09 Apr 2025 18:35:49 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4ZXs8M4QGtzFZ;
	Wed,  9 Apr 2025 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1744223748;
	bh=Vev8XAOv7p4/GbWfWcVgQWKJWuKppO41pO9TEi+b04g=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=r2TkSLITBGhcVZCRQJbIt+LgNUggnrCMcf8dImWSL+p1QphzXQWLg/l2oWBxeUFYU
	 KE4NmPsKcbB8/phxe0uQJr1hmNfSMCy8ajFAJ/BLYw8Lg9q1XMIq4XjOt52GzQFFhp
	 2j0dOcljbbc4B+PBe58NuGBIdSAXSbz5ITpM9Z6VYAk9+cIKqQpcTl3WiKueYH58zf
	 2IGBenwvG442g4NtqMmefyqOVe2wS3vST59QJX37KYrWnVOs+DdByNA2KmdvElwfnp
	 +UCO76HTkz3TOfApTHXH/Phxn4ev++kZAFgTpSoeG2LO1c+WpgXA+twft79onuX8Yd
	 IfZnFXko2cizg==
Date: Wed, 9 Apr 2025 13:35:45 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <Z/a+AVopz+HLa1eL@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7rdqkla.fsf@gitster.g>

On Wed, Apr 09, 2025 at 11:02:41AM -0700, Junio C Hamano wrote:
> Nico Williams <nico@cryptonector.com> writes:
> 
> > I don't find file rename heuristics to be "simple", and they're often
> 
> I think you need to re-read what Tytso wrote before reacting.  He
> never said rename and copy heuristics is simple.  His statement was
> that choosing *NOT* to record the "file A was renamed to B and C was
> copied to D in this commit" in commit objects can be thought as a
> choice to keep the system simple.

I was using file rename heuristics to explain that I wouldn't like more
of the same for other things; I was not trying to litigate renames.

I'm trying to litigate the _addition_ of more similarity-based
heuristics for _other_ things.

If similarity heuristics were enough for CR tools then none would have
introduced anything like change IDs.  Or perhaps CR tools authors have
been flat out wrong to not try or use similarity heuristics exclusively
over change IDs.  That's a topic worth discussing.  I've stated my
preference for not relying solely on similarity heuristics.

> [...]
> 
> But recording that as a copy may be a *wrong* thing to do in the
> first place.  The IDE cannot guess *why* you copied F to G in the
> first place.  [...]

Exactly, software can't read human minds, which is why recording
user-expressed intent (rename, copy) would be a nice option to have.

> If you inspect the resulting change brought in by the commit, with
> intelligence, a human may say "G is a completely new file, even
> though it shares the leading boilerplate comment with F and every
> other file in the project".  Your IDE wouldn't say that.

Right, the IDE should let one rename/copy the file _and_ choose to ether
record that as a rename/copy in the version control system _or not_.

Only the user can truly know their own intent.

Sometimes users may slip up and not record their intent correctly,
perhaps because going back to fix an earlier choice is ETOOHARD to
figure out how to do in their IDE's UI.  Fair enough.  So similarity
checks can help one understand history, but where one can have intent
recorded, that's a better indicator.  IMO.

> We designed not to etch such wrong renames/copoies in stone by
> recording them at the commit time.  Instead we compare the before
> and after image to intuit the _intention_ of what the user wanted to
> do _when_ you _ask_ (i.e. when you run "git diff" or "git log").

Well, I suspect more likely that Linus didn't want to have some sort of
inode number nor some sort of explicit rename/copy indication as a
significant simplification that allowed Git to get shipped sooner.  I'm
not questioning that nor trying to litigate rename/copy.

Nico
-- 

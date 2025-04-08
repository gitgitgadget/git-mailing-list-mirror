Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29A70810
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128068; cv=pass; b=LBX+jRgwsmYLF/bUjERIrYjb3LwejONTUUOojUWNUH9Ur8Rg2wdOiWT9kp9bNCGbAH3pv4y/VDGIwHstw414NX6HZIj3WzFHxC/AUI46bUI3So0ZdlfCyckQtVS3JUbYkYaV+6fWaQf6gsn/TVQGN0e8T+jY8zEDaoj6QsdnCVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128068; c=relaxed/simple;
	bh=rPoBETHG8RWITTIlkFLBxxcPYvD7K9DSB7XkOMyU414=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4c9NZ+N2Jii0fFKWMsNR27NOBiNdf0dTy+XIiYTbiNIHFZbUEi1afewSBBbXmOtzN558pBowkQ0nym2egvgOgIm52h6H+MWNlxM9YvUXtNMxkVsHX3bRTX6lGJwWIEGcd/Y3vw7HiMvgIeTGFnvuoEMRYdxjzwZUvKYGc6YBas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=Y9PMqGeE; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="Y9PMqGeE"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 795891652EF;
	Tue,  8 Apr 2025 15:53:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (trex-0.trex.outbound.svc.cluster.local [100.101.70.132])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 05BCD165227;
	Tue,  8 Apr 2025 15:53:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744127590; a=rsa-sha256;
	cv=none;
	b=Rhs8ML8UtLRBFrDDbDz6LOlovy+aKO0D7wHbrFtn3YV03IYHGQHw5YqmzFclXGJnQXbQsF
	bDkQAiZG+uIT0djRnnV1FUeKFlkhr3HcZ7kCTdztOq6tqCA8Yj4tdE3lbxn0DeodS7u5NL
	ASxuiwIAgcEv/al+zksfa12R4l3HVdpr2zWfi26TLeypHLx6+FNakv572yj5jhaX3d3E4g
	V0pyF++4zXrrska6kaP3AqyglgvcMjiS9qgz3wvp2NKML5kFrJjHP+aYZ9AlRGnrBS6wxF
	wMxfqne25jCr1suTAVpePqCjX27BWmeUxG/xr2KyfEGzNghHB3vP0cd2yCAezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744127590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dYCJ/N1NbJbLPdjWIqaa2mMin4bkRP87AHJ/igIle6M=;
	b=do9PxFlH3dbNEUgldiOOmGLazqq7F8+VLigL8mRxulRODz7KzPFQtUl3ylTO3cequyKXtl
	5CLHRTNGlgAIzFO5gM0dKleTrjcur7fhXfi5VPXHvzzmxFfosvNxrFDg2dZPxkBuwgUJkA
	+RcT/TloHdJj9HD+vxLa1MuEN5/sEAvDxHa3yQ8CddGF3ycb9GNKNF/E8wS/OCjCvgkRR2
	e5HouuSK291CugbP8lQlPki4dGfJGw0gY9G5c1AtpQ0S87GC8SkEqj5Pa8DopqZqC1R3ua
	fSbIfXMJM5neHQ23G9Pai7N1Hc64VKxVR0gv5YoBRaCRDYTR4/2kvt+ommhCcg==
ARC-Authentication-Results: i=1;
	rspamd-7dd6dcd7db-rtdkw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Continue: 7a3aca6644687866_1744127590348_566306652
X-MC-Loop-Signature: 1744127590348:87000935
X-MC-Ingress-Time: 1744127590348
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.70.132 (trex/7.0.3);
	Tue, 08 Apr 2025 15:53:10 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4ZX9b90Bw8zCb;
	Tue,  8 Apr 2025 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1744127589;
	bh=dYCJ/N1NbJbLPdjWIqaa2mMin4bkRP87AHJ/igIle6M=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Y9PMqGeEEzVyDZAsIZuQ93eGnfTaj1GeBeZJbFDFObPM0w6niJ2KpZ/xevI5FprOr
	 FbB1BcS6Vf6uLlwkf5Y0MW58dcZzE2mBAuzsepSIZaIPyoYfYk1FyerCen9uRvQY72
	 aBBrQv9OAuM8cnY2KGgBoDt+56Nw21IYPU/Uoa634Qh3fk1dwHtAFV1vuiIebpvm7e
	 aE7Hq8aH6TtJq5riPD0FsFvP8RPBwBHNzb4Ri1wfxt4LXMbkIFhZnwiIJmVFRadvk4
	 oPYOn+dcAuRD3tmfvnVLO2gWL9x5uOWycjz7vvrFdgEgXVi9qZIbl3Twe7a0JpRbva
	 2yV4E9fm45u7w==
Date: Tue, 8 Apr 2025 10:53:06 -0500
From: Nico Williams <nico@cryptonector.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z/VGYrrVZYQ13TLj@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408125521.GA17892@mit.edu>

On Tue, Apr 08, 2025 at 08:55:21AM -0400, Theodore Ts'o wrote:
> On Mon, Apr 07, 2025 at 04:36:01PM -0500, Nico Williams wrote:
> > This is why I suggested earlier that there need to be multiple change
> > IDs, not just one.  Perhaps one is a "code review ID" and another is
> > a "commit change ID".  [...]
> 
> I think "code review ID" makes a lot of sense, although what I would
> call it is "patch series ID".  This has very clear semantic: it ties
> commits which should be grouped together as a single higher-level set
> of changes.  It could be used by "git format-patch" / "git send-email"
> to automatically send a group of patches as a logical unit.
> 
> [...]

Yes.

> I'll note that even without the "commit change ID", just simply
> knowing that one patch series is a newer version of a pre-existing
> patch series is enough to allow Gerrit to intuit which commit is a
> newer version of another commit.  For singleton commits, nothing else
> is necessary.  For multi-commit patch series, gerrit could use the
> one-line commit description to associate commits; it could use
> ordering of the patches; it could just see which commit contents are
> similar to previous commits, much like how git detects renames.

I'm not keen on CR tools "intuiting" from.. similarity checks.  I don't
love Git's similarity checks for file renames.  I get that for a
distributed VCS assigning something like "inode numbers" is tricky, but
as long as devs don't race to create the same files it was always
possible to have UUIDs as "inode numbers" and avoid the similarity
checks.  Strictly speaking we don't even need any of these change IDs to
make it possible for tools to use similarity checks to find all versions
of a commit or patch series or whatever, but it's very nice to have
something less heuristic and more exact.

> In my experience looking at how kernel developers use gerrit versus
> e-mail workflows, in general, gerrit patch series tend to involve a
> smaller number of commits, because looking at how various files change
> between commtis is awkward; and with e-mail workflows, the patch
> series tend involve a larger number of commits, because reviewing
> smaller commits is easier with e-mail.

Yes.

> So if this true for other communities using web-based review
> workflows, using an hueristics instead of a [...]

I'm not keen :)

> > I don't think they need to have such extremely detailed semantics in
> > order to be able to get a header.  The semantics will ultimately be
> > somewhat project-defined, typically something like "during code review
> > you can use these to related newer updates to an MR/PR/CR to older
> > versions" and "once integrated you can use these to find the approved
> > code review as follows [details]".  The [details] (probably a URI
> > template) for finding concluded CRs might vary.  The CR tool might vary.
> > The construction of the change IDs might vary.  The intent might not
> > vary at all.
> 
> I disagree.  From long experience, allowing something into an
> interface that doesn't have strongly defined semantics has lead to
> *huge* problems.  This has certainly been the case for
> Kernel<->Userspace interfaces; so my bias is that if we can't define
> strong semantics, then we should probably avoid adding that interface
> until we can.  Otherwise, this can lead to a huge number of headaches,
> both for developers and users.

So how much of the [details] do you want specified?  If you want to be
able to go from "change ID" to CR generically for all CR tools then the
the best -and perhaps only reasonable- way is to make the change ID a
URI.  Or if you think the [details] can be elided and still have
semantics that are well-defined enough then I think you agree with me
more than you disagree :)

If we want to leave some details to be site-/project-local then perhaps
change IDs should have some type and domain/project identifier.  Users
who cannot make use of that metadata (e.g., because the CR tool is not
reachable) can still use the change IDs to link commits and patch
series.  I think that linking is the only thing we absolutely must
define semantics for, and the rest can be site-/project-local.  IMO.

Nico
-- 

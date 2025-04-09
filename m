Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03761A315A
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217663; cv=pass; b=d1UPCxD0R9cNqr0wy13uMEPbY3FQb5pbu+H0BZ66jhf45Gz7955ko9O3s3T+Rs7lK5QwlPG/Rr0q1+o7z7BB48Lbu+YrqdWPHTIqUYP6Vf55XGQYRfyA1ceidHQKHjr0vDFA46BrL1A6czrVKgWv5MPBEy0qCw2EeTTKTmUTkiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217663; c=relaxed/simple;
	bh=0E+YK+WVwLbEjopfP+032aIAmlnr9M/x7fUG9hCUN2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhUBBLmBK6RWTW5ZX7MR9EobBt+Fi70t0PhEKEp7ko9RKmkditOyozL6CV3/iYNBycvixMVCougiIDOW6t1+CTOL7JEHbl9d6A1XaViOtKDJeU+zyYeV1bGRcaUwuMIXZr+7XKm+KUYaOl7y5hIyGVSt2lNR+N6l41Y/Tcu+vFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=c+ueWkGq; arc=pass smtp.client-ip=23.83.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="c+ueWkGq"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7FFC620CF2;
	Wed,  9 Apr 2025 16:54:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.99.84.17])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 006DE21EBB;
	Wed,  9 Apr 2025 16:54:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744217655; a=rsa-sha256;
	cv=none;
	b=cLI2kdELKT1MkoNp2b6s70lkBLkEw8dYQWzHRXGwD96/GAuaZcqh2nhabhvvqVJhsdfGdc
	jx0lq6pdiDSYD/1Uo/FQX1HEv5D4qxSuRBFSnZI2tISX3gspx9UwcjgHtma8GcVMnnIQ/L
	JxfM81y3idG4VG0UEtYQV4vuzWjxk1E71aAYZifZ+CQa5s2AVPJGf0AtaYn3m3ItbDiBXt
	jwIBSJ9xYa00UjFqS7jt2Vkfw/9ADaoE6AoFXg9HKFwb/OeAjVF+fLV6Ylu4L4GPmUEIye
	N4OBE5aN7Jba1KfU0FHM9joIvcBCa5FRThVgX3v95oMJ2yqO4faFy778qgVgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744217655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KgOyGdAcW7lOj5DQgQhDHBIo5TlcNosb1BjUIdwjHL0=;
	b=78XsqLivmQ5e2D1cz87uwjmxwe2ABFIZig9yKCbfgb93gJd2QV8cZiIMRYSP52xBNd9fRZ
	PxRC8bze8N2b81s4UvLm9IkcdGGppTUlWj9R3+rS1/FH8LQ1W/CVdhOTQ+LRPmpy+o4yYR
	XtnNDzsqgi/SFZIm3RtQ4bonX3Qvni8A/6MwYGs1EoZYCb+ud39PuK1qD1f2IZ+MT3XboT
	7kCQ11clxaaiRH/b70xFI/MsdqzK4lmZcXF5alGpy+QYagIYJ1EmggGjK2RyVv6WM6j9sn
	XV2cYJ+j1fdDYvpV3nKv0CtGsCsvZS9WYonU2aNSZaxjveNtx/ezX2pAkU3Bgg==
ARC-Authentication-Results: i=1;
	rspamd-6c88b8f79f-lfbln;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Stop: 0fca87d70e170a20_1744217655275_1561146953
X-MC-Loop-Signature: 1744217655275:3256004824
X-MC-Ingress-Time: 1744217655275
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.84.17 (trex/7.0.3);
	Wed, 09 Apr 2025 16:54:15 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4ZXpv940tKzN3;
	Wed,  9 Apr 2025 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1744217654;
	bh=KgOyGdAcW7lOj5DQgQhDHBIo5TlcNosb1BjUIdwjHL0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=c+ueWkGqHvu/LAA5TEX435FN2F2B5oIX/RsLQVSveXFYN/xnnJZJnGNXTyPx2/xP1
	 Ss5EFpHRmHRLXQwl4VO7h3tkC09q2jWuDTJ2LU0MpFyQMGjdfkG+gkan7R/BreMVhR
	 fpdo46X4eHnnERCpCy7Z7bNq4c2tRLbK05gGqfJZKWH5F4RxBQNgJrNMOUq9bdm58p
	 xTUKHmgtkPCVd/2/oOG2rTfWuVB/yVp/xNL1F+ZQK8rFIJXjZNgN6chd5Jd0HJ0lBw
	 bsNrjO7tYtOU5y0bbNxaybLqPerKrmkV3ABOY92XH7He/ys7g7jKWA80two/tPbQNu
	 xs/8KfbNL0qsA==
Date: Wed, 9 Apr 2025 11:54:10 -0500
From: Nico Williams <nico@cryptonector.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu projects
 collaborating on change-id commit footer)
Message-ID: <Z/amMj/eg0RbXdkS@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409121924.GA148735@mit.edu>

On Wed, Apr 09, 2025 at 08:19:24AM -0400, Theodore Ts'o wrote:
> On Tue, Apr 08, 2025 at 10:53:06AM -0500, Nico Williams wrote:
> > I'm not keen on CR tools "intuiting" from.. similarity checks.
> > [...]
> 
> I'm not keen on fields that can have essentially random semantics.
> Part of this is because today Change-ID is in the footer, and so
> humans can randomly set it to any value they like.  Sometimes they cut
> and paste footers, and so completely unrelated commits have the same
> Change-Id which show up when you do a Gerrit lookup by Chnage-Id.
> Admittedly, this aspect gets better if we shove it into the git commit
> header.
>
> Part of it is because some tools will edit the Change-Id when doing a
> cherry-pick.  [...]

I was only proposing to leave some details out, not to have completely
undefined semantics.  The particular details we might want to leave out
are about resolving change IDs to URIs.  In particular this editing of
change IDs on cherry-pick you mention has to not be permitted, or
perhaps a new change ID could be added -- i.e., are these headers
single-valued or multi-valued?

Let's nail down the semantics of these change ID headers.  Here is a
proposal to bang on:

 - change IDs get preserved on cherry-pick and on `pick`s in rebases

 - users can manually remove or change these change IDs, naturally,
   though generall they would not

 - the actual change IDs are either free-form or they are URIs -- pick
   one, but if they are URIs they should be URIs to CRs, and approved
   CRs should perhaps have links to integration reports etc.

 - there should be one header for a change ID for the patch series (the
   MR/PR/whateverR); patch series IDs can be shared by many commits in
   one branch, so they are not in any way unique

 - there may be one header for a change ID for each commit, which should
   be unique in any _branch_, but not unique in any repo (due to back-
   and forward-ports for example)

 - there should be another header to list change IDs from which a commit
   was derived that nonetheless has a different commit change ID

 - these headers should be multi-valued to handle squashes and merges

 - if a commit change ID is missing but a path series change ID is
   present then similarity checks could be used to link multiple
   versions of any one such commit

Optional:

 - a commit change ID could be used as a ref to an object that lists the
   commits that have that change ID

 - a patch series change ID could be used as a ref to an object that lists
   the head commit of of that patch series in every branch that contains
   it

> Perhaps one approach might be that the hueristics that you hate being
> used as an automated way to sort it out, might get used to set the
> semantics at commit time, with perhaps a way for the user to override
> the hueristics, or where the user has to explicitly acknowledge that
> the hueristics correctly noticed that the patch has changed radically
> and maybe the Change-Id shouldn't be retained any more?

Yes, heuristics can be used to help the user make such decisions.  I've
no issue with that.

> Finally, perhaps there should be some discussion about whether we
> think git should be maintaining indexes based on the Commit-Id.

If they can be refs, then they should be.  Since they can't be unique
the ref should be to an object listing the actual commits (see above).

There could also be a non-ref index for these.

> Personally, cutting and pasting a random 17 character ID is painful
> and annoying, and when I see it in my shell history, I have no idea
> what might have been going on.  So if I need to cut and paste a
> Commit-Id, I might as well cut and paste the one-line commit summary,
> and do a "git log --grep" search based on that.  But if the Commit-Id
> is indexed, then maybe it might be more useful?  I dunno....

+1

> Well, see above about some possible semantics.  I'm *still* not
> convinced even with the better-defined semantics it's worth storing
> the extra baggage in the commit header.  But that's more of a
> value/philosophical question, much like how we "could" store explicit
> file rename information in the git commit, but in the very early days
> of the git design history, although BitKeeper did track file names,
> Linus consciously decided to go down a much simpler path.  So that's
> really more of a SMTP vs X.400 preference of simplicity versus
> complexity in the protocol versus implementation, which is something
> where people of good will might disagree --- and there Junio's
> opinions matter far more then mine.  :-)

I don't find file rename heuristics to be "simple", and they're often
wrong, though I've fully internalized that copies and renames have to be
done alone in separate commits with no contents changes so as to make
incorrect rename determinations much less likely.

Nico
-- 

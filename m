Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6C2F2E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902986; cv=none; b=GipVJi3IhAvdTZBvxhrhutInUtr0c41Bu4ycnke4XBjZLEjZmCVhSwyS/h5KsnEwsiW6zF/uqDdnka2FcFvWPJbEqJ8CesddbpOF0gi0E+/ig8QLwgDeXVKj8prxyu+3SEC9aE21zu05ZrrICzc/Twwgnx/IpSbbVwj2ixn/D5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902986; c=relaxed/simple;
	bh=ZXKH7dRu3QmDyFEWdxHk4MJRDreHzaefVqliV+i/PJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2RuN4P81PO8Gw4iZRyLYbrcspaV4cuT93gFNx9LKVGtX11dp1eSA6p87MMedEmqSRjL3g/oQhKWHx3iIYm/VtCA6Nb6cH708tXQZeKvTJa1dUObR2bWhtPbZ817fitQRi51+Wfje/N6qK/lTZcMyMekhKIUJ5qn9p5c2zoR8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BUyuWQwQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BUyuWQwQ"
Received: (qmail 83788 invoked by uid 109); 15 Sep 2025 02:23:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZXKH7dRu3QmDyFEWdxHk4MJRDreHzaefVqliV+i/PJI=; b=BUyuWQwQTc1xw//30yk5FUB98Svnlt33KVGHuv9zbxWF7ov/TjcLTXGuZWIX7YXYb5o75sDeuyWZ2gQk+SRBUN+1dHgrSF9LLAovFSgCNpECumHTg6CEFfG7w/Z4BezRJl4idzfN2+/sFSh2oK5nywq80DxZSsSGI4k7GAT2HD1SdcKYlglWFY9fir9SH0XUGSbiSdgOILvUjqBMP/adIJbFFJ/9XMZDYBjNlyzPV32XDglTxpxjQvD1VhGXUIDlKwYF03rGCSsZ+nAainTlbRZGCDzj9qjRTtAGp1hZUp3n8uz1lOkKqszJwxU1ARFchleNe2ZOyPzpXy925JABEA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Sep 2025 02:23:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140871 invoked by uid 111); 15 Sep 2025 02:23:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Sep 2025 22:23:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 14 Sep 2025 22:23:01 -0400
From: Jeff King <peff@peff.net>
To: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org
Subject: Re: [SOLVED] Re: safe.directory does not work at all (git 2.39.5,
 2.51.0)
Message-ID: <20250915022301.GA593748@coredump.intra.peff.net>
References: <duuus2ifgydpwpja6vccvxbcnxdgy6mc6h63okzv7xdqo23fpi@ermurkhms4j3>
 <lamzerhpp6kbgzbhztgaqvdcymaqvec232sen67t6wx4rmobih@lqqivgroonmp>
 <hbghuae56gm6ypox6q34mt4q6awoeb3itxsnmgpouycn7qodch@4pjsh24jhmqs>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <hbghuae56gm6ypox6q34mt4q6awoeb3itxsnmgpouycn7qodch@4pjsh24jhmqs>

On Sun, Sep 14, 2025 at 08:26:53PM +0200, Marc-Jano Knopp wrote:

> > > Cloning into 'test'...
> > > fatal: detected dubious ownership in repository at '/git/main/test.git'
> > > To add an exception for this directory, call:
> > > 
> > >         git config --global --add safe.directory /git/main/test.git
> > > fatal: Could not read from remote repository.
> > 
> > it is a little confusing, but the message comes from the git command
> > running in "my.server".
> 
> D'oh! Is there a way for the layman to see if a message comes from the
> client or the server?

Usually we try to pass error messages from the server over the sideband
channel, where the client prefixes them with "remote:" before showing
them to the user. Or report them via ERR packets, in which case the
client says something like "remote error: foo". Like:

  [this is an ERR packet; we are asking for a nonsense object id]
  $ git fetch origin 0000000000000000000000000000000000000001
  fatal: remote error: upload-pack: not our ref 0000000000000000000000000000000000000001

  [this is stderr from a server sub-process routed over the err
   sideband; I corrupted the server-side repo by removing one of
   its packfiles]
  $ git fetch $url
  remote: error: Could not read 576053ed5ad378490974fabe97e4bd59633d2d1e
  remote: fatal: Failed to traverse parents of commit a3287c454eb8f7b89d969e675768a6cfa258ad34
  remote: aborting due to possible repository corruption on the remote side.
  fatal: early EOF
  fatal: index-pack failed

But for the error you're seeing, it is happening within upload-pack
itself (the server-side process handling the request), it happens before
we have even established that the client can handle sideband data, and
it is a die() call from within library code that does not know about ERR
packets. So the message goes to upload-pack's stderr on the server side,
and then ssh just passes it back. In fact, you are a little lucky to see
it at all; for a clone over http, it would just go to the webserver's
log (or maybe /dev/null).

I do agree it is not very friendly, so I'm laying this out to help
brainstorm ideas to make it better. Some possible directions I can think
of:

  - could upload-pack install a die() handler that prints the message in
    an ERR packet? I worry a little that older versions of Git would not
    handle this great, as I don't think they were always prepared to see
    an ERR packet at any point. OTOH, it is probably better than sending
    nothing, which is what we do now.

  - could the client-side process (git-clone or git-fetch) intercept
    stderr from processes it spawns (ssh in this case, but also
    git-upload-pack directly for local-system clones) and prefix it with
    "remote:" or similar? That might help ssh and local system cases,
    but other transports like http wouldn't benefit at all. Also, it
    would probably involve forking off another process to consume
    stderr.

I dunno. I don't love either of those that much. And while it could help
things in general, I think the main clue in this case is just that the
error message refers to '/git/main/test.git'. And that path is only
meaningful on the server, since the url was my.server:/git/main/test.git.
Knowing that the config advice is _also_ coming from the server is
probably the key subtle bit, though.

-Peff

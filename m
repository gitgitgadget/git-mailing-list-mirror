Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7D2F4A0C
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372520; cv=none; b=OWMyCG8gIolRidruPfq+6W9yeoFTbPtWqIHLwXDpCmmhc7kodGLjLXTittoQqtUJYU3KDRA58G6zBECN5ChfUrSkDeskJHh4Oq8YzsO80af6ZFcxACd3GuRNcyawvTP1qMSNutww3E3+opqcg7sFF163Q7j6VQihtvQor1DUNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372520; c=relaxed/simple;
	bh=sU/Ms0Bb1dRveG8ZG/kBo6HZATkC8255pSEfu2UJFL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHvT3NgCFtYmCWk57rTXyWoTb96QTjfgwBN1SjPp1ThFIju8G4LoANBbgkCGjjJqDwj5X+JmJEj0PG3TTXH9RgsSSyWhuHEcMh7Lcri/g0FYkREtliKa7yGGxFzNnyOzePL8jvJ9tdSLkja8MMsi63T0DCUehFcEjW1ZuXql8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FNzYSsjl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FNzYSsjl"
Received: (qmail 298519 invoked by uid 109); 6 Feb 2026 10:08:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sU/Ms0Bb1dRveG8ZG/kBo6HZATkC8255pSEfu2UJFL4=; b=FNzYSsjllOmVrOapWwGJM4tqPzbfFj+WEQsJPsJu2eSM3ci6Ra+YqkL1JJRDecm7udXDbJ6CVwMlTgIWed5nHBKJ4Ls01PoooSjlLxQeLyHOxmsXjm7HtCbjWfgXNHiu2E/5jug8bF6PNuT6GHQpln89KuQDlMht5Df37cjfRpmDWncwbhLvWK9PYS3Vs6St5gJ8xWbv50wPJQSmMAsy+gPonuV5w9/vumScGrdwvEK5xJ3yzf1T9DZ5JOaQMzrtW7Iayd0KaXvaJ4EM/qTck8dQX4PxeMUX0pMzGkMVEAKRHa0/jXhfaBFqTbN7xvTn5iKu+KXlUywBxWGwinHcMQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Feb 2026 10:08:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 599870 invoked by uid 111); 6 Feb 2026 10:08:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Feb 2026 05:08:43 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Feb 2026 05:08:37 -0500
From: Jeff King <peff@peff.net>
To: Florian Weimer <fweimer@redhat.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>, git@vger.kernel.org
Subject: Re: git-am applies commit message diffs
Message-ID: <20260206100837.GA2778409@coredump.intra.peff.net>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <lhutsvuuu18.fsf@oldenburg.str.redhat.com>
 <20260206092423.GB2761602@coredump.intra.peff.net>
 <lhujywqtd76.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lhujywqtd76.fsf@oldenburg.str.redhat.com>

On Fri, Feb 06, 2026 at 10:48:29AM +0100, Florian Weimer wrote:

> > On Fri, Feb 06, 2026 at 09:59:31AM +0100, Florian Weimer wrote:
> >
> >> Isn't the format-patch output already unambiguous because the sequence
> >> of diffs is preceeded by the non-diff statistics section, and only then
> >> the commit message follows?  It's just not possible to process this
> >> correctly in one pass because only at the end of the input, you know
> >> that you have just seen the to-be-applied diffs.
> >
> > That diffstat is optional, and not parsed by the receiving format-patch
> > at all. Keep in mind that in the world for which it was originally
> > designed, people were not necessarily using Git to generate their
> > emails. They could be patches emailed by random folks using "diff"
> > themselves.
> 
> Is the git am format that flexible in practice?  I often have trouble
> applying patches with git am that were created with git format-patch
> and have to resort to plain old patch instead.  As a user, I definitely
> get the impression that it's not a type of tool that gets a patch
> out of an email message, no matter what the cost.

I'm sure there are corner cases it doesn't handle, but it will take
input like this:

git am <<\EOF
From: Jeff King <peff@peff.net>
Date: Fri Feb 6 03:42:12 2026 -0500
Subject: my cool patch

this fixes some stuff

diff -Nru old/file new/file
--- old/file	2026-02-06 04:58:56.148348259 -0500
+++ new/file	2026-02-06 04:58:59.432360938 -0500
@@ -1 +1 @@
-base
+changed
EOF


and happily produce the commit you'd expect. I generated the diff there
with GNU diff, and typed the rest. Likewise for this version with
attachments, which I generated with mutt:

git am <<\EOF
Date: Fri, 6 Feb 2026 05:03:31 -0500
From: Jeff King <peff@peff.net>
To: Jeff King <peff@peff.net>
Subject: my cool patch
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tveeCB9LAhLXuhMJ"
Content-Disposition: inline


--tveeCB9LAhLXuhMJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

see the attached patch, which does blah blah blah

--tveeCB9LAhLXuhMJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=patch

diff -Nru old/file new/file
--- old/file	2026-02-06 04:58:56.148348259 -0500
+++ new/file	2026-02-06 04:58:59.432360938 -0500
@@ -1 +1 @@
-base
+changed

--tveeCB9LAhLXuhMJ--
EOF


I expect that Linus saw a lot of this kind of stuff in the early days.
I'd guess it's pretty rare now, but I won't be surprised if there are
some die-hards generating kernel patches with who-knows-what. ;)

-Peff

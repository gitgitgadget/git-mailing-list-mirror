Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384252;
	b=B/46fF/gdf0sP6ja/U2fjxO/dVVyelblOVU2dZgGrB20IgPWM/ava48L8XJmK+biJWiq
	 KUhqQxB7FV7wq3sPPH3jksn2nbRBDokTQ8Bxb+XA1PyC8SKgYuZXVcYTV0uGDFc2460wD
	 2LbL8Sv/wXPhSsj5UQ/EM+DSmhyxpoPtV598aDSJFzLuhCdXqKv0xQb7FFg3GwJSBKtg4
	 IzwIVAA+M9jj/czbuY9LVQDyChi2blZlqS22BcFV3lN81t60py+G+Sso72Gpj9qwYQa1H
	 zqTES4jH347mk551GNz9L4dVCv5gULIb1AHm5RtRj1ozw+sn0Z+M+rTTmfgCppVhwGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384252;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KA4UkHupld+GmvnD0OJkWsuJlnkQiarnFkZiXd5dac0=;
	b=0/DR+uj6KZYDsQkekG5EPCWs3vIu3IG3UKgV8aMiVdUrA8ie5GZfnP6q2jPTkM5A4ZMa
	 TRzqrANyAQTxx/U6n3kKGT4oJowZCqGwYwQSb1jEVRWg5RCHysiqKZlOEHztjUN+Tiq62
	 HS1yYa6nvH+wp8QcVpsbZHKJN18lTb4wm3ukWV7KaXYMgsx5olBE8BaSKf3M7zGM6rBaJ
	 4quFuK7lmcyigJDoLACJPpqyf7JjBorG6dNKHakqpXKlJ4AUQvre6TIwbIbVgb3iptyA7
	 SrFZ+R2/lZgl8/Pn1PDLBTAptSnSYktrWNFHtPQvWemGuyU/AYCYhPmmm9wWfiULvUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=C6+VglI+;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BF606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=C6+VglI+
Received: (qmail 49268 invoked by uid 106); 30 Oct 2026 18:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cwxfL/j/nUWdPMqMqs4Dt7V3Ng2QWyoYv2zOmzbfmWY=; b=C6+VglI+Mzju51XdMqYPeZ8vhwSF1oCnw8HA28Mnu3Gwky9apxm1lPy+G3/Q1LVIbJhPcRYqcIfo5lHvbBfPh5P16t8sFp8kR2yWgqh8ebzCeiQ2YbCxtTxVeMFztqBnJ6AuEY6hLWga1uaOVOcS9L+pew6ZYZYAhhqBnoag6L7HTevIt/Cwovlg7ceXpPsZxM1/eLNHP0UlOg53nHnqVDhExc8AZMi3urOwX7WxQs45qpGwguCaNXcX/b9CUhBg7q+HgHipr+mj75g2/uqWIrgn/2qDWhAy3fQKnMVgEL45HtCfj/dRAcxrzPWDotyiWaHK5H02/OcHuAOB5zPzMw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2026 18:17:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 323459 invoked by uid 111); 30 Oct 2026 18:17:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2026 14:17:28 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Oct 2026 14:17:28 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] odb: do not list our own refs as alternate refs in the
 quarantine
Message-ID: <20261030181728.GB7582@coredump.intra.peff.net>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <xmqqfqxo4dy1.fsf@gitster.g>
 <CAL71e4PXZ8-T3RgLQQLtL2ASQMLbRrChfV6wAqxFSd_Tw7-2Sg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4PXZ8-T3RgLQQLtL2ASQMLbRrChfV6wAqxFSd_Tw7-2Sg@mail.gmail.com>

On Fri, Oct 30, 2026 at 12:51:43PM +0100, Kristofer Karlsson wrote:

> > It is a bit of a shame that tmp_objdir_create() exports the same
> > value as DB_ENVIRONMENT in GIT_QUARANTINE_ENVIRONMENT, as the only
> > existing use of the latter is to check if the variable is exported
> > or not---in other words, to carry a single bit of information ("are
> > we in quarantine or not").  I wonder if we can change its value to
> > name the parent process's real object directory instead?  Then we
> > would not need to export yet another variable to carry the
> > information we need.
> 
> Agreed, I think that is a reasonable way forward to a concrete fix.
> 
> I started working on a v2 based on your suggestion there.
> First I tried tweaking GIT_QUARANTINE_PATH to
> point to the real object dir, but I realized that might be
> unsafe since some hooks may depend on the semantics of
> that env variable, so it would be a breaking change.

Yes, the reason it's a path and not a single bit is exactly for this
idea. ;)

I never upstreamed this final bit of the quarantine code because it
always felt a bit ugly. But how it worked at GitHub at the time (and
possibly still today? I don't know) was this.

The goal is that we want to reject excessively large objects on pushes,
for security (integer overflows, etc) and performance (pushing up 5GB
blobs is mostly an anti-pattern). It's nice to do it in index-pack for
two reasons. One is that we already have the data there, so it's a free
check (as opposed to a hook running a separate scan over the objects).
And two is that it's our first look at the objects, so it reduces attack
surface to reject the big ones early.

Dying unceremoniously for large trees and commits is fine. Nobody is
sending you 100MB trees unless they're an attacker. But with blobs, it's
almost always a simple user mistake, so you'd want a more gentle message
(and possibly even to do things like finding which paths point to the
blob).

Our solution was for index-pack to write the set of large blobs to
$GIT_QUARANTINE_PATH/large-objects. And then a hook is able to read that
and produce whatever nice message you want, but without going to the
expensive of running rev-list or similar just to find out that all of
the blobs are fine.

I had envisioned a world where we might use it for more information, or
two hooks could even use it as a rendezvous point, basically as "here's
an atomic tempdir for this whole push". But I don't remember if it was
ever used for that (the most likely candidate, from memory, was pushing
some secret-scanning code into index-pack, since it already has the
object bytes in memory, and then letting it generate a report).

> Then I started adding a second env variable.  That worked
> and it was not _too_ messy though I realized it was a bit
> redundant.  We can simply deduce the real object directory
> from the quarantine directory -- it's the parent, based on
> how tmp_objdir_create() works today -- so I built my preliminary
> v2 on that.
> 
> It feels like a slightly icky assumption to make, but it
> feels safe since I added tests to cover it, and does not seem
> possible to override outside of git itself.

I don't know, it actually sounds quite sensible: we do not show
--alternate-refs from an alternate source that is ourselves, because
we'd already have looked at those refs. The quarantine and tmp-objdir
code sets up this slightly odd alternate situation, but somebody could
also do it externally by setting up a few environment variables.

-Peff

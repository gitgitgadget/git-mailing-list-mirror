Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9032036F9
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968622; cv=none; b=Phe8jOBp3323Sh6afk2T+6xJnDb2dX9q6IpQeYxKMxH+taWLgPpf331AccQw+WDLsh5zIgSqWXnZqgx0swnawvQtQwUdpRBCnt/3T7jFLDJ7uWs7lC5U2fgVLNmkjZepJ19/lMDgNdcCMjIslQCDojnr21H0PgUYOJpzKXsr2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968622; c=relaxed/simple;
	bh=511XErR6m7diuyDSPdvEZB9Bg/qbQsNd4t/8VMvUg6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl4s66+6UJQWGiVUAul5/i7bjqK/8UiTUs8/skXFO7rJ6Yu3JXLTN+KyihK75yvSnslBjxV6k2dtMYC6J/EsCGMv/H10r0wW+ceUL1DW0RZ72Sitl6Q9Std2EROR1SuO3jyIq15oXgwvCJlbdTs8IktlLL8TtDE7aC+L9UsU4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h30zKYeg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h30zKYeg"
Received: (qmail 18371 invoked by uid 109); 14 Mar 2025 16:10:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=511XErR6m7diuyDSPdvEZB9Bg/qbQsNd4t/8VMvUg6c=; b=h30zKYegiaJXIi8Eya1rivxrMmy0t4DI8SYPSER1JeiXPHQmPRpS7BkCZRqqBJIBGG7naa7J71gZRs3A5Ouy9kkY4CfgXsIbDCWr87g6hY1iA+hDd0TgUrr6drba4JShkSx1xXDA05SPBcKc6xDn7/KoObS3r7svcRYS6fryzHtrCG/vdgm4sW7RzQ2pVGiRC6WYUX5a/n/EhX8OEdtJ/LyOQjHQeriGNfgnsif0UZN5w0ST/K+2EW1WJCk5sqZPEvrxJtguoPt6cm6iH7VpDaSQenWoyRdDq0PTlU88f3b0LBRt92a68torn5wGWjVnMQG35UJkLKxbZsMob6x5sQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 16:10:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5511 invoked by uid 111); 14 Mar 2025 16:10:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 12:10:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 12:10:10 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250314161010.GA8522@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net>
 <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
 <20250308032309.GA584028@coredump.intra.peff.net>
 <xmqqfrjkao75.fsf@gitster.g>
 <20250310160440.GA26189@coredump.intra.peff.net>
 <xmqqsenk7mab.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsenk7mab.fsf@gitster.g>

On Mon, Mar 10, 2025 at 11:50:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Maybe not often, if there is only one instance in the current code base.
> > Or maybe a lot, but we wouldn't know because we haven't had the warning
> > enabled.
> >
> > I guess another option is to enable it in _one_ CI job that uses clang
> > on Linux (maybe linux-sha256?) and see how often it is helpful or
> > harmful.
> 
> The reason why you said Linux rather than macOS is because the
> single instance we know about would not have to be worked around if
> we did it that way?
> 
> I am OK with that.

Yes, exactly. I started to prepare a patch for that, but then I realized
I'd probably be adding support in config.mak.dev. So we could also just
handle it automatically there, skipping the flag on macOS.

That would use the flag in more situations (blocking the known-bad case,
rather than enabling it in a known-good one). It might hit more false
positives, but I'd rather experiment in that direction and see if
anybody setting DEVELOPER=1 complains. After all, in either case it is
still a big question of whether this is the only false positive we'll
see, or if this is opening up a can of worms. So I consider it all
kind-of exploratory.

So that patch could look like this (on top of what you've queued already
in jk/use-wunreachable-code-for-devs).

-- >8 --
Subject: [PATCH] config.mak.dev: disable -Wunreachable-code on macOS

We've seen false positives here related to calling sigfillset(); even
though POSIX specifies that it may return an error, it transparently (to
the compiler) always returns success on macOS. As a result, the compiler
flags the error path in something like:

  if (sigfillset(&set))
	die(...);

as unreachable (which it is on this platform, but not in the general
case). We could work around it, but let's just disable the warning on
this platform. There are plenty of CI jobs that will still trigger it
(e.g., all of the linux+clang jobs).

Signed-off-by: Jeff King <peff@peff.net>
---
It's possible FreeBSD might share the same problem, but their manpage
does not seem to have the same "it always returns 0" language. But we
might need to expand this list if people report more problems.

 config.mak.dev | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 95b7bc46ae..30dcd0c175 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -39,7 +39,12 @@ DEVELOPER_CFLAGS += -Wunused
 DEVELOPER_CFLAGS += -Wvla
 DEVELOPER_CFLAGS += -Wwrite-strings
 DEVELOPER_CFLAGS += -fno-common
+
+# There are false positives for unreachable code related to system
+# functions on macOS.
+ifneq ($(uname_S),Darwin)
 DEVELOPER_CFLAGS += -Wunreachable-code
+endif
 
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
-- 
2.49.0.rc2.384.gf2d6285ccb


Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18221F4288
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968831; cv=none; b=VFQgpxssIkpxyxu1uJOLEm2yf1SGD/zjnvLZivTJ6xv1kCOGaiTXj24+D7Zf1PtfesRQRQUH+n4YOUsChDFw41+ldh+gef9pUNKu8VmZ8zIfbx4NcXKTW3yCdUimKqW6msBcx5z6VJj6SffYLBy13ZdJrVGGZDa7SmZUiqfDLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968831; c=relaxed/simple;
	bh=NY8Ttysfc4goNyskMCx4ua2vbnveHcA+L6H7fz2zzag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiT6oROyca6QXe2ZPHRoTOdChEQ/7622ObAEirDPceYlK88JXEZaXLhB1KeuGIWRRU38y+APDw0kHsfnxPOMLrOOfow3LmU+b3081g5hZaDKyEdzsqWfQVf+PJ3o8ut9P+5hm8dBGRNpvywTq9KV4eyiynNe14fgR4Z7i3JHzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sdcjx8lZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sdcjx8lZ"
Received: (qmail 18488 invoked by uid 109); 14 Mar 2025 16:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NY8Ttysfc4goNyskMCx4ua2vbnveHcA+L6H7fz2zzag=; b=Sdcjx8lZ/iDNUGExLZC2F6+/s07Z6vmxTq3kmxgPlIkSXNl5AOZCk3Xx58x6d751tdmlAC7SV8fTH3myPC2QA8fpeyi5eH28uhCK4NXw5ocDHO9u5AAEEV3dsuPXHSGc17zXQpAEtZwVtE7FZXLfIquNkULQjZDkdg3H+o/uw/xwfPZwWrlis30zMdR/b7rotM31j5H+ERl4UhnUb8SlvhVpXnoAyiCc64BNAxZ7PkqvpJT3TwE3b3oQmjnwS33UgJZq3ifh5b8L21UgiKlYfKf3bksrjpb9C9A5zGOS8lruBAUBx8S3eaLzbRmNJBAC3V0csUT32jkdQKw+++ps6A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 16:13:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5561 invoked by uid 111); 14 Mar 2025 16:13:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 12:13:47 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 12:13:47 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250314161347.GA9440@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net>
 <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
 <20250308032309.GA584028@coredump.intra.peff.net>
 <xmqqfrjkao75.fsf@gitster.g>
 <20250310160440.GA26189@coredump.intra.peff.net>
 <xmqqsenk7mab.fsf@gitster.g>
 <20250314161010.GA8522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314161010.GA8522@coredump.intra.peff.net>

On Fri, Mar 14, 2025 at 12:10:10PM -0400, Jeff King wrote:

> So that patch could look like this (on top of what you've queued already
> in jk/use-wunreachable-code-for-devs).
> 
> -- >8 --
> Subject: [PATCH] config.mak.dev: disable -Wunreachable-code on macOS
> [...]
> ---
> It's possible FreeBSD might share the same problem, but their manpage
> does not seem to have the same "it always returns 0" language. But we
> might need to expand this list if people report more problems.

And I'm still a bit tempted to instead actually silence this one false
positive, and keep the warning enabled everywhere. That would help
FreeBSD (if it indeed does have the same issue) and let macOS benefit
from the warning (most code paths would be covered on Linux anyway, but
there could be platform-specific ones).

And that patch would look like this (again, on top of what you've
already queued, and replacing the patch I'm replying to):

-- >8 --
Subject: [PATCH] run-command: use errno to check for sigfillset() error

Since enabling -Wunreachable-code, builds with clang on macOS now fail,
complaining that the die_errno() call in:

  if (sigfillset(&all))
	die_errno("sigfillset");

is unreachable. On that platform the manpage documents that sigfillset()
always returns success, and presumably the implementation is a macro or
inline function that does so in a way that is transparent to the
compiler.

But we should continue to check on other platforms, since POSIX says it
may return an error.

We could solve this with a compile-time knob to split the two cases
(assuming success on macOS and checking for the error elsewhere). But we
can also work around it more directly by relying on errno to check the
outcome (since POSIX dictates that errno will be set on error). And that
works around the compiler's cleverness, since it doesn't know the
semantics of errno (though I suppose if sigfillset() is simple enough,
it could perhaps realize that no writes to errno are possible; however
this does seem to work in practice).

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 402138b8b5..d527c46175 100644
--- a/run-command.c
+++ b/run-command.c
@@ -515,7 +515,15 @@ static void atfork_prepare(struct atfork_state *as)
 {
 	sigset_t all;
 
-	if (sigfillset(&all))
+	/*
+	 * Do not use the return value of sigfillset(). It is transparently 0
+	 * on some platforms, meaning a clever compiler may complain that
+	 * the conditional body is dead code. Instead, check for error via
+	 * errno, which outsmarts the compiler.
+	 */
+	errno = 0;
+	sigfillset(&all);
+	if (errno)
 		die_errno("sigfillset");
 #ifdef NO_PTHREADS
 	if (sigprocmask(SIG_SETMASK, &all, &as->old))
-- 
2.49.0.rc2.384.gf2d6285ccb


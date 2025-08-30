Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E41DED77
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520842; cv=none; b=hYrYDNxJ0oZ8XNElKZ/GPPr3uCkyPbjeBAL9RaiLUwHCnyqjEsQIYKils7vmQe3KzG79fZoVnD2KEiuVNjEdJ6x8CqAkFRkw7f0C+NvOlQRuzYQRfhjfvQ91QWPONV4gdMsAkKfS5/VphZAdafIFKzPY8XunRwjepFEeDFmjRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520842; c=relaxed/simple;
	bh=TTAwhgzanbZALRqO6ZJmY66N7djBQLsIt9t6GIFEUIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dptz0s5FkW0wP92riucGEyGT/PpwVhnTCtHPemM3BIHOI1TPH4FCxWLiMA8XHdBihcdjwjXTK2G153SAyFyeFcP1YUZTQL3w4VBP5wl5P7wCrsm1Tn7QqC2U07q0d9yOOsHRdKSm5qP4hvFeBX/VTyuFHTUmaqzhrPvU9hAUCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TSrD7nRq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TSrD7nRq"
Received: (qmail 154849 invoked by uid 109); 30 Aug 2025 02:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TTAwhgzanbZALRqO6ZJmY66N7djBQLsIt9t6GIFEUIg=; b=TSrD7nRqLmdd1yRgD+f7ayBXbPG45oYR8e/WzzgwT7YXhZckJLVX+lRMHHPQVff+IGytCzGxTbejKS/S9SUEQqgEndSQxaNdo5zOjiG18YXFPbolxzWKFGbTPkqy9Z9t4W7QccOGkWJQvnx9f3cPv5ecHawqq4glejuG0ypR1UyicwnKic6hxWzGRgbYMCZjo4tvMC8Op9XaGPfL8OF+B0jcQ+k9Woxw9hiFtbHzfumBNLbSK6G0NWqHnOT1dGun8gEtrfsv9gT886CaX9dfPytw2o4BIfkvK02Ri49K1ceJN+44zBVWzwDozfOnPcqWwPB+nOzANvw2rGrblsI4mQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Aug 2025 02:27:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 275244 invoked by uid 111); 30 Aug 2025 02:27:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Aug 2025 22:27:18 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 Aug 2025 22:27:18 -0400
From: Jeff King <peff@peff.net>
To: Anthony Clay <anthony.clay@masimo.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Whatchanged
Message-ID: <20250830022718.GB567900@coredump.intra.peff.net>
References: <BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM>

On Fri, Aug 29, 2025 at 01:24:46PM +0000, Anthony Clay wrote:

> Kernel audio driver maintainer, here. The first thing I want to know
> about a branch is "whatchanged" - it tells me exactly what I want to
> know with no distractions. So I was horrified when I saw the removal
> nomination message.  Please reconsider - while git log can do it, I
> don't use git log... at all. I'd just have to add another alias that
> would be another thing to constantly collide with while using docker
> build chains with different (but usually older) versions of git.

Aside from finger re-training, is there a reason that "git log --raw"
doesn't work? It should work on all versions.

On the subject of finger re-training, you mentioned aliases, which made
me think a bit. In a post-whatchanged world, you are free to do:

  git config alias.whatchanged "log --raw --no-merges"

Before then, that alias will be ignored. For older versions of Git,
that's fine; the builtin does the same thing. But there's an awkward
period _now_ where whatchanged complains about deprecation, but does not
respect the alias.

I wonder if we should loosen the "aliases cannot override builtins" rule
for deprecated commands. Perhaps something like the patch below.

That would let you configure that alias now, and everything would
continue to work no matter which version of Git you used. Modulo the
already-released ones with the deprecation warning but without the alias
magic I'm suggesting. :( So maybe not quite as helpful as it could be,
but something that could make deprecations less painful in general.

That said, I'm not sure from what you wrote above if it helps you or
not. If your problem is that the containers have random unknown versions
of Git, it would help in theory. But if your problem is that the
containers do not have your alias config, then it is not much help.

-Peff

---
diff --git a/git.c b/git.c
index 5dc210b7b4..7c4b5a17a7 100644
--- a/git.c
+++ b/git.c
@@ -794,13 +794,32 @@ static void execv_dashed_external(const char **argv)
 		exit(128);
 }
 
+static int is_deprecated_command(const char *cmd)
+{
+	return !strcmp(cmd, "whatchanged");
+}
+
 static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
 	struct string_list cmd_list = STRING_LIST_INIT_DUP;
 	struct string_list_item *seen;
 
 	while (1) {
+		/*
+		 * Allow deprecated commands to be overridden by aliases. This
+		 * creates a seamless path forward for people who want to keep
+		 * using the name after it is gone, but want to skip the
+		 * deprecation complaint in the meantime.
+		 */
+		if (is_deprecated_command(args->v[0]) &&
+		    alias_lookup(args->v[0])) {
+			if (!handle_alias(args))
+				break;
+			done_alias = 1;
+			continue;
+		}
+
 		/*
 		 * If we tried alias and futzed with our environment,
 		 * it no longer is safe to invoke builtins directly in

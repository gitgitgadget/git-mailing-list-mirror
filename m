Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1E2E62AD
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759461087; cv=none; b=W53kWyMXt+ZlGPjbdH863HXvediiQ7sr9e9l6aMCYeAqWBC8CIrxt9gEuHxVcQ+EE9KKZNdN+fpk+jba+BuP2xQCmyaNUliRFI8jALjDnlVcqEK9WREz3JiF5fmcyasotXZVkpIHSIdpuB4gEKnOrTMFuRRq7IjkLFt+UX9I3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759461087; c=relaxed/simple;
	bh=SQyisjsOkjx82vQvVNrCNgAgpTpfVaheANxDtLk9Ai0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvklGfXKzg2aOG8xuDYnxa2Y5FdTCQZ8hAypufR28t/NaN+bFrNK46gj33UffHNSMqyyJa9SHwT17IfP7Bx46etkouAhXvWPuQB+biXKnReLJMCzW5qGyFzEoSK0F6WhWTpBAHHUTzDluFr6VBRJ5XaITTsytx+DOArJtt6mtKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ctZVZ0nF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ctZVZ0nF"
Received: (qmail 112332 invoked by uid 109); 3 Oct 2025 03:11:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=SQyisjsOkjx82vQvVNrCNgAgpTpfVaheANxDtLk9Ai0=; b=ctZVZ0nFe9vPX+cjRpJfeegxJvV1ai/encMdlSXsjgwNwbmSPZf1fj5fA54MMgzqXLkGCt3mWMGqaXiaHtF3/UwUxZF93KN9bgN5THwMTZyfIJ1pP5fCl799PV7J/PTEZikjnZwxGusucWFt8VJR09U3wjzpzokgBISAvae2GCYSox7DwvgjvF/k0bY9rl5Pl3l1Rcl4BYYE76in5UNM/GvC6oodEDh8aibQttiuUdtCwC7XuhKJawCvse61r8gpTkL6nZc3D8fThHG6Ikjf0p27FULn4itEJ8ouNt0/Sy6tg4Qx2g9xbvWIWVmqQieerDBVDQXVgIMuRByKmCz46Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Oct 2025 03:11:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 161506 invoked by uid 111); 3 Oct 2025 03:11:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Oct 2025 23:11:14 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Oct 2025 23:11:13 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: change the markup of paragraphs following a
 nested list item
Message-ID: <20251003031113.GA6381@coredump.intra.peff.net>
References: <xmqq5xd5aqa5.fsf@gitster.g>
 <20250927195032.37223-1-jn.avila@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250927195032.37223-1-jn.avila@free.fr>

On Sat, Sep 27, 2025 at 09:39:45PM +0200, Jean-Noël Avila wrote:

> Asciidoctor and asciidoc.py have different behaviors when a paragraph
> follows a nested list item. Asciidoctor has a bug[1] that makes it keep a
> plus sign (+) used to attached paragraphs at the beginning of the paragraph.
> 
> This commit uses workarounds to avoid this problem by using second level
> definition lists and open blocks.

I think this is mostly making things better, but there is one curiosity.

Looking at:

  ./doc-diff HEAD^ HEAD

there are no changes with asciidoc, which is good.

Looking at:

  ./doc-diff --asciidoctor HEAD^ HEAD

most of the changes are like:

  @@ -3187,7 +3187,7 @@ CONFIGURATION FILE
                  specify the sparsity for each worktree independently. See git-
                  sparse-checkout(1) for more details.
  
  -               + For historical reasons, this extension is respected regardless
  +               For historical reasons, this extension is respected regardless
                  of the core.repositoryFormatVersion setting.

which is fixing up the bug. Good. But then there's also this hunk in
git-config.1:

  @@ -3148,9 +3148,9 @@ CONFIGURATION FILE
                  •   reftable for the reftable format. This format is
                      experimental and its internals are subject to change.
  
  -               Note that this setting should only be set by git-init(1) or git-
  -               clone(1). Trying to change it after initialization will not work
  -               and will produce hard-to-diagnose issues.
  +           Note that this setting should only be set by git-init(1) or git-
  +           clone(1). Trying to change it after initialization will not work and
  +           will produce hard-to-diagnose issues.
  
              relativeWorktrees
                  If enabled, indicates at least one worktree has been linked with

which I think is wrong? Looking at the end result with more context, it
is:

             refStorage
                 Specify the ref storage format to use. The acceptable
                 values are:
  
                 •   files for loose files with packed-refs. This is the
                     default.
  
                 •   reftable for the reftable format. This format is
                     experimental and its internals are subject to
                     change.
  
             Note that this setting should only be set by git-init(1) or
             git-clone(1). Trying to change it after initialization will
             not work and will produce hard-to-diagnose issues.

So that "Note that..." paragraph is attached to the refStorage
definition, and should be indented to the same level as "Specify...".

Even more interesting, I think asciidoc gets this wrong both before and
after your patch!

Looking at the source, there is an extra blank line, which might be
confusing things. This seems to help both asciidoc and asciidoctor do
the right thing:

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 556eda5d12..110976ad60 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -60,7 +60,6 @@ refStorage:::
 	Specify the ref storage format to use. The acceptable values are:
 +
 include::../ref-storage-format.adoc[]
-
 +
 Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1]. Trying to change it after initialization will not

Not sure if we'd want to squash that in, or do it as a fix on top, or
even as a preparatory patch (since it does fix a real problem in the
asciidoc version, AFAICT).

-Peff

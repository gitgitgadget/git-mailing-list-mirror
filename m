Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A742D29D6
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825350; cv=none; b=nOGmyAbkAceaiSQNkOAHWU1vNYM03Ygwc1fvwwGIMIN107bW0pu0AS6k12nV7P4bjZLl0GcoMI6UG162idnULQ5sZ/Skf3CVEBVK0OY+BeaHOdufshCO9LB+fSRbcevTF/99N0u4cAijyHViUd0Q7+dROzdBL5XdhM6WU0BPTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825350; c=relaxed/simple;
	bh=tUI++zUHQivUKLDni0lCmoe/Ym1337WitqsyJGN6xhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkHoCP4tyWl7kzZLFKHlJaQhx0JbYDDuX+dn2zWCvanzliSHF/4m+jdi/8wvV3md7wwj9Gt7Et0FU4nQt8ePB6EjeWehhu0He+TvKK673htQ2L4mMcuuJcQDRSoFME/xjeD3CzTGMDb2K+Xt1k3sa8v72CKdSlGTh42dn/UgoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ITdtrYkB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ITdtrYkB"
Received: (qmail 156299 invoked by uid 109); 7 Oct 2025 08:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=tUI++zUHQivUKLDni0lCmoe/Ym1337WitqsyJGN6xhk=; b=ITdtrYkBDnWmYlOh7Xb2gdiyLJRTcM313hgQ76JXEs8CsZyoAsKYb/RtmUUdoAq3guPXcJbb5QZvDG987UQYV1U9C3y4Q53tQ1iSWY6n2hn0Z4pca48Se4lUaXPrW4NgGT4QraxV9nAv3UTlBqUYOI2ZGPwFUGjKfVj2ugxKGVMZOe6MyB9RaoLsM5DXLMNIuxQgI5xaci7C/p4tqe8qWw2nup4lvJkWfdoX2BWgX2CygxBz1D5NDW/Wh4BZ1m3lVT2x9vrw9Z0MnWx7TiBYcHWbYJq8fOhpkemusV5Nak6i//LGISUjQlcZulnUKlWBpuC60AcPPgvyUdTqVMrgqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Oct 2025 08:22:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 230848 invoked by uid 111); 7 Oct 2025 08:22:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Oct 2025 04:22:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Oct 2025 04:22:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #02; Mon, 6)
Message-ID: <20251007082223.GA3336685@coredump.intra.peff.net>
References: <xmqqqzvfmwcx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqqzvfmwcx.fsf@gitster.g>

On Mon, Oct 06, 2025 at 04:41:34PM -0700, Junio C Hamano wrote:

> * ja/doc-markup-attached-paragraph-fix (2025-09-27) 1 commit
>   (merged to 'next' on 2025-09-30 at a91ca5db03)
>  + doc: change the markup of paragraphs following a nested list item
> 
>  Documentation mark-up fix.
> 
>  Expecting an incremental follow-up to avoid regerssion.
>  cf. <2239952.irdbgypaU6@cayenne>
>  source: <20250927195032.37223-1-jn.avila@free.fr>

Ah, I didn't realize it was in 'next', and just assumed we'd get a
re-roll with the fix squashed in. Here it is as a separate patch.

-- >8 --
Subject: [PATCH] doc: fix indentation of refStorage item in git-config(1)

Commit 5a12fd2a8c (doc: change the markup of paragraphs following a
nested list item, 2025-09-27) converted the list of items in
config/extensions.adoc into a definition list. This caused a small
regression in the indentation of one item, but only when built with
AsciiDoctor. You can see the problem with:

  $ ./doc-diff --asciidoctor 5a12fd2a8c^ 5a12fd2a8c
  --- a/c44beea485f0f2feaf460e2ac87fdd5608d63cf0-asciidoctor/home/peff/share/man/man1/git-config.1
  +++ b/5a12fd2a8c850df311aa149c9bad87b7cb002abb-asciidoctor/home/peff/share/man/man1/git-config.1
  @@ -3128,9 +3128,9 @@ CONFIGURATION FILE
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

(along with many other changes which are correctly fixing what
5a12fd2a8c intended to fix). The "Note" paragraph should remain aligned
with the bullet points, as they are left-aligned with the rest of the
definition text.

The confusion comes from a paragraph following a list item (ironically,
the same case that 5a12fd2a8c was solving!). We can solve it by adding
"--" block markers around the nested list. We couldn't have done that
before 5a12fd2a8c because before then our list was nested inside another
set of block markers, something that AsciiDoctor has trouble with. But
now that we are a top-level definition list, it is OK to do so (and in
fact, you can see that commit already made a similar adjustment for the
worktreeConfig entry).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/extensions.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 49a7598ca5..aaea8c107f 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -55,8 +55,9 @@ For historical reasons, this extension is respected regardless of the
 refStorage:::
 	Specify the ref storage format to use. The acceptable values are:
 +
+--
 include::../ref-storage-format.adoc[]
-
+--
 +
 Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1]. Trying to change it after initialization will not
-- 
2.51.0.717.g1fc658c4b9


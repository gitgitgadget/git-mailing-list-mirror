Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BD48663E
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200856; cv=none; b=XZXLs2s48+6lAIbmNbjRj+A9td++FXGeHjVnU5DGJn5uGtSMh146MPPHRzLrRbp2nVDItLEwJKezQ7CuK40Cv2ZzCHu4Kd5yQ037xcZI1r2Pv2/Sl8HwJeNe+bE1wzOwe6qwX22K3rM1AwdOolKFCUguXmS4sj6yeAZyTNPUhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200856; c=relaxed/simple;
	bh=xninY55QUBeN9JzeArBrCFAH1XE6ZvM4j/+V6yX344k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcO5mkIhkiVWMAmQfzGOPE9swzxWAfua8OuEFslKfVOdW63gimg2NYdtxqp7Yl5hFkycS/7jd6vJtag5SFUrclVZTIMSpBNmfdb/oK/93tr6VVKR/pyMJVFLqc0ulJTOwoh8iFN6XTCBROzbO8lvzriMFppvOPoLCRwsgQvaAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X04uNyt4; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X04uNyt4"
Received: (qmail 39319 invoked by uid 106); 23 Sep 2026 22:00:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xninY55QUBeN9JzeArBrCFAH1XE6ZvM4j/+V6yX344k=; b=X04uNyt4EM55j7nsJ5F6blWpRZFqbyifvZ3koRoc2fgi4TVyOI7DSSVLRGTmBXUAg9P3TuWv9cY92TQwpLcLw64xgi8gKswmOtyu7VPo+z09amnE143dKbAtAifKuGVlb8R1iPm2zcwfEEbqSXhwkjqeuv+IDQrH8NZwKvSRxI9HZ1YyebleGiMW8N1s5LtCaYPEccW7cipCH7/aLWm2wPAiW19EYuipB502o/pE0DgSo1jknOMfYq2wsv9/46stB8TaFefTg3nMriWA6KhMghxrBg/t4IcfEmPWqOZ6bsZSn+8yrfP4LXGn3tBJSYwYz+ZMGLIp3Kpdw7pfNgxU4Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Sep 2026 22:00:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 184631 invoked by uid 111); 23 Sep 2026 22:00:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Sep 2026 18:00:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Sep 2026 18:00:53 -0400
From: Jeff King <peff@peff.net>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
Message-ID: <20260923220053.GB49087@coredump.intra.peff.net>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>

On Tue, Sep 22, 2026 at 07:29:02PM +0000, Julia Evans via GitGitGadget wrote:

> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 16b06e38e1..906db7ccf3 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -117,7 +117,7 @@ The intent of this option is to pick and choose lines of the patch to
>  apply, or even to modify the contents of lines to be staged. This can be
>  quicker and more flexible than using the interactive hunk selector.
>  However, it is easy to confuse oneself and create a patch that does not
> -apply to the index. See EDITING PATCHES below.
> +apply to the index. See <<EDITING_PATCHES,EDITING PATCHES>> below.
>  
>  `-u`::
>  `--update`::
> @@ -375,6 +375,7 @@ diff::
>    `HEAD` and index).
>  
>  
> +[[EDITING_PATCHES]]
>  EDITING PATCHES
>  ---------------

I think we have section auto-ids enabled these days, so I don't think
it's strictly necessary to make our own ids like this. But the generated
ids are syntactically a little different, so you'd need:

-apply to the index. See <<EDITING_PATCHES,EDITING PATCHES>> below.
+apply to the index. See <<_editing_patches,EDITING PATCHES>> below.

The asciidoctor reference made some mention of linking to sections
directly by title (a "Natural cross reference"). But it did not seem to
work for me in this case, and anyway I think it only works with the
single-argument form (which has other headaches).

So we could probably get away with using the auto-generated ones, but
it does mean using their syntax. Though there is another related issue
there: these ids are also somewhat user-visible, because they end up in
the final HTML documents and people link to them.

Right now this works:

  https://git-scm.com/docs/git-add#_editing_patches

but after your patch, I think it will have to be spelled as:

  https://git-scm.com/docs/git-add#EDITING_PATCHES

I think I prefer the all-caps one, but it is kind of gross that as we
change the docs we may break fragment links across the web. IIRC there
are similar problems with linking to list items, where we auto-generate
ids to allow linking to specific options (this is custom code on
git-scm.com, not asciidoctor and not within git.git). The resulting
fragment ids are long and gross and have changed a few times over the
years (I think we had to add in some disambiguation because multiple
lists in the same file might generate the same id).

So I dunno what all that means. Your patch "breaks" existing links into
the HTML by assigning a new (but IMHO prettier) id. At some point I
don't know how much we want to care about that. But I thought it was
worth ignoring consciously rather than accidentally. ;)

> -See the "OBJECT PREREQUISITES" section below.
> +See the <<OBJECT_PREREQUISITES,"OBJECT PREREQUISITES">> section below.

I noticed a few interesting typographic bits, like this one. I'd have
expected:

  "<<OBJECT_PREREQUISITES,OBJECT PREREQUISITES>>"

but I guess this is one of the inconsistencies you mentioned in the
cover letter. I'm fine punting on those for now and fixing them later.

Especially this one:

> -	  `BATCH OUTPUT` below for details.
> +	  <<BATCH_OUTPUT,`BATCH OUTPUT`>> below for details.

which can't move the backticks out (because they'd suppress the xref
syntax). But probably it ought to drop the backticks entirely (which
again can come later).

-Peff

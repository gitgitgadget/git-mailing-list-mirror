Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CAE1F936
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775944521; cv=none; b=FD4GcBGUNyRLylpzgD8wyWa75YZt6xLHr7tEMYlK6WGNQzocFHGzDtR4NWvtYDdkpwScrQfWI3cs6TgwXVGf+D42A8vCAI9Z1UW4/wtYFM+yO9cFfREhTJlM6j15a3LuNXrSQbHdjsOqa+zPAGjTVTn4mYLXm0LF6CuBNXRihgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775944521; c=relaxed/simple;
	bh=ad7lNlrPmfPxgRHoM0KyTGQ3w8PGO76hS+LhkWZuTLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJNfet4/csIqYMNAn7GxrINePDZ8/9z8KlWrvZz92T8rviUGuEzEKvbTGPHUIoiOOc6hQpsWzwN6d/kEYuJIizwxpjMGmAg7AskZDaxoqH1UKEFflXRTJ1DyY/aycS4JcwQ7t8epNXEkImgLoXFgnKUW+d3OxlFj+FhrGZz4hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TEH+bVTX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TEH+bVTX"
Received: (qmail 319339 invoked by uid 106); 11 Apr 2026 21:55:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ad7lNlrPmfPxgRHoM0KyTGQ3w8PGO76hS+LhkWZuTLQ=; b=TEH+bVTXvdA0a1ANHqdyaIb3PiwKutBv+Yv4+0v7gw36c6tokVm/F7d9jYVSfRq1+J7SN47ind4A94G8x97YdcA2n4zRn0VsfQWNEprts+FCTpR2HIGM3SxA3Xtp8mT/lob+5NiTlKHlvQARQN3N4Yrk/PxC9vXnWG3JefCBBKU/j+59dG2fDOsPTranoRZB3UKlz5ciqi4TNMYsCSAxPQuajuNwuOoclHctfIAjVQD20Y3xIYnnTse+IqHxbmREt58wRGLXVexS2SgErC1Z1D0+yv3gl+MCaG47smia9jSvBU1PbUmRIRCpG6Wto/bIn8MhRRdI4LcEWwmfp0DmDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Apr 2026 21:55:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 527358 invoked by uid 111); 11 Apr 2026 21:55:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Apr 2026 17:55:19 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Apr 2026 17:55:18 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH v2] gitglossary: fix indentation of sub-lists
Message-ID: <20260411215518.GA1651019@coredump.intra.peff.net>
References: <20260411190625.GA754966@coredump.intra.peff.net>
 <fb4dff1b-d304-4f29-a96c-373b1a73989b@app.fastmail.com>
 <236b32a3-a04b-4d20-8290-02a464037b1d@app.fastmail.com>
 <20260411214213.GA1563438@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260411214213.GA1563438@coredump.intra.peff.net>

On Sat, Apr 11, 2026 at 05:42:13PM -0400, Jeff King wrote:

> > I think the first thing is caused by the context already being in an
> > open block?
> 
> Yes. Looks like asciidoc learned to handle nested entries better, but
> perhaps asciidoctor didn't.
> 
> I think I've found a workaround, which I'll post in a moment. Thanks for
> reporting.

Here it is.

-- >8 --
Subject: [PATCH] gitglossary: fix indentation of sub-lists

The glossary entry is a list of terms and their definitions, so
multi-paragraph definitions need "+" continuation lines to indicate
that they are part of a single entry.

When an entry contains a sub-list (say, a bulleted list), the final "+"
may become ambiguous: is it connecting the next paragraph to the final
entry of the sub-list, or to the original list of definition paragraphs?

Asciidoc generally connects it to the former, even when we mean the
latter, and you end up with the next paragraph indented incorrectly,
like this:

  glob
    ...defines glob...

    Two consecutive asterisks ("**") in patterns matched
    against full pathname may have special meaning:

    - ...some special meaning of **...

    - ...another special meaning of **...

    - Other consecutive asterisks are considered invalid.

      Glob magic is incompatible with literal magic.

That final "Glob magic is incompatible" paragraph is in the wrong spot.
It should be at the same level as "Two consecutive asterisks", as it is
not part of the final "Other consecutive asterisks" bullet point.

The same problem appears in several other spots in the glossary.

Usually we'd fix this by using "--" markers, which put the sub-list into
its own block. But there's a catch: in some of these spots we are
already in an open block, and nesting open blocks is a problem. It seems
to work for me using Asciidoc 10.2.1, but Asciidoctor 2.0.26 makes a
mess of it (our intent to open a new block seems to close the old one).

Fortunately there's a work-around: when using a "+" list-continuation,
the number of empty lines above the continuation indicates which level
of parent list to continue. So by adding an empty line after our
unordered list (before the "+"), we should be able to continue the
definition list item.

But asciidoc being asciidoc, of course that is not the end of the story.
That technique works fine for the "glob" and "attr" lists in this patch,
but under the "refs" item it works for only 1 of the 2 lists! I can't
figure out why, and this may be an asciidoctor bug. But we can work
around it by using "--" open-block markers here, since we're not
already in an open block.

So using the extra blank line for the first two instances, and "--"
markers for the second two, this patch produces identical output from
"doc-diff HEAD^ HEAD" for both --asciidoctor and --ascii modes.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/glossary-content.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 20ba121314..8c4e9dd3be 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -430,6 +430,7 @@ full pathname may have special meaning:
    matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
 
  - Other consecutive asterisks are considered invalid.
+
 +
 Glob magic is incompatible with literal magic.
 
@@ -452,6 +453,7 @@ these forms:
 
 - "`!ATTR`" requires that the attribute `ATTR` be
   unspecified.
+
 +
 Note that when matching against a tree object, attributes are still
 obtained from working tree, not from the given tree object.
@@ -560,14 +562,17 @@ The ref namespace is hierarchical.
 Ref names must either start with `refs/` or be located in the root of
 the hierarchy. For the latter, their name must follow these rules:
 +
+--
  - The name consists of only upper-case characters or underscores.
 
  - The name ends with "`_HEAD`" or is equal to "`HEAD`".
+--
 +
 There are some irregular refs in the root of the hierarchy that do not
 match these rules. The following list is exhaustive and shall not be
 extended in the future:
 +
+--
  - `AUTO_MERGE`
 
  - `BISECT_EXPECTED_REV`
@@ -577,6 +582,7 @@ extended in the future:
  - `NOTES_MERGE_REF`
 
  - `MERGE_AUTOSTASH`
+--
 +
 Different subhierarchies are used for different purposes. For example,
 the `refs/heads/` hierarchy is used to represent local branches whereas
-- 
2.54.0.rc1.336.g4588871dc4


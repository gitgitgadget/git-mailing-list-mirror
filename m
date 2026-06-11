Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8F35F191
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159066; cv=none; b=W27h14qdfxsDL2TkKjuQ1sjzJfeMAnuzsfI/3BeX1AXD6gHdiIX0Rrb7Oc/+CYTfbz/soIi1ZZn/30mBtPc2HrntAL6jAeCEcRWP2EGQI5Uatb3iWSkoYS5UIXfE8pNWFxJEa9QesWVgHGMKB0N6q5Byiei1nmAvf53bRfgeXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159066; c=relaxed/simple;
	bh=1Xma4WCMKq18N3ftRwen7iTajQq6ptIf3Pi8su+Iju8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGAWL+vcoHNaFrIf7CbA8gk+oAe4+9hjCSrnvNBdykVxuFf8lJ7fM/te9HoSR1BBSNrul/hUNLX78BqXhXTJPbT1vH3LLsUU6ye5MSzkOjcN/DRMdBIziTrCtRkFYn0Rwga1EIBucfb28UkLw2fdDuInn9WtHlN/YORdFJAJyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fL0iVcZl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fL0iVcZl"
Received: (qmail 106140 invoked by uid 106); 11 Jun 2026 06:24:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1Xma4WCMKq18N3ftRwen7iTajQq6ptIf3Pi8su+Iju8=; b=fL0iVcZlny+Lb7zo5vI+9p3qeaA8g5hht7zUPUuVcP7/RIaGCNMtA/sP+d3OHsU7MEwEyP6qAmnR7ubd9mlc4oXyDaqSYZCFkML5aIimN8Z1ns7BLtsbG1ssZLRve96KpIJ/J6oXXE8fdG5mcTjlxkzmpzdPWaWL0mpLvLYU8yNFyjOxhBPU8h9OcV1m6DRFm0jgvTNWEMgKb0BlbHmOK85Oi7yl+78M3lpY8lMEVEuy3mWS95F43nJedbRvCjHWCH036qxOXer6nPI2iAR/Euo0mioWBU3hL08v3gYC+okpy375LE9E9E+HyMQknefPvvju8w7Wqz4Lvb6PdKrqqQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:24:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 313710 invoked by uid 111); 11 Jun 2026 06:24:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:24:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:24:23 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
Message-ID: <20260611062423.GA2189088@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi>
 <20260610225513.6269-4-taahol@utu.fi>
 <20260611061156.GC2187173@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611061156.GC2187173@coredump.intra.peff.net>

On Thu, Jun 11, 2026 at 02:11:57AM -0400, Jeff King wrote:

> Though curiously the case of `#` in git-fast-import seems not to get
> marked as <code> in the html output (even though the nearby `LF` does).
> I wonder if there is some special treatment of `#` or something.

Ah, weird, it has to do with our config file.

If I do this (not in the git repository):

  echo 'This is a literal `#` symbol.' >foo.adoc
  asciidoc foo.adoc
  grep -i symbol foo.html

then I get <code> markers, like:

  <div class="paragraph"><p>This is a literal <code>#</code> symbol.</p></div>

But if I build with:

  asciidoc -f path/to/git/Documentation/asciidoc.conf foo.adoc

then the grep shows:

  <div class="paragraph"><p>This is a literal # symbol.</p></div>

Looks like it is due to our [literal-inlinemacro] definition, which
comes from 974cdca345 (doc: introduce a synopsis typesetting,
2024-09-24). I think this might have been an unintended side effect.
+cc the author of that commit.

For the purposes of your series, I think we can ignore any issues with
[literal-inlinemacro] for the moment, and decide on "\" versus ``
depending on which we prefer.

-Peff

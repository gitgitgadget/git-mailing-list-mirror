Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F62F3618
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706576; cv=none; b=qWZJ/HOjRqD7oufQTadyXyTOACqeyJ/boIYHqg6KUvCrkLpkY2z/w2udXYylObyxSa11yQJL1GeaVz4x35gW5hKFUFbdxrdbXLaMIkQI9llOQarOISyKOhamXsmS1QnWA2ee2qVPNV+oneULn+3aYbSopa31SBU+r3NmFqP4Oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706576; c=relaxed/simple;
	bh=JyIWWDn1v/3GXEuhZNA2iw0oL68hCSKO2/VNR2NEXj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o960mUSC2zwvSEgsmmNuHU0Lq7tNGmiT517LqdNkXWRTjlJGSxGUumXsYKg1CknQL6Z60a9eSgZ/3V0MW/3vfes+g4NF6MNJOMR6JcxIxzM0TFXab+uJXS8tnK/Q/OXl+EhF3o/pkkynd1zIpQdSZE/w6wIfkWZA+v3EvGT4fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OoyyTAwM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OoyyTAwM"
Received: (qmail 353445 invoked by uid 109); 10 Feb 2026 06:56:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JyIWWDn1v/3GXEuhZNA2iw0oL68hCSKO2/VNR2NEXj4=; b=OoyyTAwMCBinLeMzbgW+1SAF9OMJtn5UGPqXrHiEpT3bJcbDS33AbAKm34z/2X+1Dc/zDv/aV2Lh5DO3TXmBbaknppqpOWRZ721ynAIu/LGOON4akBJKkdbGzR09cLixpECOitAdW6s+cvlaYeEDGq/yMfiZDvDDwYCYNeGOK38gOXm1Ty8r+sUszupqqHdlLwNrlWf3b+xE/tW5lpl22cRs3Ht7U041qvTkKDjfNhm5u2CB1rcKsW+FvC4EpWF9wVk/VMMnERI5LEjHKSdSjnlHImDC8Enlk5CVD8aWuyT9IguGujvU8tRkcuJSfop4XcT9N5kMp3xrfeBKQeoAMA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 06:56:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 697928 invoked by uid 111); 10 Feb 2026 06:56:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 01:56:18 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 01:56:13 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org,
	pyokagan@gmail.com
Subject: Re: git-am applies commit message diffs
Message-ID: <20260210065613.GC1756549@coredump.intra.peff.net>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
 <20260206090358.GA2761602@coredump.intra.peff.net>
 <aYoEO0CcVt2Qjgnb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYoEO0CcVt2Qjgnb@pks.im>

On Mon, Feb 09, 2026 at 04:58:51PM +0100, Patrick Steinhardt wrote:

> > I don't think there is a way to unambiguously parse the single-stream
> > output that format-patch produces. This is a reasonably well-known
> > gotcha (at least around here). E.g., some earlier discussions:
> > 
> >   2024: https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
> >   2022: https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
> >   2015: https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
> > 
> > There are probably more, but it's actually a tricky thing to search for
> > in the archive, so I stopped digging. ;)
> 
> Maybe we can't parse it unambiguously. But what we _can_ detect is that
> a patch is ambiguous in the first place, right? So maybe we could extend
> git-am(1) to bail by default with a hint that tells the user that:
> 
>   - They ought to double-check the patch.
> 
>   - They can override the check with "--accept-ambiguous-patch".
> 
> It at least notifies the user that something potentially-fishy is going
> on, even though it still shifts the burden onto the person that applies
> the patch. But I guess that cannot ever be avoided anyway, at least in
> the general case.

Yes, I think you could detect ambiguous cases on the receiving side. You
might need some heuristics to reduce false positives, though, since it
is permitted to include extra content between and after diffs (e.g.,
format-patch writes signature lines by default).

So you'd probably need some rules like:

  - Multiple instances of "---" always generate a warning. Though I
    won't be surprised if it turns out that people often do:

       the commit message

       Signed-off-by: etc...
       ---
       Here is some cover letter material.

       ---
         [diffstat goes here]

    That's totally fine, but indistinguishable from the case that the
    commit message contains a "---" and is being truncated.

  - Presence of "diff" header before "---", which means there is
    probably a diff inside the commit message. But then what about when
    there is no "---" at all (as in a non-git patch)? Maybe the rule
    needs to be "there is a --- line after a diff header" or something.

  - Presence of non-empty text lines after a "diff" header (but not at
    the end, which would trigger pointlessly on signature lines). We
    would never generate this with format-patch, but it is historically
    allowed. I sometimes use it when talking through a "something like
    this..." patch. I don't expect those to become real commits, but I
    imagine people do apply them sometimes.

Of course you can sweep all of the false positives under the "well,
you'll have to re-run with --accept-ambiguous-patch" rug. But we would
want to make sure we do not require that often enough to be annoying.

-Peff

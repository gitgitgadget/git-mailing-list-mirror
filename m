Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D23F99E9
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534191; cv=none; b=HbaK33oF5MRcY10n80bvulOGR8HsWhkTjkPgOhEQy8K8NkXwDxYrUR3jWSBx9Z95Jj6QGcHczAvlJ+i635FVk9ku6NHz8n8Cb7p/T+pclUtViO6nTCHoQ1dVdg24L0E35+Urv6Rwd10ERbv1bntiTvp/du3AWaVdYAhCWsKVqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534191; c=relaxed/simple;
	bh=xG0cKTI0vBRCSvvfkYZx2jY4SoYVE2mQqProrY2XsZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmrNnJcis+QJhUH2xykYtGhpU6WerHRV8OBdW1u/WVEsTSblWKzyqlC48+S0p7lau4+cyOSAYB32bCugqLMNkNGO0VOj8ef2A3sC1qHC5mvNmUf3satsvHdqjpyiuHKK9AOkILe17fJA4qIP5Fasn1aZ3n0GmhR8rHyYGXPO4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=H6B/3INg; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="H6B/3INg"
Date: Mon, 15 Jun 2026 22:35:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781534185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XXdVlQvyWdhXOhZyU6bkYWhKk8vel2eRg7xkX6b0ao=;
	b=H6B/3INgX87uHPPkJ0vvZbgrL35zaMHSu+JzMYjI0Q+8lyl19BWqLrDnvL59HOpXNhkL1m
	+W1FEI2MM4cQAS9spbtFXpABmBEaUY4EIMlMlnm4657iF8XpTjjR8j1lgLRO9S3uUms16R
	U9mLNwQOu42MRKYQjglyh7pBix/miAecWCEPle/hFJ7ioNErZWV4iX+BXp+BlAGUMyICGs
	NrOzvq5Iz4utieFHy1WzQjv0MBW6nRB26etylt5pF5lc7LaqEZm9XwVGBHlY93UxgnoDY5
	RqrR7NWWsBLy4LbMCSlCan2GHizXVIS4WVWjsCxoDHykQg21IxJ/YHJ41XwzkQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 1/2] doc: encourage review replies before rerolling
Message-ID: <ajANsC5pfuk0PAn1@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
 <68a1969c35cbc2d24af7a0d09c376ecf403c3591.1781358364.git.wy@wyuan.org>
 <ai_7Wh7hrD8PZozg@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_7Wh7hrD8PZozg@pks.im>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 15, 2026 at 03:17:14PM +0200, Patrick Steinhardt wrote:
> On Sat, Jun 13, 2026 at 10:08:30PM +0800, Weijie Yuan wrote:
> > Review feedback should not be answered only by sending a new patch
> > version. Encourage contributors to discuss their planned response in the
> > mailing-list thread before rerolling.
> > 
> > This makes the author's reasoning explicit before the next version is
> > prepared, instead of forcing reviewers to infer it from the rerolled
> > patches.
> 
> Not only that, but it also encourages more social interactions between
> contributors.

Thank you, yes, let me add "social interactions" in v2.

> > diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> > index 0e2a9313ce..59891e3c14 100644
> > --- a/Documentation/MyFirstContribution.adoc
> > +++ b/Documentation/MyFirstContribution.adoc
> > @@ -1423,11 +1423,13 @@ fewer mistakes were the only one they would need to review.
> >  After a few days, you will hopefully receive a reply to your patchset with some
> >  comments. Woohoo! Now you can get back to work.
> >  
> > -It's good manners to reply to each comment, notifying the reviewer that you have
> > -made the change suggested, feel the original is better, or that the comment
> > -inspired you to do something a new way which is superior to both the original
> > -and the suggested change. This way reviewers don't need to inspect your v2 to
> > -figure out whether you implemented their comment or not.
> > +It's good manners to reply to each comment in the mailing list discussion
> > +instead of letting the next version of your patch be your only response. Tell
> > +the reviewer whether you plan to make the suggested change, keep the original,
> > +or pursue a different approach. This way reviewers can respond to your reasoning
> > +before you spend time preparing a version they may not agree with, and later do
> > +not need to inspect your v2 to figure out whether you implemented their comment
> > +or not.
> >  
> >  Reviewers may ask you about what you wrote in the patchset, either in
> >  the proposed commit log message or in the changes themselves.  You
> 
> I feel like the new version doesn't really add anything significant to
> this paragraph that it didn't already say before your patch, but it does
> so with more words.
> 
> I'm of course biased though, so maybe more words help newcomers?

Yes, this diff only and merely emphasizes "use the normal response
first, rather than re-rerolling directly." a litte bit, as I described
in commit message. But indend, the existing sentence:

"This way reviewers don't need to inspect your v2 to
-figure out whether you implemented their comment or not."

basically already has the same meaning.

So it does seem a bit wordy, but in other words, explicitly emphasizing
what not to do and what to do instead is more straightforward and clear
for new contributors.

Then the newly added sentence can correspond with the existing content
at the end of this paragraph (of course, this doesn't really make much
sense.)

> Overall it's a bit on the annoying side that we have to always make sure
> to update both SubmittingPatches and MyFirstContribution in tandem.
> Makes me wonder whether they are mostly redundant and whether it would
> make sense to eventually merge them. But that's a tangent and not
> anything that needs to be addressed in this (or any other) patch series.

To be honest, when I first started reading and writing, I had this
feeling and confusion. Since I haven't gone through the history of these
two documents yet, I just completed the preset task first.

Overall, I feel that the two documents have overlapping parts as well as
their own distinct focuses, and like being intertwined with each other.

For new contributors, it seems more convenient to just look at one
document, rather than trying to understand how the two files are
cross-referenced with each other. (although I found some newcomers in
GitHub PR pages don't even read one!) But this is obviously not an easy
task for the writer.

Perhaps start a discussion in a separate thread? with all relevant
personnel? But I understand that writing documentation is time-consuming
and not easy.

Thank you very much.

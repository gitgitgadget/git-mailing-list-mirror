Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DD5F489
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801950; cv=none; b=uawXurqmdVmicb3DhO8pL25A3qRWcDsw+AF4zTjhs98PuvBtZSQJfgk7PIhajJqdcjBwxRXcrjaY9BIQ+vLj1XniLtgUZzDYQI/lkoxGRf59cVPDSdPdMlMErgiuibyzsEID9a3nNSk/J4FRn8n1+ifXPCPMReidHlj92Rwk+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801950; c=relaxed/simple;
	bh=pZt0cPcPR+9DHIIIm+aH8gH35gBu0/21cGE3v0fDLU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2f2FF0qybEHFSLd2ZBqlJjvHVvI8oRmD4yxynWFBhzNJAKsTbos/FcALlU0Xfo2P1XA8ELi1m7IE6trAsR++AyQmBoptYDzD8+gC9J/+APQeIbrKuMXTwr1P5iL4/aZu75SB4XyrdcJ99yBNK3lWd4+Eg6h+YvSuT1uZ2FtrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oc4kOe2I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oc4kOe2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD2C433C7;
	Thu,  1 Feb 2024 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706801949;
	bh=pZt0cPcPR+9DHIIIm+aH8gH35gBu0/21cGE3v0fDLU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oc4kOe2IjowFEZ37L9vvCEdllxWvBfMj/AEreJOAueuVsuDO4aIgjOhbjpIjYi7yk
	 8caNE7hbvxApIADGTkqEbvroPklNAUIykWL6EzGwa1q/Lg0ZA1aWZ0nolRTaD1cp1D
	 6UNr4bku5pm059oZyBJtSdRwFXEiRpGr62F+Gifo=
Date: Thu, 1 Feb 2024 10:39:04 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Hans Meiser <brille1@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>

On Thu, Feb 01, 2024 at 12:10:11PM +0000, Hans Meiser wrote:
> is there any current discussion about moving Git development away from using
> a mailing list to some modern form of collaboration?
> 
> I'd like to be able to follow a structured discussion in issues and to
> contribute to the Git documentation, but the mailing list currently just
> bloats my personal inbox with loads of uninteresting e-mails in an
> unstructured waterfall of messy discussion that I am not able to follow
> professionally.

Here's a perspective from the world of Linux kernel, where this discussion is
continuously raging. Funny enough, the main objection a lot of kernel
maintainers have to forges is that it makes it really hard to find relevant
discussions once the volume goes above a certain threshold. These folks have
become *extremely* efficient at querying and filtering the mailing list
traffic, to the point where all they ever see are just those discussions
relevant to their work. They love the fact that it all arrives into the same
place (their inbox) without having to go and click on various websites, each
with their own login information, UI, and preferred workflow.

The kernel maintainers are able to review tens of thousands of patches monthly
with only about a hundred or so top maintainers. To them, this system is
working great, especially now that some tools allow easy ways to query,
retrieve, verify, and apply patches (shameless plug for lore, lei, and b4
here).

The obvious problem, of course, is that these folks are FOSS's "marathon
runners" who got really good at their workflow, but the situation is different
for anyone else who is just starting out. Any new kernel maintainer stepping
up obviously finds this overwhelming, because they aren't yet so good at
filtering the huge volume of the mailing list traffic and to them it's just a
torrent of mostly irrelevant patches.

> Are you consideration for migrating?

Yes, of course, this is constantly under consideration. There isn't some sort
of anti-forge cabal that is preventing things from going forward, but there
are some serious hurdles and considerations to consider:

- How to avoid a vendor lock-in? Those of us who have been around for a while
  have seen forges bloom, and then shrink into irrelevance (e.g. bitkeeper)
  or slowly ensh*ttify to the point of unusability (sourceforge). GitHub is a
  proprietary service owned by a single company who are currently
  FOSS-friendly, but have certainly been extremely FOSS-hostile in the past.
  GitLab is open-core, and the current record for open-core projects isn't
  very encouraging (Puppet open-cored themselves into irrelevance, Terraform
  has gone full-proprietary, among most recent examples). Full-FOSS
  alternatives exist, but people aren't really that enthused about using
  less-popular solutions like Forgejo, because they hate unfamiliar UIs almost
  as much, or even more than they hate unfiltered mailing lists.

- How to avoid centralization and single points of failure? If Linux or Git
  move to a self-hosted forge, how do we ensure that an adversary can't stop
  all development on a project by knocking it offline for weeks? This has
  literally just happened to Sourcehut and Codeberg -- and as far as anyone
  can tell, the attacker was just bored and knocked them out just because they
  could. Yes, you can knock out vger, but this will only impact the mailing
  list -- people can still send around patches and hold discussions by
  temporarily moving to alternative hosts. With the distributed nature of the
  mailing list archives, this can even be largely transparent to anyone using
  lei-queries.

- How to avoid alienating these hundreds of key maintainers who are now
  extremely proficient at their query-based workflows? We're talking about an
  extremely finely-tuned engine that is performing remarkably well -- we don't
  want to disrupt development for months just to try things out with a forge
  and find that it isn't working out.

Finally, there's also the consideration of current trends. One upside of "AI"
(LLM, really) technologies is that they are extremely good at taking in a huge
source of data and finding relevant information based on natural language
queries. I can very easily see a mechanism spring up in the next year or less
where you can issue a query like "send me any threads about reftables or
promissory remotes if they contain follow-ups from Junio" and reasonaly expect
this to work and work great -- all while keeping things decentralized in
addition to distributed.

Above all, this isn't a "forges are terrible and shouldn't be used" response
-- they are clearly useful, especially when it comes to CI integrations. A
large part of my work is bridging forges with mailing lists and vice-versa,
which I hope I'll be able to do in the near future (GitGitGadget already does
it with GitHub, but my goal is to have a pluggable multi-forge solution). I
just wanted to highlight the aspects that aren't necessarily obvious or
visible from the outside.

Best regards,
-K

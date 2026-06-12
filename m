Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D633EAF9
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253586; cv=none; b=TrtlC7CVAzeZIKGrzvahzUwv8H/GzdPsFp+Qn9ktrnyjzdfLZxp7G0lhRWYxds4TypWuM9ajFlqiVTEDsj2gXgPO03ILocvYChKetnd9ZFWVzgJwZQP5zSocPFTRs+I/4Fwv6iQoFobVs/rKR+DW0sAk7bl3T8tnHBOlrvpuWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253586; c=relaxed/simple;
	bh=LPUlxq8Vu+h2iw8pLGiywzmnvawxVPaJauKa77khW7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNH2tVKVl26TTTWWQb1UrBUcvbqbj3SCPDS+Ajo6PbbeD7RynmuYXdw2XSw+kbnOP3bXVcSwFADslcieUXWfCbnBgzo3tfDbFTi/4gXSwtuKXl+3Yp+blX3B34k91iMIU3NtGmHSAApnDnmQFv9JftDG+Be7YbVgQYJX+amUacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=QB2YLP1z; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="QB2YLP1z"
Date: Fri, 12 Jun 2026 16:39:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781253582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GEYVgFsjj6hVBayQopQLL4yHaf3x++AlmtjWMVSlGw=;
	b=QB2YLP1zcJXAi7edaRob6wgw/f+1xVxRbYh2s3/fdwMHAH1eQ822OC3UY2s4VqWbn3xvDk
	c4H1iyuJ1wMpuUa3mVCHbpBxcYnraOC5R2FMA95iJHyEo+I31VBJ9Hm0e8drVPUdddzSYr
	S3ZfW75qNYrAdfPB0qJyISWboNQV3hEuX/sAjAK32ozDR1CrFwJYS1nOVLEj93V119b6Vx
	TvqGPSBUg5qYcuXxXxP6fZhpRalBfABxPQZsCzvNRufTkfNfodMlRWMXcBx2kjW2t0X+4b
	+578KAFYdmKN1rrTscS+gjVaAkFddTgQHRTiaeFiqyZ2FvdkSOwPdmbhyC02LQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] MyFirstContribution: mention trimming quoted text in
 replies
Message-ID: <aivFyBanzoHnYRsy@wyuan.org>
References: <080402ff0ac8127b654dccea59a1bf643df62a5c.1781186476.git.wy@wyuan.org>
 <xmqqcxxwljue.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxxwljue.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 11, 2026 at 04:48:25PM -0700, Junio C Hamano wrote:
> [...]
> > diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> > index 607876f3d8..0e2a9313ce 100644
> > --- a/Documentation/MyFirstContribution.adoc
> > +++ b/Documentation/MyFirstContribution.adoc
> > @@ -1453,6 +1453,11 @@ effect which had not occurred to you. It is always okay to ask for clarification
> >  if you aren't sure why a change was suggested, or what the reviewer is asking
> >  you to do.
> >  
> > +When replying to review comments, quote only the parts of the message that are
> > +relevant to your response. It is usually helpful to trim away unrelated context,
> > +such as large portions of the patch that are not being discussed, while keeping
> > +enough quoted text for readers to understand what you are responding to.
> > +
> >  Make sure your email client has a plaintext email mode and it is turned on; the
> >  Git list rejects HTML email. Please also follow the mailing list etiquette
> >  outlined in the
> 
> The insertion point is well chosen, immediately following the
> discussion on how to handle review comments and before the technical
> details of email client configuration. The text itself is clear and
> gives sound advice.

Thank you for your reply.

I first considered folding this into one of the existing paragraphs
above, but ended up making it a separate paragraph for better clarity.
Let's see whether others have better wording suggestions.

Now the expectations for contributors and reviewers are more aligned
when participating in review discussions :-)

Hopefully this addition will make review discussions a little easier to
focus and reduce the burden on reviewers.

Thanks!

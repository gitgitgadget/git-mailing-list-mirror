Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6356AA1
	for <git@vger.kernel.org>; Sun, 12 May 2024 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715478731; cv=none; b=WJykq2TrFsN9N8Usx9TpHFFYUBS65OkWP86IsHg++cv3SbLV/narVEN6feqwzXQCt/QlRr4TWdNGG+ao5+PHuUGMd68ouifS0fYk+sxmL4jgqJXo7yaY3ge9m1sdkcSpfU44fJu5AQ/Bwpdzjy1IOG0o79CXTnIYJlmppfwIm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715478731; c=relaxed/simple;
	bh=FBo3d17L/xFmkQc1jZm8wPdr1mOudoSBuCi6eEi19+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH7JeUa72+TBB3J2BCUbJr0A7hG3Q8P/fuvFgtj7LXeP8x82GqUkSwQdkQAkGxRKm2vXKMYL1lWzy1yd+1/PlYYdczwMKIdNqjQoqD0Jef1SpKOzyg1M/XkNirXn7bEEml3a3dSosIrIquqCCAhm2RoeYoDlalbB1hL8oXP0QFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q5FMTfJV; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q5FMTfJV"
Date: Sat, 11 May 2024 21:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715478725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsgMGbJb02ljYJy7nPjRfHJh+dZgLeIhkRzUIcJ6/B4=;
	b=Q5FMTfJVOdfbn2QB2zkD8hCSJcQ9IoZRHgniCT1AOjxMmbQNrMwcIDf9QZvKLtRm6lt852
	KiCRX6dV7G4m52849spksoAX1x+QtqI89iS//OQHiBSIyiV/p3I9FNXfufkII+Slb/TMKt
	Fu95YI8BiJvK1tlzPnlfnjMgx3xKpbI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dov Murik <dov.murik@linux.dev>
To: Linus Arver <linusarver@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Linus Arver <linus@ucla.edu>,
	dov.murik@linux.dev
Subject: Re: [PATCH] doc: git-update-index: add --show-index-version to
 synopsis
Message-ID: <ZkAgwBvwswcjZRrF@Transmit-DovM-Remote>
References: <20240510183622.77750-1-dov.murik@linux.dev>
 <CAMo6p=GuLtJtwiS+N366ArFB2ejrYxnsy3S9Ud4tCeW=R5R57g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo6p=GuLtJtwiS+N366ArFB2ejrYxnsy3S9Ud4tCeW=R5R57g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Linus,

Thank you for looking at this patch.



On Fri, May 10, 2024 at 10:18:36PM -0500, Linus Arver wrote:
> Hi Dov,
> 
> Dov Murik <dov.murik@linux.dev> writes:
> 
> > Fixes: 606e088d5d9a ("update-index: add --show-index-version")
> 
> I don't think this trailer is a standard one.

I saw it in Linux kernel patches. From [1]:

    A Fixes: tag indicates that the patch fixes an issue in a previous
    commit. It is used to make it easy to determine where a bug
    originated, which can help review a bug fix. This tag also assists
    the stable kernel team in determining which stable kernel versions
    should receive your fix. This is the preferred method for indicating
    a bug fixed by the patch.

But I now understand it is not used in git patches; sorry about that.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html



> Also, the "fixes" doesn't
> really explain much. Perhaps you meant something like
> 
>     In 606e088d5d (update-index: add --show-index-version, 2023-09-12),
>     we added the new '--show-index-version' option and documented it,
>     but forgot to add it to the synopsis section. Do so now.
> 
> ?

Yes, the explicit explanation is clearer. Thank you.

I'll submit a v2 with a clearer commit message.

-Dov




> 
> > Signed-off-by: Dov Murik <dov.murik@linux.dev>
> > ---
> >  Documentation/git-update-index.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> > index 8c47890a6a..7128aed540 100644
> > --- a/Documentation/git-update-index.txt
> > +++ b/Documentation/git-update-index.txt
> > @@ -25,6 +25,7 @@ SYNOPSIS
> >  	     [--really-refresh] [--unresolve] [--again | -g]
> >  	     [--info-only] [--index-info]
> >  	     [-z] [--stdin] [--index-version <n>]
> > +	     [--show-index-version]
> >  	     [--verbose]
> >  	     [--] [<file>...]
> >
> >
> > base-commit: 3402c0e53fb798cb471dd6562eb5c938885b7295
> > --
> > 2.39.3 (Apple Git-146)

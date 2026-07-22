Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172533ADA3
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701680; cv=none; b=obzHyYAdolY1h6M+zxDmjM1iHZSOHGCL2xrvP6bPfiFyexNrhDp1auux19o7/ER3ADn5BfW390VFvxGm9QW4YGj5cbenaGOXB674SYD2BBwUdhWC7m3+UWUY8mJURYf2zFK6wq6tQ4VwlKdzcMUjVaerJFmWGJsjxeLNHlGXriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701680; c=relaxed/simple;
	bh=JOoo8P0KtZYt/YEaOka/ZoF3J6rKO4if/wmRkjhxPTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyfg5KCekPzwz/xQ2VLbKfxhKK1hQwgHnOqNsy69AttNQJ6L83W9jxtae3k8WwluJvNo7BginJnYivpLaj3mpb1umoshe5yPkMGIE1ILTlJjdPNoUdCl6gPuPXddMBfSPYbSfUMeiacgnLd/cvVfyvqFKcESOZBuXp2e3YlmY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=CKus1LcO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="CKus1LcO"
Date: Wed, 22 Jul 2026 14:27:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1784701675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xl33EFAMUvj9i9i6QuWpFFewDagOrHfkpbpuYut5B3U=;
	b=CKus1LcO82nttdPMdZ1L3mi5skLy1MXAWjPPOpePi+RETc+9Wd+0RQ7MocLNKdraPQi+PQ
	4UCDV4EkB0MlbqP4bF8uhtYmVyXd0NP/th64jGamq54OYyKUVcjAoMi9ylyy41xWJC5vmK
	8oVBmA+hXBBgIcOdr2il35ONRcJP7XbQa6ccJGKaq7vXmVwAhS7h3dEEwqv6yRWkIqKQRP
	OF74TFA93U2cUrjoiJcaM4A/OAGQoQ24T/mp40BwM944YFQV9TqbiqDDXt3X79wai8Nbsz
	VQ0CY7KhpdX/NVFZBQVgQMAqQtzbNuS8Fanwzd9VeO5wSvqozIpcZJ/xdVdkIQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jamie Magee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jamie Magee <jamie.magee@gmail.com>
Subject: Re: [PATCH] t0213: skip ancestry tests under user-mode emulation
Message-ID: <amBi4DIk03ri7y2c@wyuan.org>
References: <pull.2168.git.1783359242130.gitgitgadget@gmail.com>
 <al-1JkcH91aW6VWM@wyuan.org>
 <xmqqwluot3bz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwluot3bz.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 21, 2026 at 02:55:44PM -0700, Junio C Hamano wrote:
> Weijie Yuan <wy@wyuan.org> writes:
> 
> >> ...
> >> Cc: Matthew John Cheetham <mjcheetham@outlook.com>
> >> Signed-off-by: Jamie Magee <jamie.magee@gmail.com>
> >> ---
> >
> > Very sorry to say something completely outside the patch.
> >
> > But may I ask what's the point of writting the line started with "Cc:"?
> > ...
> > I know that Linux kernel has something about writting Cc in the commit
> > message, while I don't see much from Git's documentation about trailers,
> > including MyFirstContribution and SubmittingPatches.
> 
> If you ask me, 'Cc:' belongs in e-mail headers, not in commit
> messages, though the Linux kernel community has a different
> convention.
> 
> GitGitGadget collects 'Cc:' lines from the commit message and, when
> sending e-mails on behalf of the author, copies the recipients
> listed there, if I am not mistaken.  Thus, it is not surprising that
> contributors use the trailer for that purpose.

Yeah, I noticed that this patch was sent bt GGG. But since he has
already added "Cc" at the end of the commit message, yet in the actual
email header, there is no "Matthew John Cheetham", which was confusing?
This is something I forgot to mention in the previous email, sorry.

I may have to take a closer look at GGG later.

> We do not use the 'Cc:' trailer to allow a commit author to say, "As
> the commit object indicates, I CC'd this change to that expert.  I
> am no longer solely responsible for any bugs in this commit.  That
> expert should have caught my mistake!"  ;-)

;-) I agree!

Thanks!

Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E639209F51
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596809; cv=none; b=UI1Z4mh89jkNaIY+2P7P9/Bjmb1Ea4anxl9dANi/TyENzb/u8l4wqXI5p3Tpo3HAgrakkCNRCE5bc9zfkJTSKUD4yHwhBYizGx5vb3o+zlvF36oVF+zuvngK2NB1wqYqlb3eMybgKb5zesfZYT/mItkBpudjMiovi6+Kqa/jCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596809; c=relaxed/simple;
	bh=nxlGwYnz+YNsbky/D1V3nwkE+oztNz4ETz/BtpDCk5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2U+dji8SQDS4kJa3/mpk4psT97KO2VZ7Su77Bq3NGOs9RcMFFCf3UxTTM17wFr6gqm9y0LFEOA59u1cOrhxof3Z48zvL+5tJu+e4g+3MD8eRiu+BrSta1b870i0DIupwLGzXi4fFyOCrKUsdFBRDkuts6YvkbI7ehxw+a+fihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=brqnzV+3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="brqnzV+3"
Received: (qmail 18334 invoked by uid 109); 3 Feb 2025 15:33:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nxlGwYnz+YNsbky/D1V3nwkE+oztNz4ETz/BtpDCk5E=; b=brqnzV+3v7WeGztV8KfYnKJ7AmfuIxMBybsAiNMbnAY4O7HwBYWhYuoPyGhy8KzPqHuwYuD2ne5/WZ3DHy3TMPH38ErsFcuN33Ho7IeAg3xi9Ss8gMZiUxmjEiV7LtFy3o8JqcOHb3KH8rej+Ra1k0XAZS4Qbgoa7WkTm0bPlmLcjXJLiSoejOMTZ4VkbI1L7D5rkY5IiWYVRbZU2nClGoDXs/ZquUc/UHQMA6VRsaYuviq6n/W0lA2TET06CJZ0i8oLhDW5uMxAEBgrHUqriKJtWRKju0gljoqMtKyq0HKPTuRm550iOyILQR+p9uis7Do+MwVBX94QSJX/TPdNTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Feb 2025 15:33:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21193 invoked by uid 111); 3 Feb 2025 15:33:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2025 10:33:20 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Feb 2025 10:33:19 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
Message-ID: <20250203153319.GA4165842@coredump.intra.peff.net>
References: <xmqqbjvyv510.fsf@gitster.g>
 <20250123003613.GA3900660@coredump.intra.peff.net>
 <xmqq5xm6uwip.fsf@gitster.g>
 <20250131233452.GB3544301@coredump.intra.peff.net>
 <xmqqwme73ost.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwme73ost.fsf@gitster.g>

On Sun, Feb 02, 2025 at 03:33:06PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Nice way to use extended context to show why the change makes sense.
> >
> > I've been tempted to support a:
> >
> >   Diff-options: -U10
> >
> > trailer, but that is probably overkill and full of annoying corner
> > cases.
> 
> Do you mean to embed it in the commit log trailer and upon seeing
> it, the log family of commands add it to their setup_revisions()
> invocation, thusly affecting things like "format-patch" and "show"?

Yeah, exactly. Similar to the Best-viewed-with that Ben mentioned (and
that name, while clunky, probably shows the intent more).

But...

> As a reminder for a patch submitter (i.e., communicated by you who
> wrote the commit to future you who will run format-patch for
> submission), something locally maintained might be sufficient,
> e.g. refs/notes/diffopts that is not shared by default, but still,
> this hint probably wants to be per-path (ideally per-hunk).
> 
> But I think it will make it annoying if you forced those who fetched
> from you to use "-U10" when they do "git show", as the choice would
> be strongly affected by personal preference.  And I certainly do not
> want to see anything less benign than "-U10" silently forced upon me.

Yes, this is my worry, as well. It is nice to suggest to people viewing
the diff later that this particular case might benefit from some
options. But I don't like the idea of forcing the view on them.

I almost wrote it as:

  Diff-context: 10

which would be more limited. But even that might be annoying in some
cases. And it's probably not flexible enough (other things that are
likely to be suggested are --color-moved, -w, and --function-context).

Maybe it would be a better feature in an interactive tool like tig,
where you could use a key to flip between your normal diff, and the diff
as suggested by the commit author. And then the trailer just becomes a
micro-format that some tools may respect for the feature. They'd still
need to be careful about allowing through arbitrary options to avoid
security problems.

-Peff

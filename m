Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F61F30A9
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645558; cv=none; b=jEXmsnqjCA4BK2mYi55WiG4vEDAqLl7/d/ZUd2GwT9+Yxu33pTRZxXTHUzYhKF5G7ebiZH7FYQGf24eE+IgqomQE9VxLabMKnmolW9BCpZpNrKr0vWK/B890t7HA7haVPDkGq301MnejWZRrXIbTALAmnBFO7g6EIZwT+Sd75Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645558; c=relaxed/simple;
	bh=XTp0lCHaFf6Uyg+q4II7SZsEy9ITnDi4FDkhd4/0mAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhG1S+d/mvgGey8Dz/qtQYQeF7y22lyX/kWP/L8VeszT7zv6zrJXGDhFgG00OcNcP49aHeicVbtjlM1CJvhQVnuAdckOjX3X+WaHkhq0zYAP0O5WlkVBE6x5MhkfEJUozlezjqoWtphRwHdSP1j5+IwC2KxfO0n7fm75wkwcDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OKSaiNwQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OKSaiNwQ"
Received: (qmail 68115 invoked by uid 106); 29 Sep 2026 01:32:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XTp0lCHaFf6Uyg+q4II7SZsEy9ITnDi4FDkhd4/0mAI=; b=OKSaiNwQoYvZskv/TmmC8axbFWzhQtHBw9Po4Bs9rfSfB5P1Y+KP+8WZGxBx1ZOeX+mA8rdhl6IFIzrycI7l9e2Mn+EVEkoN+PIKwd3TQ4QEXo5oznVD4W3RS9Qk487VFqrmvD2CqmwSLlmHCqk7URaNyQMLuDG92sEgqCzny43y+7ec/0GnfQ9RgPXHI0lsG3fXSilJWnqJVnNXV24ErPAzh0sSR333s6caii0YL+UtniBMnNct1GKglphQPzNsabqp9iPNAFGo9cZZOhX4sz8JBV+759lH4elVokIJ5dq1gU/7DviYvGNNDju2IwMsBQURhXWN6FRz61KUt8PKtw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 01:32:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283698 invoked by uid 111); 29 Sep 2026 01:32:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2026 21:32:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 28 Sep 2026 21:32:33 -0400
From: Jeff King <peff@peff.net>
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
Message-ID: <20260929013233.GA1089022@coredump.intra.peff.net>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <xmqq33uyz3yp.fsf@gitster.g>
 <20260924233726.GB765100@coredump.intra.peff.net>
 <01f196af-3a6a-40e6-86c9-f8b4ce7bfe47@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01f196af-3a6a-40e6-86c9-f8b4ce7bfe47@app.fastmail.com>

On Mon, Sep 28, 2026 at 04:41:54PM -0400, Julia Evans wrote:

> > I think that is giving us a good signal, though. The guide should be
> > mentioned in command-list.txt, so that it is linked from git(1).
> 
> Thanks, will fix this (and will move the conflict-marker-size change).
> 
> Should I be trying to apply my patches to `seen` before submitting them?

In general, no, you don't have to. In this case it turned up useful
information for changing your series, but that's rare. The more likely
outcome is that there's nothing to be changed in your series, but
there's a conflict (either textual or semantic) between two topics that
has to be resolved by the maintainer.

Of course if you know about that conflict and can warn people in the
cover letter (and sometimes even suggest a resolution, or work around it
somehow), that can distribute some of the load. But I don't know that I
would recommend for everyone to manually merge their topic to 'seen' in
the hopes that it finds something useful. It usually won't.

But depending on the rest of your workflow, you might get advanced
warning of such interactions for free-ish. For example, I merge all of
my personal topics every day to the "jch" branch to build the version of
Git that I run day-to-day. So I learn about those interactions early
when my build fails, or my personal copy breaks. ;) But that's not
something I'd expect most people to do.

If you do want to look ahead, I think "next" or "jch" is often a more
useful target. A topic on the seen branch just means it was seen by the
maintainer, and might not even pass all of the tests. Whereas "next" is
fairly stable, and "jch" is (I believe) what Junio runs day to day (so a
subset of "seen" that seems pretty stable).

-Peff

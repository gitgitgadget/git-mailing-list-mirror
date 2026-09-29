Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BA30C147
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646259; cv=none; b=gNOdKqCse2sE6ZaQzYYopjFmNeMkVNdr2nM0c04TT+duWiGsUdFJcUb4VIW+mXFVUhGP4+xxmU4gJBY5R+RA2kO3N1J8UTYoS9UD6Gq5AXdH7Bdi8sclCRRaWh85QG7rGMpoS6qw86yDUHAlmEGo1iC4WzM7kGU2DrxDzccgk08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646259; c=relaxed/simple;
	bh=ad+CP7nqLA8PTGkQJD8dPDBjnXmf07QZ+Ze6gh8Rt7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKqpu+RDPimDW6SCtF7tcdvROZyVoqB5QOQ6sFp06KRXJWzZP8XSZ8Kepw7G3qA/9Ddf56gA0Vn5J+h3iB/Gzo7WQ1t9whR+39UZQBaa+EfL+gZeRfGShHVYQFwCSPE8LasR3Q20JQduwCdTAq4pFa/feM7VeChr7Oi3dAKpYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gxHiao0p; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gxHiao0p"
Received: (qmail 68221 invoked by uid 106); 29 Sep 2026 01:44:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ad+CP7nqLA8PTGkQJD8dPDBjnXmf07QZ+Ze6gh8Rt7I=; b=gxHiao0pXCDpDbV+duSwJgrhCq13oPPRanKYaUttS9L0f8//UpOKSLDVv9fPqCISz8SG6llZdADGvrogTTduYFvVL/SfMsJOPoAkdP3oCuYIe5rkllTKRvOyBewY8H8uBLjRCL0YnrcAztMPbxIfLcIQQUF5iBXVCPaVwozxPzYvte9jhH0YRWfAwtCRL+P84tNZiKzEWov29lDd/zJzTdxk6m/0/adzKDoou6tmnVICSFZThwVTkCio+GofP3o/s9NOL9Nwfuf+2665fecPyFRtPtqEs/DQRg3dMuGuC+p0TuUeCLeBgKjbEDaNi+Jcgsg/xO90w2rCgNP06LMnTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 01:44:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283829 invoked by uid 111); 29 Sep 2026 01:44:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2026 21:44:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 28 Sep 2026 21:44:15 -0400
From: Jeff King <peff@peff.net>
To: Isabella Caselli <bellacaselli20@gmail.com>
Cc: Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org
Subject: Re: hostname: includeIf =?utf-8?Q?conditio?= =?utf-8?B?biDigJQ=?=
 anyone already working on this?
Message-ID: <20260929014415.GB1089022@coredump.intra.peff.net>
References: <CAK4AdTRdNEU8cLFQ_7A=CUUL6u6dc327rn_H-SeBBD_dD-K7PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK4AdTRdNEU8cLFQ_7A=CUUL6u6dc327rn_H-SeBBD_dD-K7PA@mail.gmail.com>

On Mon, Sep 28, 2026 at 08:43:49PM -0300, Isabella Caselli wrote:

> I found a related proposal from 2022 for an includeIf condition based
> on the operating system [2], which stalled over disagreements about
> naming and case sensitivity. My understanding is that "hostname:" is a
> narrower, separate condition (machine identity, not platform), so I
> don't think it needs to revisit that discussion, but I wanted to check
> before starting:
> 
> - Is it still relevant for the project?
>    - If yes, is anyone already working on this issue?

I think it's a reasonable feature to have. I don't recall seeing anybody
else work on it recently (and a quick search of the list archive
confirms).

But see below.

> - Any objection to the approach itself? The same machine can report
> its hostname differently depending on how it's set up — sometimes just
> the short name, sometimes with the full network address attached to it
> — so it isn't obvious whether the condition should compare that value
> exactly as the system reports it, or normalize it somehow before
> comparing.

Yes, that is the tricky part. :) There were some patches in 2024:

  https://lore.kernel.org/git/20240307205006.467443-1-ignacio@iencinas.com/

where the issue came up. Based on my recollection and a quick skim of
the thread, I think the consensus was that it's OK to document that it
is system-dependent whether we'll match against a short of fully
qualified hostname. But exposing our view of the hostname via git-var
(e.g., "git var GIT_HOSTNAME") might be a helpful debugging aid.

It looks like after review on v3 of the series we never saw more. I'd
guess the author (cc'd) just never got around to pushing it forward.

-Peff

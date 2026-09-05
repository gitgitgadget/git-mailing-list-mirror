Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0F266576
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616270; cv=none; b=U3MOPGom6vd3IdfOzjBIMqWn07XCG+V+GqxLbKlPqS5tnxwsE4vZKv7bhwTrDjuSJOMmKVG2laZkUZ+j9sJB3z9rZ+ygsvt8wn8UQWZ/ptvMLm5zWspXWa4xelsY6rgOV+3mQ6pbX0uZYmzRt3M/PG+KLHQW2kGPG8CfStAI20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616270; c=relaxed/simple;
	bh=Wjf2eb0QsaltyK2wLqN0Q2IIBCBPePQ359SPzpzeR1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isQIVmVFFEh6UIVT7feAlqdBrojv+QkVPifd2Xe5iLXBnsDhyBH8tH0y86zneO0x/7R1J82SJT5FmKoPKJY3B5Um9LgpEz1z6+a7JlSXY0JXsYPbrWIQF0JvkmQZBmuMBduwy3R0SGSMWD3NwZQIr2Y2WxytfBqDTZl51+0v7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YFA1Wf42; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YFA1Wf42"
Received: (qmail 18680 invoked by uid 106); 5 Sep 2026 13:44:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Wjf2eb0QsaltyK2wLqN0Q2IIBCBPePQ359SPzpzeR1M=; b=YFA1Wf42MlbruO+nsjPLGP4DP4a9MVSVa/lbxkadK81UAU5bIjDZHUq3hNK4DEghpFRgB6fa5zrzdeBYDwG78w5sdfVjxSRIuX9v4jpSSDyM6N03BW4bog0FkF+R687ijtAeZ5cuMwbZ+NBQDS/XgwkxV1mrgEz8MGqxiSFzMA91tqxnEZJ8SYLTtszHKhTTqS3n4CSCgSIhrIMBxRUDKr5GLzJwLLp1cnG94z3FiN6QMMWM4n2NX+9fXZexlm8fz7eLDSpHm7zcSdItiJ+DloqL7UMZaCs31tJiq/wCPJeB1x82WKSQNq5XXwA1s7cmL79AZknEUH57AYSBglhonA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Sep 2026 13:44:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 92871 invoked by uid 111); 5 Sep 2026 13:44:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Sep 2026 09:44:25 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Sep 2026 09:44:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	tnyman@openai.com, Taylor Blau <me@ttaylorr.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
Message-ID: <20260905134424.GA3914039@coredump.intra.peff.net>
References: <20260726083254.GA3528497@coredump.intra.peff.net>
 <20260726083905.GB3529069@coredump.intra.peff.net>
 <anWyV9Q4Cmsa5AoT@pks.im>
 <xmqq8q6hgb2m.fsf@gitster.g>
 <anlj3kdAfOh8OnNR@pks.im>
 <xmqq7blx7tii.fsf@gitster.g>
 <anqs8mT78znJmUwJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anqs8mT78znJmUwJ@pks.im>

On Tue, Aug 11, 2026 at 07:02:42AM +0200, Patrick Steinhardt wrote:

> On Mon, Aug 10, 2026 at 10:52:21AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > Taking a step back, I do have to wonder whether the Cocci files have
> > > been adding any kind of value in the first place. I myself introduced
> > > some of them in contexts where I made sweeping changes to our APIs, so
> > > that any in-flight topics can be trivially adjusted via Coccinelle. But
> > > I very much doubt that anyone ever used those to adapt their in-flight
> > > patch series at all.
> > >
> > > So maybe we should just not do that anymore?
> > 
> > We still do catch when somebody writes "if (a == NULL)", no?
> 
> Yes! What I was trying to say is that we maybe shouldn't add Cocci files
> for temporary migrations anymore, but still keep (and extend) them for
> evertyhing where we want to consistently catch antipatterns going
> forward.
> 
> Overall I have a feeling that I'm overthinking this though :) Maybe it
> ultimately doesn't matter too much and we just continue what we're doing
> and then clean up every once in a while when too much cruft has
> accumulated.

FWIW, I'd be happy to avoid coccinelle for transitions. The most
important thing is for transitions to be brought to the developer's
attention at all, so we don't quietly produce broken programs or
continue adding callers of interfaces we're trying to get rid of.

But bringing attention is often done trivially via the compiler (e.g.,
changing names or interfaces). Coccinelle can further suggest the actual
fix, but most of the time that fix is either obvious, or easily
explained in the commit message (and I feel like if any project can do
so, we should be able to assume people can use pickaxe/blame to find the
source of a change).

So coccinelle can save some work in these cases, but I think it is a net
loss overall compared to both the effort in writing the semantic
patches, as well as the operational headaches.

I do think there's still enough value in the enforcement of rules that
can't easily be caught by the compiler. Style bits like "a == NULL" are
an obvious example, but I think we have some "we offer functions X and
Y, but you should usually use X unless you have a good reason". Though
maybe even some of those can be simplified (stuff like oidclr() should
be preferred over hashclr(), but maybe we are at a point where hashclr()
can become a private function?).

-Peff

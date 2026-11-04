Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774059;
	b=rYtzeuU1rMh7qMs4Bjzy2K9Jnl8zkffcQ8iz5JzZSf25OKMrdiXkjr5irxd3l+f7ZiBW
	 DfYSsPPnKzAv8pxBhSpWOtWpCKLN5G+XakkOdh4f0w6WUqWGO455S+b4qb1W/RwL1cM2V
	 jSPBmBdPNSF4eWt+DMaLu6MBXZSk7TIVig6uoC2wb3vtmeoCy/BPXPjHflAhav4FQ14zh
	 FEUXdGqIfiTZf8GvF77pvjT8y/N91YvYyt78CBRZXIM0yKrRdO6503HOeTmRPgt6ZIaCp
	 y8L2WDNjHXtk/+RjwLJmnyT+uDLVy9til+4GR9isvzQiH7YMP0d07H6MNtY4bNX5XYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774059;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vSIqCp/FEoWHPl/CuOXbVOD1hEplsI0SiZ+XeO61940=;
	b=IHb9Nt78spYlCtTK8hTmrnHFgCKfU2cROa8FfRWc4yhU+DiOc2b1boKVY0VEx7HonmNV
	 f0CYmscctBo1Y1RpWx2SISrKJsCYUwHlWtgSqU4ItIvZToKE0rI5h/aBE9ad/VBgQeqCS
	 KH0BjqGG3kNulZJCKP6WMKLTU81KDiM+/akto6DopM/mT8S3xhZbMCQ/7Ka2E3veFBwTk
	 /BIqR6A6I/Etb5iLnjeElLv9/x4p81jLy+W1QLIs1Lgxn8Z4xjJ8F3EPoQWm5udtWR2iO
	 MxUnGDcrJPK4B7BdjpyhCAFyjfcjj7v26VwVoz01dSkbmcfuIuEvjoZY08BEP4xgOYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=XwH+ZdyK;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE22606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE22606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=XwH+ZdyK
Received: (qmail 12305 invoked by uid 106); 4 Nov 2026 06:34:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=c7wURPimiTEbKvMhsKQwhBzza34VXasqTWb9un/DDLs=; b=XwH+ZdyKutYay4Zojg0VmeChG9Da6ArxSG3jcGZx8XnIIyJ/mry+0vtNRnoTlOc1oND2gKuWFwJ7x1spmLgdcSPmmfSPiPw3/fodaZfX/keMTcS8zI2JeNMoR5gFNee+cMuoKcb/WyuZW7BN8T0d//EBbZuCIu5V0B2bv8CnyymGkdX7+feiDlmVg1+9B3UdbawbdROJsDGK62PgVF12XJsV80Nqpw72LFUUpY8a9m5BYMEZsA5WY21vWGcoq234qtaWX4F3X1Ngty79oFFjx0rXiBElxD3uvVWcniZKLrEdpjk7fmConnWkvGhk/CDjJfXD9qZKCoA9wPo+2C8RnA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 06:34:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29578 invoked by uid 111); 4 Nov 2026 06:34:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2026 01:34:17 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Nov 2026 01:34:17 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Emily Shaffer <nasamuffin@google.com>, Tuomas Ahola <taahol@utu.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <20261104063417.GB1543013@coredump.intra.peff.net>
References: <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
 <20261026011731.GA3575069@coredump.intra.peff.net>
 <at8IBMQZtJP3bQ9-@pks.im>
 <CAJoAoZnqzKv8ocsi1a-nC6LaRnpKKCO0Bxt-Pdn0dDUziEcpAg@mail.gmail.com>
 <20261030180016.GA7582@coredump.intra.peff.net>
 <auha0Ze6xksBXaVx@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <auha0Ze6xksBXaVx@pks.im>

On Mon, Nov 02, 2026 at 10:41:37AM +0100, Patrick Steinhardt wrote:

> On Fri, Oct 30, 2026 at 02:00:16PM -0400, Jeff King wrote:
> > The "X commits and active in the last Y years" one covers you, I think,
> > but probably excludes Linus (depending on the exact parameters).
> > 
> > At some point, though, I think there are are always going to be weird
> > exceptions and it is going to be hard to come up with an algorithmic
> > rule to get the right set. Perhaps there needs to be some human input
> > ("we all agree this person is an important part of the community, even
> > though they do not technically meet the metrics"). If the metric gets us
> > 99% of the way there, then that keeps the human scaling part down.
> 
> One counterargument though: is it really that unexpected to eventually
> exclude people from the voting process if they haven't been active in a
> long time? I think that the ability to cast an _informed_ vote will
> quite often require context on how that certain topic has been impacting
> the community. And sure, a person that hasn't been active in a decade
> can of course try to discover that context before casting the vote, but
> that only goes so far.

Yeah, that was my gut feeling in the original suggestion, and I could go
either way on the logic of it. Linus might be an extreme special case
there.

> > Of course that opens the can of worms of: how does the human part work.
> > Which humans? IMHO I would be comfortable with Junio or the PLC just
> > saying "these people also get a vote" (with probably a big initial list,
> > and then periodic updates).
> 
> If we do that it needs to be fully transparent though: who has been
> added to the list by whom and what is the specific reasoning behind it.
> But as long as we have that and as long as it's made public well ahead
> of time so that it can be discussed (and challenged, if needed) I'm fine
> with such a process.

Yeah, that is along the lines I was thinking when I said the above.

-Peff

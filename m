Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80656361640
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936447; cv=none; b=O9QRytGclpawSqJlv8lYMwvVhzhgCmQZBOj6VfIn1lKprC+XxZAOr7xEja3GQTgIfngtKWcshd0ftay/QAw5BbbQLsrZeOW1LzJvu3NOFyg1ODQsGD5A92czTBC7KZSLpsOW6caObGQtCV4wBG75zWQfpf80cngwuhcCBxddlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936447; c=relaxed/simple;
	bh=5w2vEpGvLY9EAaFI2lfywMXnC8ZQvGZpPzegfL+KfPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyomGKzXKn5JTh4YXbqZ8gd+mUEq0zmo5bfLL6fQIohQOSOru2DjKpl7HNeO5ORCWVDuVCfIXrhKkkakyKsw8AzOb0BtYXW2kcDgjnemQDPaTjJ+C0H7TDrG50V2MCSIFd+BOQNJYmlAZshoM30Vmopgn9zXP7rUd0P+bDNU9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CzWF6gcT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/KCyOOa; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CzWF6gcT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/KCyOOa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71D8E7A00A1;
	Mon, 13 Jul 2026 05:54:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 05:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783936443; x=1784022843; bh=klpO7/7U9C
	ih42+sbm0U56IeC324cxUU5bqdztewhZs=; b=CzWF6gcT9a1KzuSQV7iq5QEScr
	Tacm11zjvndmBCqLB8lbgk3xX3ZAx3sDMqpZFr9tUu+s9V982ty9LFpdujjRQPeQ
	XkgWW4zj5sS0pQeK7EdwOPJg8lfPHIXzP4PvzTA4oRYe6+aX5yZFhpEyTREdER7s
	LMDR/DaM9Pbnp/f4iVm3u9mZPyspzVxYUuxHenjlZ1XBzAOLdvxNJwOicT80HIna
	dwLxZELFG7L0XuHDGfc/3VmSdmBsiTJiVozSJ/6qJQcFLt9OGlk0K0i/iKvZslMP
	oDBPvfWeX9PcD9C3YOc1e24uUuirFnUDDzvrwUDe2eAFORTqAKu7GoPYhttQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783936443; x=1784022843; bh=klpO7/7U9Cih42+sbm0U56IeC324cxUU5bq
	dztewhZs=; b=H/KCyOOa0mRDzy4Evy5VNcd29jYX/eZucIGPPRgxvTGk1im0Rca
	/HUdWPtC+8TF14SGpVxo8sbdV/YW0AaVcQPDY9u0rZU5hWoF8ERUKjXi/6dUtcqt
	c2wmTg74WvJvCxLmeLidzVWsWkTJD3nC2wH3+QVTE+IjHRjjp2DS399RucN9P54B
	bH5v5EO6VPGP9+LV4FZ50VnHRfPIS88/3KJ+mmDONERT0Chjgq0AEMBdEi9C5y5N
	Gj8htu2Mduu1/V10Ve8pFmE6KH4j46z4H10X/uba0OWPoDJs6tzPbC3ICcif8uO+
	a9wrKrDl0l79HZ5B653P96Yj/0wRtlI+mMg==
X-ME-Sender: <xms:urVUaoQlCAxtIlsEb_Ni0QKMtGc7PEzxVQT6LcKj74CCDUEgtHErew>
    <xme:urVUasp3CZqNlonspWvsb1BvJibLUYjlqSHybqVDw3RAwOYcHsCJH5eN7ngv-3C3L
    -Lijnhlsj_V13_kuMAOQv5m2-0Q3Q84tOSaGoyTOK5P0Tu7LepBh2s>
X-ME-Received: <xmr:urVUauIP8lTkPrSaFZV4Ufz0qzR6eUQhLfe5jipoaaZgilg8vtjKXwVFstSDwYNUub-8lTmP28d4Zvff3MwwMvTzpCWCgfVTK0JF26VP>
X-ME-Proxy-Cause: dmFkZTFpIvDtKCle0paMOTLD0Kj8Oq9aX8qs2vJ3RujWphZpwLxj5eUN5W65KNRjPmNmlr
    IvyN/7a5XWWGK1Rzvj7XPar25XEHOBoqZeHXY/2d3NA8gKNzfRhrI3b+MFnPsVnzWrBaY2
    vWRKWYQTjUvo8p44ONKNwjAQOHBa2U3gm8/Xp9oMIDu3cl1XV8ya353vI3HtgkAcKVTYSl
    rmrr4EAI7vzh5FYlQ7EyKyO6SWKyJQsQh0YgR5n0iuX7XgKj0Y0v03LXQREDXZBxrAD9bF
    yW/WxykMLpRFl/z8Q0WnlSwyce+dLeXxDVmdy9m5bzxB3n+60+RXDJPQ7wuOqj1Akq1et3
    yHyiZEtbh69VM/Iky0UERE58IDmjiPjYDb7ai7vEIyspj3j7cRaB7Tex4t6/6CeIZJ4bM2
    HOfk8yQzcofxWBOnG3meHLoSK/A6jJdFX4zDkUEL+ETOyw0AP0kQO3zTpUZ42jKVMROt2Q
    JXiqIC59DlH9kZ6RNmjCK9rXTr84jec5tGbhs4s3+p1a0chBQeLqlXw2Bv3d71C33WHYSQ
    oewaqM9RlJh07NWK6KNSz9/kbyecCb3PrBRYCWZ6s9LPpJlRS9fYf76hNxfkoJfzwkRTcu
    j3+uFVUiO5fMr+FPO/uLVHE+7dx3YQxJRklX5TnkgfUFxy8pOgaPVzo06LSA
X-ME-Proxy: <xmx:urVUanr5TsuAfhY9DbNfQuJhVT1Db8kQg-xaDFr70Ehj4gYCy3TsiA>
    <xmx:urVUauyRUYKX_1MP3ng6FnXKnlBoowKI_8CgUF3m6u4ST80Khk96Vg>
    <xmx:urVUajODYffBHuLetHFza62of_jE5gTqzhWF5YBkzlHRj-NFkWovCg>
    <xmx:urVUar72oXMOfFxhXXt7KF55-zE5Df0luoP8SERgX9X3uffAcc7Otg>
    <xmx:u7VUav8R8XvaPrGuSF8Yg9zXf4UHRn6ryz9DTVGixSwtrt2WP0By4Pj0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 05:54:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c615f1d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 09:53:58 +0000 (UTC)
Date: Mon, 13 Jul 2026 11:53:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <ttaylorr@openai.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] pack-bitmap: allow aborting iteration of
 bitmapped objects
Message-ID: <alS1rus9thie7NiE@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-3-3710a9cc165a@pks.im>
 <alFzja98avOoKjQE@com-79390>
 <20260711080114.GA1470749@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711080114.GA1470749@coredump.intra.peff.net>

On Sat, Jul 11, 2026 at 04:01:14AM -0400, Jeff King wrote:
> On Fri, Jul 10, 2026 at 03:34:53PM -0700, Taylor Blau wrote:
> 
> > However, the remaining `show_objects_for_type()` callers from within
> > `traverse_bitmap_commit_list()` do *not* bother to inspect the return
> > value, despite taking in an arbitrary 'show_reachable_fn', which itself
> > may return a non-zero value.
> > 
> > I guess this must be effectively OK in practice with respect to the
> > existing code for the same reason you indicate in the commit message
> > above, but we should change this function to *also* propagate non-zero
> > return values to eliminate the foot-gun completely.
> 
> The matching non-bitmap traverse_commit_list() does not allow aborting
> based on callback returns, either. In fact, its callbacks return void!
> 
> Whichever direction we go, those two should probably stay in sync (so
> either both should allow aborting early with a non-zero return, or both
> should return void).

That's fair. But adapting `traverse_commit_list()` requires tons of
changes all over the tree, so I'm inclined to rather leave both
`traverse_bitmap_commit_list()` and `traverse_commit_list()` as-is.
Does that work for both of you?

Patrick

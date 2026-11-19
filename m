Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089593;
	b=bx6fv/y+a2qpxMIZeXJ+rR62shadGAz6tkp9VBflBB2pi+F4Bp++bnp70u0+gOJdcPhr
	 /zmO1/szlLSRRxj3S6EcJhtnXYXMV+KN9yguaWifBQoCZE9jVpHPtfvWf1UASdPeaDKTk
	 qgruepvqJRfkxNXq9nIZaaLtvhgIdg/PK3rV1x6c8yBNi+D3NyTkURIHffwlWJMSO7GnZ
	 14Ugj+AaibT2AW2Uz/W1oLW38MyuNI1RAHpbA4Y2QGvmESD3rpk4SDAJR2JYfKAY8iENV
	 xdXAa2MHttvax3bEyTVRvegI9UPDYMn/oEUNXhogQ6Kz6Wz8eOvgFKqhr8LMckircLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ghVamjdRp/2DZ+0Clr6rkoNo073A1KFwqLDRlwLTk1o=;
	b=X306u/uQw+hALwuy2Qrmi+2KKkGWHsk20V9jP+/9RPh7hcKY6ADShLI0ADW6B+76OMMN
	 ZDlrilC+YVVz2hYcgsVgEb+wrwcKajqK8mLSbkJHhMG/nVqgbfElaGc/1R9BMSLbaBbha
	 ifu8HVThv4Ptw6IDs51H97oabf3vrvGcYLoK2ewiPMHdOOTTJ2DFu8/M/a+uVogXy5OKQ
	 qaYtkRsbjrBzrw6bU2zf9SdgE5R7KmMDQAXBxk/N2pZ/Eg54RcS/tPGzPcIztTFKdd8Oi
	 I6rVfCnlY6Ei7NQiehHSB+ZAmZdJdNIJMrbRfGequn5mnPI/LcE3GB4J+yM/l2tiU8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=BSFkMM9T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dzAcmsq8;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC59E606A330
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC59E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=BSFkMM9T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dzAcmsq8
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D94014001C7
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:59:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Nov 2026 06:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795089592; x=1795175992; bh=ghVamjdRp/
	2DZ+0Clr6rkoNo073A1KFwqLDRlwLTk1o=; b=BSFkMM9TWWNtRyQ1CV1edj0AVs
	e6LeVidZKlkfeEFm/4W2iZpXj3zn0FnaAac3WMAMxI2F2PGxZTuXAyD368SIsBah
	nnNsus4NsEP/zk7+Wv5QBnQwsrDtsoA2WcKgsaU3GG673c3u8Y9/94j3L37gozRc
	5m5eQncflnQCRAhH0M9JJxDaPtv7D203Exx7gb9N2sdOzFmH578XYDg2HVDFEJzT
	lknmus9DmbPIsMsjMcs2H+TnV5A0VSCKNffkPIn5MEz2YrIy6gyFLt3Cq+A3+SEV
	ceVFHPxYHypjCzmFvyb+i1206Ucft4QL7/UirCdlAfMnT1Iywk8bi+tDXDSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795089592; x=1795175992; bh=ghVamjdRp/2DZ+0Clr6rkoNo073A1KFwqLD
	RlwLTk1o=; b=dzAcmsq8iL0wr4O33TQIKWutxzQMVIjTexwKw6h/1mYIqCC6GJR
	nkLq6LI+PNvIvJALoGAbWTpsYI7UslEqalk0mqI57yeju0NjyrJF5MfHcc+0O7Vo
	xRCYkffsSobfFhM8qRnXjDyK01dBtlEF3B17YQZjFtAKuiumVmp4+35VdwEtwM2U
	B2tm2IK1winIIJtjwwvxb/T6fBBhWReUiaZmyD/JGhz8Wqth6St+Z0ce3o5rFNSi
	VasLBxh8F1+XQX+LYgCJeGXB8Lnnki0kh2WszYu3faA/B3UuhDcA4wnj6qk6kxfg
	DhztLEjR7TNNpjozebOuKlg+/8S7a5qlmFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795089592; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:JEQMudhziuQu4KxMT0LTZFzJ94tbT6jUS5DZgiNazycYRYj
	3qpTEubo5gwbGNi0K/Y53SFu+xrv6MZ3p2DFtVvQQyP+1IjzqohjjINftPDJ82kH
	ipmgkUJYTZErkBSd4NNJaITSXyHmLceyHqwhpKUDUykbHQi+RRc+VYXIotVwwqNh
	oaKNb4NGC+X5fDX/5NDjbdAlvIVc6INzIbYvyX1Gt93HT5YAGWDadURjog3YvBtO
	ePlbnlLUQy+psAGk9ZdsWmXTNV0JdN0KFsAb5VgrE+oiimJWTYeDBBrGLKzX7YGp
	EF5fGk/ui6Cs9P61Vc3j1IZaVUv9wES6dv/fdsg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cXjQKywX0/NZUZE8YeFtLB7nQNcfnAVSSo0TyNIXnqE=:PhrYqIpa+eGH0vYp102b5EgLfnFv+FadAQQbIqn1aww=;
X-ME-Sender: <xms:uOT-ahGTgH2ECqN64oaJnsxA5zGibz82m5gHJhh7yRfTCftbHobCAA>
    <xme:uOT-asWDHx7ktyJo66k0P31GrJjfyB-FJbh9ndKbH1WGHI6yg_qG-cS548iiXlyIN
    uLlL3yeNJIqRWI0aJdfI0U-m6NZ4RRRTsOigYYRhjzPnScwGBglb4A>
X-ME-Received: <xmr:uOT-agwPs6foBkhZuUmpoZor270N468_gCaqQcZFE0nT9SodOAeBaX9miZ29BNGMP3H52c8>
X-ME-Proxy-Cause: dmFkZTGgIerkrtMIFMQFB6roBRxdPpQGBCB7qFR5lLl4910yenwH0lsvSEkqgS04EOYB/K
    60wlZwSRGxu2gFMBYop4bsk3Dt/T2Yn5DoXewfRUL2ac5pB56DZR5S8YCWsFw63VBkRRHP
    bgXEXMVDlJbeB/3P0Md1l02ZI+U6KJPvZIfONhh/oNbapJFbgNZhzQcB6UDh5j9D+rXZuF
    JRiZfFbJhwRLGhL30L8ksz4LGtfeT8hyrxQjYD7dT6FRkWhcQDNn52dAYEGgDXHqsRxQcl
    zt2pmVxAKyAyGXz8w8vGdSzASKzjNh0BeqXwfXgFZ9u/IvBa9nX/+TL+n1F+VnmMJzqurx
    OGcPYik0oBQ4GKmLKwkYGyLF+i4Ghwcpzdfyr+23YzVA2rIS6VZFjZRE18plbOecFDGk78
    qbMnQxJfRkDjxQLRIZM9vLhjXxfKCb2ViyrOgQbbqx9LOM+nmKfD8k8/BJf2gp0zJQ2atL
    Odcl5pVWMTLYZcrUm9b6XBPVvOxFXh4DaKDJ4YmwxABWHQ3FAls4GJJ6LKTPWRMYYlXkiK
    ojUbyGvhKoA7UrW8dLE4cSPP1y8TXpD76lc/7WIXJJK1E/v/AsDxZ7eeYz4bJLWG8SE8me
    orYFyi250rzy5MpjxlqUzeQy6bIr3osOCUmUPfkeYJV/APR3YujUEf++e4kw
X-ME-Proxy: <xmx:uOT-aiN5rLU5B6NLXbaTg1gtxxuKt58lKWiTl1Q-PvS-9l4LL-p4AQ>
    <xmx:uOT-ap6DTz-4MP8FO5-zL1Hn7Jwl1YAi3UXnIPFIbC-GSlp3xghXUw>
    <xmx:uOT-arPpWlw2hJzVvVU0Ojo4gdRwWV0ZAQ8HI7elFSVQh2k2kwPLqg>
    <xmx:uOT-avkFRYcbmrls90lPQSVDmryCw8_VCFrIyRBst8GO9m7Yw312KA>
    <xmx:uOT-asd9WYDwHLwYhIC1N0VT4BI-OS_LPofyeX0swiOnTj9W7wWOjiEH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:59:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7f7a7d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:59:50 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:59:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] refs/reftable: don't write new table on dry-run
 expire
Message-ID: <av7ksRi3bQtx3pGf@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <20261118-pks-reflog-expire-performance-v1-1-10b9263566a8@pks.im>
 <xmqq1p8i84ma.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1p8i84ma.fsf@gitster.g>

On Wed, Nov 18, 2026 at 08:51:41AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `git reflog expire` subcommand supports a dry-run flag. When set, we
> > print what would be pruned without actually pruning anything on disk.
> >
> > But even though the expectation is that the on-disk state won't change,
> > the reftable backend still ends up writing a new reftable to disk that
> > contains the changes. This is of course rather pointless, as we would
> > have already printed the entries that we're about to prune at that point
> > in time.
> 
> I hope I am right in assuming that the current code already has
> provisions to discard (or "not to use") this data written to the
> disk.  If so, that means --dry-run is working correctly, and this
> change is a performance-only improvement.  Is that the untold piece
> of information here?

Yes. We write everything to disk, but instead of committing we then call
`reftable_addition_destroy()`, which calls `reftable_addition_close()`,
and that function in turn unlinks the table from disk again.

I'll adapt the commit message to make that explicit.

Patrick

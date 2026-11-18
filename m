Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998301;
	b=A5VThnTaUuc3NYit+S43WuMEnmEr+CXaK3FDWgWKMDgEetQGPPZLDOOmx7VQjHpFUrHZ
	 47oT1DAsgbG1sYWVfK6JaHKYQ7oaDrUtITzHfuSt8A7UgZIgQobroFe24nkaGc0SmgPNi
	 B+qR6H4maWvIC5HxrCS2LzxDyIzA2qTH1LMMgS7jbBNzop7eCHfzugQi7jIWGNyfjZeQc
	 no4uwjtJy+WEbO8ifShEiU46xfwI1fI3eYa+V6vD6WagDBtAzqJj8d3Oam/COVFtBsSjk
	 +Zvl/SxpHdJk1DSRlFrTlyuj5vaKlojU7EhjlmqI/SzBkoq0ZWeQjVV3+79AFRQ++9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998301;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jq+H+AcYJpurAIPOmvJ09rkoGxmJkLsIUMsLLSX5+ko=;
	b=yuv5O2Q1NlLqbhjRXwHZhDL2vcKBVIGIMy1tpO6YMvEDpYR9z8+tMtrSkEzx88HCe6Tq
	 IqddsCrWvwn3aENR1WuQmMOALNbVteetDRsZy24JzdwuPDNF4S9Hpvd30Aqjj/+fgKrVP
	 0U+Z4PYh14x6aGKYn0aTbkhUHcU82K4Ehma0Cxhf3u3pr+UrGD4zpixZsLMIdEyy6jXzH
	 XHh/nTVW1XveQtReVh0gTusi6Xdary8nwOXxuLF2QeFwspFizmCjqhl/NLxB/BwqFhZC0
	 ReBbRYzDdvTy5Bz1Iw74jzNHjncmvw1TyAQ2vVc9SDsi7tBOMEBRK+l0NBg9swWsUQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=v+MjQha7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s2VUezyC;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D1606A325
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 10:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00D1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=v+MjQha7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s2VUezyC
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BEAF2EC088E
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 05:38:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 18 Nov 2026 05:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794998299; x=1795084699; bh=Jq+H+AcYJp
	urAIPOmvJ09rkoGxmJkLsIUMsLLSX5+ko=; b=v+MjQha7TZMkT7SbzavnvmeAas
	jFm7PifSHo+glM+fMQkiYAOlIegZ1VxIOCORCzFPvOGzNfJrvhq1hPdsLxB9Yc1k
	XZhoD7dVH90OhLt5KkuFTOaRY/50ngKUShY/lVp62bLVIZ87LcGLZ0Cx58BFsfBB
	U/DAghIkE4tQJYmt1Z1flpEJiH2FOs1ktwiYX5pmcInvEQp2KUazUvaZbkJEgtZH
	dO7P6a/telpVPUQOXCUsahLyNH6xzW5jorh2PGes31VsLWbjYYYYRZXOm1uB5NTd
	dfr3KZYvcJaeB/37vzCXoJ8DPhkfBEqzxygIReCW/Vud9dEQOj00SVjiPUcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794998299; x=1795084699; bh=Jq+H+AcYJpurAIPOmvJ09rkoGxmJkLsIUMs
	LLSX5+ko=; b=s2VUezyCZEzYDi2YLN/DZ3Nm6ZMSXbW/RqSUc/Jnsia/3lwHbBu
	Xf5pBtUELs5LzSmddMUUdN06PeNUCuMnzCJ/TDAMQ1EvVhug1pyjD5vw9uCzXf0N
	EC5UzZFEJ0KvZSD+IyHkzGzvPEBtkTRjATM41lvOvdIn4XbWcutQh4ax7QUxRGOp
	mrBET7xeTzNCdOWqM2D1I8VKBtrAaIFUe235VzdFmaWZ1j9ktgIg0ZzjAXyO9DOe
	5n7dvsH0WuubDdkFY/fomm0Fg4ORbHRyE7q7k2lh7MjIFHavTXz/3ixJRIVP7JCt
	/Evqys4Q3x+SxWljGFshyrq19fx7JZpGCxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794998299; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:DnANxpmFg1Rd9kr0+B6uZQQT3tMevdOCsNPRzLY90xOQuV+
	7jTMZouVX9FmRAMk6dFafz7aKz/9/+x9r3yKmJ2DIMOyHIFf7+CxjCmfKQiYh96a
	VohuhltZ8JxXMgqjc85OD5dG6ZfSd5Cll5H172hUrEzgRxfmW/UbDgOSYHmdADVR
	CgaA3Yiwkknc7lA9SZEuRhA6zBScbx/QHg8QuLux89m4NY7mNJGFqjrrmMLm7k9x
	hKGJb7scKk/OuQ64vtpW09/92qJbROMspzefOR28UGikhajq58AsFSz3t8jWzkIF
	aD0GW8e2tCKko7S0uwJjNIbNf1k3u5cIuvWcVDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1uGvd5Qb9z5iicbRvTMc+hUrWTArVllFkfIPB3A+Ptk=:gUx5VgGA3QWOh39CiHQ00ERDv2WxrBMHrJ/LSvOjUik=;
X-ME-Sender: <xms:G4D9arY2SlexIycSXAfn9U0DVYzCaxFTzXzvOH9fE-q_KmarS4hosA>
    <xme:G4D9ahS2tTbUh31Fpg0Dhh2dv79VBlCEDqtlKOzCKTWk-OPXSDCPrUB3DTKux2EtE
    oJsrcP6IgRZw9KTtYsFZDXtfIgzKG6LNQtM90XYueYkp7Y8jlufHYQ>
X-ME-Received: <xmr:G4D9amQRd2LH4grRFFc61NeQmitt1vzhTgeTYEe9D7joSJQ1i0ZD3g>
X-ME-Proxy-Cause: dmFkZTFpUCDRwYS/t4ayrBIzJXm0gmElWhh3bNZEbxIMVI95oc0Uq3kDvXYz7/Um0DFMNf
    m4eo4nbSiomJakx736U69SmxDECPYWch0Mhi2DHALv5bLMMUNjvI3duo2lccthkXu89Zi3
    hkWt1Gd7IGUB7FNWCwFtVlmRFqc1GZBkO+fi7mqYTr+dKBqo2MdUKXmAwUuRVFEtfilxye
    xUz8R1SxBi3IN8UcZkaiDwCO7MvXwJJn06QS5VuEqlK65+vpCuptWwnaKWmh388470zOa7
    GpSBiktZsnVFtjlVQTfquOKwD9r+ctodfliFh6ybxBZjC1D9fB81zqJh9tE/BdHsFVdKR4
    fY/tbovCSfjK3x8f3MDtQgsMW5+aPGzE/p0v0wZW9GWX7UO+G0iE+D1uGPW4x3PhdfvEDn
    ZqVw5fbVYCIHN/M7CjFzhb8JZZXqx0Bts0mJK4Ja3lTooyYmBECmVn/ZfB57FkL9SEraAz
    BOdsdZzWBHOVYpgi4Zt5D2KYZuZcpH2OOVZHkoX3v282crY11QKEVPm+6x6qji2BWmF+YW
    9sD5vRiyr9u4KGsdx7GFYamtkTN3c0074RAORJ5G4HYevMgBCs5I8ZI7srpPjvWcXN6L0q
    HVGEhVnjnnuXQcf8OyFwh5jttyCDlF4jal4EdBlxLAugHx6mamgSlc75u/kg
X-ME-Proxy: <xmx:G4D9atRpIywXQbKNPxlCe6I6XtJoRslK4z3k3FpGOsHAL2OGtn9A0A>
    <xmx:G4D9aj5Erjj5GEQDMdMYblcBN7NJiBAt8vnM5DgGUoxrN_ARzQ_7DA>
    <xmx:G4D9ah0cp2RrJRbK0qzQOR-241QarHn1AAPsuRiAP_xeHtvqoE7_CA>
    <xmx:G4D9amBOXmXvE8lnD21pomu48GQZ1mi3ctcUXSib7NgQxGmJMwNESg>
    <xmx:G4D9aoueDebTATRGo2UaINY17F-JE_OxzVDJeacwp6RG10Va-0Yb4mup>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 05:38:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af03127a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 10:38:15 +0000 (UTC)
Date: Wed, 18 Nov 2026 11:38:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ravi Mistry <rmistry@google.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: What's cooking in git.git (Nov 2026, #06)
Message-ID: <av2AFJ_WmUb0FGjU@pks.im>
References: <xmqq5wxwolja.fsf@gitster.g>
 <CAF+mdicGt4+aydaTqjP1DJRzxpRBbKSQQNai7BvXepC5Kt1vVg@mail.gmail.com>
 <xmqqh5hgi9m3.fsf@gitster.g>
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
In-Reply-To: <xmqqh5hgi9m3.fsf@gitster.g>

On Mon, Nov 16, 2026 at 04:29:08PM -0800, Junio C Hamano wrote:
> Ravi Mistry <rmistry@google.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> * rm/http-retry-improvements (2026-11-06) 5 commits
> >>  - http: default http.retryAfter to 10 seconds
> >>  - remote-curl: retry transient HTTP errors in post_rpc()
> >>  - http: add http.retryStatusCodes config option
> >>  - http: add exponential backoff without Retry-After
> >>  - http: fix retry count and Retry-After timing
> >> ...
> >>  Needs review.
> >
> > Since there have been no further comments on v3, does this look ready
> > for 'next' as is, or would you like me to send a v4 folding 5/5 into
> > Patch 2?
> 
> I am reasonably happy with the series as-is.  My eyes were staring
> these patches for too long and I would prefer to see somebody else
> give a second opinion review, even a cursory one, though.

I'll bite and will send out a review in a bit.

Patrick

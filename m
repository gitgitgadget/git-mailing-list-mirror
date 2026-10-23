Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752236;
	b=xyJN1w2TfjkqEQEeLb+BXt5Z/3s6jt09f/ehnElejXIP0atOoxbnwxdYr495LiX1sBvG
	 6JB7kmgnTPzPNhfbARgJAuRtUsBszNRVFsSRY6HhAxyoV8BsGlwlYEFmx1CHPJPuaC3DQ
	 yb0PcrXhE7Nn92lOrFDKgwcRCHCRRx8je9VuU4OK+Zjb+J7QAUOvZhUY5qBSR301NXZ56
	 JI+emCq848aszlBGEUxFX1nAY8jM3MJilGizLaW40odeeI5yOLrYuh45Bk2a+BzZIczBI
	 6rjEMq4yVZrLElQ9/Xw4gAetc6gg9TnSspcX/XVYJvt1kjlW/5Zo4KGA0Y2loT8mpzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LkDYaIFQR1Gg0qDJT/zQabC4TJfkPf8eTMTeBqUGd74=;
	b=YdhDt3gDxIEyRAPJu5vjiOzzLKVLgFm3Ul4Dx+tUm6Fbf/0ZCxtflF3EGFeKD9YGby9E
	 YKwItW7qORqDxXGFIFb40mjS+zAO72v++EwRuMK927LBot9jk43e7HLK8eGIsGCtc//SD
	 hrsggcIgS3HTM24aWRMhbgOrdB7MzhRUiODjrkyafxVAScsud0o4uT/ltZicY8t3GC12W
	 tiJXuA0WqBC7743K19CcX9gXay5efbsrfC3eAGzZAuwTH9HheJcXI2L41ZxCEljDrLbh4
	 ZcprnxVZWBi8d9QkJEiF3wrUtJdfE/jpb3I/Ncuwd32wIbp3t1DS8ruyOgPwEZpD3UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=kpDphPbC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FXQs+f+a;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34103606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34103606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=kpDphPbC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FXQs+f+a
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 423A8EC00C9
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:43:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 06:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792752234; x=1792838634; bh=LkDYaIFQR1
	Gg0qDJT/zQabC4TJfkPf8eTMTeBqUGd74=; b=kpDphPbCwgN1cetun0Zs9bIwoI
	x96WrRAvpx+YMsqyZ3bGMk2ZR8dwJcvgScSeU/nb27QvLdNEvxTavV0dX8FXdhkZ
	pnLxE/69KPD4VVmV8Z7fmER/LQBNIW90o39idNVMw3vjSNpcUKWUso1Zjn7wuutB
	29SiVuhJoaRuhrYTQBlztNH3fXBOCWFdku1KdMXAxUVYvv9/jwmfGJ9GjqzA6fFO
	U2rzxjnuaZSwqdTW+p6OxqQks32/eFaKMM6xhb5VeSLtWt1biOY5uwI5pcVA8Si9
	4nGxstU6l7BUpE7sQaJX5rw8MgYofsdxLtemRSIOrF8dkmCm3pPQpbQGakrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792752234; x=1792838634; bh=LkDYaIFQR1Gg0qDJT/zQabC4TJfkPf8eTMT
	eBqUGd74=; b=FXQs+f+agGoml3m1hUYTj77EGOLtHtDF98D28GC5OHgNytFMQI6
	teZ0UetccXs+STVmeuchZRb4zqvAWZcZeOsyD9ZdOqEQ3iItWbatIf4RrGbsPira
	8IccY5BPfO8uocAoyxntmkAZWdqvFfmtLHxo8Gb+TiMsKuT3pOJrw3JHbpPHxG96
	8oXSAjT620Kwx1FhUbjrvWJ6qAE2YTWfIu5nHjmO3d7LeWkSdIqw+FhyOo5C3MD+
	BSWflwR+/wKJZ935ipW+1iDm7hmHikU1qOyT3B72Sj2OLczRlPTqLzKPxiu4udsv
	H3aPCbiNLy82hklDdPdnS8nH8VvRbKrjW1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792752234; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tjJ037o5/hESvGpgv7Tkyk3Zs49E1yDsrisEJOTcLp+EagB
	rtMIB4ZTnlFCW3oRnlD1fYPho1o1Idwc9qYWqdU4i5UIM1L/3t8tKqL9ZGdsrLYR
	Q0Mis0yMDT8kmQSYDDPyTlou0A3OD9KlVw44zD0ZlQzIM+44MAxJLyVFabZBbq2s
	JlXwamykymg8UOcgFLMBsjFbI1ho4YFkJR+hrgYkT3lcART/ry8h4fH5WuPBVoEA
	ggRkm0ixPh08cBxGXpMkVUfuV3oqW+cg5tKW5tczhRYgyNFid572TP+GbzbEFkzr
	SBk94Q1kv8J9TvZTx4YtR1u5XWIJY7TL2fGpkPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1MLgXGtFCfeOfU+lF+jxyCp/NsksEs0Ta5d2tZJjoyk=:V20lQjT8uGI08z5IGlgUQA5UC5ehjw5yQ1E0QFmpDAQ=;
X-ME-Sender: <xms:aTrbaoQ65MjILgL5cziFPNJlz3gD3j2CdEqTrJrcmCEZDNSh8BN3DQ>
    <xme:aTrbasponBqLLrKnrXtPjI-LXbEMT-98gbyjW9RCF4ASUpKRzReVff-FdIBIQ0MZV
    P7z885OvYvB61pXX1Lgsj2MnRn3EAZPknkrHQSNH9YH7-t5GwO6ZG0>
X-ME-Received: <xmr:aTrbauKsCERtbZHCMT2pekLxC6a-X25rXuT7BnJ44jXx7EextyjGzL0dqzwbSZKVeX8cMQ>
X-ME-Proxy-Cause: dmFkZTE7HfVbxD6npTpn2nCvEcdwr+DAXniPKA0FHC3I+qC6d4SGkB+lLSmVio9rS4kzS3
    zPvkcj8UlVGfG3T5Eq2kacbpdnP4vXst2NZmZf6NIWKrqZzk7IhQHHy9o4khL2yjrpdoey
    HnuAFskjiBVZ84fHm2OWL1QrqCWSxz83uFuN3gv97+OV9cj9gzJpxP/Kp5DcKTGnkYpdVv
    0qgxXZfDhwa0mKOAidZecENDKIRp1vIPgJERwt449a3IJX2ARnwlXcLdPM2eN9YzoulHsJ
    Nob7RztevE2E8nZMBlw9Jv2iAkgX2YhWOCefqHFB+nh32NZcad3brRiwZJl7ahJdmSM2dn
    ZZMc4cx5MC7rYyfKCGpYGVivA2v00tsj1lNFZGAFzBTSRVWi0TtbUJKOzvRZY9yTM39loF
    PyOddcsZf7pcS07psVZaqEtlkCryiEAoVgfjrXR1SAd7QAEhQPTo6hFslueOyZZ9p+D3Fv
    E6pW4MmVnrSdI6m1h/St0IeiDOz3jsIX2ROBxTYR1ii8WcqaV28R/uyhw6vavUpcLdOlZ8
    ZI/J629S68gFVSi9esXWspWVqcG3ZysO8KA4MOk3sVsVLNynBMNCyuYn0fPwTSscsjEDIf
    OgXWe7ld1xDmvwlUkzleMWrOMtv/pQ/jlWQqSDZPP4e5BccL/iDPaF9CTLjA
X-ME-Proxy: <xmx:aTrbanrS_aRoxtWxDmztPyxk5Wo1pZVYerTZrbKXKO_rvChtPl9GiQ>
    <xmx:aTrbauz2uVSH-RNYlaj5CGQPbjPd_DOjYTdgTIEvEi7tgq5vVrkDbw>
    <xmx:aTrbajOEknSXXCCczaTCegDwGRH_usJf1fFqEgigjr5TCHIBCvh8oA>
    <xmx:aTrbar5jZbQUo0IWWiVQZN2geYxDs2_39ZcKHSBaNLTKj_n3Q9UC1A>
    <xmx:ajrbav8KhJLJdXzpsEw0ljQcRGzfeEou_1NoatPH-eqNU61k1h4_VLbL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 06:43:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c7975dd9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 10:43:50 +0000 (UTC)
Date: Fri, 23 Oct 2026 12:43:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	jltobler@gmail.com
Subject: Re: [PATCH v3 2/2] odb: ignore refs of shallow and grafted alternates
Message-ID: <ats6VLXUqKwKZzIY@pks.im>
References: <20261014181134.56220-1-iwiedler@gitlab.com>
 <20261019110918.71193-3-iwiedler@gitlab.com>
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
In-Reply-To: <20261019110918.71193-3-iwiedler@gitlab.com>

On Mon, Oct 19, 2026 at 01:09:18PM +0200, Igor Wiedler wrote:
> odb_for_each_alternate_ref() reports the refs of every alternate
> object store that is a repository. Its three callers use them as
> commits whose history can be assumed to be present: "rev-list
> --alternate-refs" (and through it the connectivity check after a
> fetch), fetch-pack, which sends them as "have"s so that the server
> does not resend what the alternate has, and receive-pack, which
> advertises them as ".have".

Right, for all of these three callers it doesn't make any sense to
advertise those haves in case the repository is shallow. It's a somewhat
funny setup to have shallow alternates, but in case anybody does, this
change here would avoid a potentially corrupted repository.

> That assumption does not hold for a shallow repository, whose refs
> point at commits with no history behind them below its shallow
> boundary, nor for a grafted one. A repository borrowing objects from
> such an alternate does not see the alternate's shallow file, so the
> history that is missing there is missing here as well. The fetch then
> succeeds, the connectivity check stops at the alternate's refs, and
> a later "git log" fails with "Could not read <oid>".

Yup.

> "git clone --reference" already rejects a shallow or grafted
> reference repository for this reason, but nothing prevents such a
> repository from being added via objects/info/alternates or
> GIT_ALTERNATE_OBJECT_DIRECTORIES, or from being made shallow after
> other repositories started borrowing from it.
> 
> Skip the refs of an alternate that has a "shallow" file or an
> "info/grafts" file, the same checks clone uses. Its objects are still
> available through the object store. Only its refs are no longer used
> as a boundary.

It could of course be that somebody manually created such a repository
and due to some obscure reason still expects "--alternate-refs" to work.
But I feel like this use case is sufficiently unlikely to simply not
matter in practice, and the fact that Git refuses creating this setup in
the first place is a good indicator that nobody will care about this
change.

I feel like the whole concept of alternate refs is quite flawed in the
first place. We get as input an object directory and then we hope that
its parent directory _may_ be a proper repository.

Other than that this looks good to me, thanks!

Patrick

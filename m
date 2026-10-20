Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792475904;
	b=rRdizWHCW3lwR0HJIjCCWAhKsrnNaSHEZ6aUDKIZIaHF6q9LdlkTY37Y/G6oHYy57VPh
	 Z8jISVHkksPytuAzITOd7jFkQjrS1K/b0LTLLQQ7ZCMqbplO+fctSZ4xtjRpXU2xQrdda
	 hmmowd7DBrkZZIbf/Aqy3wfqGw08dv5c2xVYTePit4xPlYCkFfOdkCqfR8u3pS+6cEUQL
	 HK6++WqHUbErT2QSPTc339GrtFSryhnMqLCj/3I4CJRGNkl9Zr78cBsGANTy0tv22ruLy
	 yfG3FQNGMyMdbhPILTGRvJrx6QnJj5/lpeho2Jj/iF50yMOS4ke2cTFzQsGWWyrVStw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475904;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gb7aqCsxGSliPYDhRft2li5RjaAkg+zYbwSggjg40bc=;
	b=lBkdFuIxsgbpdCTIZ8xdm9gkYF6DQF1NKF5lSWyvqc3whuFDkop9NHGDm0NZOrUfJo6c
	 jIS2VfgcbU0wK9ucIgbumVZN72CJiGn3h9CDFRsJnaq/la+m8mr2zDu+tKoiTE5PtjPm3
	 uf90Wk5psjsvj39dC7bHrDf0i0yT1Gmqn0sH40HPr+wnwfhlR9Fu8NptthvJiAqxYt8ks
	 4rnFTZHlmnueVtkla2H0Kbn12OkSDEA0KAp6VArb35zjcC5BobVGCCgzDyx+gGgtQxqNW
	 79wP5ypesE671AeigEIcv+7jq1jWH6Llc6D8y+YnrMuVaaLGNpyAMF7UkxouoDflgww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=MQuW0MnD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="jzYD/T3J";
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1F606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 05:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A1F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=MQuW0MnD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jzYD/T3J
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D22A7A0152
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 01:58:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 01:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792475902; x=1792562302; bh=Gb7aqCsxGS
	liPYDhRft2li5RjaAkg+zYbwSggjg40bc=; b=MQuW0MnD9kjL/ifRTJSNFvjGiZ
	Aw3GlQfApFYxGFW+uNKbmxB+I6tmjGDidptjc3sT3pqToc1DI3kdVGwNPqluoQ4A
	CFTpL+bSv0yrfMSyouLj+qte6koirJ+Prt1d45DQBsgCNWFD+z0G12h8B/TzFHCM
	dHE3xyk+nInCmth+ivn1vKLOjzKVxtcqtgk9i8IFDF039n7SiAVYYPzLlNoWQwhz
	ClU3mgq4W2b7i+ixkUTL7nxj+51sTGzRlfvQdhKk9p9awuudDj/ORYsb4q8E/dy7
	7TXt+gUIzxKYnDICJ+zZRUt0yPxsgen4o7BgX+vzcPbvA88/sBikjOfjM1EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792475902; x=1792562302; bh=Gb7aqCsxGSliPYDhRft2li5RjaAkg+zYbwS
	ggjg40bc=; b=jzYD/T3Juu0LZN0etql5VAOxqLo18298RMxbWlEC+EGiTwEJDTm
	R6L1F54lYI+wFWjtSwKvZVCh/pwhWnIomvqfkdSarsHlZtMGulc+8PmmtIV/cCIZ
	6IOM2ebVy6INNNOls4aokaxFb3oWfGJOj5oUaB35gudsYXAgUMUjwfk9ZHfqvkFT
	iB52XeniqPW/gLo+nwUQIRetLS5jIs/ycUy4AZRVh2nFco5yajZNSWg7A2fJ/H1J
	icSfqJSFWq1uM97efRL14KiE7gGA58Z2qvCW18Ve3sam0OHRXm3Ru+jgVTfXjnDh
	UPghdtt/AkX3/n63N0QYWx79b45yi0zZ5nw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792475902; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fshf28f5vKzOTy8qnB1mx3/dEqOmO04Br1hbzfhhte3H5c4
	f+1rETxh0O+IM2/KTNGmBP2fSkEZP6C6bOfmZFkTKbbRKNqvVm/zKtrs6JAJ9CZV
	bNzQEqR2oVU/kiSVGWdU3mjqnsMqtrbJP+C0Ce/JcmDu/hMqyj8NJCfRS9R5kU0l
	5AZhesxmFdK2KkNvONkse/dwuPhUSLgqpo6q38gWRsDvB1q4kI5SRE6ADDFr41jm
	rbYm1sZoSuB/8qwZsvfdGDSM9HaMbEBtVjD2bR/qg2akLWamx88glGp/fDDlD5Gz
	d6/5KphWA/Ce/wyNjvV1TtA4Kt77C8VocbNSHbg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PPie1hpMQYhR+m68mjulKWHbLFk9wPRpQ2VURWHHQqs=:o1v5R7OcXuZqgHF6yLFxSX+P0k84Y/R+N1a3fMSz/KY=;
X-ME-Sender: <xms:_gLXaoZMM4ZEP7-t_JavUw5p2i0wN5dtMSg9VSyvJShmB9SZAWCojA>
    <xme:_gLXaq3w8auleXkqFHb1DG9eC-JqyW1DFV6eqI9mcVVBo-7w_NdvddBYUvoz36cOg
    HseaUzPqNOnyPesw1TB_BbHcgLRBmQPWqgUExJeUqzfpf0IorqcI14>
X-ME-Received: <xmr:_gLXagXwOK50BWIaPJAi7sTFA1-sJOujEGdSh24wuaVPhTmCQ92Dah7YxIMgesCKxTelAA>
X-ME-Proxy-Cause: dmFkZTGdBVQ4TEUtUMs/HRzTaiz29rLGoNoXygJJbPe5B8Ep8bTXl4H6aJAm9aBAPGTzjv
    ECm+IJxxxPg1WyPyR9OMHKEGN7FPpEAYvffylAejRH1jj7ruBYvTuEk1j5KONPt6c1gc7U
    AMgzJ0o/Q/5MvkKipKqhaimCOuJ+IU+49EIqNaCBhUZ5b26pSRMrlTCtptG1/evZ76o+tN
    6PdywnNHGpaBqmvL++FwvyDhszOOUTHW/10fkNTOrHU8AG92qgaVRYRpcR38D8C1pem5kI
    1fSq5rIgvOUtX/xuzRQ7vj8KdF6lnjfxF0soWzSkTbyKDbhZVlIWQt5dYAoPl/vrtmU/sY
    wqpuOPIZsVnaY+HsgtV6iKnHjl9RfvKmSC6w3JfAgvHYEU5aPmUpeTzkke7Cm/TQ1pzEO1
    RkydFF+Ra9qwNRYGqAQM4C4dZG9tA+r08JjRpMwucKfX1e3qnAQQUAQ48bguuOw1Xl5Naj
    RyOFqVm2U/x+5seWAXenURMAhkN9e8EXpYt2Q3sN615/VbUFoCn6E1eeR8L8vN5a7EHaQg
    YqrnwEfCn9stGA+m0eFeUSFvpl1v9rA/UQh8JM7vcGiaWQeOkbElbBBukMu5jdYDvFkWWL
    0UN2JAFLqkJ8Pv6gDeaXdJ2nCsLpIh2as8k60HdOSk9qJ89liYsDYebOyWIQ
X-ME-Proxy: <xmx:_gLXasUzSdmOW5mV99ZCAngmthihs9ROD9akCky5oaqZqywSgEehmA>
    <xmx:_gLXaneEq0JGUxNIT2mvEG7YfV9uai9GTYgG6kdpV9iAuf8PLmvsWg>
    <xmx:_gLXatXRT9bcXBAuhg8-weNE2_q3JTG2Unl3BfLUa7LYTJv5L1YjmA>
    <xmx:_gLXaoe_sIpidrlzYiJBNOJyiLTiQzfKtDnzKU8K_O__SvK82erjAA>
    <xmx:_gLXai1V5Y4z8Zv0T5w5A9aIeHYlnnur2SdhfH7NKYGOjHiHA2p6C3r5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 01:58:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e4b20e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 05:58:20 +0000 (UTC)
Date: Tue, 20 Oct 2026 07:58:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] gitlab-ci: fix "check" jobs with large merge requests
Message-ID: <atcC-of1posEyjEH@pks.im>
References: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>
 <xmqqtsmlftwy.fsf@gitster.g>
 <atW_BmTQhxFRLc0a@pks.im>
 <xmqqik2x4fle.fsf@gitster.g>
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
In-Reply-To: <xmqqik2x4fle.fsf@gitster.g>

On Mon, Oct 19, 2026 at 01:09:49PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I tend to ignore those myself:
> >
> >   - "check-style" is not all that useful as we don't fully submit us to
> >     clang-format's style, so whatever it generates is not authoritative
> >     anyway.
> >
> >   - "check-whitespace" was quite useless to me because it breaks rather
> >     frequently.
> >
> > I still think that "check-style" _could_ be useful, but only if we fully
> > commit to clang-format. It would remove a whole class of nitpicks
> > and thus reduce the burden on both newcomers and reviewers. But that's a
> > discussion I don't really want to lead :)
> 
> Hmph, I haven't seen check-whitespace giving useless false positive
> myself.  I tend to agree that check-style would not be useful as it
> came fairly late to the project after all the code have been written
> long ago.

Yeah, maybe check-whitespace will become more useful then for GitLab CI,
too, after this patch has landed. In its current form I started ignoring
it because it was broken way too often because of the shallow clones.

Patrick

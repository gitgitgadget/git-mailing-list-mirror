Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0011F0E29
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130838; cv=none; b=tZSaBgPFqZ+QJqqElvetdaQivQkVGmvT5Fblp9WLeM1OZmVnrLErrOyzofI1TS7+cJoXSErHJKRmu6NKq6xvMU2O/loVT2Hm5pT9Bls68H6n2pq/nYbjhJZRPaRIj0Q1jldeOmM2tjeTgWfbml3l3XueU/e/HO4i9+65AgSjQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130838; c=relaxed/simple;
	bh=tjW0zmADPumGH3kyqQnAIn+VS8J72JWDEfX43CWPkNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tds1pvJsIFMohFoiH9xAacw2EtAGMHDzGaqHquFMJBPMzKf2v30CuWhDvJCnXBNT3Qm4mTcdHf2ZkRSnXvvDTXalOlwda2buZeBYAVCqoD2GKzIvx+u6SjQbFGe9XK4EtPtyjp2HvqqnxO6K/BANGf9uLDynxgFxsmrQJbYydgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KTM8z29e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dbVJo97g; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTM8z29e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dbVJo97g"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16BA414001F6;
	Mon, 22 Jun 2026 08:20:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 22 Jun 2026 08:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782130836; x=1782217236; bh=gH+YHdF4ve
	CYGVSYZE1s19WZq6z5O+aw9ATNA0P+6Bk=; b=KTM8z29eEk46rneE6JTF9X0IIM
	WUhX4G0w06qX0Tp8DnF0nkN49mx19UACXX4bVdL7nflF1zTAGVSa9ohoZhEzZDR7
	ovznMjbnXOUNALUfHixLWudbU2ZqhJhQ+5gZWL6JXKz7yCU4XxIoUe+coz82fj/N
	k+F+EP1NfWBNItvQZhUtMu+lRD6O9EklxOCwX1Hg0KXr2r/h9pEkkR+0UCLITKWH
	K5l7tLc2ErwxJNrLPuKGS/xGMwD3FqaxV5qZ0UhF8kqlGpZjljfUFdgvT4Ca9XPi
	IPT4Ivn3cnaVM93KuXzOSpx+YsdRTMu1u1DP2b6A1oTH7oUeUxTXj140OPhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782130836; x=1782217236; bh=gH+YHdF4veCYGVSYZE1s19WZq6z5O+aw9AT
	NA0P+6Bk=; b=dbVJo97gF5/tewkvl3UasFjEPWHOlavLKBb/ETcx4mApJ7mBy4r
	UicKDoOkQpH/vtpyp8PlsTjVg7LoTX294JiWmfSzc1V+E7P4Rx2pFxnhdCTXUVD1
	1Q8TbvTGm1S943XqazM1FxrcGCPbgjtqn8xpSaaNqhrsgAtmKj6MvOhlU2gbxEPl
	/7P92wTGy2EK9SW9fKwuXO/NmrhER9ZnFB7rKqJ7H2F3O+53jbH0AxSiWwQIwhiI
	QL6sI7WWF/TB4tVLVg2LmGWxgiSwr1OXcB0NN1abA3Ny19bQFQCG+r7MST6uv32g
	Pqt8TMyR/5DAc1mHQQ/DV7Bm4PaAqAq8o5A==
X-ME-Sender: <xms:kyg5ak-3kY624FVbdRwvkKljQuTW5XzZsV4-PmnNtmag7vbDJLHYDA>
    <xme:kyg5ajvHvoDjLeLdqzqPKN-s0AXdRdJVYSZj1UI3fjjhQM4HOSqg2T8ycNg3HLLZH
    MuXEdNeZYe4BI94-lFBVS_gnC1cpe9SuCMDXlOitl4kb_qQbREjdA>
X-ME-Received: <xmr:kyg5avDjh3rvkUppU05G6g0Vgl7Lnej6jPh54TP6x4toZ_aCcBj7RnuZvuvszB1PrumNjFuPxKzVGuVW3rnowMxn1FKEcKGJhRpOcz0>
X-ME-Proxy-Cause: dmFkZTFRmarT3xjTPMM5bSuNGGlKPgts+DTD4/LfrNaKrOZcINN5IGIwCTvYZc7F+YJpry
    2xFVB/qyH/G59rAYUXs9T+gIDIRawh4FqPWizm+SAna303koW0pn9x38XblDhXLQianvtJ
    F1zYDSE5kme8r9nikkF5mNmo9h+7Ulzyev/vCRBw0UcBGXD0QikDtEMPMpdJ0abe7Wgy0e
    a0xxKbHCEhXGLLvmkmW+Elx+s0T1syMTU85FFtLKy5/iaegymopZXvV/RyWPnd32vpatMA
    opu71FdOhP18MP1wz4yILcoDHXc1HuNT4mx3T3oBpBrE/JF1tGjPGitLSuLxvsfPX7hCe7
    4a1yxHM12m5Ann/y8O2sxZQmiZdt6yaHV/OB3O7E7+mrCXHiYCEZ25D9pLyqQIxVHnWmif
    Qi9ITALU8wfMQ3k7N4X05cna1VLzmQHEf9dr+VFUwFAP1WjyOux+MihVqCB9PoNb9Qlgn3
    7bXJaxkt7ZyuIQ2yP4ltyLMk9NwbThEveZVnHOJgQ+F27e7pL4l7lsUPmBCmmCmaldRUX+
    bRtWjWSTm1TQpsIYTGEExTLRGwWOjkVXl4LASL5t4QvLTOv3xeHHvj549Glt9PQNxWTlnA
    CgJqWd0RbRyZdlCNmtVTqkwI2DBERKt3a3aPPd8rqYR3ewGlGk68SiFG3tMg
X-ME-Proxy: <xmx:kyg5ajW7BV3Z2qC1ljSgypySSEAa58rlMKcZ7joRDaQyXA3vWkXnOA>
    <xmx:lCg5alCJv_lomGZWEDlkqjtuu-N0OvjMktGQPH6w4V5MJVod0k6H6g>
    <xmx:lCg5au-kQbB9iF7Ye55wbGeyVRt6mKACEfl2hex2uJd_NuuuYcF_eA>
    <xmx:lCg5akEHYdxOWHZqGR1rGk6jo7sMY-DEwTzPRq-UTjRPEqNlUl7ieQ>
    <xmx:lCg5ai9l2dDyIZwgVyAdsIcSnX_aZA0QQAzPHaXWGowiNzjdxbis6rLg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 08:20:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
In-Reply-To: <20260621212805.GB2297179@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 Jun 2026 17:28:05 -0400")
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
	<20260609001134.GD358144@coredump.intra.peff.net>
	<CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
	<20260611085526.GL2191159@coredump.intra.peff.net>
	<CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
	<xmqqa4sog1e9.fsf@gitster.g>
	<20260621172432.GA2206349@coredump.intra.peff.net>
	<20260621174518.GB2206349@coredump.intra.peff.net>
	<xmqqfr2f7iay.fsf@gitster.g>
	<20260621212805.GB2297179@coredump.intra.peff.net>
Date: Mon, 22 Jun 2026 05:20:34 -0700
Message-ID: <xmqqik7a4vhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yes, though that implies comparing the index and file mtimes with
> nanosecond precision.  We have that precision stored (at least
> when the system supports it) but I'm not sure if that comparison would
> run afoul of the reasons USE_NSEC was not the default in the first
> place.
>
> I guess not? The problem there is that the nanosecond portion would
> sometimes get wiped if the entry was dropped from the kernel's in-memory
> cache. And then stat-matching would not work. But if we are talking
> about strictly asking "is this mtime later than that mtime", then I
> think the worst case is that we fall back to the current behavior.

Right, and you are right to point out that for the purpose of
comparing mtimes of files' and the index file, this would make it
unworkable.  I can imagine that a file and the index may have been
written within the same millisecond but we can tell that the former
slightly earlier than the latter (or the other way around) with
nanoseconds resolution, then only one of the two lose the sub millisecond
resolution but not the other due to its in-core inode evicted out of
the cache.  Depending on which one survives (and keeps a non-zero
sub millisecond part), they can compare differently.

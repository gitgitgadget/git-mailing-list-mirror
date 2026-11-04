Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815551;
	b=saSdqG1jvA/yVFpuNT5nCf4dzxxhHxu5DSAc74VwWLF1iMsxXMx8yfNYqyzYKJ2U7VM9
	 8S3fF+YpU463+y22ycNcAzjr4atEJLtr1y9vm4iyDhQB9Z6WE3y1qPZQdB5vwGTqLFD1G
	 EEApYiEe2KPGicQ85K7HAVCrjkfB7lPJbkXXjbrqoZ8zeaX3tRfC+7Co6eH/R6GDh340p
	 xBjSNVcKO9ccZQU8KfmaPOzRnaH8YVGHSUNnu5O0RHJy2WxD4TqCSCjAtN+M5BjxIBgQI
	 b0uDajCoU2+iJMd0skEZPE5Fx0pOtFOmMhN5OijnfUFpqGj0HelEnfNmAq701ieIyFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815551;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=blMg3VPFFoU1mxmgqYQ0x9Joqh5uc8mJEer8mj65Wow=;
	b=u9RFr48EBlBkJbv9E2OC44MGuZzoE9TFLl8G63AaWOs0rx1b/ATZ6HPEn5prais+wBn5
	 7azLqvRoo3rrW587qCfYj0/DlQW3g5mZRRx/Kvm+Q3BKQBiXi9JUC4GuqUct3YvL21JY7
	 xr279nQCjM5tPQCvgP9Bn4WFhtqC7kAooyud13w7mFzUEW2d9rBi/hvLuc5Lg2sJ2YWWE
	 3sfuuS3nOOSX02hevWFaTdzw+gazwSmQNYmBs2w4ZMSGCz3iiC3a+fof9r3qtWOqvidL+
	 dTFRh1D6hnCcb3MVidisPAWxxBfTS/CqJlUiDzPAPOzyYHLek8p4aX11MDvoEzBHJZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Us8yuVVl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hKh5LRfw;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E44606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E44606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Us8yuVVl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hKh5LRfw
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A0EDEC1A04
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:05:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 04 Nov 2026 13:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793815550; x=1793901950; bh=blMg3VPFFo
	U1mxmgqYQ0x9Joqh5uc8mJEer8mj65Wow=; b=Us8yuVVlCMyBFENpTfMVBAcjnD
	oUJgqjadqCraxwajDWrwQ7u/a19Vm3cFsTwhjm2nTRkFT9+QVJxIRX6F+68mFvxh
	SALXRG3WyS8VQu3UvvleLh0mjfkDkYTGyjJYToEv/diDRixDmKmhv4HXlV9ua1jQ
	pbsb4liQohMHowDdbToj4W159JluWDHZHEmkglauK4OSIBc8Id0PTI0F2nM4bU6H
	NdG0cKD6f+Qjb/arZezDDiBmJyQ/foVZ7sDSDfdLAvZu4Q9mC9eJOoldJ183XA6n
	8caPy/QTpQj3VRmp8k5kh0LGqRftH3A7brCt4dOII7eIcYBvhmUghBMflizw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793815550; x=1793901950; bh=blMg3VPFFoU1mxmgqYQ0x9Joqh5uc8mJEer
	8mj65Wow=; b=hKh5LRfwxBLKzx98xy+d/SD/uyB+A0GSDtygm+Ls3sIcJVdD0nP
	YwuocU1acELLclGx3Bno6K4oaZZzjgBlYgBIIqSbdQPhCI1/QGFviA15Vjevbk/U
	1Fiss5vxz+YIxuA2QWZo78aOoPbgX4SrImFM5968btEuazOR0rI02zgVv/0qtaeR
	MQ1gS5RveS44pGxsiNSll8r6BrhPU4KdKO2DttpAVlfe+mGbcli0EmxxtpQOMgoc
	gdmrXc9ABRBT4VbFRZKctfWWeReh+rNvlV1fywMUJswm1XNTB5nuzQZsBmPxKt7F
	/gVRzssU+ua79k5f5zX84H5A/Hxuevo10SQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793815550; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fW9XZRbzdl+f8vOSnnyRQYW88VB4BYJwSFEuahTIV+2Yj/U
	5w1MRj7sIskDLLjKoWilnIa7jJe48OwQGy9kb5qW2U8TkeevZVBwE+x5hS2Nmj8o
	wvbesiwmKjnO8yCwrNLL07B9BYJ6UDyu+9PbMsu4OAfAydLly701mirDx+YEGNGY
	dgWiWYeIabgkGMB8UG66gOJkH4GT4LfBaPlfn6GjUSiYO7JGrjf4yKA51Kt8bY2K
	t3CyILmWIx5vQWEqARoM/xRQC56IW1fGQDPupz3T/TH0WWsH8AsuX9Q3uvXzlnUz
	LUjd6sOEEnDFnS30T4VWldQfgJxIyNQXg1dk40w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CPqD0SChwui325a7gCAir8a5SZtF6W1Yo9OuZA7LAOg=:ymw+6/zFwffcs4tptQeLgUv7ivfiBi4gaPXQYxMvpv8=;
X-ME-Sender: <xms:_nPraq00ieIt6W6wf4yvi6CM6WbDH56QNv0R8zxdWiIJWWF1tZRnkQ>
    <xme:_nPravXfCE62Mz8QMA3-y6BFYD94yCeCuI1st2__LdwewkKJw5a2yG4tEIlKk2_9w
    yq3MC_6jWrizjn0_ksloW2e7v1iFmX_YMLXn15vK_nuyZQP5LnmrQ>
X-ME-Received: <xmr:_nPralJVHQrCyv51oysD9V9lZNEot0FvPikx8WHmda9fiL1s1ySbD0aIyfK3OlROc0gmN4XEbHT5Z0TGqg6uH7qelmXZ23GtEfhw>
X-ME-Proxy-Cause: dmFkZTEt0N+l1gQE9nSEnChRkWZJIXu9e7Q6G46GCV34oJW5Y3P21v+OGvvAD/hq/Mu91o
    1ingo7/tkWL3GPxGz/OP8+RwDbFxy1ka+rQdWTxM06aPwiiVC/frFK0BwpXAA4YqIWhNWK
    zvm6HQGVKALtpqqdvU35W+EmCoqK8EMcGukPsRnLLEG3zhKItSwo2FtJh0mSNOpqHU/LHJ
    6msMODmcr3MZxRAevrHMnb7sBYKld37wCyfwpD7b4kyt0QDg2KBqVrFS6yEjc+gJmp/5Wa
    kC6Ge7QdilitGwoau6vBJ/d9ucW1r7qpDb7RVKkPkPJ9QoeJr7gOZFM4DGPB+DhMFHd9uE
    Hm+J3Qzo2szKe9nOKLBV3G6M/1sS2EX/vMqDBL9RRTuw3XGPUhft1VsasRoUSdxlOW9hsA
    E7Xm1CBR774C2n4ypeD9Y7M0JkYiHuXi1QZ+RMyN4jJFfgchuSvwAqaZs7zA1HAlzntROE
    +3j40btQSVUychSwFQvsUgjQ5/E6NX09oK1+t/3nPaxOhMyEnQdKa6TzQ0kdcW74IRRpmM
    3JH6TXtubuXASCznUqKkJJZcGluW9+hnPF+ZGKursfZMnAqnJWDKxUgsbNd95T9AipIS1B
    V3Nj4Dt8PVwxxjQAmB0MZImoLY+Z/G24nPOieJxoiXDRlr0krhmqWiTRFeVQ
X-ME-Proxy: <xmx:_nPrah1ubPu3t2QLSVoPfnUCwn9OPjuThWNTRKqbI-qDASQYB998_A>
    <xmx:_nPrar7EiWgpoHJVTETyRO5h1IEBiG4MAb00t34jbC0sdvtu7GVhXA>
    <xmx:_nPraq_Y4L5uSR9Udq-UJGg37dGcfaEKbwBDL_xu_pe_JqTAPC6yyg>
    <xmx:_nPraiXYlz-y0kpNWlS_MxnIekckVYSzHBqKqfv7cM3mO4A3IWsmGQ>
    <xmx:_nPraiWqN66LJj5TE1f0IaQmV_gMN_cqW-IsEh3BIewqxxpC1zEmxb1C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:05:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Jeff King <peff@peff.net>,  Kristofer Karlsson via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
In-Reply-To: <CAL71e4OreARF+dbCU3S8-_umrFEptPLPUiPDH3SYBx6OYjVpfg@mail.gmail.com>
	(Kristofer Karlsson's message of "Wed, 4 Nov 2026 11:25:38 +0100")
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
	<pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
	<20261104024806.GA1492379@coredump.intra.peff.net>
	<CAL71e4OreARF+dbCU3S8-_umrFEptPLPUiPDH3SYBx6OYjVpfg@mail.gmail.com>
Date: Wed, 04 Nov 2026 10:05:48 -0800
Message-ID: <xmqq4idw320z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

>> That's how _we_ use them in the internal callers, but it's a rev-list
>> option. So we can't say how they are used elsewhere. That said, I think
>> this is a totally reasonable tightening of the definition for general
>> use.
>
> Good point.  I will reword that part of the commit message so that it
> does not rely on how the connectivity check uses them.  It also seems
> in line with what we already do when loading alternates, where
> listing the object directory itself is ignored as a common mistake;
> inside the quarantine, that check just compares against the
> quarantine instead of our own object directory.

Sounds very good.
Thanks for coming up with a good way forward.

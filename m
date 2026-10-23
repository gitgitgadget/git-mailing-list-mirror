Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765862;
	b=ZThNGVhxJ8+khw/dK46hvLRP66uzv7SZ+szRvn/hYDrwDOLDkudu0iZWPyooJumBO9by
	 fCmzq43w3i0Bl1E605d2vE0/bBWdhbFlfO2WmTXhk5lM+MLD9CAAA+dDDpkXP+IBzBbL5
	 TOzAYmq2W76KUtGF7WXTCrHjV4J1sT8MTXSaKe6ygzyIkIwfEGbeBJl45jTj2760s+yOQ
	 SB8A3QgmxJCWVgKKawenkJOd9Eo5VFo3Mko6dbe+bFma5tztEqXqq9oxh4wx+DlQh/947
	 XZhZvWudp0NkES42C0sOIi+6O6bguPkzMra4pCwaXNwQoH4LkwVpJB+PMbmrWFZ7RpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765862;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=cQ5Zpc2Bo+25lTBKbkiCczLjzMmvwpn0kFC7muq7pig=;
	b=e80L0mUCMDVzUqgPk8dBo6W1jvdacm+CNB7bD1jwcmjkVoHRwSseSvMJqGkr6Qv6xXXK
	 I6MmaMyeaMzbAulCpxvBdgp1EW/ka7b1urj8rzvU5/ZEsXC5SrgVlEPS1WyBQOgPnR1Vc
	 KQsMw2g1sjWzgygaS97AGGTJ8PE5iD8cG+KIZ+7ZY82/yFj+B0GvtTZwAtyN8+P2QWahd
	 N1HHXMQXSufRKyXW7QZ4lueRLVBvIc8fSD1rY2NHPh7kzDaI3X/Hb2gVdlWrCriXwT/41
	 idY1NJFFxkF3mPbG2jQaB0O0hYC1/cqHmnDsuIblivfQKpcq8/VIcucoBw9uagkZbxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=AUcwMFFG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rR5bMX1E;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D721606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D721606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=AUcwMFFG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rR5bMX1E
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A51221400120
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:31:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 10:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792765860; x=1792852260; bh=cQ5Zpc2Bo+
	25lTBKbkiCczLjzMmvwpn0kFC7muq7pig=; b=AUcwMFFGFK4+eh1BNgAxCztB/i
	ZZz0MKKqu7S/3Tw+1K/4gfNmJKfQ51Otf/VW4pMAJpB3H25KqK5thFQkVgb1xIs5
	AUgHQy7O7Z87ps9C+JKDSE2qRjiC2OZRCMj02KvdtXN27vzYbavzumpn4+lbGSo3
	LFd2krBjp3gDuR4b3NcY9uS0JMFaVJavZnsCG4QkBJOOQ7ETc/8Wd6YZl3rP8ZDt
	ao3ec+4wTtGkFv/HzS2xwbrIdp74hqBUUrZmcutazccF9HJrkybIWgFfzSs0W+8g
	vBTZPSP+1KxzD/18qgwg0E9sphkWf10IXp2tx6Sb/SPbs4hCwIPwTQ5amOag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792765860; x=1792852260; bh=cQ5Zpc2Bo+25lTBKbkiCczLjzMmvwpn0kFC
	7muq7pig=; b=rR5bMX1ElOw7KaOp4C6mSjzja/4s4tIJKTHGitWvALwTPTItRsx
	yrrSkwAGr1ANoh7ycT+NDo30R/N2MhhlgjwE4dW9naCgPEbh+kkkK7Tb9w02l/Zs
	p1ncdeZXPvFB+KJ9P87cWzCuK1DDuk4vwAdBwb/8cxH56Rp6GLWll9QlIIILfm0+
	dMX9zrxeLczRX6RE7edf83lC9hLfeoPRAtGk7j8PoUtQxNuCCLI5drtKmr98Yvyu
	eku2lhgzdYeg8l6EW5fHBFujnRLdOb31YUKM/rxEK2Nx+9DzODamvJzhlHOoGuHt
	sdwRw5GKTrVVizDBNfSIzSH71bT1qmvhUkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792765860; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ka/JHm6YyAYIDKWiavseLY2O1utXxg2deSrE5DGdbZOI1qQ
	lXTFvZTb4TilD9MINiVKshraoP2HY4jcAGXpJeCZCMlFSngX4PZeVtMTt//k8l92
	o+6VhTADEn3rWSE++xmMkia4MDUtAeVRhi9zSYbZ1LKErMA6DuHhkBb5NhfsmyjQ
	+VtuQv1pcNd2Ei5GrdO4bM6iPO2mLp3212p+fLkp4za3hnDDKkYp9Bm7zTxXGIbq
	5M2tIv7fTBc9YRyF9wl54uwDQbZxSTQ9eH2oOxSU83DKFZswEcwXxFeq+OwpUkeW
	0Pct0bTqawjRisfO5Zchk5VcXKrLLTyrSCnEplw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:W2B9+SYQqXTmuItIjng+DQSlJJctpmbt28I6f7VTIaY=:4ArrhhF4GKCznXyKgIboRQ3MoY0/1Es6i2oOzV7UZ0I=;
X-ME-Sender: <xms:pG_baitxJkB4okfTwRDY97laqI6Y50iiV97kaJ15QibaeYybwGvTmw>
    <xme:pG_bajQ84DTVXdXrM_lZi6BBn1wbS37XOUYakUV0GdzhCzeUD0MgQM4p3v4CYQdNp
    zkpYewr0op_mMn8ad5TbsteM2cgPt_w37Y8imFZkK61O5PQTBqxlw>
X-ME-Received: <xmr:pG_bapKT0VmA3fvTN_QLo-VSwNdQwAxVm7QAd7O2gzOQpfDhiXMHxNJjbMKtCpmIWVDbAmadGqoen3EHyzmwxmql3OdeMDwGPgyz>
X-ME-Proxy-Cause: dmFkZTFNe+gGvPFA/+8L1ASkT/dyMAqaJ39KhzDPhqcdDdQk2Mzv0JWEQiuAbzO1IvM3/N
    5u7a9PtQ9S9u+YSVU9xxPu8brELZ9fJqfEjRpbwjUdvMXa785ZIS+XBmjiUiyXu0/8dUwo
    8IwBaqwSr/eo2L6otCfa3tZfJgOsnbkeaaB9jYrPW4uwk0EQoD8XMjUULXPEw5CBwffNmL
    z7UmrLXHF7IucWbWN4Z/AMXJRLUI6FEzmEHlSO8y2V8swarvhy+1HrtXO75NQepiyzQk83
    apI5y6R8pMtVyNjGkoqH6ULlj2gbGve1gvXkudrssRvtvZvgFJWuDX11xPfu7TvXjRmznF
    EMm5ueG4tXRX/3pAXc1r3PdfqscWvlBdD/R/CE8kOcSdOQgQG59AAVsuh3D+8LvfWVzIG0
    vz78atIwcBYI7NJS0VEFdPv5SxjeegTvFWxecZp9NyXkzoBZi3VvFdrrYkUEFJXbkx6+Uq
    bMeSpB4pxp4kC9uhwhgkfTTgBtfkCJMTigx3Jz2o6bS9uFg+xJBD7kOZSqsHNoBAh1KCoQ
    +gaf2NcHYasO+a7Q1YqH5kk8ig2sMtZrVneMy1O7IV/SDwzY2ksfKBX0jZzzatGBUUPzFI
    dIbWrDRIH4qAwauTJjdfNxrqOSvdLo84BaEa+e9RoHpNZjKzomLFURrE07JQ
X-ME-Proxy: <xmx:pG_bams-F2KQTc8kqGvQVavh4sY74ySlBG2uQJcCixsEEdSU1_QDlQ>
    <xmx:pG_bag9MKEHnae3gkoKqd4xCx66urHCUzftNWlGfO1f1MfhBzUN4Qw>
    <xmx:pG_bag2uUD04ROPRAVuJz3Fh3mTwCRgH6lt3h0cKgxVbtf9JFR7XZA>
    <xmx:pG_baljXThudSHJb3P_fE6_Ish-Z1NSVExwgGG9SOI3dsUxDpnu31A>
    <xmx:pG_bamjnWxnXl2mmWC2G3IZ9OFUTeZbBD2Ntw35tfEap_iUa7-XC8tQc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 10:30:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Jonathan Tan
 <jonathantanmy@fastmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Derrick
 Stolee <stolee@gmail.com>,  Ted Nyman <tnyman@openai.com>,  Daniel Reynaud
 <dreynaud@openai.com>,  Aaron Friel <friel@openai.com>
Subject: Re: [PATCH v2] negotiator/skipping.c: parse parents before queueing
In-Reply-To: <atqSs0yzXw0cf3cH@com-79390> (Taylor Blau's message of "Thu, 22
	Oct 2026 17:48:19 -0500")
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
	<9e9ae442333b5e2ccc0905c44c2c3e16c49481a7.1792704069.git.me@ttaylorr.com>
	<xmqqld7pcqku.fsf@gitster.g> <atqSs0yzXw0cf3cH@com-79390>
Date: Fri, 23 Oct 2026 07:30:58 -0700
Message-ID: <xmqqh5icbial.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> On Thu, Oct 22, 2026 at 03:34:25PM -0700, Junio C Hamano wrote:
>> Perhaps rev_list_push() should mark the commit as 'SEEN' only after
>> repo_parse_commit() succeeds?
>
> I considered this but ultimately decided against it, since the default
> negotiator does:
> ...
> There are various callers of rev_list_push() in the default negotiator,
> but all include SEEN in the provided 'mark'.

It is understandable that we do not want to widen the scope of the
patch by adding a preparatory "fix the existing ones" step, but I do
not think "the existing ones make the same mistake" is particularly
a good excuse to add new one.  Would a hybrid approach to (1) avoid
copying a mistake to new code and (2) document near the new code and/or
in the log message that the difference is deliberate and fixing existing
ones are #leftoverbits and not addressed in this commit?


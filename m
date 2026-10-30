Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360687;
	b=PJZTSxkdm2prBDm8PFqHpGSFBZoHLXLy6q0VRBagd04mi3UFA5FTtstw8TfSYBoc4Qrf
	 XoZYajMYQ8r5Ret/lKsIZwZznK7cWiG4Ax0LAVJZ5T8FE4Ef+/FcYJWAiClGl8Ng25fAO
	 RelaBPE4/S8OKWOYSdsRLx15E3l43LqeLSnLF3bH6iFaf52ljpELVJwLT0YupwS5hiKpX
	 N99lWN12INfG4at6n5v58lFkOECUQ+oKWuHLDKEQDgnHph4pcuPX/LA61f56rrcvYvpTu
	 jfUxjBzWT/VEJcYo1JTokFi9TYZ7gj8HVY3K8uJx7pFDjScK+UPaH0TeqQLTIgdWxWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360687;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zGVGFlCD9FuvJSfrKa0Vu8FWN3EK1T07PXIqkJ/foRU=;
	b=QeSLXGEsUP2K+u230c/0lfWXiPIejdM1GtpW+Ss+zPD1CCp1Zhp73JbbCIN+VFOOsNag
	 R7b/kZPJl1ywa2Gy7cDjzrpJwTCLzV4PlUysBBjHm6WBS/leTnar5b9fNI1J2hpeJNZvG
	 pnjjK91/bUn898jlvRUwRZMK9sTEH7KGmqKtYXQGAvjHmOuzD5ZnugnYi+FsIWTa1zOfo
	 tbM9i6By1oP6Ufihb4W9BLzIuE61jnXsCe1e2yuQQrYdSgMuPHaZuwH2vydi35EDVE6BA
	 3LRNd7ssqwLQMJliOeFlsTA4SBtWIUEAYq4gtSdT5mq6ltFId2Q4ipeSh9aObSZVZEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Lz2ofuWv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p1jmUude;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D7606A326
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 912D7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Lz2ofuWv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p1jmUude
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE3ED7A012C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:44:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 30 Oct 2026 07:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793360684; x=1793447084; bh=zGVGFlCD9F
	uvJSfrKa0Vu8FWN3EK1T07PXIqkJ/foRU=; b=Lz2ofuWvI2CLHHR2Gb5P1dF1Q+
	/vCQKJTZZyeiFG8tJXakunltMR3ay5iQRrUla122iZVSobAZwd3EmUuCtCnjhlgI
	yUtaHqtwPywZi6Bl+v47Izlxv6cr3NUw6SNNMgdBmHLUMwSyhtCWVWBVch14yXVg
	YkDUmOyJAOyP1ISuElEdnyFoRV+VfSZfgdNSdsiyVE5VwX8eTnULTVmqxj6qshdL
	SUsaCHwmc6WfiiBrJIAV1J3g5Ii65xcJwfDoNONsVpwG0C5GgIs50ruJeTLTFBvx
	YTQrxF4bRjOLfY64z5bQE/QMVe0RqiqgoMiT8aDFFRl3HE3W+Zr6n2yEkuEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793360684; x=1793447084; bh=zGVGFlCD9FuvJSfrKa0Vu8FWN3EK1T07PXI
	qkJ/foRU=; b=p1jmUudePz9gXt0rqcIpNSWz1YHX80oer1y3W0XoxMq0JQyqsGQ
	1eQlYI37kOghRP5qArAwm9Oq80AulfxXaJxxu14cAYq0zWEYBueu2OUlowDTNebC
	XMCmOO1IxziQIVkaVsJiIcDNbf4LWJjdF6LPiAHgm7XWVFMwDHPlsUJXlWBgvbTu
	S+lM/CVp2p8PzPk5M8c6LzzTCrrKluRtD6Q+GNEX6igg4iv7TKM/gZdtVHt2mg4Q
	z0slWhxxh/53+Z1O6muNYWkNFRm7vETXs7hJZyAPzpXTUsXyv+b7JW4jsXPmJhzy
	ZY342p+/xwHZaQXnEPWD2Uhm4OTsHcrqQrw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793360684; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vh4MzAZS2A5pUdsADxouW6yyzFubWYH4VoZT69gqyOHL1L/
	YrW/O3ieqcjAo/799orXqfA9jR1zVgpXB6nQU7dxK20E5ddrQalECkOfz6X8BQrz
	cO1nOS3KksN+IWeSqcN+NcyXMAf8/GS5nO4Vnl9BKj5SSQxmAGCp58JQhhxHK6s0
	v71HP6wH1hU1ZQNWOq4G7XPnhohQLyjSa8pJc9EEamJSVzcUcDTOf3d4O0mYQ6Nk
	zexq4dE1VGvN3sHSUywyU2ZHj164KVA8MAMDo1LcHi18s85YWGrsLmq8dVCQs5F7
	kRSJ5slHfLhB3EZFYieRI9EitswoNQ+barUArSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:o2VnmLJVBJzKPZLxvmUc2y6EJnvLeW60AQic/84VbE4=:iD37Lk6/rPmJyR3XRNvJvqz3jQO64dU4LTUzuBoG2d4=;
X-ME-Sender: <xms:LIPkagyHuMKSafRypLH7a-zFnTKiz1p_qNlDZY-uuqziXF1RiRWcfw>
    <xme:LIPkan-JZ5Bsc_qf_qzSKiO4SSGu_ZhXLK-7SbhLd_ga2MSLJRxYfgla5kYQhAz4g
    vWjkVeTtUTSvhq5sd9N1CbD3OI9Aai-Q4JL3FTyjqmGiSI0y0jz>
X-ME-Received: <xmr:LIPkasL_dK3hcnlU21pr2ltTidzucQYz5Pyat1ZQ_Ki9zJYn2Osw3LMtdyOK0WxdArlHOw>
X-ME-Proxy-Cause: dmFkZTEweYRmagK+U6NI40C2gOY56/U7LG2BkHRYtHGegF8oYRz9i4J2vGpEgnudzkTbxw
    S+05SZ6tnysqAiIuvW0rwxSCZ00N22HDFMiHosy/Ua4cl6RIbsjuJ/uu7lp6OCXbAHqwkT
    6QXUlJGPjy1NHLsRNtVlr5IhsX7e34mkzuRSD0q6qfCPSfug2rRloXJkdp42sa5WRXVz1s
    OB/Vtpd017fmsUWB8n51/KGmPksOVmgNcVVsvnKkP1w/4p1Gl3FFTMFj/yE9SGa9bGqYZd
    DEAc5WEVzqrmu52PmOXcyz83GCHyepZh88qBQqR3ddvqbZWDlNCiYkOIuK5E9t2uSo9UrW
    uDsZbLiLkyNl+/mZPx2C2zpsrfDuzTbWfDzBcdBwgfoeJwWbFIqZEmKtRH0HHBSsHSxFEF
    cELHcrywywF8Y98o13OMk/C60Xux16S1eRy9viAXSYCOPOBR3a33c6uEyGUNrB4J5oXb/0
    6zebDeAaBa6PkDtt6HC3d4c6goESm2AY+ruW6qwPLZeq85zSDO5zDnTDNwauZ54Iy0k9wm
    VFdjItAm144W8N9y3huFdGuAxwkLRYhsCQCppOeAEgjQb5OBhokdXXivFCRHTcgTpi8VeI
    MyFObumJieraW8/g1VW9/BvaI74q2MSY4WaZwdqFmjJvSg7225lqcvN0SU5Q
X-ME-Proxy: <xmx:LIPkalehXt8cM15RbK0dhBmg9qi2cdwyS0qN8-dLahExQwSjXYYq5Q>
    <xmx:LIPkaj-r6LTF-53YmZa1VAAeb9Qyw5J9uB1EHEWBz17xNaenIP3-VQ>
    <xmx:LIPkaqqiLyDRTGNIhtOG2MqeclORWXarzLqcN9TwJwA2dwkkCyYhpg>
    <xmx:LIPkagB1Le_i1W_AyiP0UACxAiUynOiTPnZrvCicDr1JseCXdAbpiA>
    <xmx:LIPkas7Uo3SkbBjEzjmXvSD6JIgDVWcHg-vA4ILXP3B2Sb3qmOjBcrZK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 07:44:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41ad265b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 11:44:42 +0000 (UTC)
Date: Fri, 30 Oct 2026 12:44:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] convert: use size_t for text statistics and ident
 counts
Message-ID: <auSDKKHJONZjx2LX@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
 <cover.1793352943.git.gitter.spiros@gmail.com>
 <84e9e38a3e63a2b135847471a13ea36d37bd64d4.1793352943.git.gitter.spiros@gmail.com>
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
In-Reply-To: <84e9e38a3e63a2b135847471a13ea36d37bd64d4.1793352943.git.gitter.spiros@gmail.com>

On Fri, Oct 30, 2026 at 10:58:53AM +0100, Elia Pinto wrote:
> gather_stats() counts NULs, CRs, LFs, CRLFs and (non)printable
> characters in "unsigned" fields of struct text_stat, and
> count_ident() counts "$Id$" markers in an "int". Now that the buffer
> sizes they work on are size_t, a large enough buffer overflows them.

This sounds a bit too deterministic: it doesn't necessarily overflow
them, but the possibility exists in theory.

> Unlike the previous patches, this is not specific to LLP64: "unsigned"
> is 32 bits wide on all the platforms we care about.
> 
> The counters only drive decisions, but a wrapped counter makes the
> wrong one. For example, a file with exactly 2^32 lone LFs gets
> lonelf == 0, so will_convert_lf_to_crlf() decides there is nothing
> to convert, and a wrapped "printable" or "nonprintable" can fool the
> heuristic in convert_is_binary(). In count_ident(), going past
> INT_MAX is undefined behaviour.
> 
> This is not a memory safety problem: the counts are only used as
> hints to strbuf_grow() in crlf_to_worktree() and ident_to_worktree(),
> and the buffers are then filled with strbuf_add(), which grows them
> as needed.

These paragraphs very much read like AI to me. I would appreciate a
human touch, also to demonstrate that a human was involved between us
and the AI that tries to understand what was done.

> Use size_t for all of them, and compute the size hint in
> ident_to_worktree() with st_add() and st_mult(), so that it dies
> instead of wrapping around.

That's awfully specific.

The patch itself looks good to me, thanks.

Patrick

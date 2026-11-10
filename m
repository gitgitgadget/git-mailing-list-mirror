Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348777;
	b=SzfGW3MJ+4ujGV8Ma/22PEEsjlgVbfBrJvj5bsZzgKriucO+ucs0crNsvxTeKUklYhrS
	 ceA6yPNw6Pc0Ks0bbpHiRV3mpLRZSzIcO1reD8kRmmMDPK0NZwUexfz1bHFziqaJpb14b
	 s/d+Dmiy//0fvQ+oJGtKJCA95vdvunmRsVH8UQMlmWH0vTdAIMEMxcPfSdlQy/Clfi4y5
	 XuGk7uGYzN1FnDuFCnXADYCI7BeiN8KJzxGKdmIed9VGiotY8OV+O10t6TiTtWNWKsfuh
	 CnSCQmt0RDpnsAs07NWBCbeOUetpVSekT4H3b4YHDoO75I0xoQyek43ttbVdZiaqNvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348777;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LE+dzB9jryYX7bwoSwVp/3jSEUUHtUdkZPsF7qyqvXo=;
	b=puV9bg2ZfegySfomvZTDJwPCaRLOM+XMv1JkD4VMYJfDIj5HLvdnQmHoYNQVZhjgyP2h
	 zZZJRjJdKmyaY2gIPGCJ/yjTESDCgex0H9T/HN8lF1RojGbhSmy6zYzNzNx/x5leK7q98
	 xik3jp1lWvw0KkB3lq0RBOMknL8s6bCm5iKt7FnDv4aQaJLRRPVqk59VVIbc7obDEOme+
	 TLN5dnb61psO+6EnqXS4RntVHjzvCxbcSxIhMzQFu9bMsPBXtr5XhwCPrhAfctAiDvGnC
	 P68qte7EhRWAJdyWDT1Ca3LmwFp7yUc9DdiqAYjHRf0u9AeB5IuHNWfKQwJeck/LIVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=oDWluNfH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bYPDvSul;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6A606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 22:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB6A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=oDWluNfH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bYPDvSul
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 47DBE7A0197
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:12:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 17:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794348775; x=1794435175; bh=LE+dzB9jry
	YX7bwoSwVp/3jSEUUHtUdkZPsF7qyqvXo=; b=oDWluNfHZyIkUiq/C9+cufBcJX
	M2IwKzhVJNv0KnFt5gvZCeKeNNFRewNYPita0v63Tc2wcqbjOMUBtKSMrjTkWswS
	yNez3wS8/fDk9LrDuTcb6z50oHqTmBFFyp+OnThEt2eRp26PF9fbPD0Z66e9atUI
	uGTagydAiGjG31CLY5QjYvwTXdCHDZbAZd9h7a3l5znmZUZeGxRF5OKlcsjArtQj
	L47zyJCZzSnbW0gQHOtVmNihlb3QPfTtJL/Bjhyd5zMoJaC/AuUotzWWKPYmI8IS
	ik30UnJ0cprMwxvjNQ8fvKzZwRerj9ovJxd59mbtTQwFnXjb0r5fn39nURCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794348775; x=1794435175; bh=LE+dzB9jryYX7bwoSwVp/3jSEUUHtUdkZPs
	F7qyqvXo=; b=bYPDvSulguK/JVpo4ftY+9z4BnQZODc7biFYCaKBM5GXaxFZkUy
	ep+gyDFSrMLgO0GPPQnLqqjrpX1z3ipLERXOIWaIH9DQvUnNLfiGL/Y7dtzQk7pq
	TwISpQCY9CxO/3qNzBGJSZMonjCH+XK8saL+VDCz5r9cQ1kMrkT/dL8i+XJKoKBu
	Ufs5zpAldmqCTpAlp1ZrmwlwwsnpHB3wFSAY3iUcHfmBE6U5SmYptUmhgehv4364
	MprLufl3p6g7Ylf+ojWNNy0XFcEmJ6VhH6UcozepjUkILaGv6rdZQ5nDtqvv0yEH
	KYNeLjradZl20yGkTvgAm9QFnQNrSKo/s8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794348775; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WUFP5AuF9EBZMM3uAJS06KdhEytvAQkBnqoxcSLDreXvaP/
	wths0OyqKfPIFAEN1YEKckdz0UC8obvM0U41RZcz9ntcrcMNOp9tybe5lRA2fYg5
	Ajnvd5ZH+O6wjXbM30QLb4BKirMoVWazfvRLmYdmVeuxZKDyVg0eXk8ZLKXnbku/
	t2iPTTAJsPDql8e1S4dtig+2/D28vNbaUXU8KbNstE9ebnAabQ8o02XTpPc1eJ7R
	Nej+rdtHkdU7x1TBg8b6G1Uc7H3Tj8jerxyElXrji62/H+GWXxyxSEb9n5gIXpR9
	H+lOZsZo13KUFD/cVnp6j8W+62LbLP4B/xvnN3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:s9T+NkyByRLy4REv6r4xeFl9EcGJt/IR6i6xdd+hOIA=:Bt/RYekX5HLk1KgtBf9sF5LZt0/JfLG//8F424iZChg=;
X-ME-Sender: <xms:55bzaopCXmX7GBTvfWGhSFFIuRo22tujmjahcqpmXlrc6Q78GNpFIw>
    <xme:55bzasdeQrU5fixfzZdKuKWpUe6PsxQRaCEdShuHusHLjndhNcK3WTh5BEa_tKeWL
    IY6kc90kzS-mMX3R3Yn6qWNH_OC2tIdnu0hzLfWPlUowwm-SNC9RA>
X-ME-Received: <xmr:55bzanpaHm3mj0puwYpzWmcN_b8dZ8H8VlPtHskh6NUVY0TT3m_FTNiysaAN8Nvz-2B32H2QMjByFTBDRS0VgGtapItE1SrtF4w7CDCNhX4F1APCp5eHPcE>
X-ME-Proxy-Cause: dmFkZTGU23IkkmF33gHnMk7myBkAFs/C4FgcJrXjrc5qr0HDtnyPk0GHoIxXr+Kb8ZL0jA
    uJHneQsKeNuKwtwnmU38+G/llrudjo5BZQJLVBjYUur8SEcTQwAt1lwvdp1G/bslcFNdXk
    ybWKCLT+cjvPOUwXPZpSKnHFOIvJTf4i/74ljW/feUWAKqDFWiiUhH3yRZZzdnn2+BI7oy
    2pggNYSSIAFgijjyUKShlkG+2D/RYhJphooNlAqdRtGDIL6SnoG19PmTrLDBAY2E6KwVWc
    kRTSyf/my6ZHlFhnxHgDni1PZqK7kRSe85KFD41voa8dyxQM8iXLMiVutT5kbvv3ot5heG
    7MoEfJCm6x5jWynNWLcQd1sJ8FGVZHr/HDfMeexVzeGoCn6d3+EwMKpB/Bghd3juFlu2h9
    X3cgn0aWi8Wj51zlP+86PX3Qbejkw2hCrQqnytPu2UJJHRX6HoQ/I8ODrOmWMu4LJynK3K
    Ami2/260MGSuHRA8VYpUW/yKDvZXjsW846ntHpUlXOP/fsyykyv79inehbX5qfdiQ4dL5p
    /1tYCC1R8BhDoVchzGR8or80/Ai3Zwkmi45Gv1pvxnT7PuyYpyaxmG8IZ56sQu39dnvhKd
    EvL85OK2IKQBtp56T7Yht7nRLww9a+jKhzpw2kOIG88BCMXoMjG8ZwB+bjUg
X-ME-Proxy: <xmx:55bzatFvRD71oxntqVUnU0jrto8UskP21AcstKo9gy8BEY8s9JbN1A>
    <xmx:55bzant1MNoELn7eGm85seCC7m90w7NBVV59SIDBRjwit7c9_hktgQ>
    <xmx:55bzavVtv4Jxf-fA2TzzkfthSZfh4btKAG5QuBlz7JgOHTRZwd3mfQ>
    <xmx:55bzajGCOh8o0YNv2rfvf4Z38lq9GPWyZEAepD95KRJ6u-pgCzMzzA>
    <xmx:55bzalivlH08TtwcJXBEwzItASo9Hui1MErCX6bU3hXvdvESNDI8n30R>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 17:12:55 -0500 (EST)
Date: Tue, 10 Nov 2026 17:12:53 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git 2.56.1 and friends
Message-ID: <20261110221253.DBFncUIG@teonanacatl.net>
References: <xmqqh5hosgw5.fsf@gitster.g>
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
In-Reply-To: <xmqqh5hosgw5.fsf@gitster.g>

Junio C Hamano wrote:
> Credit for organizing the set of these releases goes to Johannes
> Schindelin.  Credit for finding the vulnerabilities goes to Luke
> Martin and pwn2addr.  Credit for fixing them goes to Toon Claes,
> Karthik Nayak, and Kaartic Sivaraam.  The xdiff hardening is based
> on a patch by Jeff King, with help from Toon Claes and Christian
> Couder.

Many thanks to all for the effort, including Junio.

> This addresses the security issues CVE-2026-111760, CVE-2026-113408,
> CVE-2026-114466, CVE-2026-114467, CVE-2026-114469 and CVE-2026-105437.
> 
>  * CVE-2026-113408:
> 
>    It is possible for a server to advertise an unborn HEAD that contains
>    path-traversal characters (e.g., `refs/heads/../../../TARGET`). With
>    the files ref backend that can lead to ref-updating actions to write
>    to unwanted files.
> 
>    See <https://gitlab.com/gitlab-org/git/-/work_items/809> for details.

FWIW, this and the other GitLab work item links appear to be
inaccessible to normal users.  I'm guessing that's not the
intent.

I added Patrick to the Cc as one of the folks who may be
able to poke the right folks at GitLab to open them up?

Cheers and thanks again,

-- 
Todd

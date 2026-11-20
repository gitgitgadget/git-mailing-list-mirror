Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193665;
	b=uOCFR/7K7hLIfIzti8ci5oFouseXtk7zJbaN9yHx8O18edIH0aGEn3b+4Azog/gK8J0n
	 LMs4+Uo6Nua5S4jy7NbFpRySxhnVkXvatxReInC3+j/V+G6RLs9kGds/VzsnDjuIwsTyP
	 /Hw+/Dt/oWmCmL4whzla6UO2enDSlclsRTjo53KIVBvqf+M8QAusAIe42aYxe+UgBHa0x
	 7ir+Nny/lzf+ImXbCldr2wc4ZfLXGEqAd9lkFoCdpnMFhXedh/qcemSZZBUuZKWabClUY
	 NTdZ4kJfPT5i+GPm64JHhf4lWjsQTd9yogce4Mbc4mlTuRQ5SVKhMecwF1oc7DKROrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193665;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=twbbm0ez9gP5WqiQYQjwbtdtNUd1jDZMV5x2bMKY1SY=;
	b=HhqPvoc0sqduWYzUtTICcbhvSEntoTUUcHaDRpMHfs0ColYAdWHJdzsQfBi6bIWmMWrG
	 04nbGhx7bTXGeelHW0tWOLczl4S2Lnyol2NWdYHJLBaSi1iYY2hlkNGJlRCDLX01n4+nd
	 USAleRW/7lzD8Id7JMdlbs8gg7koyz2Thhy9aen+Y3Wuh6SGczBxpozEvpGaUuTgaD7qP
	 uRS+BTwDfIhzhJXG7+y/rvH7/O+Q3gHMcJlxhql47LT8mbqCXbcsW5H3MZCNr48AmRl8T
	 XIXrAyKKQiOc0DE+U0PN3GoEG4kGplP21lvZ9PmMSIughiMemkvXBJ5CFleT8McYJTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Pw21npLn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SwuLizIx;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA40606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA40606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Pw21npLn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SwuLizIx
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8ACE3140012A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:54:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 20 Nov 2026 11:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795193664; x=1795280064; bh=twbbm0ez9g
	P5WqiQYQjwbtdtNUd1jDZMV5x2bMKY1SY=; b=Pw21npLnW+uJzPDuKp/TBGW3jz
	HxyqI2cf+3kJY9/fbV0GsbUoQJVhW6sjYzTW+tvCNljc4l73GnT+AG18vkTrbQWD
	oOf63BycDIWpN46xVhISjlxYpeeRp8Wo4dSVe8FkFNFWSbmR/1X9M+OWp/MUbt4B
	K+LIIGoX0XCIWZ6elEOgjcIMqQiAXj2avIVPJMCVTeqHxIiIYjG1kjJ+ZGPwm6pD
	UxArvUeuWMCa8EE9ej3dhrf8GdTAevKG+jYZVBgV9uLCVl2a2HG8J3d9m3fEjY3P
	XHImZu5iuG7RGfaXDVQAxFpWYCe/89QuxiL2Bno0LiLNv5benuR6Ve0S+Wfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795193664; x=1795280064; bh=twbbm0ez9gP5WqiQYQjwbtdtNUd1jDZMV5x
	2bMKY1SY=; b=SwuLizIx7WRW13vfmly74MVwQTUdbflul2ENwBV/f34dtKJA0pS
	8I87QxHa5L0IW4/IudIaKsDpDcaJJhHwezeiiMfj63l8T9glkFicAh8crPMuGJLW
	kEnVFPCNf56uSZiB9ThfIEavqCBKvteyMOvaNqsKqcDY88DeGSOHPJ3CNYibpltY
	wIxBZGmf7ecnjpCLk584otM0cVg5i7lUY6XKd4SqNPErSDB6oxK9liBdaVNlsDld
	/yCEx48vgl38p8tHwKeHYwJqwucDPiBRHqKdvHDQKj7KDPiLydPnai1w4fsSlosc
	hAo/gyK72jU0kVenmILCupzycCXcEDOLBUA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795193664; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:h+ihW7Hsy29MMHvWNMKFmFBonh01hnbh4m2JvTJefa9xfpK
	10nASbvnA+c88W8k0ETMWESNVCDnna3Cgq5Z7ws7fhYwI5ULfkWcQnjS9jS4XZWu
	3fg45fbZ6FrGl8qvs7XYuEMlP1885CERif2DEfNI5W6PsQ/eu5jmKWwu+cSzSh4j
	8+sqjxm4f1YM9nNFYojy6iC+h1Y54TQureb9HyecPTzuo6mEELMvlZ9+OcX8WUtm
	rxCMovHtAE9hMRYi9FT5n184+xyNs9QdqRUSjieOIW3c1nmB9Q4IV3fHufb9ZWF7
	o1m0ATreUUEJBVxUzO+S9eyxxPiOZxLYoVtTH/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:18Wwp1F7TFOiYfxa3GWR4v9BJbUN3B0rPec/IxVvk10=:8totBG4sfiiL7lRViazZbI6fztcvyo5vwJ7yeUXgZNM=;
X-ME-Sender: <xms:QHsAaznm4lkTP3CwemSk3j220Zhdgq6dl86mg2HqFx7X5fEMFNK-lA>
    <xme:QHsAa9siLOaeSe9xRwDhJHpxGN8aS6TZMi5qdYfD_lLsQwuDq8ddI97De56yC3sZf
    nh-yhR1UYy0GcKpoEw1vVBvtSjwpETM27a172QUOVUl01-gloXH3Q>
X-ME-Received: <xmr:QHsAax8sEldAs9iwhBtJcsULbHlADlwA4HTkwakrKHB_38E_qEzy_SIq_C76fQ9dpfylbWJ5eTvJ1GFtW5o8Pw56zKLRYxQrrbDK>
X-ME-Proxy-Cause: dmFkZTFE6vcRYiZgufXw8W6b/W/FY2uY06eLvsqzKfbur2MRHEifoDIS7TFuLaqG0lnTkt
    VSJwTNywPLLGifjJ3sBg4EWtTPeUuo9jDe8RIX77BRNSNEEmiBnxrBGIoBlywf09DL2eqo
    mwqfB9xL1cWYxyT5dAlbTOBT8Bakxh59rD2BCgNtmBNVI5rK8PXjnwpU7RAbZ4KnnpHW16
    CeruzF2j1Uj/4b66b16KZpnCkEJjTcaQWQvk3g8nWof2pCl/kSKh7bc+jIcPXKx41+2TOX
    B3NOZRu3KeD5BJPe19iYEt5QxyI0ZrM22MDlnhJLji5QGwyOTlwowInjH0q8FDMexGCZAd
    5buFG8sFp2+5ITd3y8d4Cc/SBen0c6Y0gk62vqz3SUG6VFp8NgRytRwZne1J8Qpt5E8DxX
    7b70cVtf/JGV0nOwIvUq/yrkazkPIYcwJpEtHg96SEWwNUXN/S76nMB0LUKGFmldoSYQu4
    shW1pHLLtkhVvjLydbPfY4u0VlpyaDH0p0iywsQdlMvotQfykv+3JQBwVITNgAgIYautep
    JV9M370mvWUsUrmt7+Nnv3SCSoKLvEyuq2mLYmoUyNYzkuzY9PrJYLixnrVviEWsGlST1T
    x8mbWdcNuUK61gxakPXgdtJsR8FObP4jV+Z7KQXC8oPLuMZlAy6KgNWaME+w
X-ME-Proxy: <xmx:QHsAa3PNlXotZMLoki6bshs-GGWyHwiZMKWaoht9GsRfLdbtJ3jcnQ>
    <xmx:QHsAa_GIdx2_df-al540-v0d3uMYXCHKAUEJGLxRlu6sTXKcTjy6og>
    <xmx:QHsAa1QuFjHZq3xHHwJh22SGmPIMfCnM29y_sTuGcilaqfDRp9yv-Q>
    <xmx:QHsAa8t5ureTegGzkLy8uee810iQ8QruZII8ydxk_tbW07VVfRs9ww>
    <xmx:QHsAa2ddneL3LTLMZWM35cCun7vCCX3O5aXxWInQQq-UmTDTIabmfIns>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 11:54:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 11/13] builtin/rerere: use `OPT_SUBCOMMAND()`
In-Reply-To: <awAd2xxwvH7HCpbH@pks.im> (Patrick Steinhardt's message of "Fri,
	20 Nov 2026 11:16:11 +0100")
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
	<20261119-pks-rerere-subcommands-v5-11-0c1092b88958@pks.im>
	<xmqqwlq8tpbm.fsf@gitster.g> <awAd2xxwvH7HCpbH@pks.im>
Date: Fri, 20 Nov 2026 08:54:22 -0800
Message-ID: <xmqqfqwvsatd.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> Fair. I think all of this boils down to the pattern of having a default
> subcommand. I think the pattern is okay as long as we really only accept
> `git rerere` without any flags at all. But I think the moment where the
> user wants to do something non-default we should refuse flags and
> instead ask them to use the aliased subcommand, e.g. `git rerere perform
> --rerere-autoupdate`. So essentially:
>
>   usage: git rerere
>      or: git rerere perform [--[no-]rerere-autoupdate
>
> That ship has probably sailed for git-rerere(1) though, and I wouldn't
> feel comfortable breaking that interface now. But at least it's my
> personal takeaway for future commands.

I do not think it is the worst kind of backward-incompatible changes
to give an optional explicit name that you can but do not have to
specify to the default action, so

   usage: git rerere
      or: git rerere [run] [--[no-]rerere-autoupdate

or something (I've always considered the default action to be
"rerere run") would be OK.  I do not know of OPT_SUBCOMMAND()
interface has an optional subcommand bit, though ;-).

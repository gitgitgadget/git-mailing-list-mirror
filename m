Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222941;
	b=ff+jALJtDcDlE0JIpLDCe/9NkYTc03xfsOfgSu2/H+DKkE6ZYA9L8vcP1QqBeK3X++95
	 9Me/Tmry8SnvaxaCqEYJlGCL3ijsRqF2E/kiBp2cO//xvu/f5OxaekVBwVso9c4q+AAWY
	 wvmuGJPeJaNO3aFqYHh55dSryaKEQsL3x3ETNhKo1w+MweUc5Hry5BmgmGdsRbBAXgZ8k
	 xrejUjffs3Y6WyrKZv7iD3/3jYcGT/OdiQU0wJ+hunVu+xoUOO8VoljMVG8ttZvjtYJ2K
	 3U0ed0G3q96UF7qQuNqgao/oB2tpBmsB99fCrlQZQiXDTqrL0Q3dbEBupb+q79vq3aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222941;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wvN9LtZF1MG5+AaP2Q7rjd5r8K+mN261MFW1YPgkdho=;
	b=o+N4r7QExV2ik5z5zDPKjzhnWlaPjFYUNH3VICvQg8K7wjwnFH3yiHOUWGfJpgUs63is
	 TA1ttcgKX7PRrmCSkduppLrZo8euOj8hQEhS14UlU0VgKGrRUh9dBznrIldhApr8Fq0EY
	 pDiaL94mIw6d0QV3XiPV7sNWRAx49Jf1GOOGEOGSTO8DBLy0iStrDF+l25My2ZdUQnlBU
	 FmvQJ/A7enU477G+cueoevfBAnY1sw0ee3Dv4j5//nZDDTyNJx/U/K2yvEwMlTZKdpdv5
	 t5OCEr9POyhhJmZszM36APPOhugbMdL010ji7ZZ8CzrFTsFQ+kiW0EZkSu1S0KehPOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dgYMga3E;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KQoL1kb8;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D30606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 21:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D30606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dgYMga3E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KQoL1kb8
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 840EE1400169
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:29:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 17:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793222940; x=1793309340; bh=wvN9LtZF1M
	G5+AaP2Q7rjd5r8K+mN261MFW1YPgkdho=; b=dgYMga3EFr/aezd9l4FQxez+P9
	5vtKIFPs3fWln1aqiy3Z/Q2XPJJ4cE9UBlAXo7vJDggOHTslkSTNgRRzZlX+ASTQ
	a1GUI5MqsUJYcpOYa55v1ATj1WXe4iExzflC2t1IsEjddBefarNJkcj+x98NsA6Z
	RwFNbY2/gof1F5c1yqQR+RbTC9s6U5Aa6dZPS+Rbd2jWmcvT9hcGbxODXOuVhtXG
	ODwjgItXvhvrZXkr3RDsoKTlF5BS5YZlz6yrhfal4S4AU5hm6QQs5GOE25i3kEpG
	oelCtF8mEcMmVsZiwNWZ8xcyh/5YOKPUY8qqYeVqrATcCCwo9ExcCPHW8j0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793222940; x=1793309340; bh=wvN9LtZF1MG5+AaP2Q7rjd5r8K+mN261MFW
	1YPgkdho=; b=KQoL1kb8cgYcEkitnJD3xovG+9DSmJL7cw7eFcO92drDwH/DoJ5
	QD1IzBlVx2S5O4KkUi9h3ZB+yP+vVqwH6TQmPK1Uyq+C5NcUqC0YFqsE/FbdAXqu
	cqGRoqInURN5pVKDEYCsMhHhzbIAYgw4RR9Fhxyefnl3g21+RqsA402alP/Rn27F
	rIfZXhk8wXqVdBTu/uw47Oxh+3kDEXsCLBbCNKM1wzOvtV3gJsj9aiUrONWpgcjj
	W3AlfkPZsQdWn+5LS8El0Y9HL+MMc//QT251WybrJefV7joHwMfwD8c/tFaOe7TU
	+urzrwLQoxSZjoczlypuzE42QTSiXwx7/Bw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793222940; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:iI9xie3E3KkIwfbWRNUxrQj1L36mML34zjSDlgO2W+7fdSe
	XMDpjUFqsgkoCRQPBzt2EEItgH2idMk4GoNKNDyHziAyqXCzxBz0I8Osl4m8P6qP
	4Ut/n0JmLHhKR0CtYA86TN+VRehuCNB3LunuJJof2L96vzcKUc/pcd6DJTAXR2w9
	FTrzN/nC2xjg/fpxGgT4ESkgyg89Zxr5gZ4TNricfsdSxcaAag465wwlJeyH6zRk
	/26YBKqZNhQzCVPYq7i7nUD3IqLfSj5Ve8uJ0CcCKRFOlFtuDOKPDxgjSdsMEze2
	tNqw0Uxp4IKhaKr7F71nsMb6wAOGntCuaxfq4OQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kDJy2pGNfe52R06DG9LWeiwq3+qRazdewkg/a2w1cF4=:ixQSI4I+q4bdL2wqmvLMUOL9Efz9mqam8++VPNkOytY=;
X-ME-Sender: <xms:HGniaouTeFcjICccp5JcnjJuFc8iSY2JkTFrd6z0AWFVPcja214czw>
    <xme:HGnias6r29J_YjIaxQ2tlq4XzI4CyXhpV324XsX47K151lEnSK0HI4Vhn7gzQ2p7a
    cp8tPMcF2P-1QKI7va-1Q1CgnUex1RceQ8p1JkDqzYng9nc5qJFymI>
X-ME-Received: <xmr:HGniahJDSV7W_PlvXYJx--Jj2hLdRpuxipVc3hBEw0gilZZ5XWMtOAVb7UyE3LW8OMs-INNbN3odazAs_zmXxuwRKBNlnzAHpOqv>
X-ME-Proxy-Cause: dmFkZTEC8YD1nCJOAQ5oAPqOVXX8uuzPQhR+Ih7M9cjOr4YM0ufBHVUXD0VG100v/QaDHY
    j+TB2PWyNq5nQpG/yARHLc2SuYzuScdMRkHNH5rfr++1SrjKMbMDNQsKRYI+zACxP95oZP
    RQXxw2Yb82W8GTznT5Be+0k8de7Entm5RvhPP25GKgX+umLuV94mqpzkHPFOwOrZFk2XBl
    R3GCZxYDwq9e7Pxf42oSeI7MSymNyctm8+9G/ptoV/BhxqhWGgi/kXlh3qLWVXGln5T46J
    MTPDkxm3ALu5s5AlXSpPmWGTpUz0L+19xWX1Y2XrgaG89SDAeZAC9kbvBCqeZ46W+dtoqq
    x9834onbfsNT1tVgxx7ABSPum3A/C3XF5gQiph1CCh2iFuhU7cDlsEQwX63roPrSYdmtgE
    EJJdXSKO/ZdXIZn0oHJ3MlmXLNj23KQFdYUu+hVYtEeqRGHaDpvKiGsM4Oy6HpH2Ek4lMd
    Hr3ajXej/y+6RO/rVokYPEENiToQNI/xAiaDmlLbtF82N9pIhCBxUU9gtqdU4kTGkQ7I8b
    fNYx3DSWUb2M5F+YRttSPKf/iJVvSyZ/OeQBeQ6FS0DKFD17WK4ewWItvMt44Ve6ph6hYZ
    x/8jp8f51o4KVICNkrIFZFlD06PTbM4Ucg1iqvABOlQvaMpM1hWhjcsRvHPQ
X-ME-Proxy: <xmx:HGniak4-1lCZs2770NACr8ixxvgc_C2-z8LcFOcR5isqNRZF4CO9wQ>
    <xmx:HGniaswWfGUQlCu2hs5xT5usk-PM8b9oFJwvBr1cq7QkgUi6cvhebw>
    <xmx:HGniagZ-8qgVW3OFOYmLuacaPtPQf7Ke-4bgSa6LyYGZTB5tCLZ3uw>
    <xmx:HGniamQW1JtljISKqqi-xhSKakDRWsExzvpyBoIRgsqQFr2Eh075MA>
    <xmx:HGniatAYD6jNRN8nUzRObPi-QxGq5T8qsymfoNq0CO86IWiA9XKV7LU4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 17:28:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] builtin/commit-graph: some small cleanups
In-Reply-To: <xmqqv76l7e48.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	28 Oct 2026 13:40:39 -0700")
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
	<xmqqv76l7e48.fsf@gitster.g>
Date: Wed, 28 Oct 2026 14:28:58 -0700
Message-ID: <xmqq8q3h7bvp.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> I read the first 4 steps and they all looked sensible.  May come
> back to the remainder later this week if nobody beats me to it.
>
> Thanks.

As to the rest, quite honestly, [6/7] and [7/7] were "Meh", even
though I do not think they hurt [*].

All the rest looked good to me.


[Footnote]

 * Unless these things are lifted out of bulitin/* hierarchy, there
   is no strong reason to avoid relying on global variables or even
   the_repository.  Once we move things out of there to make them
   truly reusable, these things start to matter, but until then...

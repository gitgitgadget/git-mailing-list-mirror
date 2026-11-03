Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742124;
	b=UuKO9CnP0u2lNDSKoRy4e63H08Pn2x1GIlV2NfgzPUVyvAAsvcp5Y1RWQnhiGz+5Gc/E
	 djo/6C3gbKQRzz9PaZ9B8EaOPAJK3j+aqQ94J0YkyZhZ18DxNie9kWxLNLQnRwE0r53Db
	 YLlRxPLp/VFJeWLvNIKlzdAc3XQZIbRFvYoHI/yHYD7+RS9YPuZ+Mdh6Q8TNx5tit5OCT
	 2WObayEgENQbeQI/WbFXGi7/cUDJdGEyQ8GG5AyMfB7NaE3VPs3T478BG8BHOnakXUUjf
	 UWk/rdssal2v5LkD+hVKnC4ddiB/7ddd4Za1gOMWIUnQTwebgFyqE+Bbe6K0U7/KGbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742124;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=xIyssJA6TQ/GCOoE+tn+L/ncg64+vra7v84J5nZrI0E=;
	b=kzGnU7F3gQxET0oUxH3JhXo017gjdFzQ6GiS84IEG9VCyeHcS8JmQfo4+88A/E5GfH8r
	 w6RJUnv+WCEbOJ0KGGVeszuq4r7+hlo1Jj9PaOUlZVkMzgAgWDf4K28n3YmK5+G5LUbmR
	 0ufGvj6G12Y7tAlfZZnye23DjJ8cv71anQx7VgTRR5DZ9XjGAIZubnK+HJGaiL1oHVYMA
	 NPwfKhYCynJxA9KLMaVNqmRTdba8f91V3PV4gDYJcrTb2wIriSB3hQR7DhuX0r0Hs7vkq
	 smoHQvAclrXyyAnCfx5N0e4He9HTAJ11mlRbmPDggChyJWx9R0DWTPY0+foQT7pydcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=temperror header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EthxTF+k;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OBWpw8yl;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80490606A337
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80490606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EthxTF+k;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OBWpw8yl
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B8D37EC0699
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 16:42:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 16:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793742122; x=1793828522; bh=xIyssJA6TQ
	/GCOoE+tn+L/ncg64+vra7v84J5nZrI0E=; b=EthxTF+kNUucxtbj7TJ1qkrqYW
	gZLETJM35YyvKRs64b479vzwzA9+5uS2JFacC3SVwCJtTj1WSLVPK0W8LF+7bfZK
	uyNecmFJVVuvcFF/t6BQMgAmM35Cm7k33WSvQloOtckXSZQTdSRwM4R+gmmp9qv1
	nMEpkO7uChOV2FOtdFyehxql0L+mAX3Jou3z9bt40UyvOFqJUaWs0P/LIQjedkHi
	tIRCgEhYugktnr/KyLD2iJfozUlPk/CBHRklFgjCQyoogo0wNaceL6gXoIQmdHhH
	CnfZNjWIXVrqSuIwxPBHgPRHa3jVSQepoOKvIO/8EbUHglVuYLTX1XFdbScQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793742122; x=1793828522; bh=xIyssJA6TQ/GCOoE+tn+L/ncg64+vra7v84
	J5nZrI0E=; b=OBWpw8ylI7qL3ODrJpV+N9Uoo2Fw900AV5W6ZAUISyY+X4duaAS
	eaDUiPZGIDzmTU0G0VchubA4GRL3qNbagb1OBeBkjI7SLgvIsY5RAGG8viws0F02
	Gq9ew/VK4/QW5dPcgZknakj0Kgiwvy/SZ5NqRGH6WC0fec0B26N/COTkEHoRkV4o
	5QgMeM+NqzBbgtkTwBakrPTMPc1avgEzLZX6/tNijt58McAWD8i27MJoZNTWqfgv
	8adgH8tokegTHy2aNShqJ2cYRgG1ngyBu0hWb45eZaFFX2d5jW23Rera/C/P3CdF
	vVeg3PIQVHoA8WFoERhFjH5yktbTYHUC5ig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793742122; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hPV6g66Utxw634nAIGIf4iK2UxhS9ZB2MOe7ETurADu1jmT
	ae6VJoOwTF8Wm6oJ+rpX5855TeD4twkKxHH3iOrE2x00stjdnG6ZgVB4KnbyfGI0
	M5GuVTmkCCrrmu1UbxJXvjQf7q47xWx5wKRbEN6kZY574P2Ux4gwlMO1yDmBYJaA
	hn874yX99MAd236YJI11VSO9ALXtUSLG6v6d/O0U4SJpPQm6m0jdEhL/dFzSmi3K
	tx/xj5d7C3nRrGnb0TUg7XzSoSRqp7j7QuerhjoE+KvZDEQOjXg+sRbKqVaDyUKk
	NqQjpeNcetLW7MoSNhclri3//1Yjfx2LNRZrFCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:l6J0cpAn0DPZfxF1gaUKJX0mXXiZAybLsbalcw63lBY=:zQTpp00IOFz9BuM+PEYMkAmSy6AKBQLBlARFbRev61M=;
X-ME-Sender: <xms:KlXqauW0VrM8pqDuLTA3xOVBUesTAwIZvQbUNlsWZZbLNy2uMYPDWQ>
    <xme:KlXqahequbauGD7gxMjz7BFtTNF8AoXItvejWLCxAG1lw-ARGxHEP7KNKeaKpGUPQ
    h18i4tWyUexvsk8ysB1zr5uZBmyij8AOy7pDXs7uG3aCuTsEgZyKCc>
X-ME-Received: <xmr:KlXqaquoJP5P1isLbsTPo-qkpeJgLnKpLrIJ643XIvZ5fny_tdxeV-mkSY4vLlyO1AxIV0srsgZGiDsAuYlYNI533fSu6C1uLy6g>
X-ME-Proxy-Cause: dmFkZTGZGhCLLfzU5RjxUsHk/kgBTZpjsBdE4lW3ukPsmxFBUOAnWLNlDqTUKp71XxGAt9
    nh4zj+cpOoPKVrTDDn1kPG62Zb6O/FxfD/U/1/yxFROhmqDsJh/XYvxbeS64ijskWlR8Gk
    MKXuHFhcltkl6VAA/b/l6vEJQ+rO34wNNGqsR68aJiBRyL5jr8g+9E4o5PRgnCPvnnvGUr
    FGXLbaG1iRuSEsPzKioyg6r0uJx3EB+wY8K3jJtny/9sMSM8EMwXn3+NuD1fiobU6xvqIe
    cpEtZcXNoKSgrjkLkzoawKLNerMWr6+EOPpgxcynGBZXr5y4LJ2rdQgCuB5WFZpQUTmmIT
    b9cdjIA285HrB0fq+tXXvPHH45fVNBMi1VVzbENYqxb6xdoFn4BtjIDXHoEKtSnumy7YfH
    TBZpiNbZ+jYUCbobsJRsEPuhOiNsfQU5zUgeM31wfJvAMwFl2Gisj2aF4uzaq2mFeVnu89
    P13WH8AxF7FHZDFEnV3lbpqp70s9J+lvMEWpkkvckZ7WdyB2HhzvIf2wUYddMI6s/cagnb
    ds69SsmaUkdMutnn3NEWf+XullbWrIp3lhHOrGgn5TzqA4DhUMoGkCWZNhESQIwUuq0NOr
    oReHl5wu21AU867RfvWcS1XuZqymEsmNapTTrA8AQ5teYRx4/r7BdyYM/GSA
X-ME-Proxy: <xmx:KlXqag-danLpeWskyXgbzhvLO2ousvxplFyNU7sabcJdRTblxpPPgg>
    <xmx:KlXqal0WaoH_Cmfr84a9DF1JZutGtFg6UAX2olkcFvQTJBMadPnK_g>
    <xmx:KlXqalBt-7FqTBjjz4r8YkxT1S-dThNBVCE1DuXsKbPohh7r_T-e6Q>
    <xmx:KlXqahezPCgEoBldnAD3mdie8PzvmdYu9QA5wdfECV_RAu-y-aCxzQ>
    <xmx:KlXqagNIm91pCbPhz6HK3arCHj0iafb2tK9hpf3-mkJsdYOzKlLEb0IG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 16:42:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <ff8c1473-aaf0-4737-9ddc-5275e6ef70a2@app.fastmail.com> (Julia
	Evans's message of "Tue, 03 Nov 2026 15:45:22 -0500")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<xmqqbj857l9r.fsf@gitster.g>
	<9a6ae876-78d5-4513-8c75-c4c071c3db6a@app.fastmail.com>
	<xmqqtslx64em.fsf@gitster.g>
	<ff8c1473-aaf0-4737-9ddc-5275e6ef70a2@app.fastmail.com>
Date: Tue, 03 Nov 2026 13:42:00 -0800
Message-ID: <xmqq5wyd6193.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

> It's very hard to understand from the Git history the reasons for
> adding examples that were added 20 years ago, for example
> in 803f498c03b where these were added, especially since the commit
> messages from 20 years ago tend to be a lot more terse.

Sure.  But that is why you send patches here to invite people to
comment on.

> I do hear that AUTO_MERGE was added more recently.

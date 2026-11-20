Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198125;
	b=shwuXgmWK7iDRuMY/ojLfK3CtunDtjxnmxsPMobRkPt69i7lBdwtWGR7Ng7li8kC2hMP
	 FFAssjRcuVwP7wCDNau8NOdH7TqcQ8HXu58qICBMhVDi+H7uaKEAPF+mhOf2J/8JK46w0
	 j2wMlSdOa61zdbGEkrMK0x7r4L5DRkU09XsjCzB7GdIfmiJsp70tmZPzqczZTduJg7Oes
	 pkrHatIyo+saBcMR96w8pNVxfb4M9D//6FS9TI0xa68n98vcnUnzpE+m/T9PX/gQHxrUq
	 t3GM8y9MMkQ9e93rOoHYUKkbm7Gwj/kIJzEyIOyK+32j9FunVbEUNJ3senZpzUcacTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198125;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1+3Zq53g4N+FiOWH+oSmDWAWNVmY57cibBL8wEsUUs8=;
	b=EMNNNhGG1nX6yoz6BMvYD1dKyFFw1imkBjfYvDtgErKK48Qfp13EBUtAX3VXIzxp9YeJ
	 SZ8B/Z56WPHY4mwzrTYN/2ClHiGx/GrN1c3RHsJu099kQOiUwRolRZXU12PkDRyFkEh78
	 1n3pdgk1u6bs6bfyuO8MQJEYNgaxlmP7+PYzZGoVblfVBu99kuzsLPeKUrVFcjLLgPiEj
	 n7v+NTyIK4bhJTdkWV6bDP3MB/TbUMQrcGIi9FfGD8tl24ZpaHi1D7/0vIncNLIC0CoyH
	 2zhlfZ7ti8eSL7SP+7ypnaZSTW2o10t+4VQOBYXahT+6TkiRwza24DPkEijsEjLSxxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="mmvVfG/F";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hqK9miLC;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163F606A8B0
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 18:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2163F606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mmvVfG/F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hqK9miLC
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4631FEC0A04
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 13:08:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 20 Nov 2026 13:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795198124;
	 x=1795284524; bh=1+3Zq53g4N+FiOWH+oSmDWAWNVmY57cibBL8wEsUUs8=; b=
	mmvVfG/F6WgBDBu0IEJTWcxT1v06zvCsWFnnyKlGiLae3hx9xGO6ucDyTEdoFw40
	1YAPjYd+Ec9tvq5/6UZKqn9SmamwtDLy9FEfoJJL3I+AmBP++JjjIp2XufeQPAmx
	ypTCMcH4CO+rMYYS2Yc+0ftJvOvGWyr+fKCCC4p8fhE37u86IlretLuD297kaLxI
	hkPDMfR6Gwrl+9NPVpAvtXELLn4i9TvuVaQGmlniUv7jr9uXABu43oYkVIuz1CRl
	VJ9kTzjojDwDxPddhpsdvbx8t8CzJSUjwHS3I/WOZGSE3lGiBi1Ig5tbMrThTNUw
	H3aMN7Ap8QHjzkuvDffA0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795198124; x=
	1795284524; bh=1+3Zq53g4N+FiOWH+oSmDWAWNVmY57cibBL8wEsUUs8=; b=h
	qK9miLCerLVMfbQhPU2chti+Lze4zD1HkZaEzqCJGoWZgOiCNfaMHYQpa4ARTnc+
	RnIpvUR5aP+ovteNOkS9+wN3wECOzvC24LuOqGXJlOKv5I18IcwZ6NLjsULgVKdh
	YGMn/pL1IFPlTmhOvEwO3eMU3hs73EUcQs37mLMEKKALJrxhAZ0R+OuLZAmYYTRi
	oZlgVqPz5LMyeaLnSJlm1vBHiEwsYWjjQiQ17dDyy0H7r4cDvxPC7WQs+buh8pw5
	NQywJaPthHOOsCJMVjr7dwLXcka0aWfaAiWeptXDp2GGnj3/yi04HcJQ5PctJfrg
	ZeIYp9jRZ5gIdBoRoKiSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795198124; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SAXpeks4a0HHRwiHhTR5MHQP8UNjAoH/goglAcjo+FvXorj
	AuaIjbu6MP9TscnYeHJyNlh9hNXBBWsVcue/KeLAIW0ohyMTwySFAHxwAaDqWljG
	xRwHM/vJ52gG+nRxKJ4CmPReS3dA9mKT18csf1PbNCkrD7wml0l22KcoBEGV41dO
	gTAGVV+hi49XpFWTZF9GyjZsO7HMNV21I/X9UWlJFRyKhte0Uwd2X+toIOMTbLrH
	B1O+PbGyUEsrSpx7lc33keu5tW0hj5q1RpDglZg2QZ6tA781GTy50AIFi9vembtw
	UZAJ8Dg/5aeLHVSYQcCHwgDZq9qYIso+1WS99gw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Nk+0hTCVCTDFRfPQgkucRzBad+vpZu1W8XxZHgMe4+s=:Ub3L9iLmrBlPQc1iWJS0PYlsOT5aCo/swMUHEsiQTMs=;
X-ME-Sender: <xms:rIwAax1ufjpVFna8lmpWuwi65Mj23M74ApVB0q2KNN1iwujV_lFBuA>
    <xme:rIwAa-_Wq0IIgskNXPuxmY0W3Hm0U_QB7n1ZftROrpbFNDkYtMgw92Nq6qIOmjROt
    7G2Lmm2auIptuoyxIuJij9HywQM9r1GFY6K3UokRglt4xsjzQ-1xQ>
X-ME-Received: <xmr:rIwAa6PQq8_o4ByhXqmN19CNDqjYAxdXB2TlKL39rXam0eCFNNyf3SrR6H8jpFi2Dqarx1JnTSPmvq9jdmI8cAGIEVf2GWXN50Wj>
X-ME-Proxy-Cause: dmFkZTFdz4RW4JDGIDijShXcA2ptDQfazoC/9Rt8pg6czC7ZY0pWDa7sWLoMmE77BTpUpG
    YKP9SBODTCnF5B96ZzIPPVIFkHa7JnyHw1Nn6tcehOCLlB7GD4RrisORNKXbN/Qv9CZ2o5
    /x3Ba/RBk+Kd83SSRaRT0Bdypoj2brNTGv4adTMgoyR+215nMhCVySivgVm+zvnVr8yk1k
    SVxC003xPBS8mxFGKnxszfnkYFW6wWctVPi1IslDf3R6GfJO+3pnWsE/irqtNR8/HXRulF
    yCdzCJMIhhtKfLiEY/1P1bPwEFKEl+Dl/TgzQEmfN43s02dAcdclF+HdOchzCq5thWcgAE
    hqvHmSF20JtLISOafKDHeJPB1eAFY56Yjy/V+NgQD6Jx5vuhw2ZZyOobM1potNLCIIavF8
    +bBCX4StbDm4ghTgYbE1w2dTKl8Zg8HOU29tSxyxjsTQxtG74MKudcmicDbtfn7pOo2U5A
    0gqcIaCGH4vGezyd+9cX8K86B+rEKiMcknkQ8NG+nNPSZ81wdJ94jbxADplI5kclO3cl1M
    HBNSXxfVAm4yH2768zo+GTsNMxvMDoriqcqHQnnPW83s51Nle52GFPdL5CDwHj1ESptfD0
    YglJbhSZHoCwGqn9JBnkTxFxXZeUDconMbjNOHMqwAq7a4OsqbcezEAabHYg
X-ME-Proxy: <xmx:rIwAa6dxf_8gp1XNBXdeDKjgftlm7sgw_O_H86_98oWTQMdCui5gDQ>
    <xmx:rIwAaxUraRbIxY-rm2HGvB6u4mRiyqkBAqEDHCCeM7dXyFw1dVAEJg>
    <xmx:rIwAa6iP1Ph13ZQkQibtEx1B44GE8P_IfjUNLY8-cxIwIPY6wQEVkw>
    <xmx:rIwAa49iq2Ak24r5xBYEBbFXWgmk3P1qs7J5T8SxKBXFyDokgn_tiQ>
    <xmx:rIwAa5vKtuFgYc0K9MGSBX08MuCOlRJg8y1ueuTaOFkfft99VjQ70dN1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 13:08:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ophir Bleicher <ophirble@gmail.com>
Subject: Re: [PATCH] doc: fix AsciiDoc syntax
In-Reply-To: <93127462-BCFD-4086-B19D-4B640F515140@gmail.com> (Ben Knoble's
	message of "Fri, 20 Nov 2026 12:54:24 -0500")
References: <pull.2496.git.git.1795194752259.gitgitgadget@gmail.com>
	<93127462-BCFD-4086-B19D-4B640F515140@gmail.com>
Date: Fri, 20 Nov 2026 10:08:42 -0800
Message-ID: <xmqqh5hbqst1.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Fixed it to use AsciiDoc:
>> 
>> https://gitgitgadget.github.io/#...[here]
>
> Good catch.
>
> While we’re at it, « here » is generally discouraged as link text.
> It’s not particularly accessible for screen-readers, for example.

I also thought that it was a funny but understandable mistake we
made, given how prevalent Markdown is these days, but didn't think
of the need to improve the link text.

Great suggestion.

>> The differences between using `gitgitgadget/git` and `git/git` as your base can
>> -be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
>> +be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[here]
>
> So perhaps we could reword this to something like
>
>     Further [differences between …] are described online.
>
> with the brackets marking the link text?

Sounds good.

Thanks.

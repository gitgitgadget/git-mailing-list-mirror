Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048082;
	b=pzT4in5XcNQ5OguFi2NLSEgWNVV5duYJMIxQ9v0UfjZb6nzn2LE+mWRQrKS6IkjAgKl7
	 E2y+PDknEgksrkasDX3TBTRYg5w9pNallIijFYaTPlWvtCP9w2c0liB2TBuJrYVF1o5/8
	 pO0WK5JmkG2iF0CmSm6ctlbMvOd3UqyDNlIKpTIG0wQxW8MCvLw06X+qFqjvu4rId2B99
	 Mb0L9Y3lPA5BX80jyAtnPmopFrAXWHZNytDEeEgmdj/Fqto4lbhbrC9IE4TwiLWZb0X4w
	 AOAqGAK0PsQsDt8BXyj2vVMDSYQDZz/u2Wglbbs7jAg8S84OiBFjbF6VqK0Bz+tOfgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048082;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=HAUYEG9hXI2bjdCkGBHSNZAsEdVAjG+JLA4I7/lpbKI=;
	b=WpXGMmr89TjwQN62GGotxGywonRWO9BVF4NnchPE973pnReAatfKL71tdaa2dp+fGlWA
	 /weB7KjniqCVFW1jTmbJSASfLmTmESc5VNWX9xcMWGdYIO2eae7f1F7CSo6Db02lTHKLk
	 Ou+p5DeqjP/TY4QXVnzkhNPdrovfFUFMcMxNPGr8gJIBJ4tsunsC7Ddl+7nokMzj2jdf9
	 kGS6EP8FodEcRhU8rABXhDv4kSjnHn6o1Hp8Z7ljl1O8J8LZVffJLuyJPITokibUXKQUy
	 B7+ZK5iMtX0fejIu4jAHixeAdwKUaBIHqszoQ7OqUb7TUnJn28baMJ+pwkB6rOSULtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="WKnTB/lG";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jnqMy19n;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45868606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45868606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=WKnTB/lG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jnqMy19n
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B18E14009ED
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:54:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 16:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793048081; x=1793134481; bh=HAUYEG9hXI
	2bjdCkGBHSNZAsEdVAjG+JLA4I7/lpbKI=; b=WKnTB/lGiII28P5MUuys76VlZ4
	g2KnyhqT6ceAvxAIF0RonTXgcPyAePlBIbTxi9kFnbRGzOEZQp7A3HF9B0UZ7y5G
	k7MHTOLEhmzvSsWuDUVFVGSaVlclmDaJVU5kSm0I2M012ih5CrTj+kVotHMYoLZ2
	LkuFtKcieHKW/PcxeRS94TbSule6ArDKBaBcvg97GzQGztaHaAnpORj5dZLCcnsf
	AXWQXegflezz5GHVRuY/+TJ1EF7jK5i71xms+QmJSlujsYAaQYJTDab0xLv5UsG2
	68Y8bBqR46EaV94vBA7w/sJjkVyh+ryvmCBlEvZMVc3OE0n+cTVaA3P0GYsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793048081; x=1793134481; bh=HAUYEG9hXI2bjdCkGBHSNZAsEdVAjG+JLA4
	I7/lpbKI=; b=jnqMy19nc6zT8bg+KnJ71p0W2kxcyC4v0n2hN0aaOnPgb3YXdDc
	9FTeEyTjWG3qb10f+hdv52oSjGc4BUUN/99uFmFXJURlpxtbebxDUgTBGJwyAVyE
	GsTGABDXmc2igQwctyntuDPH2PXnk0kw4UycNVpiIphyVcY9M2SloCKBSdqsOCVY
	Q8vdDo/5QU7/I9P/+s8sIYg82uhp2KPlCU7b3/3zWidWFS8dLlKeNuHCU80S92Re
	xOJ5dXlxmAUhsrMhuFS68ChAd+7HOpQwFP1HFAAgC5tPDWw3xZS4duP5pdxoN8HW
	OBakBfyVQ/fyLtP7cGDdL6GUTPlJMLx2fbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793048081; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lRFO5gRLBcIP4Grvc6Zp62TnpDD0KoedZim1teOWOIBlOvr
	B7BpXf/LUMvP/NtZaY3lVG3FBdIOnkD7SVqGefGNJLCMDnX2k4LyEfkavtUCDFHe
	GXU+XpC+k1Ior0Rnn9t7ig3NJk5nBfhKtZlMEwY12JxgZG2rOiiIX+jmq+uJfc/y
	zOOCUja3/FL+KcsYPIQnvHF/4JuvzuWCNWDXnskI+T6tNDjEaO69PX3Fazbu59yM
	Wir/CePTuNMpKvB8iIv6j9kmhVA4+Ftw/WSgIYcFx7lNlvrwMRFLl8L+0bzJoZD9
	fD0jOn9qQeDQRwE2I3uJmiccPCEegoccEElhyXA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:iArIuAMF+szhuv2HKt+6yRf1YsfMB8DwLgNTJ+IaOAU=:n3wFMwCOUWIrNz3dCkkjAnzIE9yRuKk0eyPD+zj+/nI=;
X-ME-Sender: <xms:EL7favyGo-0djQKQ7T2lVBVxMS6qG8zTvcxN_tWthkttLUQDqr8stQ>
    <xme:EL7faq8iqAnQO8KeTNbpqWw8R5c2we2gwJd6-PIwzx6eosL6RDQB12KLsY5Qn-tNQ
    tM_xJndaS-uoO41ywpibjAbFpJwkpfTGwQP-JbXkVE7Kc9pR29QOvVs>
X-ME-Received: <xmr:EL7fajJZ1y--VW_D3HTIvIxdo_SHIzp5UWP7G13AAM-YNkVZoMsJjwA21U6J4oK1iOiRtsIaZTtOUC3uyE3OGFIlXp6kbAd2u03k>
X-ME-Proxy-Cause: dmFkZTELHtKepXUdSuxLp/8FwjgnIFHYL1NaL9q/BiTPymhXH+un8F6MX/2GFzxFcGu2Wl
    cWpxARmsj5lBItdQcDbVK2H/EmJbrQ8VDd+NL1LLFcMwN5kmGjzCvdS8ycPSmfmGaT1Uxb
    gubN9ABxNGNo3ZWiS0qqiKyDV5XA1VaBfiE7l+mFFXaxE9obmGO/xQYd3o0lL0QfK2dAz+
    cOoCdlL4Esb64zdXR0kywqjcRX3zeySuLiC25hsD/HVehCYwMQd8OXzylt5PREJhKWPUAr
    aLxl/sMKCrUUl1aIa/qs6sNtRzN2jo7XJtQ1eL3MlwJQS0ajAJq4JPR/hJpCsqTXnMPOCE
    ZVJXL3nlCBv4Td0+UrdxEQKYa7KiCX2QgDn4qhDIQHddBX/C3WN1xy0ndsnXoMJy8k6/IK
    sMtoqrefmi6RjbV8BR7NqnpRB349XxKZyfV0guhm5hFPTOmWFiyyRJrOUXVNkt/rOZiyUt
    Ibqe0DeSrOEPP1tnmdkzv1sHUeK8QinWxhmt6cx0tTmyfPtPl0Zs/0AZIsl9vf5RLS8S5h
    En173LSMKKkQqkJRTfNvkAohqwRyhGj5jOWmHRAMGYGUQ5uYB5ld3sU43ec5Xk7djuKHI0
    DyRPcEAP5rf7RvoI278gwnOm6mOXc8Hz87FspkoqnzQel21FND3xaPVuZDMg
X-ME-Proxy: <xmx:EL7fagdW2VK-dyHsUhc4xwH6qyEcg3oYjj4QHJ_u5L4dWp9CroTOZg>
    <xmx:EL7fai-6vVCnkLwInd1kOTkGz5LD2Q60T5I34sYcduAqS0uQDct7VA>
    <xmx:EL7fatqeksrJjgS1voBMYfZ76PXP1BHlz3RJWadYDnbiggvqlViqKA>
    <xmx:EL7fanD1JYZbJ3-Z9OqNxVnsOp1TzjK_WUlzOGyEdCoocD-9-CuoSw>
    <xmx:Eb7faicrDc-oPxtis8K_xA-wNsiNSz1fRqPCauaMiZ1oq0Kj0IiFjP9c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 16:54:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Richard Kerry" <richard.kerry@atos.ai>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "Julia Evans" <gitgitgadget@gmail.com>,  "Johannes
 Schindelin" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <fde274d2-8549-4fa6-b61e-518f84926ff8@app.fastmail.com> (Julia
	Evans's message of "Mon, 26 Oct 2026 16:22:16 -0400")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	<xmqqzew8wb3g.fsf@gitster.g>
	<60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
	<AS4PR02MB8336459DD1A4537A43A5C724EB612@AS4PR02MB8336.eurprd02.prod.outlook.com>
	<a8dc2d4e-bbe3-4190-b889-d9f1355e8d2d@app.fastmail.com>
	<xmqq33tsqkr7.fsf@gitster.g>
	<fde274d2-8549-4fa6-b61e-518f84926ff8@app.fastmail.com>
Date: Mon, 26 Oct 2026 13:54:39 -0700
Message-ID: <xmqqld7kp4hc.fsf@gitster.g>
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

>> OK, so shall I mark the topic on hold until you decide if I should
>> expect a reroll or we'll address the above in follow-up changes in
>> other topics in future?
>
> I'll aim to send a new version this week.

Thanks.  Marked as "Expecting a reroll."

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045028;
	b=kDJetmPRfTyNunDsCLavmEaJ6ZnVC4dc4t1zmHYUGC8tRwZxlx3QXs/4WWI0Z1ZqF5hi
	 nG7U8MWMeWEwyLTTxaa3KzihDBp+tqSzpg/qRHtbFdCWj8+5fGd5RBOvNEVSaJ8RQ7CO5
	 KfjAUf9/JDsoAbw87GYGxMqcZ/NhjrfAnUGyBjLPqpobYkp9DHi4jSJ5H9V0/D6TSBEy6
	 pIq2rE6iARMFoyT/aFF6A0l/GcQl9MaDmy1eU/xKbNRHVpQDFAR8hCUYnp4qlUrA8wKME
	 5aZFPbZQrCqTK64ne7u0kQRw7g3qIxt95Ht6U/8/NwnHDiV60ExYaq3FV52kL0s23ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045028;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=81Cqu2XizdMWVYtI0NsWv+htr0X97m2x8K729icx8oU=;
	b=Kf0cEZ0tx+3SNzbRmOWVxL2Fgj+fSLMvCZZqoqslHvQ+aW1cL1n8XA6nbef1IkXaAT1p
	 gsV6pPtPfeTVLOXN/hyK/+aWPotw2yo4oYEC1TeM+6KPK477+HeODW8/X9ssiepuxCDQs
	 p4uecvS8Nzn3zSwiMwrbDQ8syKSg5B215l48BVpWEqabOxxDfjOHUchkhO+K32lD71T+l
	 OL28RPCHEK8ZGF7+Sc7d/vJTHTBy2unuOZjZOTynuyc2zSzNowcFlYPxJVdU8H054C79k
	 SuGvgr9+tz4zQjp8sOF5UR4TX+UHD+GTIkbmMLDfyuRECdVMl4K/89V42UvMZVN4fLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=O37Cjyum;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="A9pPHim/";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1C606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11D1C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=O37Cjyum;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=A9pPHim/
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 75B5A1D003B4
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:03:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 16:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793045026;
	 x=1793131426; bh=81Cqu2XizdMWVYtI0NsWv+htr0X97m2x8K729icx8oU=; b=
	O37CjyumxdsGXBfUi+4lYWkMxGPYHEx3e+ZDRKM5wnnAlfQRHxBDwaLHSG7Oo574
	lqrMx9eJhDnkOReHY2k5sFkKkUUHdqOoa7YZnmU/ZUjUrNO3+ZB27lxBxMvlHhln
	e5Nh+MMZYA2f3sxDYp6wNUG8LCnkPgHrSG28kGyAj+V/3NOVsm8TyCCnQwaHW6aw
	gcD4apugLy9SiDrj+YkdwNH3qtL9T+tH8vgIGxKpfTn9tV7BD95+dUi2St898mIl
	+u39oTQ9S5InEfSoxyn5tis/0X0FOtdRO5k9QOx/X4TJGLwd1NO+PLM1MDxxhBqB
	SxJH+mWmtkvYX4GW3qouMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793045026; x=
	1793131426; bh=81Cqu2XizdMWVYtI0NsWv+htr0X97m2x8K729icx8oU=; b=A
	9pPHim/3F0EIKxgQfbVlEf4G5CMd48a+Mz7PVUqKyHoCpDLJSxM9ORf/DyAwtigo
	J5QB2iqwVNP1YOdN3LpbKNCCFNJ9ZlpfwdhiBb+GKqmwAkA/4kk4RVPUyC+fNCGT
	T7viogt2Ahr5mOdhdaUWWAksauG9GlhfLYn67h+35oB/8+ihSfatSXg4DGDIcCa/
	vjes1h6UuU+ued7/j5Qn1XlBTjDtCOWpbVi6eLMyxqRKEjQIuAHXBvCU9t12tDpr
	Qqcsa10QCao++/lOuFzlyB1SDI0EY7mMGz1miMId6pK8vpSLLPqnhJ9S/aXhKKax
	nKH9GsJ0RLeIariZFDbcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793045026; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Vc9sjroYirUNNpfQ92LY+oRpmtxAuJP+tcSxl+yUul9T1bh
	WQGdSXx0z9majahJogMnUjeM/KCNlS+VHZNAp4yKxBOoMyQZRKo7UJc0sE37ZIwP
	hBarx1N7HoUV870F6bCVkQmiZkrM30PlceB0wLDbWxeYy+bgXWhuke238RKsptqb
	3dwaZHAWv+AvoQY9DgZpp0DamDceW0TPllSKTZtbZHNRpa+3bSlTpwgfnHZrMM2Y
	HnNFb5qh0QrtiikiOT/grxSiBuQ+pF7bRx62njdiCSfh5xGNgnyq23X5a9PwWhhu
	OiJY3MTLpWyHHCbkFsScYHiQioKnJ/0paU0Tepg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CITi5heb8Yyuk/1x5GiQAsUZ/J2jc9uO5o1M6yCBMJI=:KW02VmkyQ2qzoQ2hOZgO0K8kR/HHMCo/d51dS+Rlgp8=;
X-ME-Sender: <xms:IrLfalXQS8HzEamm2kRutdU_DFowqrr3miuDzclGdANNVdHvhG4t4w>
    <xme:IrLfagbmXgqikMknOXNgYQbGQe8vLodpC-u81fPxhnLJE_Q6TOGugx9LPPO5rAEFu
    UqFg3nWbBBoo6q2bV7LAt_oktdI_0npPQgdBpzn0Wkoy2aGy0xql9Pm>
X-ME-Proxy-Cause: dmFkZTGZIum51Nj3bjlloCk16VkMCqtbYwO4UVzNBZ2QLguy2wOcJY3m9D/oUaEpuRp2K0
    L4V4dxmYmVcn2JGza977clP67eST0lr+bU4lBAGhOZrIIoVbkJl8/pqo5oJLCaY8XxU78E
    2VghQWfpxGw6kwInu042EW4u9xvlUs+9C/gleRcdi2/uT5kxJc84+NImYaV0DJsBceGZBZ
    6S9tYMAfLkF2wFWdvAMp5druC0pQMPibU0TnWKyegmN2eATrWi5w9wGs0gztOQyZDWaYlQ
    E6rIjFrbDDYuxlirl4AKSpGsMvL6PS9XQ/bPe9cZRPkw46fbMOODwMf1Df+9co2NoN5anI
    jkvaVuaUeMBPmLgAH5XyYQEqkeMHLU894sNoP7x7bn+683Y/7FzGBKBXY0CNvFrbzYysEL
    DzCR7TAJf8oYhi9nYOytTpywPDE4rMC/IIP9O95DhiGxX23j0DEJgpKoKf/Lg0RlrrXbpv
    VeMybVnXQAAMbNlGUXe7bkZ+5A/hxQu74FDTJEB3f0zATm8uCO291Hu4/W3T9e3+DEalEI
    qPotW4nh9y1kQjmoqxwEbmk7Q26Kpqxu05sf5Ch0bLms1zscLTq7YBIWldTLxsC8a4k+4L
    mfCa79Xd5h+YacT1zgVOKW2SJblCrwKeeMvLnzxQka+MjTAxE77Pce5kXFoA
X-ME-Proxy: <xmx:IrLfaq7zWKyB8H5AOjwvQ_vob1DhLlmrTw4W2Mi-yqJKfNRloE2vFQ>
    <xmx:IrLfalY_11qA3QCGvmvpYXsJ9PYGu7RZL0N82nq2Fzr8vyODjjK7qw>
    <xmx:IrLfapj46jz-vPjNuCnav-vta9YNRWD8drglcZ951DPrKY2ghnGxKQ>
    <xmx:IrLfam_CgAs0rD-jgWhlADsuX0aFcm_4-Dn5rJPaWBGVcys_Z_dUJQ>
    <xmx:IrLfasHn8mpM0RPfML1KhmKtY6FJtNuTJF4pHP2hTCDeIZNVBjdKod6v>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5DFEA78273B; Mon, 26 Oct 2026 16:03:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ApuIcoGem8Go
Date: Mon, 26 Oct 2026 16:03:25 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Richard Kerry" <richard.kerry@atos.ai>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <8e2a3ad0-2d04-409b-ab1f-17553cf2dce9@app.fastmail.com>
In-Reply-To: <a8dc2d4e-bbe3-4190-b889-d9f1355e8d2d@app.fastmail.com>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
 <xmqqzew8wb3g.fsf@gitster.g> <60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
 <AS4PR02MB8336459DD1A4537A43A5C724EB612@AS4PR02MB8336.eurprd02.prod.outlook.com>
 <a8dc2d4e-bbe3-4190-b889-d9f1355e8d2d@app.fastmail.com>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


>> I'm sure I've read somewhere that ssh is a nightmare to set up on 
>> Windows, so a first-class mention of it may put off Windows users.  It 
>> might perhaps get a note that it's for Linux/Unix/etc users only (or 
>> only-ish).  Anyway, I've been developing on Windows for about 30 years 
>> and using Git for about eight, and never needed ssh for anything.  
>> Https is all that I've used for GitHub and BitBucket, which you might 
>> consider likely to be the most common servers users might see.  And 
>> bearing in mind that GitHub has on-prem versions that may be found in 
>> corporate settings.  I'm not sure how easy it is to set up a local Git 
>> server by other means as I've never really tried.
>
> I think the idea of giving HTTPS instructions is interesting.
> I don't know if it's possible to give vendor-neutral directions for how to set
> up Git with HTTPS, but if it is I'd be happy to give it a try. I'd love any
> pointers or suggestions for how to do this.

I just did some research and I found out that Git for Windows comes with
Git Credential Manager, which pops up a little dialog the first time you run
`git push` asking you to log in to your Git host. It looks like it works on 
most popular Git hosting services, and if anybody is running their
own Git server that only works with SSH auth then they can follow the SSH
directions.

So I think that we can separate the authentication setup into the Windows
section (where we tell people to use GCM) and the Mac/Linux section
(where we tell people to use SSH).

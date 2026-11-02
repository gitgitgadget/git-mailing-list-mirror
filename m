Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622869;
	b=Q/rBd7wYYYLEMXdR8ReNHHZoi0oaG75zPIuyKPZLzsi4NRI0QFKNj6B5zQRcW/GrCb8c
	 3M3H3UzczSLiswsKpMt5YTDGlZ4YuVYilGd5ZOWVXSqIoO7XQx8HWAOOmZKs5mAU4CgaQ
	 HsB1s6bt0RJ+LHryl9EJIFgFgcbMBWosA6lVavPBjgNXC3Q/hNlYpx+kGmEk084pCUNbG
	 tUqfRGhqLg7q2xLmMF72tWfo2Rsw6GSOdhXIqgsQxasacH+DVg13RlfaVO+w143Qv7B1x
	 ftllL1ECcrSPiM52or036+C72VcUu1K22mj4Am7drIk/ztCoL9r7hWrJY4VY1hX4OMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622869;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=g5sePybaLdL8PO68UQXYJwAJHF4o4G4NSK69lzk5SrM=;
	b=dRq+JOlnFB6NRmFR3O4DXZdE3S+UfPvsc3uoBculPekbaLwiGKvipb6whhAesbwaGci3
	 XBKvTGm1MY/Qh4heqH1o+MivkKHXSQbrKx9LPuz9KtQxVk6c1g64hifEC47SpXCEXsEyy
	 Yp2srUiogtFDX/kPFuN6thWEu0EamlKq0NkkQ9C8+N5Wd+fy0tA52YX2+/tUAdw1TiEcz
	 Pv+R4z57k8wJiKozpRifW89NhIHcucPxSy9Qak1ZcFGqpNkWImEo8bxc9UGB4Qef3PXK7
	 lJrVZRE7ZQR0NJ1HUoBCyBb0X3PRMi8dtbm5C4N+TEGqP0+HouzlpTUSF4OUUsq2WcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=ScmLVol6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Q9m29BEh;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C602606A336
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 12:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C602606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=ScmLVol6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Q9m29BEh
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40CEF7A00A5
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 07:34:27 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 02 Nov 2026 07:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793622863;
	 x=1793709263; bh=g5sePybaLdL8PO68UQXYJwAJHF4o4G4NSK69lzk5SrM=; b=
	ScmLVol6FiEh3wEg4+Ta4fcO7Xuv6Xp8Tmcl4KgmhbHUiQW9Ca0baYInafBaRHQd
	LYlo1s0tK62+8lGCZmamz9QgPAXI2aRQqeWZMk28HmCqu240ItT59dOAucdKBrVZ
	4guJuMlJK1pW1Dt9IhWxd9hM5UeooayShA4rGvqSe5vixowKhi+i4wM6uhyNFuwf
	AdpeWqGgtXMelDPG6toVCX2xSkn/iK2EPSuF7R/FbaMVW0UmPsIK4jUcWO21vTB+
	q/RB+u9JeVFdTLf7uxwQHhzMAzzKQGS1Qi7GL9ihQV3pi+usTVerNsJwumiGTHIy
	EX78Wjf8HnOpzX14niN5ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793622863; x=
	1793709263; bh=g5sePybaLdL8PO68UQXYJwAJHF4o4G4NSK69lzk5SrM=; b=Q
	9m29BEhlfedFJcNzTbnjDUPqpDv6OxpMdGOXjfBDsQnBF4VNo9dcj+d3T8AedgBX
	KTkwpgQ5/X5K1p8+d1uw3mt8l6d7vNy3JYi7yR85+OV2wIHzJ8xsGno1PTbEhvHE
	vplypSF08lhmq8K8Y9Y3QMDSewDB9aC3TYTvsJ+5SE4+VinnMyi7plUzMtS7Oef4
	SZrKcsaOX64xFGRu4Nv1A2AslR0Cd+6dQ4+3c9UvFAdQm36VfUez23IFR0kQwWy4
	Xbi48jwyrJ8/3cmyDKcMMdV0HCJri6mpiCZQVtLD37Sgo99SKsoCqNHXetVIZTD5
	0lirX5ZwwgA75MEDhrZkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793622863; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KBet930rx9eatGEKyn4fEB6k+Ij08x3+sbZG7bmFbYyg8cV
	pcwLKVvUIlinU2hDth4fRNpe5X6oOrlSQN9tye0ZVlLW5Y/tC204T8paOnQqUYQt
	xPjh0iM8pqBajE6e6NaZCHg1SwXtyg3JFzJ1N28rPaNUgLEuAWCv1Pan6CNUhpYq
	mlP1XXVabJNlQqUTkzQf9IO3Zp7lvqMrpEEGQt0Vu4lNPe5eKrMK5ANLTgYKgE8r
	GFL9NToni94cLGGhoCaGxeGm3M2P4fi9znwcXzmcf9e1GvO/0dIoHwtHqCCLsHV7
	uczsUf+l8A1HHgM6EIPyKDfvx6+hguKnrRK6hYA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LjYYiJZ++6xAY1IlAYETGyN5r/lAfFqyXlLep1FZkDU=:g5sePybaLdL8PO68UQXYJwAJHF4o4G4NSK69lzk5SrM=;
X-ME-Sender: <xms:ToPoahkrJ7sH73pABmwJv1kYaqyj18wfvCxok8n8swvhePBx6HA-kwU>
    <xme:ToPoanqjACX-ORxMxgxUSDTR2CX506P_dUEl7TKXEjYbWqiNJSAaaK6ya8lC5wBxV
    r-QhBLSaltqOVVgSZOokfDjT8MODuaStGjAZd1wBXw1IRxpG6yO7g>
X-ME-Proxy-Cause: dmFkZTGskTAAy3n9Os4OZq54EQfSdv7TPcdWbOhuyD0FTu6/gJzx2S2EuXluwEDCLEOO76
    Gz1hXfu1AhVY4QNqBnDyymANnDgEx2K2NHVEpyBQTecnl+yZzv+HLZkhLd4nmwXvdC7g1U
    FFcEGWQOWvChEGowJYFQ4Q6NfDVzIt5G0F9FKr8KjKw5lxSRCUY2UtXxL9p6kGfjJ2XpKw
    cAy9P/lowFMQ7OjQrA2QhMJsVvgrw4gEpZovqG7lk9N6wwCAeRcasypsR/m9HsDPc/0UY/
    HxzW3YqvXprbviqui4nAhYZJ/J9EC3CL2wc7YiQPEw4K7ONm8FhH97fgXZCFbxGScTcsIX
    Oy9iflaaqEsyinVLoFkfzhVY6+n4Pc+uDiGAXLxODUsskwui/5dsKX6Le2ly/cQv3CSXrg
    6lB8O8+xMiDTFxqNApqnYScWpDidXEmdYErn0rV+TyPsYr2L9CQBIa6zoqG51bBZRKzCJl
    R1qwbktFKBuyA4scf+zwXq9A3nDCMjuGCDXwqnOz3PzhuiU/RWpCTzoo9NFvVNXQYtXo2L
    Uruzs/JmNTUuUc2T2LJQFL8BtGLgQM8AEmp6bqN8gqCnFfsFcadWfPZCXvlHMDFRwJcqOq
    faUzP/8ts299LGXQyf6iVOgDxJHunX0koz+gB5zqekfL8Htn9n8K5bHs2V2g
X-ME-Proxy: <xmx:T4PoahLYkWAsdi5aVGUkyDSvjZ3e2Rnym-BYAFuhJbTEsAUSNHr1gA>
    <xmx:T4PoaupVcngErZ6I6RfonJPAtXLCbVziFqUVTgvuBRQaa3olIM3O8w>
    <xmx:T4PoapyNrFYCtCYp52z3IDkNoLqRG7MvSElUajX4hJUdSbdzuZOWtw>
    <xmx:T4PoaiPNfsb6fjCtx2EVDvKnKClYWY99rKLVBtXuLlAJL5uadV6VFA>
    <xmx:T4PoahdEWrT9AsEeqOaZrMkYpwTuY1AY1W8PYwgpzc2DTgBVbUbPuTz5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 568DA22C009C; Mon,  2 Nov 2026 07:34:22 -0500 (EST)
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
X-ThreadId: AoPVM9u0Bqt7
Date: Mon, 02 Nov 2026 13:34:02 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, GGG <gitgitgadget@gmail.com>
Message-Id: <e1ed2066-5cb5-460c-9c1c-0177d338f7fc@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g>
 <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
 <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026, at 12:07, Harald Nordgren wrote:
>> > Is it possible that maybe the review process needs to change if too
>> > many things are getting stuck?
>>
>> >[snip]
>> > Rather than discarding acceptable work.
>>
>> My work which has been stuck is also acceptable to me. ;) But my
>> opinions are beside the point wrt. an independent review.
>
> Maybe we can trade reviews if you send me the link or links here? :)

Nothing I have right now is important.

Maybe I could look at the design of some of your proposals. I=E2=80=99m =
not much
of a C programmer.

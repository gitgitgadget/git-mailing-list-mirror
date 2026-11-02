Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617337;
	b=lpdl4g5whW6VT9IXwoof+shvExcwOt/TO4ezht7xba8Z05RlJg1R/iTjAyV8bNj6XC5p
	 ZOZbOzkITQMqPiKP7FCh2c+ZFdekipQHAfDQsnJKzhKouaLUD2gfej0Kph6WHdj21xkdU
	 ddqTOahziP/ZlKYaUo5GTtBgRRDtT98nrEgm+z1yLLUaSh9qEzuzQ9R6UxbsjFPBw+Ect
	 SQ62NdgA5+DLuEMXjWW/5juc8ueAHdxmwu0i/XFgKQ7xPpKbDwDQ9V+uUyHuDNLChUS3T
	 DEoeRm7xBgCvpc8SG8iQ90Oxtba/oTbRfmKqAYpzaxJRy6SeWEmH3Vn271Ev3+FNiOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617337;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=TpOtxPyre08AJP82jHIG1whDU7xsWcDuBmDXKIAAhDo=;
	b=gVqDbIk2RGg0xCIwFyXwmbJbyVdy7CiWH2dmbFhsIbVgkPbugOezfJWCYrYzMnStKoe2
	 PXfJHZWRRpoJXgohmezKzlshYA25+Aa/2TJM/svx/gVHInhYTtpycpborCCmUDjFxjOa6
	 pymcKgYaQ2AFyBFojnDPxFbd00tXLpzUoL9ihbEs9yb0M0iMjZzlHCVgFHx0V2xIyeIS7
	 SCMQjnhlKH68LCTvFggpxFVryPTAT5k4zR85vCx5rmzK1UQBUFOgHSHeK6k4Fl9M5oNO+
	 +ua2/RRHF1QlZbo8nS/LmoPZP+FVRo5n+ShdKPel/yMBxs3AsEuVK635b1IYYshEDNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=LkjQKMAH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YbGXpM+W;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8560A2605
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB8560A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=LkjQKMAH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YbGXpM+W
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 29159EC0176
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:02:16 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 02 Nov 2026 06:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793617333;
	 x=1793703733; bh=TpOtxPyre08AJP82jHIG1whDU7xsWcDuBmDXKIAAhDo=; b=
	LkjQKMAHu8Xoo0XKmK/W+d1LboY8IV5+j20YIgmj4RrXGIPJFsZUMWpz8REClCU0
	5khdo6t8/yTd/+87qYAaWy8tZIL55SoXjboludAIv0Di1/kMsBqofPAMXf3pZaQ4
	KcLnpstxtdHbqxLRdzvG0FJRIUuSCwCadFNdH5yyGZE4K9nCfeLMXptG7vCPrxVH
	5rd5joRgHXnx/oj8GoPv4d5J7B1cyItNzkfpgdLfnElS2LfPP4FKLzu+DksoT18B
	e4OvMq/mgVs44Mvu1I7IpHrY3H/ODkeTGslXklulkftrvy3mj0nRleOo8fcgGyLg
	1OaOz5DLRAvokqTfAP05TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793617333; x=
	1793703733; bh=TpOtxPyre08AJP82jHIG1whDU7xsWcDuBmDXKIAAhDo=; b=Y
	bGXpM+WB9ZJvNA6MRJdoL4lkWgW2q7DuOjK4du1vRbqJrl4BLqIkMA//1gdMlQ1B
	TOUOLnpoTc8B/lkzkrZHjLc5LB4KXNgkMObMYJTeAvbdqEKrUPN+NTdCL8oMCSgX
	tcE55PbfjSC3xVZ1o/p3DboOXOcWpfX3noI6IaOxVkY3Chw8i1VB/+cqLyWudKrv
	910PzeI4cnG5hMjuHh+ggrcnqq988UAAtJRVY/C5/y+PBJH6qfCpPcgoQkVfMZ2K
	eYjTActhuVUeLMIWOOxgP5mNd+i2J3AmXlGT9/XhUDA1WarekP1ruEfIpyhQdcpY
	I5DFJHToocOL9Vta6jLQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793617333; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:alcrlYoT63F8vPPaO8p1/0ekWqmsQVLF6KzltH/R1lO5HGs
	DyquZvk8mlhTlZsbc21ftAfl8r5viplJmq1WMwGIW1a//egrAFJkXWGEOyI0eMzB
	NvrPsMEfbrrMlopKth0/qC02phccJkfqS30Lo/FijABcWYQNjyWemqqjRO/pNB5b
	M0o87xC4gTlG8aHYKKLDQnG10tCUXLRV8ELT++6lLgx3D+wq7aama1rNx1czboKP
	aVLzvTGH45BzjS7mZR05ScGgLKg0/fN3p3iYlkqvRXi4Ffi2P3+9XoozpB+a6ci5
	XjYbMJb4tFjG2UzI+qrDXiXybQ0UF1aRiMbfQNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Kwjs0qmGTuJrTDzTDLioJzm0h7HPJTWhn2SaM+mWLTY=:TpOtxPyre08AJP82jHIG1whDU7xsWcDuBmDXKIAAhDo=;
X-ME-Sender: <xms:tG3oav-jI9nE7946SM7SJmn-9AAyiZT4-dycikEk8lomam0ZabhIswQ>
    <xme:tG3oamjBJqaHYDfOBlhZJgfl-IXagt3xKKLwSfAxe4da1i64a_4Xsjs4MCftCLfNt
    8ZmUSsCcti6-ILKNF1zFxuKyBgs3Rz1kQg8PAMdCZN5z5tv7x1Ddw>
X-ME-Proxy-Cause: dmFkZTGSZg1Pf+gB7imeiAqg6f8DfWksXbx63pVzzPs5QBKbID54k9yLxqDTxO11/ArGQK
    tZU5/I4CG8D+CGiq4tQpumniL/OfnYRdS7sYsloOI3wRHkkAYTW1fG14WPMpGhyKwnd4tD
    KJh1y+eWRPeYXNoLVmu2ans2R7hI17NWR9fK5s3tOe5kK21700T013+Nyu0ApuCYDsPp/d
    YrDTlzfAcnqN6dPWjCmo+vAG5c4Md8PYt/0ZG44KtrcLX1FPOgw8kxF00CrzGsLeqHUXm7
    eXVsU8vWXJQFYxZh8LnkBm4/d31ahpnAKY/mnBsrTASwbTrnQy8mPFjBgIzn6BefgNKrmj
    GJKW8j672DJkQmOAD6WUIBgwo8gNfUIuqdESFLz+s0v73LFuGxh+IGkdtCbGctNePDBoQR
    uTMYnr8TYbMPVZsxbXfiBQpYg2qhEGtMssxMxwIIBfkmHbmk0gypSGyvlTfStSg1TO2t9Z
    qplBnYx2Mq8sava6qBH5JDBY6fNeAmjaLC97+lNRf1C4ngK95k59g2X+ljBSlq5sEZXpQJ
    snStxoPIfkJk7U5uW6cWqbIaA/hknyZaLOD+uuETCtcvdJ03zziS9QR6IeFOgqGDmJgNc3
    MWkIlIaw2g4LKzSY6h6Q0yWZsqBXiiLKNWxVGorSNuGI+DW8T9ZMwY7dRetQ
X-ME-Proxy: <xmx:tW3oamhNbjQp6V_xIsOoQos-iNePDZYnw1aW7oC7KFopy7Cz07UoIQ>
    <xmx:tW3oaoiPA37vnEHusSlfnjG5Iqo1flbkfJQwGHiXyDwIN8-_vUmi1Q>
    <xmx:tW3oauIJ7lAsHgLLym3ASIIOrAPGh3ToVT-6Ej1ay1UykYCR7ddoBA>
    <xmx:tW3oavGaj26UUy6dFblC6dtjcaivdRxWP4grkbpQAdEE95TwQnQU0w>
    <xmx:tW3oau2ASJXUsldRk3QrBnA1BOC_JGLKp3QP7mZ5cyh9Yv4TdJUTwEuh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0D89822C00A0; Mon,  2 Nov 2026 06:02:12 -0500 (EST)
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
Date: Mon, 02 Nov 2026 12:01:51 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 GGG <gitgitgadget@gmail.com>
Message-Id: <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g>
 <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026, at 11:06, Harald Nordgren wrote:
> On Mon, Nov 2, 2026 at 10:21=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
>>
>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Harald Nordgren <haraldnordgren@gmail.com>
>> >
>> > Asking for a commit's ancestor with <rev>~N in a shallow clone that
>> > does not have N commits of history locally fails with a bare "is not
>> > a commit" error, with no indication that the repository being shall=
ow
>> > is the reason, or what to do about it.
>> >[snip]
>>
>> We unfortunately haven't seen many folks interested in this change.
>> Is anybody interested in reviewing the patch to give it a push?
>>
>> Unless we see some volunteers to give it a review in a few weeks, I
>> will discard the topic out of my tree, as 'seen' has been crowded
>> with topics that have been collecting dust without getting many
>> reviews.
>
> Is it possible that maybe the review process needs to change if too
> many things are getting stuck?

The regular reviewers have been talking about review work being scarce
compared to contributions (contributor work) for at least several years
now. How can this be changed if there simply aren=E2=80=99t enough peopl=
e to
review everything? And why does it *need* to be changed? The only
contributions that I know of that git(1) *needs* is full support for
the hash transition before Git 3.0.

> Rather than discarding acceptable work.

My work which has been stuck is also acceptable to me. ;) But my
opinions are beside the point wrt. an independent review.

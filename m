Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646335;
	b=1D28CuYCF2mZ2sCgpX8nCBYkXGcSq63RRdm1+IqQUPQdXY08pwVPkJ2OrzETKDdWnZza
	 /G2WJxBk3ZOlwoe5SNmcShOI50Fygq9OVGGLuFBDCK/kOxZNSPMlKBlJOYZYTcOhQ6jY2
	 wl1yp7MQH4uX7FQYBfvsu7psXs/6u4omLumSVI06tI+UEhY0g4sruS1SPsS1YYhxnEdd8
	 c61q6KD4JkmEK7cNLbshQ2OAUWC54Z8oBmx9sPYSGIBDiew3+QzslZaAIcMCU51Gl0gT5
	 HM5ZxwKtOHtIMjN5KTFq4hWO7svM6SOpXxXJjy7d4Gyno390K0b+4r4ssUSkj9Ozvcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646335;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Sr6rLRhMeKiXCGT825yyX0J8Q9OvwNFijvMbBgOeIjo=;
	b=SIkSnp+F2OImYtBWZK5w5m0xnRI6lRgdHD8l9zKKZXkiNZYSn61r64QGzPRrXor96E16
	 P0IBftebiCatdQL8SzPZaactDnLWrD6rayVbDCpQTurCpvoDoplyaEldC+txi6LNS0SHG
	 6k62Mf7yTgtRgvi4D7gyed4yNIR3qAHJ3MLHDuSSnJ/fef3ApLDSD2QmShXLo2lxLZtTH
	 W7TExRqQJNxSuSfKUf3M+Bs2JWo16QPOub7YAD7wUWDT86my4hVlGdQc2WAYqy4Fx8hXn
	 TAIZ+mXErI5i1kGWpMsXqd3I4B4rMmM96TI6XpML+mDYFZR4bdtDdtCbvp6fmrgC0ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=udJfH0rA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ilQKSVGb;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D3606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D6D3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=udJfH0rA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ilQKSVGb
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B0421400192
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 01:18:53 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 22 Oct 2026 01:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792646331;
	 x=1792732731; bh=Sr6rLRhMeKiXCGT825yyX0J8Q9OvwNFijvMbBgOeIjo=; b=
	udJfH0rAr69SAF0knnEQUr6RYeNdbLH9PPnaL/hAMYtDhz0y1PsjSIoONYPFSshv
	pZHTymb66C7DGuGyYELstFbyxSJ0uzbwPob15IS302I1qWJuwINkN4hCkpcXy4te
	bcDIxSf/Uo2l83HfC3GxMVsRI2KG7rJ7+/IWBcWzAZQN9U0WNguauN+RdozQtbTY
	cuwnZc4Vw9HG9zlFBqRlu9V16ouhXeE4KSExmELDoNxpgHO3VoK4zZG6Xm9vKFvd
	FQlXyVojXi7xD0YWcrX2mLZsZa0f0d0Lg9oGc6ktK7UJiZrUfiVYY+4NymW4/o9s
	Nvcuw4wUcjwgBsl3Rhht9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792646331; x=
	1792732731; bh=Sr6rLRhMeKiXCGT825yyX0J8Q9OvwNFijvMbBgOeIjo=; b=i
	lQKSVGb14E0dOmpRWbHP8PBPY+sc5TP7LYGPOcmfQ0EAg1EeIFN+bOXhGtENBpGY
	BCf87g8qSSYz0NSISeVX3K3Bt5jjsRSYZBZ+zIoa7DPL2FwpAJbCJF+AEin+hpZn
	F7RgKAisQDGNrsAofF9YisdeCm78DOf3Nl6izafYBdpYA/eGPFjLq2aFCeZ1DSkh
	FdhKzchMSpkPfqRnZ+HJ466eSyb1LjB7/16ac94iGoviV70Y+BSNB+Nty57m79Xn
	2/AyTB6EVrx2cIhHgauTCocvlkGYghVjQZnvkyhJhZ4sngqYeDmsqTgcKTmCRB5V
	vbc843xpUoBv0lnYnCUSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792646331; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hiW/yxGthwF+oDGXjP9aJTDzz1gVfbMftgFNvcA6QK4LTxZ
	tFKs46/1RveFCwFlJppxxytp7MIb3dg+lLxKFKfeYhDMliG6IEafdRMbgdDGXPGI
	mkRccz+kOpMKxTYDcv7rssrNNfFA6eeS3uOBfaTroLd5XAx3yjsCAPtwLyFmBlb5
	HUGA2zvFJoNGvI40tVr2I/TjkRFIKL51sjtN4hbIbsY0Q9IOWpnrGJkdqwwR2te8
	uPUGF1UDKwcNUQypz2ykXFKzEP1mgbazXCdZGGWyxpeflWXwfGSsdff1YChb6+vI
	2r6HQL1T0BGe2JObPtrpv07jAD3/RWLY65UbAZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XpwtG+JaTUvQWb5pk0wkO2LTUHkI4keF0qs1K32S6+U=:/pC8ztzAGN+9VraZIgBkB+i7vgWKLbhC2VHAy94FMko=;
X-ME-Sender: <xms:t5zZagUlWfcF6jRVs3FsL1KTxxktE2oj3KAGFAWGC7B98LbP4h1jDhQ>
    <xme:t5zZavYUYrohvGejIC2KiB0W8rdwxZeoeEwNSZOxBlaa9KV0wJK8sF0OBXBHm01Pq
    h_A3aF6gdrK695TDenDEvi67PN3TmveoGZ8xDFFW21MbICaUrliGg>
X-ME-Proxy-Cause: dmFkZTGyV3cRXoXMYOzHrwLfwI7P71ZsNmwYEclF1yAyA5KFgSz/JUhAi8gHPW0W7h9bdE
    q7K+ppXJOaHpR1Cqj3gBAnzpWxBYrnIHw98u/uglCDnzixxYyuu1CyMaJqhvcQACfNIs6r
    4xLknmdbAYjLCrzmKO9NdeZOtOOUbeYqG5h2hUSLaeRKebYGkHYqMF35Dl5UftAk05Bx6/
    /4k2f6AunqLNn4IsVOFL2SFUd5HlObyYIZ3jgJkkK3tcBhbjbrguptDgQ0yABHa0Vaw1fz
    KFhE9sEx/WwgVwKmERnu+S5l7DHu/8oN3OhFarJG2VAXijf3zZYmt+4nsbF/ThXu2kDaUD
    g9FqOD1HOqPNjutfm6utXEf7owCzNoWCxO8mDPRZ6oxp3QoYKULE2/KMd87mgkdyJRmnRh
    zEfLpu5J1/a/q+STJJx+VLKo8znIEHTvGspAgBy3tHXTmAhrEJB3lrR7w1sao+HvJ2XxyG
    VpoQbBektk4vdffdiBp8utKrDELvMjqpQidvSz4AwtNyA+gMr+MG8ZWOM5VEKGAKFy2/+i
    sATzLtxHYARZLinmkO/pLfh1vuBgRgJFv5IlZ+PBBh06E+VkGqe1f/7zLzvxKxp8R3nMPz
    q4ynQyor8RTwt4wdYTV4/5Ts+35v2MddRDwSJ5lHBibSKud+Gd0J3tft/swQ
X-ME-Proxy: <xmx:uZzZat9imUYZFDHNXuL4UCQiS9_42xLCOhbY4GR0Xx9q-eE1LFtA8A>
    <xmx:uZzZaviA1z5BYG6qPlN8ln2zZDbEKSpJM3kaQqUD-faC4Hq_CMDTNg>
    <xmx:uZzZalfvgQGPin4AatOndP5ZjIUUgceENqMVMbT_JtiJOxgpvO_H4A>
    <xmx:uZzZaupfJcbVizmyCAUkjBufHxVleFNudCVrzpRBjLHTO96EmZcLyg>
    <xmx:u5zZamyK5_Uq8ghMT37SdBcaqHR0nirOAeqLsgF__syXiYHUr9m4xsje>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E42EA22C009C; Thu, 22 Oct 2026 01:18:47 -0400 (EDT)
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
X-ThreadId: AB9N__B7nd93
Date: Thu, 22 Oct 2026 07:18:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <a219a76c-faf5-4c50-9560-bf48f65167e4@app.fastmail.com>
In-Reply-To: <xmqqy0bqlqez.fsf@gitster.g>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
 <612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
 <CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
 <xmqq5wyvq9p8.fsf@gitster.g>
 <ab05a3c1-9da7-498a-a9bc-d586414ad0ec@app.fastmail.com>
 <xmqqy0bqlqez.fsf@gitster.g>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026, at 23:00, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Wed, Oct 21, 2026, at 18:50, Junio C Hamano wrote:
>>> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>>>> [snip]
>>>
>>> I do not know about "manual pages", but making this available from
>>> "git help" would be good.  It raises a huge question about what to
>>> do when Git 3.0 comes, though.  Are we going to change every section
>>> and rewrite them to say "we used to do this differently before 3.0"?
>>
>> See me and Patrick=E2=80=99s subthread: <ar0OicAaDipYx-xU@pks.im>
>>
>> You could transform it into a section at the end for =E2=80=9Cwhat ha=
ppened in 3.0=E2=80=9D then introduce it with
>>
>>     These things changed in 3.0. They are written in the future tense
>>     [?] is reading about what will happen coming from version 2.98 to
>>     3.0.
>>
>> Then you wouldn=E2=80=99t need to change any of the rest of the text.
>
> The rewriting effort is not a major concern.  Rather, the question
> is whether keeping such a historical document is worth it.  Do you
> still care about what the major issues were when we transitioned
> from Git 1.x to 2.0, for example?

I=E2=80=99ve mostly just outlined how either approach can be handled. Pe=
rsonally
I=E2=80=99m fine either way.

As far as being a living document is concerned, discussions of old
versions could be promptly deleted. People who are on older versions
will have the relevant discussion in their installation. Beyond that
people can use the power of version control spelunking.

As an alternative you could keep just the previous breaking change
discussion like mentioned in <ar0cjf3rdrp6NAba@pks.im>. Like, when
you=E2=80=99re approaching Git 5.0 there will just be Git 5.0 and Git 4.0
discussions left in the doc.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623510;
	b=TG981lkBLj/6yhNWTyAU1F6nHwDezx2DXXP9gBjwy8qOhyET57CH6lczzupiWtMfGML9
	 a309PrB8WlspORsBoBOeYp9vauEcDREL4wBILPfaiJfCYU2c5huevGMrPQZwB0yoT+I3/
	 2bJRdK/wcFQHHI5SBCVzIQU490VlgngRzXr7PtVOlKMQOSnFbMLtjrViJeJLgW+CY4Stg
	 wMPeqMayTUHs/mxoade1fu3bgtBSXkQs6Rezd4nSSkU+M2goC8Y6J+LRywk7Zjc2TVNNh
	 Pjna/iREpkmVZc8zSmaMCjNK6a/kZiWBtOyZchu7fmjgrZSnX2nARJiy/VB73vddDTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623510;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=GgsBYjeVCFZ48AIap3C/HVJDM4SqWRtfc86gQptggY4=;
	b=jUbwhFwl0FV9V08c1BRQTNwbaUskhtPLSSA+6Ao3RiTKf8kQEwa/3TXxiICqmJTBTn5s
	 CD2MC5tw8oHYFHkWKmuuC/KDJL/09fMfk1HGxHF1IEltcKfLTupoXdOqNLcR8JlSF9uvo
	 2C/dKc+w/+kWFbiNBqF4Cjy1CG00CTZnlZdO3lEshCShbzLTZC+azyG++R+Udy8BIDekL
	 v2X6Peg64fJ3pCEIwk+lEeWujcO7KHl8BAjwOB529AWE5cSYpJ9kZ6+s+QL3xoqKHNSpC
	 VmtLMwHaGvoiAmpWIKRyhI5zwDdEd0vfAKlq7Sk8JZ88IuY4k4NmOo5BWO0D4jSu7Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=C8b73SzM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=t2TDoPBP;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E9606A32D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 12:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377E9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=C8b73SzM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=t2TDoPBP
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 526137A01BB
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 07:45:09 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 02 Nov 2026 07:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793623505;
	 x=1793709905; bh=GgsBYjeVCFZ48AIap3C/HVJDM4SqWRtfc86gQptggY4=; b=
	C8b73SzMkaGE1RbutnNK8g8ItQB7bKuskLoyDqYwtNiu3sjz5X3ktwplkfNHhdHd
	ktYGjqP+SJWcn29TTQEandxl0kyFghAJx++iXAr/nM9KYtZ57xum5j//8cAxnWBS
	wPMo9t1LNHutJ4D7JRIr0xvWBpRTirQMJDRODAkYVXrKo9yV/Jfm81NYlii13jud
	fwpoYFUVti9tdLtdIdY0llL2ibmNFmt8oVpXlv5iFa8ACsqHe/g/x8iquffgMNQe
	knM61xuUp94hmf5jlNYUBlCRz+4+fpdaNQdfobg3HZ9KiwXuhyheOaE/PA/sxDC3
	7QDk24YympycnpCkBghivw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793623505; x=
	1793709905; bh=GgsBYjeVCFZ48AIap3C/HVJDM4SqWRtfc86gQptggY4=; b=t
	2TDoPBPb8zFXN5Uv30K6+A/EFhooyEGCqkw4hKpcfsF2SVbUO3DkKDvD0AHZNWQ0
	vTl2vqIz/sjecKLeDiJ+8OkeoJ4lQBV0K7LSxTvlKWwa77KDK0zz0eureSxXYTiR
	GXA6MdYmPBi3+nrLXMLNkzSbfpt+qaVDA0ogFNOYJSjepL+gTS3OxSUHJ07Upaj7
	edyMDwyNCcf7z2yL3myh5G/SgnBePUrWfJEhqCKijTn8YYjUxOZ+oevk9gRQMooa
	yAkZmnzXofoUs0HdLpbC0p7w3teEIC1a0/cNyOc2bPpCGjdBWsroxBm8OYOaLC8F
	zir1Y7HKIZa4sc4fmfWuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793623505; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nmTvJR3d2n7uom8MeoZZBMsp69xLCzmld3CJNTF8yW4k+Nh
	otL83reImBllbce6n1OGCgUNVdjQ0ixr+cN1GioLNitVOKcsmfGALamh4879wvIN
	Sr+IGZrhjGFP5UXaNPvhh3em+rNMtAdywX0jAXBRLKPa8+hpzOuDar2okv8W6t0V
	AYvhHZD0YjZDChdhV21HUYWHJdK0PbVi9ZA+mEKcD8hp08N/m+G0U+YftmpobH8c
	iV9k/McJnxrBFEHzgSIskgqe53Km87C/NoqKuL2p5779YW1nrxpwH5+dos9sdYeM
	0e/aMllBbWR1gCRHQ5hLbGsjyc0zSTUgp7wI4jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BOehT2Qceure500hht6vE/urfoD+wdDgUGeCrB+AXwQ=:GgsBYjeVCFZ48AIap3C/HVJDM4SqWRtfc86gQptggY4=;
X-ME-Sender: <xms:z4Xoanzs63Jl7y7zS0UOs1Ce5u15LbTC9hs2uvJuWzK35SeOWRMbgK0>
    <xme:z4XoaqHsyUovlFqtgkkzsqE9cCmoH-uFbcmQlqrwevoTfkDVwgiL1lCo4h1o9fsQG
    s3txptGVw8D2FrY9gEzyu8Oc4ewtcDmjw24XtFsbBhXRQMvGF4Z9g>
X-ME-Proxy-Cause: dmFkZTEtaIDcxtrZmpYw9pDkEirV9Pjc3y2FdSS5ZLi5r4BwxYV608wOkM7MU8cQj3NWVS
    Bi11dzCG0/mg2B7j91tA66bonAejJgljqMGFMB1KqBGwXIYodF4T2bmcRCm57hhyFB7jjG
    w7xeI5zWORxLHXSedmEUYzBnSkdDC6SGkJdtfwFsRIJfxeXG3UiwQ1JAClPj3FaNgKUYvw
    aV5qMSVo0freKpRN0w2w1AiXZvNAiXnV5hNQ2KAGELHmTLaxrFFyJTMzmhc7xnw3WOD+Kx
    CvdDK54k8ywb7/8g/mq8RIxdD7iYcWf8JZ/mHEXZg/EsX9jSGVA0+oO0dHaa1pMkV0c8HN
    btuPI7MfadaHchOnnOktPnI1EyElZ5Mrg0BdpqIOhzMjG9BZxCKIE8Oc2B6R+YQCSFln4+
    4CPzD53I6f1W8GxJaa13oLb9dbyX9c8gCEtsHY1TCqj//auZa9f6QbfGgGsuqA4q0dpn8D
    n55Az9y0X5ciblX1B513k0r1TdA7j4NvxiJQqqcOsUxjH8S8TAWIB/9H0tlS7WM8cz/yjn
    S4hla2AizgUE26ArU4eZ8Au1z02tvYb1etGedVDuLK1WF/bkliG3ivKeoiIuGD4iIl0Gd1
    PH1qa/lX99t39+3T8PZXJcM9stMfnW/I6MHjH2v1z9UWCpktTsftEJbKMpWQ
X-ME-Proxy: <xmx:0IXoarfS3WvpEC-36Y6PTkjHqwhsOuDpqLppk81p2QuQscrSZ32jFw>
    <xmx:0IXoaqiRZA-obydxjlPA2Zr0o-pGeZkhea12E5dfNDl_s9PX9hzsaw>
    <xmx:0IXoarzDBEZ0iEFFC9PWGELWW4ZCYq7fzhdOG1K5VIPzXsPAX-yHfg>
    <xmx:0IXoauNdYiAc7enl3SuxKlVSI9nhh2xryB93hLM0K9UAa28PWl9Umw>
    <xmx:0YXoavXnh6ABukSbGrcou3Xp3M1AfRhXFThAiN9t6pmvsomesHZFI6E1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 331EB22C009C; Mon,  2 Nov 2026 07:45:03 -0500 (EST)
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
Date: Mon, 02 Nov 2026 13:44:42 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>,
 "Harald Nordgren" <haraldnordgren@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Thomas Bachem" <gitgitgadget@gmail.com>
Message-Id: <c2c820b4-5bf8-45ca-b79b-3a5762eaa713@app.fastmail.com>
In-Reply-To: <auiBFhXI_xiBTPbg@pks.im>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g>
 <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
 <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
 <auiBFhXI_xiBTPbg@pks.im>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026, at 13:24, Patrick Steinhardt wrote:
> On Mon, Nov 02, 2026 at 12:07:29PM +0100, Harald Nordgren wrote:
>> > > Is it possible that maybe the review process needs to change if t=
oo
>> > > many things are getting stuck?
>> >
>> > The regular reviewers have been talking about review work being sca=
rce
>> > compared to contributions (contributor work) for at least several y=
ears
>> > now. How can this be changed if there simply aren=E2=80=99t enough =
people to
>> > review everything?
>>
>> We can loosen the requirements on perfect code, as long as it does
>> what it's supposed to and doesn't have security backdoors.
>>
>> Many things like tests, leaks and linting are already handled
>> automatically by GitHub CI. It's a good time investment to automate
>> more, because it frees up resources long-term.
>
> Even if we automate more of it, that would still not fix our bottlenec=
k.
> I do no trust automated reviews enough to just merge patches without a
> human review, as part of the review is also the conceptual direction
> that we are moving towards. And that can only really be reviewed by
> someone who is familiar with the project overall.

I=E2=80=99m not sure what was meant by automate-more, but if it is rubber
stamping by an AI then I am skeptical as well.

>
> Now automation could of course still help us. For example, if
> contributors started to self-review their patch series before sending
> them out, or if we had a tool like Sashiko [1]. If so, the human review
> would happen on a patch series that is in a better shape already, and
> that would likely require less of a time investment overall.

I have had good experiences with private review by bots.

But again the usual problem with an influx of contributions is that
=E2=80=9Crequiring=E2=80=9D this kind of soft check by a bot is not some=
thing that
reviewers can check for. They can check if someone skipped the
whitespace error check. But they can=E2=80=99t check that someone skippe=
d a
self-review. It=E2=80=99s like requiring =E2=80=9Cusing your own voice=E2=
=80=9D for commit
messages. People can just say that they =E2=80=9Cdrafted=E2=80=9D it wit=
h AI but they
rewrote it =E2=80=9Cin their own voice=E2=80=9D. Uncheckable.

Contributors have gotten a hundred-fold more help to write
code. (And even commit messages for some reason.) Meanwhile, what have
reviewers received?

>
> Granted, at times we err too much on the side of polishing the last ti=
ny
> nits. But quite often that's also us trying to train newcomers to write
> proper commit histories in the first place.
>
> What I would very much like to avoid is reducing our standards just
> because "carving in to AI is inevitable". I've heard that argument way
> too often by now, and I don't think that it's a reasonable stance to
> have. It is very much not "inevitable" that a project must move faster.

*caving

I also don=E2=80=99t see why this project should move faster in terms of=
 features.

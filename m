Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE764A06
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958232; cv=none; b=WofLXMVKc6ZaTJn69Q8atCAw4Gz/p5dWSvICdAxRp8ouTOA8g6IKiRU/m9IgMnt42P9YxQ4ECnqwKBuT5KDHvjt17J2xyVsUmnQtRtNewKMOFtbsE7eg3SDCMM6Unxsaq3uX3JTNNzlq3OydgCrE0gUDCMmf2frCDWZGsWvfGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958232; c=relaxed/simple;
	bh=ZrM5iChNenTTzpB/3jN8Qcmofr+/ufoHvTcNT1ncFLA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B2MQdNyjOKZBuWijhp8BPvwSKGPd9i9oXfZNUlY4xj1uC7bH6w4hGlap3K7FwQhWvJR+50Amp0a/Jyt2kK6/+mK/QJ82XgfuBnDhLDH3rkG4tdlLj5bPS0DwP6wDuJJo38mx6pdUQc9laseV2ImaqaGWqoAw5DFBybeOfIKz/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=NKuufwgH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RmCpXSyZ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="NKuufwgH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmCpXSyZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25A797A0289;
	Wed,  8 Oct 2025 17:17:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 17:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1759958229; x=1760044629; bh=yr/ffEW0YalJKOD39t7GVDaHYCOEg4U1
	rOHkCSPt0w8=; b=NKuufwgHNjAFQ1IgEQjoitZhE2NX9u6jB09L7ucMxWoH2vHQ
	0SpFdL9QwE3zu0Oi8lKgZ46ev7WtRdMcVhUZLgIH8Jvx9wLQG2JfeBprruQ3Ckr9
	pbS+NRSR2GZawtKBf+y7Znw712SkeX1qDtEwwPWFqO68O1NNHIgAEkkMvCgpeuDT
	AYSjJLXKkKs2YMvk2cED8+aKE6wkfRriKRHGHRth5s7uaA2h9hO8pp2gsVMibJom
	nw2vyRnwKyGTyZIMwuFIFF9F/kAihzx1Q5w9ZcnJZDRrL2YsG03/VTyoXvEFzAJh
	vU+2s3xMtpb75830L01uUK2r9rXUPgufEnfFhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759958229; x=
	1760044629; bh=yr/ffEW0YalJKOD39t7GVDaHYCOEg4U1rOHkCSPt0w8=; b=R
	mCpXSyZXgRRpIDmy8F93MFVC/m2gdrTdFdyWD3QEjylt1W01RygqAfpMRXC8f1pc
	FcylFECuRvwmDgdXt8ffTcpUZUYQWr9JaCnhiIkRn2viLNH9b38jnZTCzon0dRzA
	n1nOH10BYN8ceM4m7Mwm+c2m5nJCjR4ozf8xy0y8oUcpp29pnliRRKcHtgtyMwbT
	rWan1XGBmeeHx9YLzQauGQ3lmy9FZuXUOzbFmHAyYrvfupMW6+If3nI1zwzPT1UF
	y6zzdKjaPkiYJ1yK72CbaE2eAOWjyveJSRHhU79dOsNOmHkN+UrsKWZAoNPde+N+
	HjzEqqEw0lNsdkzCCeWCQ==
X-ME-Sender: <xms:1NTmaLUpX7cYHvLJQxL8crK9GW90BmJlte6UE7YByMIC0TN5hEQcRsM>
    <xme:1NTmaOYzaNee6Ub5Ta8qkTiGdd4_QfFr6vikr70CUREAon4uszXxsmKFSwSi_xqIj
    J8FOB236WS9P4eXm-3fFOspRPDUL4ur5ed3m6h3dXHPfAArZiw1dq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghl
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhihsggrkh
    drrgdrvhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhh
    rghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehtohhonhesihhothgtlhdrtgho
    mh
X-ME-Proxy: <xmx:1NTmaK6lvI2ef8O2KaUlIxyQhXb-ggH8O85RKiWlNTBHMD0JcaTeMQ>
    <xmx:1NTmaFccQ6mmgkzREcxTxEMfjugtFT4HmFaqnXsArtibkEswx58ekA>
    <xmx:1NTmaIvRxzW9VMimkpOHiV9yn0nj_9aPuhB9nXa9QFZIvHtaezzoZg>
    <xmx:1NTmaNnreU0osbXPWnavMYW-RA7K6ijQRHimbAxnJ2UfCA-ymAubRA>
    <xmx:1NTmaO_rabKfZBtHr5pXmJM_yuOxdkUFq3xMFYPFGWq7iQD0LRgoSTYE>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 648341EA0068; Wed,  8 Oct 2025 17:17:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzP7wyaVJMbJ
Date: Wed, 08 Oct 2025 23:16:47 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Andrei Rybak" <rybak.a.v@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Justin Tobler" <jltobler@gmail.com>, "Toon Claes" <toon@iotcl.com>,
 "John Cai" <johncai86@gmail.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <84715a9a-f1d2-4baf-a025-46490052a27b@app.fastmail.com>
In-Reply-To: 
 <CABPp-BFHiwTwNmk3DHSQsXocYYbcaQV8TfVs052v9xFE2NYjWA@mail.gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <f0abdc27-6850-4b9d-b4eb-a1c92f731142@app.fastmail.com>
 <61107972-5755-49b9-a126-9442418ddff0@gmail.com>
 <6d19a0c4-f000-43f5-b2e1-f84f341063a9@app.fastmail.com>
 <38742a2f-5c5b-48f8-a9fd-acea47b7ce71@gmail.com>
 <CABPp-BFHiwTwNmk3DHSQsXocYYbcaQV8TfVs052v9xFE2NYjWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] replay: make atomic ref updates the default behavior
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025, at 22:56, Elijah Newren wrote:
> On Wed, Oct 8, 2025 at 1:02=E2=80=AFPM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>>
>> On 04/10/25 00:35, Kristoffer Haugsbakk wrote:
>> > Good evening Siddharth
>> >
> [...]
>> > I have been using git-rebase(1) for a while with a post-rewrite scr=
ipt.
>> > This is used for interactive rebases but also just keeping up with
>> > upstream, i.e. a regular rebase.  Then I was idly thinking that
>> > git-replay(1) would be faster for the plain rebase case=E2=80=94but=
 it doesn=E2=80=99t
>> > support that hook directly.  Okay, but I can get around that: I can
>> > parse the output, yank the commit OIDs, and run git-rev-list(1) on =
both
>> > of them to get the mapping I want.  But it would be really nice to =
just
>> > declare the correct post-rewrite format and be done, without having=
 to
>> > parse anything. :)
>>
>>
>> Ah, that's a concrete use case! You are using post-rewrite hooks with
>> rebase and want git replay to support that workflow without needing to
>> parse output.
>>
>> That makes sense for the client-side evolution of the command. Right =
now
>> the focus is server-side where hooks aren't typically needed, but as =
this
>> moves toward replacing interactive rebase, proper hook support (inclu=
ding
>> post-rewrite) will be essential.
>>
>> I think --format with atoms would work well for that - you could get
>> exactly the format post-rewrite expects without parsing. For now I'll=
 keep
>> the simple update-ref format, but this is good motivation for adding
>> --format support when we tackle the client-side features.
>>
>> Thanks for the concrete example!
>
> Let's be *very* careful before we add any hooks to replay.

The hypothetical case I was talking about was using custom formatting
output to drive git-hook(1). Not adding anything hook-related to
git-replay(1).

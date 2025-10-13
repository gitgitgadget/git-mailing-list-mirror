Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860A156CA
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357886; cv=none; b=WGY3tODD8fSLyb5ONoGTbKUHKEixQXywZhi6FpVJujcmk0HsOO4Uha2fyTn/5Q7NsasKCaqygc+bh9Dy6H/JUIqwO7Xyp4dJ3M96xUq9X63fpT5vSuMzy2uU0O4+MBAz5Lqk4TvRnxSkGjGY/PdtcALFEyQaFc9EBvC/aqp9veo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357886; c=relaxed/simple;
	bh=Jy+hwnECl3Yiot40Gex/O51UJclPA8VAH/l3JOMATxs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rn72GnvvTBbkjdM9b8qlahzX9qQl15jteKoT0T5/gJdJHVVChG2Ao4qdkI/k1cWyzRb6zzzJc8eR/rIpaRzH+HEoUmdSL0UJn26ddPQsOLy9rZ2wCSgGDxwsrBYXK1PPI0Gk0QXv93TPKJL6wNyNoD2S3Fj9t1MHIDCE3yaIGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=lvCWrBo3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6RZ9lUE; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="lvCWrBo3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6RZ9lUE"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B5CB77A00A7;
	Mon, 13 Oct 2025 08:18:01 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 08:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760357881; x=1760444281; bh=UA39IlAxClnlXqJUuxb3SMTEV8JMtwj6
	jxoQWgCGgLU=; b=lvCWrBo3T7mMKd5M9gHySkcUyegwd0tKFfh2nrZIwhsbKkdB
	7/JtNtopTaKZP4nhNmtNwl5Omj2OGoY7kLwG8D+a7vG9di/4sdrXZTyEyNoPTNMy
	dewHgir2WkcuEmxa4ZPzS8dM6jRmpaBN5K1rR6j7BDarwZ/TVglkJWW1b3zVmOmT
	5nm4NtYCxajRzAAJCeyop3g6c4Z9qR2eFdbEQvv1Oo4RRQ5VLc4e8FV24XzfZ1Ma
	mfGcFg3D/fEutcBwFnFf/mJFlPXat8fAvhejDNpdsx5xWzB1Dpm0Kp3QRTKe43mF
	lzBgwjS8IOQ68UjGqQCzURSVm1JZT26v0GB6lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760357881; x=
	1760444281; bh=UA39IlAxClnlXqJUuxb3SMTEV8JMtwj6jxoQWgCGgLU=; b=U
	6RZ9lUEoCu9mDfgKnVA8kmgm2tWgXQLLAvH2YxKzB0uJctzTcXCLp+bV9D6r+BMp
	ii6erxsEqXReKomaVMfDEaeelq6ylweRCY6TorQ+j56eaBnfXowSnBGoMUJP5VAO
	rkJymOVib1zUnGyQQs2QhRVwtszOfbtetbPrH+3xMPrm91ac+hMHbSksiSqyOEUu
	sTZDDTEUCAXGMHfvUoo5YiRI6XjpoEVYQONM/+wLvVQSOPlCR4CMnO0oDLha7mVF
	cEJwKNGmi3fR5ACa1UXN5rRXq8WcmkcaDjzw4w2OyliUYc7C16jSbAvX5xqyjbWL
	o4WRQGoJaLlwCRK0A0Tqg==
X-ME-Sender: <xms:-O3saKrh4RVDak7BDZ7c6oSKr7A_m_B7_5akTM9bjajyA0aE6ozDQFA>
    <xme:-O3saDelMpJ17pqEeF7GWN6EdnNisIU6yYVXYtDedOMC99v0P6wBfaB6bZYRMiAXJ
    lOPzjLQ9kVK1S8oiK9yHyBuKnk0juHYHUlnchKHDS83tKi8bpgWIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheprghvrghrrggs
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusg
    esghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehglhgvnhgtsgiisehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhurdgu
    vghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehmohhtihhsugeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:-O3saHijtrB3pWgHVWmv2tTk_qcMIV5AwxCf-TgcK0lCHSJ6F1wlHA>
    <xmx:-O3saMI7QEJ4TMNOjZ-anQfbt2ugRH_nphU-cOGLH_8r6_LllGxZ3g>
    <xmx:-O3saGnLegf3lb4pr0m9eqKfVARyWLdX5FWozNZYVyKYwJJssOkSCg>
    <xmx:-O3saENwP2eFqs9b7_b_wKTefqJ-7LQbKxQmVMLW1b_-YY7Ic6z5TA>
    <xmx:-e3saO60RxLiXP5tFea2GvaOTgzSS5e0-zDRYSOEyk4yxQPwxlDbP33d>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AFAE11EA0062; Mon, 13 Oct 2025 08:18:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiL_X_pxFJps
Date: Mon, 13 Oct 2025 14:17:40 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Glen Choo" <glencbz@gmail.com>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Denton Liu" <liu.denton@gmail.com>, motisd8@gmail.com,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <d4dc8042-b996-4889-88cb-f0862a12d09c@app.fastmail.com>
In-Reply-To: <B78CD1B1-67C1-4EA1-94A7-13AD40C43585@gmail.com>
References: <xmqqy0ph5ov8.fsf@gitster.g>
 <B78CD1B1-67C1-4EA1-94A7-13AD40C43585@gmail.com>
Subject: Re: [PATCH] doc: explain the impact of stash.index on --autostash options
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025, at 20:04, Ben Knoble wrote:
>>>[snip]
>>
>> Yeah, that is less useful to me (there is a tool, given a commit
>> object, to figure out at which merge it got merged to the mainline);
>> I didn't think of a way the information can be useful to general
>> readers.  If the mainline merge was a release or more ago, then it
>> may make sense to say "commit X, which appeared in version Y, was
>> broken in such and such way, and here is to fix its breakage"
>
> It=E2=80=99s not clear to me if you=E2=80=99d like to see a v2 or not,=
 but given you
> were already happy to merge in the latest what=E2=80=99s cooking, I do=
n=E2=80=99t mind
> not sending one ;)

Sorry.  I misread a What=E2=80=99s Cooking email[1] as asking why a topi=
c hadn=E2=80=99t
been picked up. But you were asking about sending another patch on top
of something which was already in `next`.

I wouldn=E2=80=99t have sent that email if I knew it was already in `nex=
t` (if I
had checked better).

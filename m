Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9D25A354
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747839; cv=none; b=gYzcN1VnoA+95NonxSL3VYjXvXNkvvPC6NWunsZuc6EprK/JWDKXL26ISRv6prJ4gWZhQ1lNqJxcwaQRubRwJU3ozfGnb2bKNa8FLqaYDdEebVemjgEMigrvZTa2inYeAul5VfohL3QKmd2mf9vh6tW5G7Rae9UdiYCy++yIW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747839; c=relaxed/simple;
	bh=zJk4Dp2/Ajo3W3ldBP8HbQiJQ+lJpIwLrGnqxd1nq0s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XEqY/pRzTNbIdZbh/qCUecfT+u+RDafzqrUE1zGyBuFzF6g84qEVp7YOyUGmIk8NIov1Z/HrBRla+ctzGsig8pqiInhHKrAb1c/dwuTgLeYmH3Dh9wCXqpiym6HUrSov1WPpmbZzZwG3h+S7U8+BSOhaCPypd00eOo1GzeIdTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=PbKFuoTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gI4QXpWg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="PbKFuoTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gI4QXpWg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F0911400105;
	Tue, 10 Feb 2026 13:23:56 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 10 Feb 2026 13:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1770747836; x=1770834236; bh=HcHg+j2cFxbmbkBTAnkUJL+KCIF/wNg3
	180O94jZnd0=; b=PbKFuoTL5VFR6iKT6bPwnVRjdIvyKqx0GGTGBRsIsz5xXein
	X7CRa+cjnuccqjoH+q2YDFD2ypXBvHmHh/MgtcWzprtVqWSJE1GF4lA9au02V2ru
	pEygYgJ72GDAinspn6l2On32IfLYt7nVkr7R6CAAC2/94wNq9ttjYlX2KZiBAx97
	DV0TzEwgSzzeb0+Y8PGGDme3g2J0D/KJA/9dwrn9HzMNApyXgvWtCsmgp3kcsvhG
	PKxbdNVqNPucgLyIFT85SpPky7Q633PkjyJxMFPBBvD4ix1FysCsa4UIFWdXaGvU
	ZUqUWP27YdNFQnyd9SecCl1wXSzehmzKGmXkGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770747836; x=
	1770834236; bh=HcHg+j2cFxbmbkBTAnkUJL+KCIF/wNg3180O94jZnd0=; b=g
	I4QXpWgJWWaZrvPzF9Pb7SbiDPRG+xQaANc+YMaisfGcu0i+XzRuvA6Z2QF2gGMw
	bcgNWPjHSScKJ2W79/EgNIQL2dWY8ONKMduVatP+2K1/HsGrA9dAuCWWJL08Gihv
	6quPeDQAsZexZAQWG2Ov8kuFBbsS8I88AkpjjiWO4/IkeQwuZy52PIU7ev5MhCbT
	vtqRqqdhkngLgHt+e+c0WslrCumhq0vDRFoIXl31vnBVv+TRW4XwRQ91SVyw/zyi
	MhNr28Zz+1TJWdSZhxc1sOx8BaDem9Vbe8Rcf7NqCySS+MnXIPumKZG8yCTTvw2x
	BZnRK7ymKeT24f7sWuMtg==
X-ME-Sender: <xms:uneLaXVl3WNzorGUJEV8yX54S-g2x4061fXkOWCck7p4jImyLaaCvn0>
    <xme:uneLaaYk1kdSFBgCx8CANtRcGUNvProICMUmmlrCEPzCGSFNQDsW6saep5EYunEOm
    4UBKswXtX1R2_-U66UBSqPejt9drZGSG-kGJ-qXgTO8wslHg7v29A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhessg
    gvhigvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    seguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhuughgvgdrphgr
    tghkhhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghthhgvuhhsrdhtrghvsg
    esghhmrghilhdrtghomhdprhgtphhtthhopegtrghlvghsthihohesshgtihgvnhhtihgr
    rdhorhhgpdhrtghpthhtohepshhurhehrhesshhurhehrhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uneLaV1Jn00d5cZnZhBM6QA9E6qFq9wKFkNTeD4ABAG9HFBRIWWQsg>
    <xmx:uneLaYHIL1GMckHyAmpqwrQmEFBnSgYBy1arysYgucpkwdxpaezj9w>
    <xmx:uneLaYGVK7dQmoqD0-wRuTg1JLHj91sqthGrYpWFO3bIoE7wfocM7Q>
    <xmx:uneLaT5ugAm8n-GVWO1lprQGRU67eqJh8_kAePmgfjPWuQW5P1AkPQ>
    <xmx:vHeLadFUIxkf1yHAdC3o3AFeDyP-fQkSTuVdyBbW_mn3BPcd2k8lVYZ3>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ACB841EA006B; Tue, 10 Feb 2026 13:23:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2LExlyUAPtc
Date: Tue, 10 Feb 2026 19:20:38 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Matthias Beyer" <mail@beyermatthias.de>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Chris Packham" <judge.packham@gmail.com>, "Jakob Haufe" <sur5r@sur5r.net>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <cd125186-dd81-43dd-a7f6-388b683d01ca@app.fastmail.com>
In-Reply-To: <V2_format-patch_caveats.34b@msgid.xyz>
References: <format-patch_caveats.281@msgid.xyz>
 <V2_format-patch_caveats.34b@msgid.xyz>
Subject: Re: [PATCH v2] doc: add caveat about roundtripping format-patch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Snipping all my verbiage here.

On Mon, Feb 9, 2026, at 23:37, kristofferhaugsbakk@fastmail.com wrote:
>[snip]
> @@ -796,10 +796,14 @@ CAVEATS
>  Note that `format-patch` will omit merge commits from the output, even
>  if they are part of the requested range. A simple "patch" does not
>  include enough information for the receiving end to reproduce the same
>  merge commit.
>
> +'''
> +
> +include::format-patch-caveats.adoc[]
> +
>  SEE ALSO
>  --------
>[snip]
>     +
>     +    It seems that the section break in git-format-patch(1) does n=
ot get
>     +    applied in the man output (according to `Documentation/doc-di=
ff`
>     +    apparently)? Maybe this is the wrong construct? I couldn=E2=80=
=99t find any
>     +    other thematic breaks here (though there are several variatio=
ns).
>     +
>[snip]

I want to use a heading instead.

    =3D=3D=3D Patch application

Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E73B2A4
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756680; cv=none; b=NByKuB1F52AKP+f60lvJNahN65R0NsDQ56vfSSzyYtP32pptXq4IbWh2v6tpRR6KQEtXmHDlehDubrShydZJJV3Edk/Zlqg9TNvHrOCY4tdjxjfaB9bsQvJXR9X/vSCqQ14hd67qslTB8pqZrdYBViLYiknjzoaxL1CGOUCuXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756680; c=relaxed/simple;
	bh=vuk1Fd7vHzCont8H8T+6oxscNXGaCGhar4Nlls3MtDY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YCvscIWZ/U64CyZ7eoeN40R3ni3o8accaMp84ZEeWbTlqGFmd/wyKpfLdCHpZxDCNTGs/W1lmdxd8M0CdWhiIUyw7f26J2v3jXstKNrL3ZbP4qc8Cnhd1arGyfT3f5Jtv4kHksgOnhj+1oAVRU1l0Zg7BbNDjLNi5sx4wcJaHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=nVOYPbJt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWSyHJRh; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="nVOYPbJt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWSyHJRh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B2EA111400A8;
	Mon, 12 Feb 2024 11:51:16 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 12 Feb 2024 11:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707756676; x=1707843076; bh=DUTnVkxlNooxbljVwWd9pRgTD9xylMiV
	KEdId/es2HM=; b=nVOYPbJtpS0YFTvwM0YXitS53xrjqOeifJkANxYGrA7Xeo0j
	OBFtjECLmrtIINtAzDZzojT/6FPkAezLQEeDMMKp5RomQO2315UWGWs1DzkKCtPC
	mAQo78TlubuBz9FGYRTiGiDNfqM2mykjjXpyqo97vtEvEtLmsf91ITMScoi9xuRT
	wxtWf44VEMkqbRIYYPp1Y3ojq9CsHSIRVxqkaUOlAmOmxqvJIqCeVTCabadQj2RO
	jiv1ZrKLXUS/jq4BaUmpic5UEdl6/zOyBFDV1GzXEk3J1s5cQZ9SdnVx+ZgOuUD1
	J0qzwy/fu0BcBoArNiGAB/DuKYt8V+TrpZZs8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707756676; x=
	1707843076; bh=DUTnVkxlNooxbljVwWd9pRgTD9xylMiVKEdId/es2HM=; b=Z
	WSyHJRhZuZyvW9+LrxuA3IKu72854Pb4F+0G1QHOpw3I/FGP2lfYBMmU+bU2eMok
	ndGC3RxlhZEUYBP+ZAfWFOwAE3UGwwe3j9IfZpSy14M0aPqMl8aY4S0s/6+5ubnB
	EMeXEqDkRKAtW11+ZyVpugCpAPaY3co6mrmXQ6ca8v1CVhg48D6frI5tyiPnrpQu
	C5s9Oai+uVtc1e5Vuv9tU9oBHiHvAuIC2nAgICXE59b/WCqubZHQossJjMbk9qQd
	LN6Q3vC2o2FgHL/bFStc619pRYfUoslkEihTUw6jhpl8bH4qPRWzQTcviX968GIk
	mlzqeEGq1wv8HY8slqPzQ==
X-ME-Sender: <xms:hEzKZR0QEqlaRzHyrX_5si8oEa3mFPIVH-ODfsIfsWziSOYcVHoeacQ>
    <xme:hEzKZYEG3X9IWeN434NEriz0dQdzJzCqGKcrd3PIB4nBlAam4vMx3pAVLkAqLK832
    z5U8JWwWslWWFuCZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:hEzKZR4DQNkd9IAqwtzI2bojY1OcBugV2S-RXfg0qbZG2mrq8NM_IQ>
    <xmx:hEzKZe2zmSu36x37V5ZcbeEiMMiVmvCzhkZwZtSwJaC_8Oliz2B8sA>
    <xmx:hEzKZUFO2EhFA3fj_WDj_1D6VUiu3dDOdWS_dYWu4RrgQC-oO8oupw>
    <xmx:hEzKZQhoW67sPpIzDTqTY_dnVrrPEtGeBPo24LnjzWTbH4GOP0TeXg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5E11115A0092; Mon, 12 Feb 2024 11:51:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <09b1ab48-b58f-458c-89f5-0c419d92f61a@app.fastmail.com>
In-Reply-To: <89d32a5f-b5ab-4773-bd9f-d33b4e348e15@gmail.com>
References: 
 <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
 <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <89d32a5f-b5ab-4773-bd9f-d33b4e348e15@gmail.com>
Date: Mon, 12 Feb 2024 17:50:54 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, git@vger.kernel.org
Cc: "Tiago Pascoal" <tiago@pascoal.net>,
 "Chris Torek" <chris.torek@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2] column: disallow negative padding
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024, at 23:47, Rub=C3=A9n Justo wrote:
> While we're here, I wonder if silently ignoring a negative value in
> .padding is the right thing to do.
>
> There are several callers of print_columns():
>
> builtin/branch.c:           print_columns(&output, colopts, NULL);
> builtin/clean.c:    print_columns(&list, colopts, &copts);
> builtin/clean.c:    print_columns(menu_list, local_colopts, &copts);
> builtin/column.c:    print_columns(&list, colopts, &copts);
> help.c:     print_columns(&list, colopts, &copts);
> wt-status.c:       print_columns(&output, s->colopts, &copts);
>
> I haven't checked it thoroughly but it seems we don't need to add the
> check we're adding to builtin/column.c, to any of the other callers.
> However, it is possible that these or other new callers may need it in
> the future.  If so, we should consider doing something like:
>
> diff --git a/column.c b/column.c
> index c723428bc7..4f870c725f 100644
> --- a/column.c
> +++ b/column.c
> @@ -186,6 +186,9 @@ void print_columns(const struct string_list *list,
> unsigned int colopts,
>                 return;
>         assert((colopts & COL_ENABLE_MASK) !=3D COL_AUTO);
>
> +       if (opts && (0 <=3D opts->padding))
> +               BUG("padding must be non-negative");
> +

Sure, I could add a `BUG` for `0 > opts->padding` in v3.

Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A513C9A3
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649816; cv=none; b=XowLZKjRs+vZAC2AToLMaO53osKncCZueSKUIb8Vm8xyTnPXtODaItsaBrl3f/qpks03S1g9sj4ZnxDiYv8j+j/KtQBcjVsvq+PPHqLpv7z/E0E5lrGkxEvZw637wF2ERSDaT7FNy1zjUm6c8uBm1MZwdq7bOzjfO8fxcqdh+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649816; c=relaxed/simple;
	bh=uRgQvS2BIYIGQE2mP25xrAkMn7AhVaZTOVu3S6xkscs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=haF14DWOt0JsWRGZL9r59ciUpV1dEKJr50+i8SLqE2b+XYBpJvtrHzmOqqbrEmwX0xwV7p4djs+RnLBEPF/RzMvy5a2XrPXfw65sp/NI258s7Mo7pS7T2ka9OpylnfLMvI8ygrtZeS1FlhnkQsYO+GdvaEl9NV91nGZOBMETbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HfVt4Gwy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HfVt4Gwy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1892E1380137;
	Fri, 15 Nov 2024 00:50:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 15 Nov 2024 00:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731649813; x=1731736213; bh=fIvIwBLQsFwXwRQYoCe38RKvlQi0uB3zn+o
	3mBY/cI0=; b=HfVt4GwyTm32QTVX3TybFyw0/+qUjPwc1NgOzjDwWuehV/YUlo0
	lyVBPpnRdE+0qPoV0tuT4H1a5lfnVoy+3MdOuAkD5whZh/sUjqxrO5E1AMUB1ff/
	8UyEkcml/gksDTAh2f8a+NI4nGVILYDjgTK9lCko0IdeA5swF7LVZ03Zdbs5sDuO
	uwUml2+vv3w3/R+s+jdB4GbmyxyzQsIXwjPKa9vlMSOow37WWkvebeILod/bOBGi
	9jEHJGJDWaK3al4PAPSM4Bf1Jv8W2NQbG3AqkymqkQSqC2Wcs0BAS0VWBMuNmaQq
	IiBFGcvX/io0KQ1AVAB/xpfujAzIYoxXXZQ==
X-ME-Sender: <xms:FOE2Zy3I_W22qAfb75Nzqu6d4H89pcYB3cwFlc5j-yMoH0oAFJmDxw>
    <xme:FOE2Z1HFWK43ZH_Vbn_2Xye-m68y3jrx9y9Md1VRlpFylWnhZ8q97q7vQp3gNAn2X
    hkqvrNL7F33q5beKQ>
X-ME-Received: <xmr:FOE2Z64hHxkpRQssSbVMJ5einix59Xf3mFOnhoZ2rWFK6bPNzkwsbRt14kdfVC70shCYGG0_RS0RTRol4H691khhBns7Zq8htRF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepfhgvrhguihhnrghnugihrdgsvghntggvsehtthhkrdgvlhhtvg
    drhhhupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FOE2Zz0Xz9-QdnyEH5IGu4RIBw9LQo3evIfPJjwkSpi4zp91vc6pOQ>
    <xmx:FOE2Z1F3jej5yTlvicjqx20EL05iiUk56ebZN9iIJehYi4D6Cn3Ztg>
    <xmx:FOE2Z88vAduGT1Q__ZjYwU0eTn3dWQJ7TLVGdJ-xL4WdsL01Gms-Uw>
    <xmx:FOE2Z6nm5lcdzprsjb3ddbYtfInd4mhMNb-X_XinECldHjqHPSmL1A>
    <xmx:FeE2Z0CBfPanCbLlLbn7N93whJtmfu6UYZGZZR_xtGSAClNC4ufIFB-X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:50:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>,
  ferdinandy.bence@ttk.elte.hu
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
In-Reply-To: <20241023153736.257733-3-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 23 Oct 2024 17:36:36 +0200")
References: <20241022194710.3743691-1-bence@ferdinandy.com>
	<20241023153736.257733-1-bence@ferdinandy.com>
	<20241023153736.257733-3-bence@ferdinandy.com>
Date: Fri, 15 Nov 2024 14:50:10 +0900
Message-ID: <xmqqr07d11wt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

>  int refs_update_symref(struct ref_store *refs, const char *ref,
>  		       const char *target, const char *logmsg)
> +{
> +	return refs_update_symref_extended(refs, ref, target, logmsg, NULL);
> +}

OK.  As the enhanced and renamed function is also external, we do
not have to worry about reordering the old one to come after the new
one.

> +int refs_update_symref_extended(struct ref_store *refs, const char *ref,
> +		       const char *target, const char *logmsg,
> +		       struct strbuf *referent)
>  {
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> @@ -2122,13 +2129,20 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
>  
>  	transaction = ref_store_transaction_begin(refs, &err);
>  	if (!transaction ||
> -	    ref_transaction_update(transaction, ref, NULL, NULL,
> +		ref_transaction_update(transaction, ref, NULL, NULL,

An unwanted patch noise?

>  				   target, NULL, REF_NO_DEREF,
>  				   logmsg, &err) ||
> -	    ref_transaction_commit(transaction, &err)) {
> +		ref_transaction_prepare(transaction, &err)) {

Likewise, but the noise distracts from the real change made on this
line, which is even worse.

The real change here is to only call _prepare(), which also asks the
transaction hook if we are OK to proceed.  If we fail, we stop here

>  		ret = error("%s", err.buf);
> +		goto cleanup;

This is also a real change.  We could instead make the additional
code below into the else clause (see below).

>  	}
> +	if (referent)
> +		refs_read_symbolic_ref(refs, ref, referent);

And if we were asked to give the value of the symbolic ref, we make
this call.  What should this code do when reading fails (I know it
ignores, as written, but I am asking what it _should_ do)?

> +	if (ref_transaction_commit(transaction, &err))
> +		ret = error("%s", err.buf);

And then we commit, or we fail to commit.

> +cleanup:

We could write the whole thing as a single "do these and leave as
soon as we see any failure" ||-cascade,

	if (!(transaction = ref_store_transaction_begin(refs, &err)) ||

	    ref_transaction_update(transaction, ref, NULL, NULL,
				   target, NULL, REF_NO_DEREF,
				   logmsg, &err) ||

	    ref_transaction_prepare(transaction, &err)) ||

	    (referent
	    ? refs_read_symbolic_ref(refs, ref, referent)
	    : 0) ||

	    ref_transaction_commit(transaction, &err)) {
		if (!err.len)
			... stuff default error message to err ...;
		ret = error("%s", err.buf);
	}

which may not necessarily easier to follow (and in fact it is rather
ugly), but at least, the resulting code does not have to special
case the "optionally peek into the symref" step.

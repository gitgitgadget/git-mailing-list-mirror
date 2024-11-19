Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA518E25
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979356; cv=none; b=YejSXmMdI8ttcRIKW2OmtY1YAKT1pGUyJHw++wpwR7ljdElqkVOy+a3UoZBC1YTnIc6oCzWzLPxKzwvg6KKRehruosLIGdsWPQWR6XNpaj449OwTzNMG6zRYfbPqm1q5TzCUwt6pXclRP6h3hTvyL2VyQY1owskqyMiZxtWFMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979356; c=relaxed/simple;
	bh=IMUdEVV7Gn1GscyJvm8ePB1euw5REAmSy5uKzKbv7wI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/SF+4p1kEiovT1hJXDBY4ySuyui84MXVjl39tWat9d/PVWdSsrx0g46gXT1bA74cf/tiIR4FYV1LuIeWDGL9ghix9BdXgX2qjLSTmutdv/uQWBWg1OsdYQ2A5hVzSlhMNs6XvaoVe8TDtlaBaY7L2gTe9EOj9L41lUihbDcnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N3ogdw0b; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N3ogdw0b"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86E9F2540118;
	Mon, 18 Nov 2024 20:22:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 20:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731979353; x=1732065753; bh=CvPwfzcXYrVyIUGsfgL9/DX/eA+nCM3osc1
	kkRcKH5s=; b=N3ogdw0bfKR2ukp+tVGtrn5NOn9k11I/VcMGpTPAtb/1czaPDRM
	D9HuovyoPJlz/cHP2Y53tV9SVPGZlecnmU8R1zY89zY39A33WmcZTgcEFFBo8MLB
	6WcrSTcZTbZTNNsKnudAx1GRTMLJyoXb1jxybV0R0f03g1lFyuOMwvwsS4iQsqJt
	RSuB6eapqNGWEF9TRB3Jafnr/ATFy5kqPXX3eocJF5ja9nTfBD0+rpURjxwsfSdO
	C5QsbynkTcLglUQenKUqJntjjUTvGk1W2Q3X6+15QBNA73wIzSLxPnMXgoS92pQA
	63h+4xRmDEBPxYbW5OT0Ts/MSks2o386nsw==
X-ME-Sender: <xms:WOg7ZycCADFCd4EIbqM4Sa3gM6l8VrIGdBP9NnIaK3fyGbIGFOmltw>
    <xme:WOg7Z8MQ2vTlZjWFjm1tatITB976-cGdAwzhXxLtHRwpSbfSJu1LCUhYXL1K_FQyG
    ST_bjY3MBHlTD-GCA>
X-ME-Received: <xmr:WOg7ZzitDLFpMly4mtDBRfbd8toVK_4ncqiRIq9yxBF_n_kBlXyFAnZjcFB5Iq8KWmtHc07C8XE81GixWxsoXS5QASAWQnqrVEdD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdefgecutefuodetggdotefrodftvf
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
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WOg7Z_98iUrK3VG-9EZwwc1EDRrEGfbAmj7-uAp4le4z3B6BibMxPQ>
    <xmx:Weg7Z-sWL9w_4nKmtrE3wm8ukbz0UzuLx374oqVof6dwssrZrPodzw>
    <xmx:Weg7Z2GALnq_68wkfq3jfoAhXfsv1XIY4gVWooy2Us0_vJNPkwYkOA>
    <xmx:Weg7Z9NgLbdxbmMhIDsl-r88kymCynEwi92a4FHieCPYTYF3syMyzQ>
    <xmx:Weg7Z4Lbg2DQyFZVUXIy6ZEcE5kMxUVxeha4Pv59Zt7KsqZu3S8un3Yp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 20:22:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref
In-Reply-To: <20241118151755.756265-3-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Mon, 18 Nov 2024 16:09:21 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-3-bence@ferdinandy.com>
Date: Tue, 19 Nov 2024 10:22:31 +0900
Message-ID: <xmqq4j44ggq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Subject: Re: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref

"output" -> "return values", or something.

> When the symbolic reference we want to read with refs_read_symbolic_ref
> is actually not a symbolic reference, the files and the reftable
> backends return different values (1 and -1 respectively). Standardize
> the returned values so that 0 is success, -1 is a generic error and -2
> is that the reference was actually non-symbolic.

Are all the existing callers OK with this switch from 1 to -2?

IOW, if a caller using the ref-files backend start behaving
differently with this change upon seeing a return value of -2 (where
it previously was expecting to see 1), that would not be nice.

Because "reftable was already broken" is not a good excuse to
introduce a separate regression to ref-files users, we'd want to be
careful if we want to do this kind of "while at it" change.

> +/*
> + * Return 0 if the symbolic reference could be read without error.
> + * Return -1 for generic errors.
> + * Return -2 if the reference was actually non-symbolic.
> + */

As this is an implementation of ref_stroage_be.read_symbolic_ref,
the above comment must stay in sync with the comment over there (and
a comment before the corresponding function in the other backend).

I personally would not add the above comment for that reason, but as
long as we are consistent, I am OK either way.  So if we add this,
we should do the same to the reftable side as well.

By the way, it is arguable that it is an error when a caller asks
"here is a ref, please read it as a symbolic ref" and the ref turns
out to be not a symbolic ref.  I'd say that it is a valid view that
the caller asked the question to find out if the ref was a symbolic
before making the call, and "that ref is not symbolic" is one of the
valid and expected results.  So if you wanted to change the value
from 1 to -2 only because "you called read_symbolic_ref() without
checking if it is a symbolic to begin with, which is your fault and
you deserve to get an error", I am not sure if I agree with that
view and reasoning.

In any case, this "not a symbolic ref" may want to have a symbolic
constant.  With NOT_A_SYMREF being a non-error, you could structure
the caller like so:

	status = read_symref()
	if (status < 0)
		... we got an error so we stop here ...
		... we do not behave differently on error type ...

	switch (status) {
	case 0:
		... everything is peachy ...
		break ;;
	case NOT_A_SYMREF:
		... we want to handle non-symref here ...
		break ;;
	default:
		BUG("unhandled case");
	}

Also, even if we decide that we want to treat this as an error,
lumping everything else as "generic error" might make it awkward to
evolve the API, I suspect.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 38eb14d591..60cb83f23a 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -830,7 +830,9 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
>  		return ret;
>  
>  	ret = reftable_stack_read_ref(stack, refname, &ref);
> -	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
> +	if (!ret && (ref.value_type != REFTABLE_REF_SYMREF))
> +		ret = -2;
> +	else if (!ret && (ref.value_type == REFTABLE_REF_SYMREF))
>  		strbuf_addstr(referent, ref.value.symref);
>  	else
>  		ret = -1;

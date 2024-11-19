Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F377111
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983280; cv=none; b=riDrrrxd2hvRjhNZwTI3zxwo0UNvxIhp0h11f3XzCs+GUGN4VnG4RKLRUHdk+f7rQffEBukt8nV/CYusg2JqllvUSFN1EZvvp9SWMjI8dT4kaAE0uJNlEk15g/5vubRY9X9mkVcH+w4EgWxruz3pnkCPCxJYk/TzOlV41Z7tU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983280; c=relaxed/simple;
	bh=qLCDUqJdkW+ZQHkeCK+9FP029JkFiMd+n0IJvvw/24Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nTc7sO/XcTrY85vOQ9wRxDX2etcd+lyB5NFOQX7PsYv8YIY3r0oV+QXij1ZDpu4eYemDjYsOIm7s48vMbvWh+Lf6ITLL9KyD5xCq/e72cKUMtjOwqurDwl83cWI3ahzmqUAu+aXzdFJJUCZCQzjn1uVOhleSAU9zSvHA95Qz9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LbGVpDzO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LbGVpDzO"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98C07254018C;
	Mon, 18 Nov 2024 21:27:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 18 Nov 2024 21:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731983276; x=1732069676; bh=5N2DbNCqLvhGLW5T+VvXTASnCggySev4Zwt
	sHdt/WbQ=; b=LbGVpDzO010/pNbpmrmi3056DbysKY6nwhRR7sGMFRkcYyT6rd/
	26I4mS8pxzKSHIBXpu7l0+do19K9DY5twusA4+DqNh/SeFKWi1LQEJ0ijZEKmmaB
	dFgI25gjAMxHreU7KAQ9j7ZByM8Dm5mNhY8VYnQsHJvqkop36AvPEy0l3QBVffGj
	w2RT8dwfznEA3A/ui/EwFCXZ6MEZyg66ZsalJBrUSb54cQNRh31spnvCh9SnwXlA
	H0fpaGcO51iU1cvunF9j7j+XFzLOv9uKzL/Dvr9Zd0reZE0/l4xWQoDmSUnv+W0z
	Chgv2EEmPTHCK8D6rnb6Wann6o1Z58yNnnQ==
X-ME-Sender: <xms:q_c7Z8t8_Uj6Y_gSwNAVn9tpjE6UhDBsvTBRA9hrp4iXYZ0voIc81Q>
    <xme:q_c7Z5egJi8YT-bi4MeY_cs0tbQestCPQgC8DFpJvahZtIB4uF0mNc0Q-6MJPg-C-
    zgHvORG2ckCRbazNg>
X-ME-Received: <xmr:q_c7Z3xiTrxaT6c-LIfTEiQBQdXwMZNVycfl5e7cfjWoSFnOZM7cp1VWKVxGgKwvfYYPLxLTGx_QhCHwwvoUbzo3fs6NrESqzonP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdegjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:q_c7Z_PCDjHtVZ4RpcuCXX6me5DD4IG2r8-VrKj5uK2SYrW3cQgJPQ>
    <xmx:q_c7Z88Xt9Q12E6VRcxjea6cI8RN-6zK651xFI1ELNPtiwiEmAEW6w>
    <xmx:q_c7Z3W5EwdA_sy4QyqM7ZAfyABnXcc1oKLePH5FHWXhLGPHR1oYtA>
    <xmx:q_c7Z1emfpzFeBskPmc-xTgFoluCFc2xSIgBEbkjxPs1Gfm3ssjU3w>
    <xmx:rPc7Z3aGdiX0WFhyxdjU4aciU2MjF5fgp4enerdHAj4J38ZORG5RP6A6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 21:27:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v13 5/9] remote set-head: better output for --auto
In-Reply-To: <20241118151755.756265-6-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Mon, 18 Nov 2024 16:09:24 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-6-bence@ferdinandy.com>
Date: Tue, 19 Nov 2024 11:27:54 +0900
Message-ID: <xmqqldxgez4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> +static void report_set_head_auto(const char *remote, const char *head_name,
> +			struct strbuf *b_local_head, int updateres) {

"updateres" was too mysterious a name.  "res" stands for what,
"resource"?

Looking at the way the parameter is used by the code, it seems to
indicate that the remote HEAD originally was in a detached state, so
"was_detached" may be a better name, perhaps?

> +	else if (!!updateres && b_local_head->len)
> +		printf(_("'%s/HEAD' was detached at '%s' and now points to '%s'\n"),
> +			remote, b_local_head->buf, head_name);

There is no need for !!; any non-zero integer is true.  !! is useful
only in a context that takes only 0 and 1 (like when you are making
an assignment to a variable or a structure member that takes only 0
or 1).

>  static int set_head(int argc, const char **argv, const char *prefix)
>  {
> -	int i, opt_a = 0, opt_d = 0, result = 0;
> -	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
> +	int i, opt_a = 0, opt_d = 0, result = 0, updateres;
> +	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
> +		b_local_head = STRBUF_INIT;

> @@ -1440,20 +1468,27 @@ static int set_head(int argc, const char **argv, const char *prefix)
>  	} else
>  		usage_with_options(builtin_remote_sethead_usage, options);
>  
> -	if (head_name) {
> -		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
> -		/* make sure it's valid */
> -		if (!refs_ref_exists(refs, b_remote_head.buf))
> -			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
> -		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf, "remote set-head"))
> -			result |= error(_("Could not setup %s"), b_head.buf);
> -		else if (opt_a)
> -			printf("%s/HEAD set to %s\n", argv[0], head_name);
> -		free(head_name);
> +	if (!head_name)
> +		goto cleanup;
> +	strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);
> +	if (!refs_ref_exists(refs, b_remote_head.buf)) {
> +		result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
> +		goto cleanup;
> +	}

OK, we refuse to allow a manual "remote set-head" to create a
dangling symref, which is a faithful rewrite from the original.

> +	updateres = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
> +			"remote set-head", &b_local_head);

> +	if (updateres == -2) {

Where does this -2 come from?  It is not the "you asked to read it
as a symref but it wasn't a symref" thing, which was mapped to -1
with [PATCH 3/9].

It is an unusual way to construct an extensible API function to say
"all different kinds of errors we happen to know when this
particular caller was written return -2, but some special cases are
not -2".

Rather, "all negatives, other than these selected few values we
special-case and handle, are errors" is more natural, isn't it?

Maybe I am misreading the code and missing where the -2 comes from
or the significance of the value?  I dunno.

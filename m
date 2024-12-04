Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00134C76
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278817; cv=none; b=hW1fs6OfSGIMkflA2ZVnuu7qZ473TiKyPruT8Qhnp+CMAGHliIATyRDsNKAmNT5vFgplUmO0u8R+OHj6jAHmAMxO72cBgw4TxeaqK6msLYh9BPeQWf/ahwsIjsEtKsztocsaw2B+5KeXiHiWyl8v7+ArNcSW6v+8bfRAvn5s2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278817; c=relaxed/simple;
	bh=MRVQqg7KyShbPWaFjngxH+d2Cr/fpqYukT+XKf3MyBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=efZkLKgahyK4LzJ4tObgCqoscj7JTSXgCtEl6kB8y3OnZb8FL1auxX951C+WMbIypun3Zz6iAwoCc0krQr1QnJiN40Seh1gaC7bijgiYeove0BBTnEvmfjkUmQBCVOTtqiJ8AQyQrAwGVd5sDwU+qeQSIhwyQKFWEQR3KKccMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTv9UI3o; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTv9UI3o"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AE57A13805DD;
	Tue,  3 Dec 2024 21:20:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 03 Dec 2024 21:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733278813; x=1733365213; bh=h5I6S4L+rgnR3oTqYnw2jxw8IWbg5wcDo5p
	dvURPR8g=; b=vTv9UI3oCLbv3tCUBm7rusC0udLij5NDpJXp0AdmQN0u0udWd+H
	5KSy/XdYn3vXDpX+JXWqgaxpCNSvwdSsxsvIGo8Ow+2uCQIuj33plDHBeaF+Ny6f
	GmBRaXL0Z/70u8t6xBB/MO7XcYi7gMM5WugvQBO8IOWve1i2FnlAocasgq9hZdcF
	hGqGYwHChFl0k8pBSpmaJQgClzE3x+4vHrvjMqS6Y2F1jJand5lWfwKq1gaie2Nr
	hSCUgNTg44QljIC7C7EBx+SZpiN87yBxuQd+V78gfrt+RNS18TbU2obsmx+nP5S6
	R+xkNZMLhAQw8hWD2ypVucsUtWNqYp1VZxg==
X-ME-Sender: <xms:XbxPZ2H14WlNBCs90im_Ax9vxioqZEkCh4hwyxXZiIAA-yM3rVF2Qg>
    <xme:XbxPZ3W8DLM3RLWLuG1ZzGVT7Usqt53KxBAd2C2I4b2JaiLOWCgVEWG43HHEoEZFR
    -rUCWhmnfKvOrlfMA>
X-ME-Received: <xmr:XbxPZwK0-dbRXITTg0sts7w-dmjjaWD8Go6iFqQEkwxMLmzd4022hsGL29EtfO3n4JMP_8ry5TrdTRuvcxpOwERYQWPyAQLzu2dEtSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdegvdcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:XbxPZwHdxtLREbnodYmfq3tdJRnbcgy9nfOx_3xzpBmPyM4tu9zCng>
    <xmx:XbxPZ8XDakCWXmElnnFQYCc9Gpl3npO1vNpmDoN_7Ggk8N5Ldt1zeQ>
    <xmx:XbxPZzP12inGNI9HDqJmfZ2obQEtYe_1ICSWQgHRaQDMk7MY-NCrEw>
    <xmx:XbxPZz3KJ0JqkD3DDktBlKW8lErjF72RWuo9eVPQLKVQLOEirc64rQ>
    <xmx:XbxPZwRAwbMfq0NaKR0FlR2G3uTzjktgFGLKZNUbJspFaVniGi2HaSvd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 21:20:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH v1 1/2] fetch set_head: add warn-if-not-$branch option
In-Reply-To: <20241203215713.135068-2-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Tue, 3 Dec 2024 22:56:47 +0100")
References: <xmqqiks7oprx.fsf@gitster.g>
	<20241203215713.135068-1-bence@ferdinandy.com>
	<20241203215713.135068-2-bence@ferdinandy.com>
Date: Wed, 04 Dec 2024 11:20:11 +0900
Message-ID: <xmqqh67k5gv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> +static void set_head_advice_msg(const char *remote, const char *head_name) {
> +
> +	printf("Run 'git remote set-head %s %s' to follow the change, or\n"
> +		"'git config set remote.%s.warn-if-not-%s' to disable this warning\n"
> +		"until the remote changes HEAD again.\n",
> +		remote, head_name, remote, head_name);
> +
> +}

Style. "{" that encloses the function body sits on a line of its
own.

Perhaps use the advise_if_enabled(), so that those who already
learned how to deal with the situation can squelch the "how to fix"
message.

> -static int set_head(const struct ref *remote_refs, int follow_remote_head)
> +static int set_head(const struct ref *remote_refs, int follow_remote_head,
> +		const char *no_warn_branch)
>  {
>  	int result = 0, create_only, is_bare, was_detached;
>  	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
> @@ -1660,7 +1668,10 @@ static int set_head(const struct ref *remote_refs, int follow_remote_head)
>  		result = 1;
>  		goto cleanup;
>  	}
> -	if (follow_remote_head == FOLLOW_REMOTE_WARN && verbosity >= 0)
> +	if ((follow_remote_head == FOLLOW_REMOTE_WARN ||
> +		(follow_remote_head == FOLLOW_REMOTE_WARN_IF_NOT_BRANCH &&
> +		strcmp(no_warn_branch, head_name))
> +		) && verbosity >= 0)

Reorder conditions combined with &&- to have more expensive ones
later.

	if (verbosity >= 0 &&
            (follow_remote_head == FOLLOW_REMOTE_WARN ||
	    (follow_remote_head == FOLLOW_REMOTE_WARN_IF_NOT_BRANCH &&
	     strcmp(no_warn_branch, head_name)))

As human readers, we may know that no_warn_branch is always valid
when (follow_remote_head == FOLLOW_REMOTE_WARN_IF_NOT_BRANCH), but
semi clever compilers may not realize it and give a false warning
about using no_warn_branch potentially uninitialized.

We could do without adding FOLLOW_REMOTE_WARN_IF_NOT_BRANCH and reuse
FOLLOW_REMOTE_WARN, like so:

	if (verbosity >= 0 &&
            follow_remote_head == FOLLOW_REMOTE_WARN &&
	    (!no_warn_branch || strcmp(no_warn_branch, head_name)))

That is, "if set to remote-warn, always warn, or no_warn_branch is
not NULL, only warn if the current head is different from it".

> diff --git a/remote.c b/remote.c
> index 0b18840d43..f0e1b1b76a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -515,6 +515,7 @@ static int handle_config(const char *key, const char *value,
>  		return parse_transport_option(key, value,
>  					      &remote->server_options);
>  	} else if (!strcmp(subkey, "followremotehead")) {
> +		const char *no_warn_branch;
>  		if (!strcmp(value, "never"))
>  			remote->follow_remote_head = FOLLOW_REMOTE_NEVER;
>  		else if (!strcmp(value, "create"))
> @@ -523,6 +524,10 @@ static int handle_config(const char *key, const char *value,
>  			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
>  		else if (!strcmp(value, "always"))
>  			remote->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
> +		else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
> +			remote->follow_remote_head = FOLLOW_REMOTE_WARN_IF_NOT_BRANCH;
> +			remote->no_warn_branch = no_warn_branch;
> +		}

If we were to do without FOLLOW_REMOTE_WARN_IF_NOT_BRANCH, then the
above becomes

			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
			remote->no_warn_branch = NULL;
		} else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
			remote->no_warn_branch = no_warn_branch;
		} else if (!strcmp(value, "always")) {
			remote->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
		} else {
			warn(_("unrecognized followRemoteHEAD value '%s' ignored"),
			     value);
		}

We'd want the new choice documented before we graduate this topic
out of the RFC status.

Thanks.

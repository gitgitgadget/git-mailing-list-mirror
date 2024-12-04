Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7B1C3C04
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340527; cv=none; b=bjeFFUMsTqhO4zZfroxhZ+eq+zG9gOkzbnKFQjAv+EDUO40uHoPAHCBlkDwfUVEHU/6c/PfQaLuAGlxDX6tZUGgplRA92mZ019YzCLhaUaorvDwkxg69GWUWoEF+vvBwC3HQxD2+vmqP+R/KrSnl96EeyceelLRxsMmI8jYg7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340527; c=relaxed/simple;
	bh=1umKwZsCAo6JaWcSqjbbCFVj7d1jo8sMIIUn8LGuGRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hnSr1GqLL++nXQ43mGwrs2d3wEGuJ/Gxvj4p6mehBggna955VLpiF+lVXXcbQqH84a5EV/zhxosZ6qvU3FtO/UiGtZUqvlJPkBF0qQly90+0AuOUP0VHwggprirwusmbEVNTVUJKhUkhq3UEET/hafvxQMlv0tp3yhnvdxdGpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCJOUexv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCJOUexv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D1D71380592;
	Wed,  4 Dec 2024 14:28:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 04 Dec 2024 14:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733340524; x=1733426924; bh=5Kj+LqH7JyyLSwCaEeN8507l0N2Es4php0O
	Ixn2QpB4=; b=fCJOUexvuldCBqVA7mBziGk6MSNr3VO0l/n5q0N55i28Ie1uMzu
	s+j5PQxVLKVL3POwEPbDwbXIok9ysH4p1tPN7gLC8dzlg6O6hpyhupmj7Q140Y3I
	yCZOcA1hpMaBNqbx74mvMmvO/3xcAEuqqSNF5cUVMV/Cn6xpLMPOuMnTYhTOp3w5
	GsAOH/6u3uNy+NvBG6mQ66WGSqR5zoWLYFp4foht829csh98rnvIb1hf0HivdiLK
	IbEq6xfHIWOmMFPVLkeEaQroJo23MH9kpYz8YH2f9Zn/Kcwhj4TNpBt8rgC7qIAO
	P6UWwdRDn6p94O48z5+qZ5jTyocYoPapFxA==
X-ME-Sender: <xms:aq1QZxVEJcQ4Jj_WSsUJD4aFB_kX4jhKShgC0Mo6OPsFJK3SAv_wxw>
    <xme:aq1QZxn3WkBX9b3gV_DtAbnNs5wunqGROUzhTy5sffBXA1rgF7M5DdEDTtt7If84f
    FELvOqIvuMtXhF4lQ>
X-ME-Received: <xmr:aq1QZ9YDKJGzvGTVvN0N8mCsNy31uj8gP84wtF_JU-9Psj4VINxlzZXxsPvIFAVLBVSjbLQRSr3NrBbW20ZDnvR7_dF8u2u5AMxWT8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrh
    guihhnrghnugihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:aq1QZ0VSpyPjXqIIAzNqGtWkLrkUiPd5ZYcZhaiw5RLcwIBOpzVCsw>
    <xmx:a61QZ7nJB2zb6YoeyumlEjQKKq-KnniUI6GI59nMF15AxqgDs_klXQ>
    <xmx:a61QZxe2_-N-TeVk1AiONLkXSKeu4L9J4ITuoERqRve7N4sneVbiCA>
    <xmx:a61QZ1HDShOYRfHySKO6Cu-_VKYqAMZkcDxsaEG0EkPDBuSFWUyI6A>
    <xmx:bK1QZ0iOeaCU9ZQNGDDb-imV3CaMDWHmQKS3I9s4ix7C7Ki9iY4suw4y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 14:28:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	=?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>, 	Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/3] fetch set_head: move warn advice into
 advise_if_enabled
In-Reply-To: <20241204104003.514905-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 4 Dec 2024 11:39:24 +0100")
References: <20241203215713.135068-1-bence@ferdinandy.com>
	<20241204104003.514905-1-bence@ferdinandy.com>
Date: Thu, 05 Dec 2024 04:28:41 +0900
Message-ID: <xmqqldwv2qom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> +static void set_head_advice_msg(const char *remote, const char *head_name)
> +{
> +	const char message_advice_set_head[] =
> +	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
> +	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
> +	   "if you do not want to see this message.");
> +
> +	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
> +			remote, head_name, remote);
> +}
> ...
>  	else if (updateres && buf_prev->len) {
>  		printf("'HEAD' at '%s' is '%s', "
>  			"but we have a detached HEAD pointing to '%s' locally.\n",
>  			remote, head_name, buf_prev->buf);
> -		printf("Run 'git remote set-head %s %s' to follow the change.\n",
> -			remote, head_name);
> +		set_head_advice_msg(remote, head_name);
>  	}
>  	strbuf_release(&buf_prefix);
>  }

Looking good.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index ccb74428bc..5d7ee1b550 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -123,7 +123,6 @@ test_expect_success "fetch test followRemoteHEAD warn no change" '
>  		git fetch >output &&
>  		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
>  			"but we have ${SQ}other${SQ} locally." >expect &&
> -		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
>  		test_cmp expect output &&

OK.  We just lose this part of the test, not because the advice
messages are squelched but because they go to the standard error
stream.  An obvious alternative is to capture it in a separate
file and grep, i.e.

	git fetch >output 2>error &&
	echo ... >expect &&
	test_grep "Run ${SQ}git remote set-head" error &&
	test_cmp expect output

If we were testing that the advice mechanism is used, do that with
and without the ADVICE_FETCH_SET_HEAD_WARN squelched, but probably
it is a bit too much, in the sense that we are not in the business
of testing that the advice mechanism works correctly in this series.


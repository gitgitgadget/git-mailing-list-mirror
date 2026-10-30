Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793387655;
	b=GGUdqXBxQ0bV4N+ewQH133mm780hVLZFEmErbYutqJcaoc+cy/IvOZiBwYSmEmBjmSPl
	 I3V3pTxu4dmErLnQqsR/AQrAIprLMuipZ9MccgjhL+qBzL9XvEvYuixGlSyREthDy8w5D
	 V/mcHFEVyW9LpVlj9+50vIfRXDKZ1RPmSNEgM029ieEZc5KahkFvOcjt4czE2E/gfwtms
	 coMZ3in471noR+h8kOvWotPBiu4mhiwNb8kQSCtNoNnSfye3Z00hLl/T4RtBGrKQH7Klq
	 1UmJ2cpuGKD2kaM1PUMMUD7c4A3Z8eYLd4XR+vmRKoSgQXe7sId7gy5qYQjGFLAQz1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793387655;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=H6eODFZcO9iEJU3s46vGcWVEgORmUjA+WFGFheaNnN4=;
	b=oFSRSMNBiUxvYCPuqYTqPUDFAW7K6jDpZi1Cw7ytRmrArtZy6Y3XFSxPcjqaEULkN4/+
	 eMpVVIYlmQcjaxqdHFwUGCSJqfS7l5GHhh63Jwwf/M1WtwZwAUEeutVjjBiY6ZUcYIvqA
	 yEmZcItyQ+6MamVUbrcRUojX9vYjY2pgZiGCo5cA/o0d2BYR+Hp4yLmM+lgsg3A8M7trR
	 7Og91zyKqXcR7DLmYWju1ycF5rBXxIu7Umernuy8YNHoAyBrf9mpqbg+mK/A/mqEBd75x
	 SyqvDrT3S3yTQjMFnqTfNRK9552nBvBZN7Fgen3HB9W6fY0yK00i9J7ihM6p8RUDEsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=a9MHXbwG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JkCE4VEi;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83506606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 19:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83506606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=a9MHXbwG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JkCE4VEi
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B663D1400087
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:14:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 30 Oct 2026 15:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793387653; x=1793474053; bh=H6eODFZcO9
	iEJU3s46vGcWVEgORmUjA+WFGFheaNnN4=; b=a9MHXbwGDj5BymOiqlV8b3Kb3c
	ubSdQ3QDAO0njiU6TsMFjLTst0KwwJzUK0iL1tRHkc93OVx/Fd949EjqgthEvorp
	42JmKcxBwHwmfkXwc8WhKe7dWGcJaPN+xTFEg899pHUNIlh+Vu2NmLdpWt2AWs4w
	+Uj5dFsEhOg/Xm43BSYED5UCBkjXhi5Mr0I2fBb26t35T00myIZYjQG6b49mBHHj
	XIhqe5PTlLO1W7oVNnlji/t5Uxs5aezCNjV4zbDTFX73qA3A4SXXyu3vhDJUxDXH
	t20iKAWViQ56sffC4e70lMQti91KaJVDOkLQ+RJGkcPJbgMEWCRPxM/a499A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793387653; x=1793474053; bh=H6eODFZcO9iEJU3s46vGcWVEgORmUjA+WFG
	FheaNnN4=; b=JkCE4VEi4CCiDS20oK8l2q11r1PhvL6oe37NEbRfJwqjLO+XBxA
	ECDMNVp2NgzIxnh/FLMMyCVr5N18IIdWP+kLlHXDXrfVj4CAYyXHNO0RZfkXEA2z
	5mf6gUo0QP27F1ajyfVIB5tYN75uNJM2if29H2GSuna0Bb7zSPvV+8LItWLDFC2R
	GFNrEApviC1TbLMQ+RtyhiYoUu6lrYeVK0OBu0298lZI8Plo5aDHWAsVsjY+XTN6
	A23vdhbKO3Lejvrex9XMzeO1iWArY+cWbAEBmsqGA+AdFGsQChBPmtVE2DO8WQad
	JdUIJ8zTG+rcxfpMC5zUNdp6z4fh1uSJKRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793387653; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JqNlLpaTH0vjct4T3iFvuLtWCpor1ZsHyZl6q3P1jVqXKF+
	D71JjhCCSzTflXQuJ/obhhf0hl25iY5Dz9v9hI3RBEkt2H8ZXDtAIIFiPbZR+EJv
	RaPgAFVTtgNJ+ZcTSC3U32lzWUldcn47FfwPqX4pZ5uQj/1NebdAp7+5CoVdtHac
	uDkXGf6ldhX6++mOHLp7MuYjPGu6nKhNAWka3gBmnSmbi4ZRSW1GUPXkA8uhkvIH
	J18hJBqebW69BXpMESWprp5Qu8Vt4/7dlwKQ+9DOceTn0dE7Xo8oDoswD0N8asAP
	RRY3CDT5BYxfBg778ZoKtQRsdtuW9B3Vfsxa2iQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:qAHot9U0mzBN75xP87RCfXsMBUbieCRsyxA0kk8bROM=:yVGFIB8RnewMJhbbiL8VS06DYHD2vHsNnACMVe8tFTU=;
X-ME-Sender: <xms:hezkaqELM2Yvdc2Vwb_bvuSw3VzjpefOjYimF6C7g6aTaKn1YqzlfA>
    <xme:hezkaqaUA0VT8iqFX4ERacn7BJZxqfrhSLDasjJupBl2aL37trSLJrxnYcFeb5aGS
    R2PZSBN8h0hAbRRcnKnwScM08Xfk7YSI7gY4jKsF2CvKSdxDIgzms4>
X-ME-Received: <xmr:hezkaqUsqCqZfvm17tpb8K9fvVYkU5n9mZZpFHjo87yHJEBuYUSfv0uBRlotkiB6w50aa3MdbN9oAiU3UCakZRujj4BIKxRh0_52>
X-ME-Proxy-Cause: dmFkZTGpCWPEmveLJ2CtSpuawnQHf/H5UI0XYM3Zn2dcsvJHNFxjDQtu7CyI2xHXExHEHr
    EbHPSKAKcfN1iEyfqNIgGOro52d0OFX4ewug1cjfnerBtgT9bgN1TTXQv9+2l88QJ8Z5FO
    hsfRL0OKDiAwnfAajSzsdvGiYqvCUHOHG4uGo2iEe901mHrFjDCpzaPHwhxEV18tnpVfjh
    r5/957sJ8n4Fst5TYmS/R4cCSe36Mf3Oe3aAdZvQ28Yw8yi6MxdsDdbGFXvYxXfe3T4YcI
    vN1HjNArHza0NubMFllOzTs6rYtkyE7vbWPvTP5YbSwLtiWbfC5ZRlX6U+CNfEXIF3SnTS
    S2xOTttgKEqeNFCNWyQq0wWvxZinx73O9l71FfN/OrfZe+7+F8md3MEXr7uWRCL/wboHT6
    ia45P7uMqNINz6BrW4rFnNNCYfgfiAeBeh9kB4b/ExNF/Hw6hZxzy/U5m/enGAxOQNZ1k5
    Htlr4jms4XpGbb71bJ/YrBav66YB9nzI7OTWpS3UlcBKg5AobA1EftWCvgtXE0LH3r0Z/T
    DUhJZ9Mg9VHsH6dKzkM0CCfDPE6lLHZWTbpd8bz99NZuyOL6AhNRifDkxiWmq1SC2P88nV
    tKgqda2rHW4V2F2JKuzWsOj1i8eeoNgM9J5vS1dI4v7nZ9zH3l50wq7ovpTQ
X-ME-Proxy: <xmx:hezkaglevPQNgby3PQ1EVkdzMgl2LCQB6n9urHILnCtKM7livUNP9w>
    <xmx:hezkalCuOhfbgJgN05SOn1hbXXNMdASc03XUFBeJ_Oyn-XMTkWrQRQ>
    <xmx:hezkavgVEI_b42pvkzu_9o_wWWv7F_JTyjDweVAgP_MxEeAThaTEyw>
    <xmx:hezkaix7-TBsqWTcvS_5kinVe9Mu9n4pKQosZ95MZ4LZMdNxPLSTvw>
    <xmx:hezkamoznT6bfIBs-ybKYi-WBlTT1q7CvAJ7ZZY6gd_8C_Pr0XDib2UP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 15:14:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 3/4] branch: add --delete-integrated to delete rebase
 and squash merged branches
In-Reply-To: <bf30f57ceb77c5052a72aa7dc01e3bb163993a63.1793357582.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 30 Oct 2026
	10:53:01 +0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
	<bf30f57ceb77c5052a72aa7dc01e3bb163993a63.1793357582.git.gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 12:14:11 -0700
Message-ID: <xmqq33tnvw58.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void find_landed_commits(struct landing_search *searches,
> +				size_t searches_nr,
> +				struct strmap *landed_commits)
> +{
> +	struct changed_paths cache;
> +	struct diff_options opt;

A tiny nit, but because so many things are called x_option in our
codebase, I am used to seeing the variable also carry "x" to match,
or the use of mere "opt" down below would make us go back to see
what kind of option it refers to while reading the code.  I'd liked
to see this called "diffopt" instead.

> +	repo_diff_setup(the_repository, &opt);
> +	opt.flags.recursive = 1;
> +	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
> +	opt.no_free = 1;
> +	diff_setup_done(&opt);
> +	init_changed_paths(&cache);

The .no_free member is set to avoid the diff_free() call made in
changed_path_of(), which in turn is called by find_landed_commit().
Everytime I see manipulation of .no_free member, it makes me look at
the code twice but this seems to be a good use of the feature.  And ...

> +	for (size_t i = 0; i < searches_nr; i++) {
> +		struct commit *landed;
> +
> +		if (!searches[i].changes_nr)
> +			continue;
> +		landed = find_landed_commit(&searches[i], &cache, &opt);
> +		if (landed)
> +			strmap_put(landed_commits, searches[i].branch_name,
> +				   landed);
> +	}
> +
> +	deep_clear_changed_paths(&cache, free_changed_paths);
> +	opt.no_free = 0;
> +	diff_free(&opt);

... clearing the member before calling diff_free() to release the
resources is also in line with the established practice.

I didn't have time to look at other parts of this patch (or other
patches in the series), but the use of .no_free in this function
looked OK.

Thanks.

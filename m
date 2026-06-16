Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC471303C9C
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621584; cv=none; b=LpM48lvXhH5Im9E7EaIaeloca+BF2bbkAOvGls49lrdF9wgoK/8a5RHOAcMOLb5y0r4bZOHz5gHUYGy3uU9HoE7tz4UoX7+Km6k6WwVG2/904eCLliKWMIhugmA1GvjZm1/O1Rn8F0UrxLRO1IaDkxl1X8wUXc37gPdhkQd446M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621584; c=relaxed/simple;
	bh=Db06xndU04k2XJuuyXoI15Odp80jeR7dIZzIokE5guY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TDLCue11Zq/kCVKqJocMy5BWAZSxAEtT4q/JsM3OSv58Zr1550BdnF3kIB7VFhnfOAY38OTDcnAj39MFcOJaTMBeOcheNZBbi/uLDqCV3g3jXyovkiuHRmd0i3ueRcoGDdF/Tgt80BJ2kEeGcKCM+O3UpK4S1cQhFZ3TCMJq83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cepJw5cz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y40z1i50; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cepJw5cz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y40z1i50"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 10E831D00101;
	Tue, 16 Jun 2026 10:53:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 10:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781621581; x=1781707981; bh=PMX1FT7VjG
	QQh3YrMcNu/405wKr3jS8kRcJcceR6qMY=; b=cepJw5czUsHP6YjXlRKs8IOIQ8
	Ly9fICk5SiyrPkQTKiTaO7yj8uamiO9+0fDF5CYjyLhFjlsWRBU7MwK/SQmOKFXr
	sdRHyMhD/WDOnPPJC7/v1K9p5bGSBgLhsX43OjbG7/g0dUqegE7DiK51tgVr9lDD
	C5hKdChENUVCnNp55ef7rgReLfhymJI53//k/FpWaIkr+OCWYfsQgFkai6pvaCzz
	cBecbMePs5aZkispGIsRJEN5bnTaVAGl4kVjXHFsqicxRbGTnk0hJrKkyeuYWhAv
	bbRv3vwgsfrlZOR/pcQy1BZgZ3u+LfvMu4vSgG4mJFyWqkGZaA76HmriU1bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781621581; x=1781707981; bh=PMX1FT7VjGQQh3YrMcNu/405wKr3jS8kRcJ
	cceR6qMY=; b=Y40z1i50nWPn5wMBlIFf2MRGEIN5OvQfj8G/SW0H6CL54p+drk2
	lbwkkkxWql1nEaFJW0t8qkv0vo7AWJ4oWGM1ewqc+Y71QMa2w8/kx45Lo/kV5BHQ
	PGgnqjA3YlceBFYvdhaGpX4bwbnF/OAWXHEtAPlMQyb7knRkG37LoBJLldpozAT5
	jYa3Tg2rV8Xj1VhWyz3VU6+NtqWWGn1muVirdaTu0IRvUYT3djCfKa2FGVI8teAJ
	/AW9N01lfA9/hdZ0I9S9BuRsBSCyaLQVbvlzQMMR5Ovj/eeTRd3q1lvFJywnHZ0o
	jz95blad0xILE8hVea/2LBZOwqeK8KVcb2g==
X-ME-Sender: <xms:TWMxaqhPZ8bXSJtyzAWfP7Bk7RmzXK39dEmeiJmccwA7WbK86m-H8Q>
    <xme:TWMxaifSPxyiInyOtcPMfDL-j3APFLVtApUTDU-LE2l45AqvKdj_Q9uzocGJ8wFQx
    x0vTH_7agR8z_VWBp0XAiPajdpD19w9JRVTnS73Edwx8U1nx1k>
X-ME-Received: <xmr:TWMxaveMbSCdT9QTSLO0f9kEkMBjUUBNgnLhqITB4kDQC3c9pw7Cm70GemUorbabBIwsVLbOXIbzxrZ-uxu3DcWUuP08jPrxLyIm>
X-ME-Proxy-Cause: dmFkZTFQynjETECiL76JVTG60UdYlilX05/y6ECUmlr5EmGy8LmIkHmW0mYcCEiBrZjdT1
    lO6rcfzrGoxziBZ9jlCe1kznHpDZWw1lNIu1n7E8sLJ2tbAdLeTxoICdMkBiktVD5lnI+t
    ME9pb8JgmI0DpHJ8pTpg+1oj+zy28VKtaU2i3UzrNo2eAyfcOca8QY19lEX8wVYUuN8FHt
    pxSCTLKBfrfpMWn4DD1ehXy+Dt5rXwdZ0vYwwWrhfdiDi/J+rJp7iU/M+peWqD9b9tonvd
    id4hmpiWX57JJaBXxEGY8Xd3yqnzvSXsNUYoeQDajDd/s4Es+yNP9Jz5p6GNnWZtCh58mH
    xRk6SEC227bEl/qGNfRuQwY0o9//7FjF8AiGI761evizuFBU0h8EA/OfkSVmzADZgsHTFl
    ryMg+LXYl0nHG3GOBBGtyZnLFY9xOFPFKk2NWkOzUojpAXzgEFYf2Qu8f1bsomK7mHK0JI
    rh5DK8SvDZsfSl2l6cIGwAO+Ghcxf7DNiWlt61UhOLYaVlXgEEQs7rKrejRH3tyVJDl4JM
    oBGbLz2pRdVCVAX5qtBKanGz2uBQx4eQXDtqynV70SX3IY92YM4hWgnZxvveHcnbR06kjE
    GUF3YCAE0khwQEEvyzNvD7n12ui5jDoth7nB++NRSgKQB0zevo10NnIyTkdQ
X-ME-Proxy: <xmx:TWMxas9yyUnpZ4fKZYTslbzBFlQFvvjrda7e-cYsCXJeQFuETeHKZg>
    <xmx:TWMxarlXISv9zqqpggerrbGpfLyq2XrIdExJ_Gl0AL8l-i2xeOYTqg>
    <xmx:TWMxau8QIKml0p5FEqOn9Zww5MQJH_81jwk4wgLEa6fnjC24Tpt8bA>
    <xmx:TWMxapn5BB4qw8TLYHZqoP6aihuyYd5ExDyTyF05U__04mvHPNsW8A>
    <xmx:TWMxaqlf6jDZhREne1ZrjwH3IK7NzHk3f7TkumrjCSGNlmvXFnnM81mp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 10:53:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/refs: add "update" subcommand
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-3-9f5219b6109d@pks.im>
	(Patrick Steinhardt's message of "Tue, 16 Jun 2026 10:44:08 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260616-pks-refs-writing-subcommands-v1-3-9f5219b6109d@pks.im>
Date: Tue, 16 Jun 2026 07:52:59 -0700
Message-ID: <xmqqse6m4jw4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>  git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]
> +git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]

"<old-value> vs <new-value>" is good, we should update "delete" to
use "<old-value>" to match.


>  DESCRIPTION
>  -----------
> @@ -58,6 +59,12 @@ delete::
>  	reference is only deleted after verifying that it currently contains
>  	`<oldvalue>`.
>  
> +update::
> +	Update the given reference to point at `<new-value>`. This subcommand
> +	mirrors `git update-ref` (see linkgit:git-update-ref[1]). When
> +	`<old-value>` is given, the reference is only updated after verifying
> +	that it currently contains `<old-value>`.

As to the lack of "create", among the two potential changes, I have
a slight preference for adding "create" and failing "update" that
does not refer to an existing ref.  If we go that route, the
"--create-reflog" option should move to "create", as "update" will
never be used to create a new ref.


> +	if (repo_get_oid_with_flags(repo, argv[1], &newoid,
> +				    GET_OID_SKIP_AMBIGUITY_CHECK))
> +		die(_("invalid new object ID: %s"), argv[1]);
> +	if (argc == 3 &&
> +	    repo_get_oid_with_flags(repo, argv[2], &oldoid,
> +				    GET_OID_SKIP_AMBIGUITY_CHECK))
> +		die(_("invalid old object ID: %s"), argv[2]);

On the "delete" side, these messages quote the object name, i.e.,

			die(_("invalid old object ID: '%s'"), argv[1]);

We should be consistent.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203184;
	b=cqM9s5JcIznhdbf8dAO8is2FNa5CsyvcVm63hpYYr0UzS9l/ydoucDSv6w0LdpeRZB3i
	 54EGJP2XqypAGqyEos6gzQ7cOxl0Paa3EhLuu/yOe5BX3EaZvhJ0VT5s5ms0nnt/3dEax
	 q2fI4840XaBD073n7VUnYRDpjdeJP6WiWZVlEqwsFk0Utt528Stw5YWtBnUj697U8vVch
	 ZRN8w8QpnI8rbp4yKZPInSy5Nu3LtfBv1Tehmj3ztzc9ma5q/Puiyn/gUAE7kHEObHwTu
	 S26IiK0zwssyoOZ90UK4zUkjodagGfD6ZEfh/v4xCtxDkftbDOUtJ339omVhep5bjYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203184;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3587j5sJfHqgZCM2fNXrGV/TGcybPfDziCsANiDi1lI=;
	b=0yABAPvAWQhUkYyKkdPvy0RraS+GpBBl1y3ZDgakCzby0i9ffEk1ikGZX0dS2ObuBt1a
	 Y2mhRnG/wz/cxlOWjOd5eeLu6vxIAZ1eEzk+fVqeJP+D6b+VWX0NpDZeNPd6VaDOAgAFr
	 kXdBeeSfpke+3RsYym4aHdhCr57ia9FA+Hp9MuRmz6OfIxcQqGZRSMcD2uGaEE24VMra5
	 1mVLqwgpagdOow/1G5TPFgLMij3N6A1ZK6rTc4E4cA8m2RwYmysuoMvFaVj/LnnL4/fwt
	 kMDchfzroYotq6xLkOxH6xaeiuqGGYE+YmaM0gnIIphApuwVIHA0wnmJ4sgjp+AOXug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eKr9f7m4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CjKzDOH3;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CC606A6F3
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003CC606A6F3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eKr9f7m4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CjKzDOH3
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 15600EC0B25
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:32:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 14:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795203173; x=1795289573; bh=3587j5sJfH
	qgZCM2fNXrGV/TGcybPfDziCsANiDi1lI=; b=eKr9f7m4SxBkaMXS1k+dxKt81j
	wTV6U3I9QWKr2lY6k2PGCCiNAt3jNIgT0GtktL5VhZz37BoqMn3iWvFH02Gnyis5
	tfRTRQqPTzZMDn9coyXqHCJ7LEvpDPR2D/uCk+lHyOb13rEQ3bd084F6VXx5EzUj
	PBhIRnnOR07SyvBeqa9e+PBcBULuoT1/CN4D56YHeUz3CKZDDG1ZO1CdNA8qs9KY
	42mYqvYqC/VbYW7qdGoSFb8rxkh8x96nBlZgAZzc6azCgJR0dRwZofUpQTZmJ73T
	O6wxsSkqPdeiL+HBekZgliScVwYigarw9UYRAOQ12tr6Kbn9red1MxhlFXNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795203173; x=1795289573; bh=3587j5sJfHqgZCM2fNXrGV/TGcybPfDziCs
	ANiDi1lI=; b=CjKzDOH3DfqDza6Gzqt0/FRDsiAG4UggUnRNoPFPfSiKL1w85Pd
	Pf9oLQi/x58mI2nk0qKtDwdLdlrMeXLb2zqH3g5kWC0giyOlz4xM9OYkqHSyaRY0
	0xbY64OpVFGXRS+Te/QPpSyhc+Yt393USZgJLOignT9G7iP/s7c9/jCEGa9WSyut
	B1gnVc07Czl9gAObiBMaob9qJ1rrj/0u/YhYOYlT/8Ob/NyuvR1sudWnNFax/axa
	L9MHudMfCOFmQcXyiceaZUOJsmfI3mwxr9cpgJHZCFUm705Em+Ne2msKgeLXSdSI
	HvUPSwEDYraevfxYRB1TlT2lhmWcRSV9ecg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795203173; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CJ+tU/Hmz3idSoSRKSnukkGaoWGezA8BgQeVRObZSMBIchK
	yMKPntMSpKaUNj23FK5oLLGa86y6RFcLLfTQ/As4LZunQnB0qFlB5fvqTDMORnBS
	eo69R2MoLmWrS8SGXXYG7fNJUc0jY52PHADSl2fbf4sU+lckGU20xnKvjXhfGvKD
	FytB5Oup7MUtLCIIeWYEPrjEKNf/j6YAz3fYsK6qLoYP/lokUuCojJVMQvGCgN/i
	jJryC0b79VYx8W7pwmF2Dxucy/1YxR1GK3/4vJ+I2aAdKlZFXnFf6LaSS7uGnzjE
	J4j+Z97VSJadnRIYR+7WI51EUbjr3zURJqeItCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WCyNadNLCUE438Wi0Oi7OepfSY/Vy/a+Sd9cBqRTFIc=:mvwuhKWiDXDMb6LeyxSw9Wd0hEB53xmdPJO5gRii5Xw=;
X-ME-Sender: <xms:ZKAAa6Ag9Rd7wGfnQaYkrv5N-PUcv8eH2NBJjdkj8r_KRCueUf4WvA>
    <xme:ZKAAa3GE4nSyf6xhnP4pCCGJUMoeLXTQBiCcT1_LLGLWTr8_V_sEh46uUNNLH08AE
    sabYUo6TqEQT0c_3GSrtHbRvh2UZUcDosTGCU-I4to8c1CibRKN>
X-ME-Received: <xmr:ZKAAaxO_ueRSwlRHtMvW_2edxXpenfyrEbgUXtjtX60QvZawiErc0XRrZMjzMQ7sQITWcV_NX3NWYApCQl2LzkJNZwzdfrTm-MTl>
X-ME-Proxy-Cause: dmFkZTFlQN4pE11kG+sSgaW1tjQ83AR6Q78fucHK1hATlM9eQBDiioOAXwkyxgJ+OU66K6
    zM4+kHJ3j7gtKamFI6w0Gv/TvFNP5cqgW/QM1WWe3CJ3mP9KL2miP9BnsDaxYQL6OYHCUf
    weIiIIANq9Qy8HZPECRUPgxIK13b/OrvagJz5yYRAfptXec9DMZ5AMiPGFYj3GgodWqoBN
    +4Chlx/QkLs48x13EfHT5l34/hxeOiI1ZNb//4K+OTvj7oS8/234Doh75/fssDmJ9fp0W8
    i65GAY2/7+OD8zURsKrhR4fku59BzKFxVVyvSpw9zG/vOfqq2AYef++9ruRkeCBia3DREi
    M/cPTUUHFqm6eQ7O9z3R/zjcIjtQWluZyjTQYg+oKrJ+4w4oAHKYrS1+v8HOaWJK3D6++0
    iFImdY5ricOqp88t9VSGsp+Na9plAv0Ifvdn2pYhnSun6GBYIrUBQBQnh1njQSIG28jwIZ
    RN2n4mYNpz8cAYdbjHKq/O6IETwbbPAJ0p1dm5FNFSdg598gOB4NSkq8j6eLuSFzlUF5MT
    8btNwqM7qK52OK1v+8P1CajO5GT+tFhMpkvvSAH1GFBsaPpU0eoTzeBMHTzU4Q/rkj1+p3
    SH+oeGpTDy+YbDzjroQFIWnHkqRuROLCSyUbQxkmu6cA5WxFzh20MaE8+oMg
X-ME-Proxy: <xmx:ZKAAa44i0vE1OdSX8cb5ODiVcMDTHoNfaW0NeKbOuJun3ID6mHThMQ>
    <xmx:ZKAAa0h67EG9F2RipWClXgjkaxtSMwwkkXoj7KDm3AOd-xacHoXZHg>
    <xmx:ZKAAa9d2jsPeU7RaUYGCIrztOGCDY6Rigli1Yz2AzPwd1UvyKHE44Q>
    <xmx:ZKAAa8y_qAseunpTE8_j1oZXeJNRv5LXQugyagvNKVKouwr6vta-wA>
    <xmx:ZaAAa74Tz2mofL644zDvGGJXhi5Wi9MBYhNB1nH6jw-3_HW2EE1CMkX4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 14:32:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 2/4] branch: let delete_branches() name where a
 branch landed
In-Reply-To: <c4513f9ec1315c34b7a75b95bf50bba59043c274.1795184664.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 20 Nov 2026
	14:24:22 +0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
	<c4513f9ec1315c34b7a75b95bf50bba59043c274.1795184664.git.gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 11:32:51 -0800
Message-ID: <xmqqeccfpacc.fsf@gitster.g>
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

> @@ -357,15 +359,33 @@ static int delete_branches(int argc, const char **argv, int kinds,
>  	for_each_string_list_item(item, &refs_to_delete) {
>  		char *describe_ref = item->util;
>  		char *name = item->string;
> +		struct commit *landed = landed_commits ?
> +			strmap_get(landed_commits, name + branch_name_pos) : NULL;
> +		const char *landed_abbrev = landed ?
> +			repo_find_unique_abbrev(the_repository,
> +						&landed->object.oid,
> +						DEFAULT_ABBREV) : NULL;
> +
>  		if (flags & DELETE_BRANCH_DRY_RUN) {
> -			if (!(flags & DELETE_BRANCH_QUIET))
> +			if (flags & DELETE_BRANCH_QUIET)
> +				;
> +			else if (landed)
> +				printf(_("Would delete branch %s (was %s, landed as %s).\n"),
> +				       name + branch_name_pos, describe_ref,
> +				       landed_abbrev);
> +			else
>  				printf(remote_branch
>  					? _("Would delete remote-tracking branch %s (was %s).\n")
>  					: _("Would delete branch %s (was %s).\n"),
>  					name + branch_name_pos, describe_ref);

The use of an empty "if" statement body is a clean way to express
that nothing will be emitted under "--quiet" without making the code
too deeply nested.  Nicely done.

This is not a new issue, but this makes me wonder if giving the
"--dry-run" and the "--quiet" options together makes sense.  Would
users really gain much information from "--quiet" when they are so
paranoid as to want a preview of what would happen with "--dry-run"?

>  		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
>  			char *refname = name + branch_name_pos;
> -			if (!(flags & DELETE_BRANCH_QUIET))
> +			if (flags & DELETE_BRANCH_QUIET)
> +				;
> +			else if (landed)
> +				printf(_("Deleted branch %s (was %s, landed as %s).\n"),
> +				       refname, describe_ref, landed_abbrev);
> +			else
>  				printf(remote_branch
>  					? _("Deleted remote-tracking branch %s (was %s).\n")
>  					: _("Deleted branch %s (was %s).\n"),

Likewise.

I wonder if it makes the code structure cleaner to follow if we swap
the order of checks between "are we doing dry-run" (which is on the
outside in the current code structure) and "what is the reason we
remove this branch" (which is the inner if/elseif cascade) by having
these different message templates (currently a pair of three-message
sets) in an array and choosing which set to use based on
"--dry-run".  There are of course a few things that are done only in
the non-dry-run mode (like removing the branch configuration and the
branch itself).  In other words, a code structure like this

	const char *msg_templates[2][3] = {
		{ "Would delete branch %s ...", ..., ..., },
		{ "Deleted branch %s ...", ..., ..., },
	};
	const char *use_msg[3] = msg_templates[!dry_run];

	for-each-branch-to-be-deleted {
		compute if branch has landed;
		if (quiet)
			;
		else if (landed)
			printf(_(use_msg[0]), ...);
		else if (remote_branch)
			printf(_(use_msg[1]), ...);
		else
			printf(_(use_msg[2]), ...);
		if (!dry_run)
			remove branch and its configuration;
		else
			what is only done in dry-run mode (if exists)
	}
		
may make it easier to follow for readers?

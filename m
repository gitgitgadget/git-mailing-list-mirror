Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930355;
	b=yQIavmDpp9105ICrE6BJ0SvrG0UnlfNrfABVTDMlf6mfmG61nvoxCEl36USQCsw+kyaY
	 uD2tMSyBFhhO06PUc6mU2uDqfbmUTazskcoRayM2EM71C5YGcJI4BpRyYHWyS1XHn2S/M
	 6rwmpCSRITBn0JUds3dR10UXp54IrOnK2BIrNhAghUTUCUh10997BA32XGjoClNsRjZxs
	 bJb84f9SSj7ZpIyQ1oJ7yBlitrKD83F1i+RKajHJ2hrjK3SzOP0fTElPCUPhpmmk1+r+m
	 xRkTNHEwKTmPiu+NMmhpcfsaxdBnom8PO24cZeKVa/9U/ySygQWczRgrVhNPDoZrsiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930355;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3CfqpYgSUfmwuVTu0vt59b3591md00PYy9Ua7Kz4aPA=;
	b=Q08y5M+uUsHWNBkU45no1GBW0lrxjnVeukx6PjMGoXol3sZDr1EOAWXMyahnEW9sVz75
	 ZlhZZW/wGmhOFBkWZjbxgum5brnALgW3CdCdmkKiwP0xvtGpswqHLI2NYUMlCpiTc+8Pr
	 M+oxDqRBxpN5TFyB0thlVNOJVsOSFSWNKSZq598TSTWBX/wD1gIGJnf4/rvjV8AdMK+zS
	 f4VYSGdUfeRa54NC84tQ//YNkL1aDzpvU/shgoeGvR0ZoDrqGdcsG4Arw002J/edLR9he
	 6nm/MR2UJfBNa4fhD62mI93rv8TpqH8CrXhmd+VPzxGhiGBA7cn5LkvIw9dbcpu6nTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jrSqZWj3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xnBrdzoR;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C68606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 01:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C68606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jrSqZWj3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xnBrdzoR
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 35CA4EC0247
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:59:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 05 Nov 2026 20:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793930354; x=1794016754; bh=3CfqpYgSUf
	mwuVTu0vt59b3591md00PYy9Ua7Kz4aPA=; b=jrSqZWj3xnq3arGPXk/KC5AMK+
	kWiw9M85v/lYfsz4UeQhQTrY7bQ519rkBK3CUOV1ld5va4z2VQsIDioaVc/hZUOL
	DAXjmRj4AU722QsQjJ6jvUE3Y+ppCW8up8pXdlZnE8zQdcs/4vQGB94MfU+WdVat
	OdKk8gzgVcUgn08kaGaZTrJBZiYmMSvdhbHEwvkLz/bHE+9Tb0fovfKkEfQacKFj
	eiNTGON4yh5TA5/pQotsSbRYXsA1Z0m26iq+JvyVEw+gprgtGQgj1dowPh9iRc4j
	UXMLDNX+5vgcWRdFqL/Xafvr0zAAaZ+M/n9/hVrr1QI253VeH/qUqldmCt/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793930354; x=1794016754; bh=3CfqpYgSUfmwuVTu0vt59b3591md00PYy9U
	a7Kz4aPA=; b=xnBrdzoReEVzfrYauyoPl4m72FrMtuxCXVDTBjnMhXK19L6mIVZ
	lSJRptVT4jh0bAYpoXfIs8vIWB0NHM5MoiRL0Bfx8U0AR+d8zw9ZA1EX1byNFhaj
	0PRX3/hZ7L3zhokw0SthT+WlrLp6mTrj9LnbJry2leNxTdz4PT4EkVEYbiDsK3N5
	xXkyQHneRYTQE/Twmy6Y7Jb6RUjEMoVBNsgUKNHSbLI/2kc4W5Gyu38+aSEdbw8j
	h0181HFYkK9c73iSRNSW9/KeuwgOU0lFSD+XsQoFpYz4+A9TlilcHmBewljnM6pB
	ZmIxCEG9hSaJj3Hs79ZqB86DTI7oRNOQZiQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793930354; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RHQ1JNsZ3rr2FM+Yx8gYDeKrH4p2doFZlMkzEevYS6RtLj1
	NpbH07xqF7UK40PPsCyAcK1cFKjIo6S0HrhlRmU0u/XYJ2eCFz4fqRzqDSR30JEv
	19WnwjJYutOgJ3z/Y+ZQkkULZtWkoXAUmzNQGy8KS4hwnXZ0iMkqFG8x4uKcBk4d
	We9vfqYT48WR712N5emfkjvX12VB8I2xhyM1Ro9vmsDng2GQsep/F7iS4+VKnsWO
	4jTnm2kNAU6mKm9605QlmOGxMA00B9dv/BWABkw6IY7d/YWDRpM+nwBUTHPntJPZ
	9v24m2+IqFibU8wITN1DI4txOGowSvtdG9XnQSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FCtziixpJ2GKjviv+5b24OMMTbcV3H3eAEuZWNU1hlI=:BzK+69ERsgewMh71ASChbMOr+TL96aeGygi8AEbYuxo=;
X-ME-Sender: <xms:cjTtaihdkRLaT6ed6uwzcnVuMuM5yjWExllfMl1lnfMEeCIqGBh_nw>
    <xme:cjTtaqBapXV2KFUFfjmITEbwqwdxMzFuSsCNyRIUdFft1WiiENGMR8kWQjYr0t9Ui
    KIRd1jS_-lCZevTEkD9sw1xCrk4AEAMXSc7--hEPd4_Qbp2VWTcAK4>
X-ME-Received: <xmr:cjTtavFjPWCZDwJpL_MCPoZF-plAr2T1vPRrpiy2bSttnln5N3jsoJtUGRx2zL3gV8HGycPveIe71X6z5gHC4ziY_iPpvLB-fOZ8>
X-ME-Proxy-Cause: dmFkZTFD/s9ZMqCX9WfG+fUiuCbGFInNxCJ1zodhGCVcpr35XYxa5LUd8xxOFbjXPNY5M/
    rIxlsMy+sOLocf/w6dq4fYwzuYpo40jx7RCrNlLV/my0g0UVyz0OYZS8E5SLaamt6kel0C
    Tg4leAyrVik+MN5eep3nclJBCcOZnUYHKXJueN2syTi5503Fpf3S9m5AcilE3LOSweoa1Q
    W8sZhPWZ5x8Zj5bOWgnwdJqLIZZYoxzeYo76TreCpaw2SALmeivqNJUb8kgQxMxad8r09u
    QQi7FR45GXPKmj4f7maZbr6CiSJ9R7ir0febr0bG7B6Ce8nUa8B5LufKT5tYba9EhyWvWS
    r1lsLf7EEEELmh92lSAGX8GFlVb5cZR40Zw8sqZur8G7FNQn9eDMHIsRTPnANmjtu3nwLW
    IBnRHlEAWUnpvACj2OlO6ph7Fdimz5F+YKpf2TvKiddrpI1/lUkmxi3PsS/C0fK2vjllso
    RcvAKiS+X+3TnYsQL6XBansygyW8HSB1jYd/bhYyNfsDALysCsf3DIB/li0L93tQuvoYhp
    +AcF4nSSSx8p785hy76l3hbXOPa+0OI/vl1HXblQ2drOKLGgq9y7bsAI6X+0bDWtNK1AtP
    AyFX3W7hNB8MvxGOV8CVLfzQE8gpZIPyaU+LpcYJZ5NOb3Dajb5rHioFTE0w
X-ME-Proxy: <xmx:cjTtaqIhOhtoY3zNBx7c4PdmHpyPPLkil2gOAUy5aqr-MkR-ZWswYQ>
    <xmx:cjTtarkTkfxYxD4jJA6p4FjyAAtLjld3vfXzyecm6Ydk6gUyBwoQrQ>
    <xmx:cjTtaqTpn8ypxmTqOPQDQCa_giFvHMEaGRLua_QAjM60QwZt2uSCaw>
    <xmx:cjTtalLmGu_HgyLvWVgFF8kedgsL6LE8_dK2OEcF6jMKK-YB75RpGQ>
    <xmx:cjTtapkYkA_s-UXSo5z3HljGU15C1jSa_Z2BSQ1iNAa6v8LKs-4_qEuq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 20:59:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v4 7/7] stash: simplify reset_tree() function signature
In-Reply-To: <f61ebbf9a3e1196dea36e5fbcf4294c6addad222.1792767795.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 23 Oct 2026 16:03:35 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1792767794.git.phillip.wood@dunelm.org.uk>
	<f61ebbf9a3e1196dea36e5fbcf4294c6addad222.1792767795.git.phillip.wood@dunelm.org.uk>
Date: Thu, 05 Nov 2026 17:59:12 -0800
Message-ID: <xmqqo6c2oh3j.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> There is only one caller and it does not want to update the worktree or
> reset the index so remove those unused parameters.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/stash.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Ah, an obvious simplification.  Very nice.

>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index f97cd4771a5..f0e3053ab49 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -332,7 +332,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix,
>  	return do_clear_stash();
>  }
>  
> -static int reset_tree(struct object_id *i_tree, int update, int reset)
> +static int reset_tree(struct object_id *i_tree)
>  {
>  	int nr_trees = 1;
>  	struct unpack_trees_options opts;
> @@ -358,10 +358,6 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  	opts.src_index = the_repository->index;
>  	opts.dst_index = the_repository->index;
>  	opts.merge = 1;
> -	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
> -	opts.update = update;
> -	if (update)
> -		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
>  	opts.fn = oneway_merge;
>  
>  	if (unpack_trees(nr_trees, t, &opts))
> @@ -738,7 +734,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
>  	}
>  
>  	if (has_index) {
> -		if (reset_tree(&index_tree, 0, 0))
> +		if (reset_tree(&index_tree))
>  			ret = -1;
>  	} else {
>  		unstage_changes_unless_new(&c_tree);

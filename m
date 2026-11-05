Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905520;
	b=t8ObXVW9sx21Td8f9899L3vJ8WgltK0AZ4svDbgVUymoBIIWitEY8zMe/CawipXp5fSm
	 VJnK7sDlU36fF8kBFTH2lMbbswEV50ek+04ZojHO0pt5pgjNVooayKjiIPikZyyx8ACdK
	 jbcha5xftSPKkJGN7S+qkQpBCA9Wzher7nee4cuBTxz+MxAdX5LJjzyIzOyLo7VvLuRPx
	 46v46ydm8FpwSki+ior+/r1l+oQmic1x1lO8fTxGijCBav4GdMWwlvUbmw3yzTMOdohDT
	 GRHG6ZUALbxOC7yW03n6LaOj3FZP+yZJF8hyEUbf/7xICiAiVMglPhYKQinyfgcqMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905520;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=33lKedb9fsKFryM6o2EGVd4yFAXzb97LRWOKdCqOkZA=;
	b=ARYfYChvHGnvJk1cFpX8JuhDLg0tyDVULP6uRfQgLt8wgIBhOw7xAuHwDMUoWNCH7tZi
	 KOp1X07gaz5bBYG1ZweXqZepWG07712i0i6EZPVwaXU47yY+5rghsf4T1eGsAbMc6H3KE
	 01UThRnolTTr+aLA/WgLXE4GbRGAh5XpMCOcV3Aj1flMzWCIavednejtowaMwMatnTZIX
	 qXMjZTdD/rPcqOjpC//tA9sXhETJYHlFKx0qpx+cm1r2FdDkkypLoLyceZDKUC1zQJ4XF
	 imdMLuFmlIASSNTDEEUNQEbXAYkDCBkbFtdAUS24fwaaBmm2XDUbyo/wutw43xfjwpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Amd9OJl0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uqE6gx20;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C11606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C11606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Amd9OJl0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uqE6gx20
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C0BA14000F4
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:05:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 05 Nov 2026 14:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793905519; x=1793991919; bh=33lKedb9fs
	KFryM6o2EGVd4yFAXzb97LRWOKdCqOkZA=; b=Amd9OJl0TtyaT2GmbwzsLhVqUf
	44mz/aKJZsU/aBZJkLLnxK+kW695c6CkPxQoS9imp/Gr/mCw41nY9j+X9qWZomn7
	h7+J9UBqEFwtrSsY6Rt4IkT02N9dgPzcmR6foIpkDk2964brN8v29dGY01eT8zvC
	1Bm/cl/uIyh/XRzd+HwUX6fXQ3aIUKV8H+JVHkL0lluxUL4+KBZLWUnlYIQQWNw8
	3FUnsX+4wGYiV+56AVkmVkKQLcsI7SV9dqF8JE69NXbglUiPL9/cHAQ9g561aYXm
	8hg0tE19Z3drPRCAQ1eRIEz0hpVk8nYLw0QtlP+umyi0yNjPB4OKSk9inQXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793905519; x=1793991919; bh=33lKedb9fsKFryM6o2EGVd4yFAXzb97LRWO
	KdCqOkZA=; b=uqE6gx20z6cZyyDVSSW9yyWMc7V6OoHMSeZbcHQh+fHsDy/IGk7
	JHlLNKba63QoTbKSeeqHQDepW4dgj4Zie0/f1Z4jPVZtHIRNZ+qgBff/4uSdUSzl
	venEfcFeKydlWxQzwJwpsoAq0AWgNMgCygAtlCVEaCx9Z2k9/bJqfFzLZgtMgnr6
	e5AzNU60koIgWMdKCnH9PwUjJNCxYbg8rsOZGh7RL6stoeHXrMEru9yAY+/r8Kdg
	fm6Mcu36ukfJ33G/tywzNI78o2TPv9p6XOcJ4TEMcYAzcb3muoQ2wB19XifdPBOs
	YOHvR3AO1d0VLVywc4uylNTST9/YNLJCMPQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793905519; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:b9Zb4bOVM6DK44FwnIfLX/4EjRY8Iv+0svpHt6/Rve4SA5/
	0zmCdMf06wOS8M7Pu7Ocvn4GGtxcLcFnc6VlMKRgkwiLvpWt3Ks3aq6sj3/8GvwP
	WlTl8R5lD2Kij2RSi5HcQCLjeJujNtiPf9emmSXrbLdrnrYXu1PimqIa4D0fCUK7
	Txg3fzTPOcop+Houwa1X0Vh0vGgKtMQpgbqrNIfCOSgLiM42Rem6GY07OcvBbKHs
	TIYuhs854Z0Ru0aTmXFuUDR7MXt25nwf/4FUBJDEIRIShwY5YdYUjraClWsvKYGt
	9jqPi6YTVW7izdUUU3lop4lc2/LglusA7hxvA4g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aXJxluP7O2HYaM+qaejrc9A7aG69ujyLqzg2wK7S5aE=:AaaO3+tBo0Tx756H07rJGOp0rCd/A2GxNlE9UvnQUI8=;
X-ME-Sender: <xms:b9PsakPq0J2zTcrtZ1cOnJp_vots9d3DIfyGJRlYtqKrQeukpv85Tw>
    <xme:b9PsaqDrmIKaCIQyouFyjXdw9UbFTllhgM7QwdGxNI7p2Ixl9VS7NhwYRjd62BdJw
    aR4GmiOcVY_oYOrDrVNoglucJCQEYE55AjEGIBGsGW1dRuePdZGmQ>
X-ME-Received: <xmr:b9PsahfR2ok5j6yD4sFVDsyIbPMJC25JMwJZhppWLXU5xZ56aetGj_oaikXIIakaAKlBd5jFsgTTxU_WS9nIjNYTOWC-At_ngUh->
X-ME-Proxy-Cause: dmFkZTEhRkal4k+srmKy7mePfW+itKMXqeUrZ1Ny4opXsa5u6h5JqGGrSj0BDQGjKf0zNB
    vf68syLO3eTPAd2LqwG+i7TlOk6k1MZK/8wu1bDZW03Jswf2JGYp9bGuTVJTivcjICys7L
    v9mEPHwa7skBdKDf2RMajz2kxEr11fJ7L1mQ5s+GkX4puJeGcqTb9b70bLSVgo5XeHLBrN
    wRmCUfGGmZdTxb+BlWrxvU+4LaJAzCJCcx93GlceL6vKvqgLWSR+SCXVEakPtrcuk5qWZO
    gK69s4aBcRbjuAMnT5GgXvDAXPj1mjynEJIJ0jldsPkz7Z4776ilFkkFxZavpKF6b6AbPQ
    wnMv2Y9F/O6FbE85DrdntJ38Bg1sgujkE5PQPS01EEYElytAq4KIBdot0j0Uqr/S+N8IEv
    jLkeMhE5XwvFx0RS2iAlYGtl8AF8RpoUCBfNgKwDbgG8uC/569G2BpybRzdIJunTpEmWGg
    k14XUPpyToG/+jM8mcg6ER8GT6mmYbKqsFtks7nUGunwYRmnF+mPZ9rjcHmNBeanMu54qB
    65BHggX2/Ct6cVvEv23mEskY4naeN3soBhyhdv1MV1iZRfM6O2MBuBeFHo6WdbIdBPnySG
    1nEZRJZmMFgjuCPJ27Z6C616cqj+qOXNx/rq53R4st6w3uX97lUrF+CMaspQ
X-ME-Proxy: <xmx:b9PsapPOInJapV4PfxG5ysnniFHtWDnbm2cVq0kVe5vQaqB8l9GZ9g>
    <xmx:b9PsahKVLPAcmjDD-RPPPMmBTiOagdbeOnPuSxEK8eN1XvHEGpE0eg>
    <xmx:b9PsapKiOTq4xEaeV3IRWmeEul0VtlZnuY9wdm7lpNS4h0eQfCQxjg>
    <xmx:b9Psar609I96IV8iANmv_OEHHmo2NZ5ltzMKFc9rFzQiV_hlQyQytg>
    <xmx:b9Psaru0WIMsqQyWxcpKFkNpUkLkJky1hNIkz0KbeJOCimVrlpQIBM9e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:05:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH] annotate: pass the arguments to blame unchanged
In-Reply-To: <20261105073101.1449292-1-tangajoris@gmail.com> (Tanga Joris's
	message of "Thu, 5 Nov 2026 10:31:01 +0300")
References: <20261105073101.1449292-1-tangajoris@gmail.com>
Date: Thu, 05 Nov 2026 11:05:18 -0800
Message-ID: <xmqq33tfumj5.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

> cmd_annotate() puts "-c" in front of the user's arguments before
> calling cmd_blame(), so "--git-completion-helper" is no longer the
> lone argument that parse-options looks for. It falls through to the
> diff option parser, which answers it. So "git annotate --<TAB>"
> offers the options of "git diff" instead of annotate's own. There is
> no --porcelain, while "git blame --<TAB>" offers it.

Makes sense.

>  builtin/annotate.c            | 22 +---------------------
>  t/t8003-blame-corner-cases.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/annotate.c b/builtin/annotate.c
> index 7f754f2309..c1f258993d 100644
> --- a/builtin/annotate.c
> +++ b/builtin/annotate.c
> @@ -6,31 +6,11 @@
>  
>  #include "git-compat-util.h"
>  #include "builtin.h"
> -#include "strvec.h"
>  
>  int cmd_annotate(int argc,
>  		 const char **argv,
>  		 const char *prefix,
>  		 struct repository *repo)
>  {
> -	struct strvec args = STRVEC_INIT;
> -	const char **args_copy;
> -	int ret;
> -
> -	strvec_pushl(&args, "annotate", "-c", NULL);
> -	for (int i = 1; i < argc; i++)
> -		strvec_push(&args, argv[i]);
> -
> -	/*
> -	 * `cmd_blame()` ends up modifying the array, which causes memory leaks
> -	 * if we didn't copy the array here.
> -	 */
> -	CALLOC_ARRAY(args_copy, args.nr + 1);
> -	COPY_ARRAY(args_copy, args.v, args.nr);
> -
> -	ret = cmd_blame(args.nr, args_copy, prefix, repo);
> -
> -	strvec_clear(&args);
> -	free(args_copy);
> -	return ret;
> +	return cmd_blame(argc, argv, prefix, repo);
>  }

Nice simplification.

> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index 30e7960ace..6824f33332 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -303,4 +303,14 @@ test_expect_success 'blame does not coalesce non-adjacent result lines' '
>  	test_cmp expect actual
>  '
>  
> +for opt in --git-completion-helper --git-completion-helper-all
> +do
> +	test_expect_success "annotate $opt offers the same options as blame" '

Making "annotate" trigger completion-helper is a great goal.  "git
help annotate" does show the same set of options as "blame", so it
is in line with what the commands actually support.

Looking good.  Thanks.

> +		git blame $opt >expect &&
> +		git annotate $opt >actual &&
> +		test_grep -e "--porcelain" actual &&
> +		test_cmp expect actual
> +	'
> +done
> +
>  test_done
>
> base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05

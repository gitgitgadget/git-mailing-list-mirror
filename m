Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049609;
	b=eTeD40DX9QyTv+MIy2avd1caGfIPd9U2IbGt5rOI3qaXxL3URuBDZbmdThAD6g5AO6iJ
	 g16qC+XfbfVbdcdxnLTbGTM3mRdnH6KKWP/NWDK5I05d2JnxVOejDZNo2cxnZKPzNOfe3
	 oowX/JN6r/f9S3bvaegf9zcofX+3pdckftk9tiAouCJMfRITc7EbtsfQUZn5o93wofXEb
	 hnxzshqrXWLBem6DE7WrH1DdKY0hs85qTY8zqMdNUjAqYmUNjJLneOUkjM2J9XN5VSz+/
	 bApeIYF/uHbIOMg6bg8aVRAPNoZouuGdB/ScAQIMyTZBWFwSj93QiixwSgxGSft1iog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049609;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=v+bvwISnztWZqlgdJYvsRS2K9UW0GCi5yrQJqIg9EZ4=;
	b=BIbnX/r7HGFAwYEk+eaZZ+g86esbWBEgJBdXo607B4XiAVlGRcxwNBsuznZ9wzPxa32o
	 xcbXQe0Oj4/guYMieunurOeEzRDKYLtkmno0UQ63KQzEjtZ5rYPfTYtmMuenMHCKAwHAa
	 tOJuQD3M97iy9hEgKjdFyE1GjEWI/MkPAUcoeV8OzTyElJz2c7TghJ1D89WMihUMRyoyH
	 Q/Hnc+GBjmE0xkNljHcEbAarXVjVq2l3vtVFFZoQBrgsoLWOnoczQ3VO744tcQtbgk/AX
	 0l43mVZH42htkzh0DBi/FBQHpKaF5F25KENZqocicQaa7asJWGhAA04nYV6mZzAMUTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZnwxZkk7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rZWP2zqm;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B07E606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B07E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZnwxZkk7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rZWP2zqm
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C99F1400A17
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:20:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 17:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793049608; x=1793136008; bh=v+bvwISnzt
	WZqlgdJYvsRS2K9UW0GCi5yrQJqIg9EZ4=; b=ZnwxZkk7blw/tJvOIwXlilIR7C
	89vxvMVhBGoGPTfE19hEt0kXzKumIDDyhU3CtQnbw2YIxehjYCkBkyp7excrV/pu
	RItZHkXwAp6qHENmYrFWGw/KW9hcZUhrHtjz3rVczbL3T41ZlXm18m6w5GqUqscO
	7le0HjN4DK9IUv5CjQ4lDkU9F2kFXueceGDNK/4p8IEYBGU86XpWo0hdp1WjGUwj
	MsDSMQIVarH9EIDNc/YwkQkM2pESO57NuAsExthiqcf2P/2gpbdaQN1SHV/TZTIi
	pwB2fou7fDkLKRkjrinI16tY89S+eeyDR+D+sq5yWWFJZJLNsmYslZi+4sjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793049608; x=1793136008; bh=v+bvwISnztWZqlgdJYvsRS2K9UW0GCi5yrQ
	JqIg9EZ4=; b=rZWP2zqmn2LxTrBEbsZTzYPPL6J5FQ6qLa4XLnHuPeT+IvWtyYx
	JaMTbTeWYF11WyPt1hYPzx3QaR8sSc5ApPPY3RTCyPfglfPHRoxUBN9Mxixndkot
	6Av5RsQfZJz28C1txJnhD3TgOe2b4GIM45ZApmollGvYS7YqQmt5vKY70z86wRaq
	rqVv2a4KGU5dKbukiNlGZKtImyaWJ7zTfDN5Uu1yQxzsJcW6G+EXugFfkalwWv6r
	FpzQlJvmovuWVcnTW9I7dxDqfdQOUilZHxygwk1cjLI/brYJi+9lwmmfwFHyeHtA
	+vt3VRnfxdYFNsrPuaIwDoVYKwmCA7LYxmw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793049608; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:khDEnsZNRh3XpzkK0JOrC5eaKxajLn8tJxeqQK8Q0JmtDn6
	RRHlImNstCzMl1TCpR96i2EmbQM8pfyAN0Pr5RTiyT6uPTLP3Z1RMjeqGqwtKjX0
	fmedxXVsjb7p6pEzllHlQ1l3I3HpCN/23d+xS8CKewUDTRwm4caOpbvc40Chy7k5
	u0BVECGTb4pC0D687JaWxqfngBj4ma1VeQOoahEe2v3kQKk34+Qaej/Bnk/x8Fzs
	LAXbr+s0fyvT0cgJHcsyFKEUjp5PNA6m/f39aj0hV5lMwdwbxaM7v3TEBFz8bZS9
	GjSN01VEkrrcxxsS5RiEAi3fSnh+jFaoDvoasHw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JBAARFAQmpKpEm/Y/bByzuUj0Wqy/37NuL2WAc5525Q=:Px5ztqdNyZmDH+gLTBPF72/97HlEspO4HzK9dQqR8/Q=;
X-ME-Sender: <xms:CMTfaptVc16I4-MqL5qyH1LuPomJ9iWvS4iGkMdB5PbvrqlHl7RSxQ>
    <xme:CMTfap6sutxkvdhxhqjA8kVGNfOH8FuGp7nS1ju6a4dOdwGemrMDIQcz3qHrztu8-
    Re4qRu1djYERRbTIJ9Ts5jiV8thbUeh14dNZ1iQ1IW6K2gUNKJsXg>
X-ME-Received: <xmr:CMTfaqJ7twxsx4N_EfP372hda1zGuoiemKtmw5BkC-hAHdFc0eqr5CEful11tReImaUbW2LGxIeHZDC8TL0W8IQ7NukNrKvvJEBN>
X-ME-Proxy-Cause: dmFkZTFs9s9Z/dUL4h+2HOPNE66JbmdkeitZhms43/ZkL73L2CQLzNk4QmILxBY5Ptfd1e
    k9MS++jAjEa2iatbXR2/QDBpkGB08tVTLKY5RtOojFwTP9q/stvFAPePeeLituLtsgFhqS
    PA5zoKzFqkcxLS0Xr3cWwwNPlyZ6dHSVL3mqN7PZbJzBE9Ta2RoZypsFfzkUwKByU15KrV
    wQ7vGB0vLuEPNT1ol9V1XZ6z+cvyyPBqz8nW+GnoaSYwtaP7iOkfkRr0WkeZ8dnG1lTtV1
    GBqmp0KHuhFdky5JlTAdwHdRbIdw7Q2z2/mjDRvGit7tIx8jw9g5khGX6x7ukSZSaMYoSw
    BrY0epe/F3b1AqlNxmAJXJJkw/QE4lREcLeo4fF4vKJloJVnKWkOj/C0bzgRo73QfewFLF
    mW/jZWoiwnOb5BUCrjAnV+C1LYRp2T0G6ejYVuvHR5Av0c9Co5hr0CN426OjyQj7S8CO58
    K6lvbQ2grX6gbqRIeLaNHXahwYb/RhNQkOD2Aepq5fDr+EEPvEJc2f4Xk/NjlaysxRFIqV
    A051lI3fSA/hNqHzyelzycmhANdgo/BABN6JP2j9ECx11aZdabOPBv1Fr6J1z9WJetwton
    DV07LkXOrmXZ/gw+DrtArzjYMAnIwmmlcN/aP3W0g1kyktcNwhccuOcRC53g
X-ME-Proxy: <xmx:CMTfap6zVaE82hbMmbiVxwUKjxSgbWo1mFkOhBcnqeGjaMD4j9lo0g>
    <xmx:CMTfatzp5rRLpvjsJhnLr3-KlMghXWP4RQwq5PMTEgFSUWXQXh026g>
    <xmx:CMTfata7zuXwItUPE8KnCH0-mEqc-4MJZ47NLal8UE7L51jOE4Hs8g>
    <xmx:CMTfavRH48DMLnU9OyEpqHMUh57Rqriua6faYG-vJjtPy0PNag6WjA>
    <xmx:CMTfal4I5dY9Vw_yoA6T7p8afGf6-fEHv77i_Bwrc3nNJmWi_WddumfA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 17:20:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tilak Kumar <raaztilak07@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t7104: use test_path_is_file instead of test -f
In-Reply-To: <20261026164536.50520-1-raaztilak07@gmail.com> (Tilak Kumar's
	message of "Mon, 26 Oct 2026 22:15:36 +0530")
References: <20261026164536.50520-1-raaztilak07@gmail.com>
Date: Mon, 26 Oct 2026 14:20:06 -0700
Message-ID: <xmqq7bj4p3ax.fsf@gitster.g>
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

Tilak Kumar <raaztilak07@gmail.com> writes:

> Use the helper so that a missing file is reported
> with a clear message instead of a silent failure.

This makes sense but what is GSoC doing in the patch title?  Has the
program already been announced for 2027?

> Signed-off-by: Tilak Kumar <raaztilak07@gmail.com>
> ---
>  t/t7104-reset-hard.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
> index c23d6e3f52..acf145e69b 100755
> --- a/t/t7104-reset-hard.sh
> +++ b/t/t7104-reset-hard.sh
> @@ -29,7 +29,7 @@ test_expect_success 'reset --hard should restore unmerged ones' '
>  
>  	git reset --hard &&
>  	git ls-files --error-unmatch before/1 before/2 hello later/3 &&
> -	test -f hello
> +	test_path_is_file hello
>  
>  '

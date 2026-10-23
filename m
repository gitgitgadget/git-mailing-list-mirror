Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775189;
	b=h/YCbTL/Ci36SZYcz34Bv0jWZrJ5DZs2V0ZT/DZ/iuec2j6orx00grWxnFDroN831g72
	 raFQfwBL0IzDnE46vj6dqsAkGg2vLdeEixsUckNDby6NYiynp4D+CYVqjqL3pXke+rbeE
	 D9UJEQnyol8PkHHZuk3mW0X0Q84qJaxqcOGxM4wMA13hW4oPB7RuHXqPdSaT7xKyC8n5I
	 Wt52aUl9AeefBg7JUDeRCf/13okaR+L8iPo902jEBtBhf5DoEdc1F0kMmcj6Tmo5Ru6We
	 DXIrONiJR9QsiUx57NZQozDbCFQshvcdTCRTbMYbSthC5PPHnnSq49Tt0DymIu6tBVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775189;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=CFBG9oXOmfQ18P18xvKMKwwk63F8JGVHVSFSA0se6oI=;
	b=H+LtZI1T3U06nHGr/pFIumSnHOPAasLyZ4YWAX8XGWsLw3FbwvmkUtidVpkhUILOEIJj
	 EzSz+MmxLv0IRQqkezVbCGfKBu2tktWMvu3XBAuC515EPO4SYLNAf8LpgaRWivHbr5mIp
	 qdMQ7FAN7cic75Gx0LBDZfgquKhgrSmXVGRLSchZteglc2Q55+O8tu8Fy5eBjpwHKKlbf
	 qjAfJa5Br2f4Drl2dBWL5aaOPnkXPVwMikfww61om/qdxxwoQXSGb8i9LMsRDnNWi7J2c
	 gOEq25KKve3PqocxIIj1ULT890qwL7wqyGvwP1nUvcEnJ8GYppwclgbkn0usdmL6Ofw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=h4iiVHeX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=igdXQZPf;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382E606A325
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3382E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=h4iiVHeX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=igdXQZPf
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83FD11400144
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:06:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 13:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792775188; x=1792861588; bh=CFBG9oXOmf
	Q18P18xvKMKwwk63F8JGVHVSFSA0se6oI=; b=h4iiVHeXdYQa/yz4oYxQHMqjEb
	A1fbAUa4Ka5hI/tGbekAgUpPuVvyT0UwV64C7cyFDeeBRjKKeOqFnV9BxMrNevTK
	0UG2LNWHOx1ieDTlu/N3jjgmzGTEAHGjJZ6XZXILsC38Bk1euJRwjRXQdQtsUWHg
	Y48s/5ye8u2ZX+Z4XRyhv11I2wjjRDPw3yyNnr7TRW/DeCP2dzRVjC1J4MObS6lr
	boz+BRuWD4LdEi992jzcQdj/h8nKqD3WnVQ20xe3pXDRyGW0mhZW4Luz+/MkzYs9
	5fodLxP7mcmbcq2Ug1drA9v+pM3bn/n2fTtU5tm7DmvzwV2l5uEL2FWxaATg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792775188; x=1792861588; bh=CFBG9oXOmfQ18P18xvKMKwwk63F8JGVHVSF
	SA0se6oI=; b=igdXQZPflf2O8N+X4TjoxfuzttOcB0GGB0JYjDU/wnlPpczdxJS
	u1TMYqHZZpbPEh9spjRctadFwLbCBbqUnnv8yQ0l3QbTa8g8rSIbdF0OEdJzo9/4
	hnHM62bQkDNQKdw5u7a/QaXC7yjhet13NeoUY2N4P6tkvbsnh/JVhQfpWR6UN/fR
	jFnx6654Ds4oNw1hy5xK6zovuAxHrKdZpHmYsawLJAVLOVEAzJf9MM15LLPTN15V
	MZHGI05dZ0CVuuWk8oAYsO0odt4PcPjD5mtpoZ04EaLlhxwcjrVPetSdiieNdfIT
	mBUUFCU9K0LiD3UQ8mb0Di7hxdq50GPBtjw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792775188; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DM+DmVAuwYnMAihfxQnwhNMpaaYG9uV05mO5QYm7T7r4MNG
	aq4gCpNZkgMP2axhBdbEzMN6phPO0UT9Olo5uD5ReMAAix5b5Rm2XgrJJoTYnM/n
	gS0DSjbZySpb6zpZRg0uxUEsY9vb6IQfblc4HfyVoO0f/pdWob2laCZG9Ow9x2vd
	BfrXFCfs9iXeveJd7d5SixtaIdLhdnzKNV+dnAYv+6kVd39Kwy7x0sXtMPIvuh+m
	8VZJU3iff9wASlgQIOG495pjxkDYx8k7cs7K2DxPo3vnW1z8zC3yBuLpsZeZM1XG
	V0Mg0Q6sTlFLO4DD8iG2B43l2hjvMAIRdzrJb9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ma5K9luXopQcE/bS0HclUHjnoE1HpZyYSSPUsRle57c=:YxkVxdc5nXukwQJWFislq9iAALN/6bX2nO9RYvFNRYU=;
X-ME-Sender: <xms:FJTbao7BEowxoXvyGuM-74qG6oE1J-wVssghGxe0YdNuqTfsLhVtmA>
    <xme:FJTbagzk9isTVT396-t-im_Ei8dNDz0ehZrBDXaBynB8MKAJZwyV9pv3IOmuh1RuI
    WMxuFJlgX06TY5W8-zUxz4NHPeGQzls6yBVTr4e7J06PM2bwrSndg>
X-ME-Received: <xmr:FJTbavxzJM9SQ67SmSsSz9HBZE8jBSXSe6u1HuPNvxh5KahKcQhT-DpS38Es3TRbtqhO4No1W4nKjydzNSvOfwHKK5AkL6HVsQUE>
X-ME-Proxy-Cause: dmFkZTGogMn+pCxeDquminegR9GNxIiJxYRvu+CSXEkwMa2XwYnvSMM+PJw2BWKvEtRtCn
    enZFFAFqpg2gDT3aexnl2/2w1u801b0OWFDCa2a/SBbRquIkSDiR5+AI4FZv75CTPIQswL
    zxjlbTZbL2N4GGfbbJsdGntygXIyJg8dEENgzOvkeVeeGCE+J1gRn37/HZkehqNf1siejh
    nZyAt7SsWEu/n9QiderYZML7RRwK8s+dpIM+QQNcizCuWsAyQoiCCLMa3G+XouQhbLgGXA
    S9zgrhHHNm8iH48YeFB6wjcTwE1zr/o7ZRfynz5N4JM23r0AFlr3unq5bYVnT4OdCeb4cX
    tp4qmWxqzxxQ7zavONMdRmIZPbIv9b9YCFhUX4YeLZ9uQ80ZhOCfYlJBmoQ/T/+rl0KXwc
    hYCl3SR9JIxPRjyn3KFKVDgSosr/fB6HGQoVS0sbFcu7+V93kNTCsws5X0jQS74g0N9BpZ
    age6Fef+TawuZ0fS58RzvZLTp4m1rCIxevq9Qeuq3ASvU9IDx/uUskQC6KQCN1+I+0SDW8
    dab+c2jmdVJKaXUULHHcMz0YvinTosgF/HvWMAG52dhps/OC57Hx/JRoZhndZapbw9OOVZ
    ZlRu1WWaDdOlglXob9PS6S80THNYmSFJLVdD0qjPms1ObHKiX+XJ4Yb991ow
X-ME-Proxy: <xmx:FJTbaoz0quxshXHWZDiHabP1na5x2dJw6vA3nRtb_ZUuoaicNXMx_Q>
    <xmx:FJTbapakpWq3eu7GujJveYJjf-BazvQzL0DUqtEzZh8HtGm604ZL4Q>
    <xmx:FJTbapUxqgzx_NOAIGk0vE0nq08eb5ohhbEB8S-AOA_mlMVyPriFCA>
    <xmx:FJTbanhCmI4kcpDAK1zKzUZJ87wlkIK0yH1l4a6S_5kVV5T1xEUKkQ>
    <xmx:FJTbasD9R6tfaX-B5Imfe2tMBu3I8Cu5jt0zYtFgO68En6mOjI0C_prc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:06:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Rub?=
 =?utf-8?Q?=C3=A9n?= Justo
 <rjusto@gmail.com>
Subject: Re: [PATCH v2 5/5] completion: drop "stash save" completion altogether
In-Reply-To: <0266646fb4e6eb4932ec728ce425af9886e5f146.1792761643.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Fri, 23 Oct 2026 09:20:55 -0400")
References: <cover.1791827304.git.ben.knoble@gmail.com>
	<cover.1792761643.git.ben.knoble@gmail.com>
	<0266646fb4e6eb4932ec728ce425af9886e5f146.1792761643.git.ben.knoble@gmail.com>
Date: Fri, 23 Oct 2026 10:06:27 -0700
Message-ID: <xmqqpkx08hyk.fsf@gitster.g>
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

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> It's been deprecated since fd2ebf14db (stash: mark "git stash save"
> deprecated in the man page, 2017-10-22) and the previous commit removed
> further documentation suggesting to use it.
>
> Since we recommend push instead, stop completing for "save" and remove a
> special case in completion code. It still appears for "git stash <tab>"
> when GIT_COMPLETION_SHOW_ALL=1, and when typed explicitly we still
> complete options for
>
>     git stash save --<tab>
>
> which is helpful for folks with finger-memory for save.

Well, if we can replace the command line to "git stash push --" on
the first <tab> and then start completing for "stash push" with the
second <tab>, it would be superb.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 697fef5462..9cd9c7cadb 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3558,16 +3558,13 @@ _git_stash ()
>  	__git_resolve_builtins stash
>  
>  	subcommands="$___git_resolved_builtins"
> -	subcommand="$(__git_find_on_cmdline "$subcommands save")"
> +	subcommand="$(__git_find_on_cmdline "$subcommands")"
>  
>  	if [ -z "$subcommand" ]; then
>  		case "$((cword - __git_cmd_idx)),$cur" in
>  		*,--*)
>  			__gitcomp_builtin stash_push
>  			;;
> -		1,sa*)
> -			__gitcomp "save"
> -			;;

Nice to see this go.  This would have been maintenance nightmare if
left forever as we will have to remember updating it when "sa" no
longer becomes a unique prefix.

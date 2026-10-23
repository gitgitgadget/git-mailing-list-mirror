Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775195;
	b=0iZK+bm0qJvcpMS7PzyOq6Z5wxX0Ge74TrQcLhDvCDnt4EoZjvyqULSogRNpY4crdkvG
	 qw4SkDEbht2E/bpIefVkHNOU4BUKcj+1qqJAJOT7weoAb2VgfWMEGbT/g9D/uTUDpxtWy
	 iyHBv+VcBTdb0xhhVLoBF/kqlEMlM93/FmKjVqLBBFs3JD7t1ZBPBXvJtTkVtnFB1gDJS
	 v6CNvWlpD0uSr4vzrHO+R0Vqv/ra40L8i7pdXE18uoQWCHvUWrFqfs6mVAurbSzrL1JmI
	 8FM8uPsJAhrvHzj1fpvXPs6fFbQlAWUuYUc79TVbWEUuAFbKHFDcI/nMixRwwvFq5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775195;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=JGr5XIoJeUDEjuallCOrfgKWjQTyMo45z7YNJexhQfs=;
	b=0DcJyajO9GN1yzTTVjTmed0KO7nwILvqgt/ntIBwh4sZfIGeemsQjHLhxnDjbWcPzyfk
	 KmTy3FprXBg61/ra52i1Hs7cXrrnUnX/RHvFyEetx8tOD0/Cr3cZmQs9M4UkwfL3mgGzh
	 UFib2L95fLAukuMNdZ/JsUgZ2d0Sozn0LCwjJ4nRgt1nw+EX403gskWglhp4MsdIrK+We
	 tc35JiLZL2MbQCynhOLHhY3V7MxnHj6l8fxqPVh342KyiFxoruXK6D2mkCQ1sPQeQOCmy
	 Qj3E0Ehh722L6d5SVRjGb8Kqa4E/LFJ++pYF+rv511CfgnC8SDemf78DFIqJs/6a8rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kGQ84oVq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=phEKNf2h;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89543606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89543606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kGQ84oVq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=phEKNf2h
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BC3DDEC0191
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:06:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 13:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792775193; x=1792861593; bh=JGr5XIoJeU
	DEjuallCOrfgKWjQTyMo45z7YNJexhQfs=; b=kGQ84oVqmbyY9w+36QwQX4MtKC
	XVSPAZa+waioZRz10F89q0RW0PiHcc6KjewL1eYVT55WfPnz0zIDT18kyURzVG5t
	LtIOn9cOTi6GZRAm9ojAdD98iPme6J3bT+7aDGkIH/fTdJu2R0xG+UbRa2qx4krb
	BwC91d5gVfduRK6gqyaNJBfM/u/ovDJCe2Bn17Neguyf/XwrlbxSlBv5XyeNTHRD
	GNje84HU0czypKUzm6+OjvPoVt49GZ/OUxwpmVFvgzvBKHMPXyiWXjRqrdoo8C4Y
	0s+3XCVB6J0R5r8+FpHDJ6NN+8R2PixSzx4SKls1TfFLM9spds+5+em1g3SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792775193; x=1792861593; bh=JGr5XIoJeUDEjuallCOrfgKWjQTyMo45z7Y
	NJexhQfs=; b=phEKNf2hrlB4/48J24YGj+w/nrjwC4XoShPAXw6oklvY4GYg3Kp
	ozMoVRxg0ouPeNjlZOVwPEh/g8qqV5/gU8Zt21Xj5DgB/fXzpXmnO8evROnFfKtr
	ChD11r6BECc1HQPA4aVLNKqzGopLANSD+PQ5RwRYi/sJeR7fxKtgR6ZnGK3/LoUz
	9EZfRccbgSLBkdXbBhh31k1KSdMxjWGbNbmbglZy4Jkwmx37iXeDGquPWCUQOIui
	J9Q/GGqIqmx4EjqaTJ9KkhjLEeQ02VBXyd73fjYcD5jPLboRO1Pqnsc4pt1rohUL
	AP9jeNrhGv9G0ouGO9nX2pPAgfuiKA8XZfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792775193; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Z4SdYAYSluBq6gzGRtRH7WknX4dWGVspt5mBfO6Bzus8p7H
	xttV9KRPR1ca7MZR/5NuEZgpETNNTtmUpZJ2HMD9gHN7GwmtW5yt1BKMqzlshCNL
	kL5TXvquqefyOCbP1Ra/+kDosgss27rp6zJKdvP8zijVD2KwO7AisykI6DeXUfxg
	0dqxq5ciUmcuyquNagbqL/y6pYvZ55+rIAoXXrK9jXTbMxAgOd2g1B3G54wQvFbL
	FqVyZMeuvEdPRF4/CcEGpZczz8ysk7cAAm8FZbOzEisSlPplXveXR193lcKi0CxR
	WsXLr7M3L7klTXMVFoLQI2W9wkWGPiAP1xm3Z9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JwdGeeCzNCWXcoWyVCL/K2EAtUxDJdRazNSUZpRLRYM=:XEvEktr+4xkbrFI4Eh/kdTMeohUs0xtaAIGTxnon+bY=;
X-ME-Sender: <xms:GZTbau_7mKr-LLVCPhpZdrzVyQwbStkghCSbXJh75ciRO5R43YOrnw>
    <xme:GZTbalu__vp0P8Sc7E5Lke6zwQjhewHa7pa3m_6MXQfBIcpKFf819SxcpG1seJmR2
    vFjbdKmq-NWCudY4SuJtfFXAeHCP6QlFhOZ-doBiBcP7oDM_hY4Stg>
X-ME-Received: <xmr:GZTbapBJMX5TXHX-4lAsl-TA1MbkQ5ZtI1NAzXdSZmyn3X22ftduojr1QtT8F5SJRVIoCkpU-xpEOzKe1w9UBpGpiyDY1OmIQLbc>
X-ME-Proxy-Cause: dmFkZTGogMn+pCxeDquminegR9GNxIiJxYRvu+CSXEkwMa2XwYnvSMM+PJw2BWKvEtRtCn
    enZFFAFqpg2gDT3aexnl2/2w1u801b0OWFDCa2a/SBbRquIkSDiR5+AI4FZv75CTPIQswL
    zxjlbTZbL2N4GGfbbJsdGntygXIyJg8dEENgzOvkeVeeGCE+J1gRn37/HZkehqNf1siejh
    nZyAt7SsWEu/n9QiderYZML7RRwK8s+dpIM+QQNcizCuWsAyQoiCCLMa3G+XouQhbLgGXA
    S9zgrhHHNm8iH48YeFB6wjcTwE1zr/o7ZRfynz5N4JM23r0AFlr3unq5bYVnT4OdCeb4Zb
    EuuasaD3vJkyvMVWvL456lPLa6zFO0nAPmrxFTCJcgdhb6SmcgzBk3MDMWo1ixtAa8z7i2
    1MFUj/yp1USw799yXN4T08AqhF/V1CRARX3qrG8P50oBYfb/xKf1Knje1HBT0lpTk5OT91
    QIhFqdRtN5ZMbknUit0K2gE+VRls9aP2WblbXzB4+qZjh4l7QENQofPIh2u9u7P1iKQdoK
    VcEIsPBfe18zwqApDW0NCmcW/0td0vRCJ33x1wmclZHHAfNTJ8J+/bWQk2oUAf/6K9ExuY
    hgP8PfKldBnXSrXNbsPR8cWsx8IQ1u0D+fxjNVGhZDBMqvpxQPHhix9QTm0A
X-ME-Proxy: <xmx:GZTbalXA84wcbrtHPcv7DBp3EunstEHVI1vt1urR8wTNpaAcHVYhrA>
    <xmx:GZTbavB3MrQD8s6aDg9Wr3ZxvK3mllvoGcsovmCHsQDQlEQteELEBQ>
    <xmx:GZTbag__FBGG467QwLn-lU0dhEExaiGmUWWZQp_WnTScxJhfdQIpyw>
    <xmx:GZTbauEm184sSy-SX1YTg9uUjz4C3qo6iC1HyuWApADDnLGzCQDG-Q>
    <xmx:GZTbasgDKqRT9cxZFiVRA1pvJJbavhHHKklFfHqlXfKKEbLE_aE4_gY9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:06:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/5] Completion: extract common stash listing code
In-Reply-To: <abf8efb792e6cc90db2752baaef4a7bb1d00f4b1.1792761643.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Fri, 23 Oct 2026 09:20:52 -0400")
References: <cover.1791827304.git.ben.knoble@gmail.com>
	<cover.1792761643.git.ben.knoble@gmail.com>
	<abf8efb792e6cc90db2752baaef4a7bb1d00f4b1.1792761643.git.ben.knoble@gmail.com>
Date: Fri, 23 Oct 2026 10:06:32 -0700
Message-ID: <xmqqjyn88hyf.fsf@gitster.g>
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

> With no change in behavior, prepare to adjust how stashes are completed
> by centralizing candidate generation.
>
> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> @@ -3593,20 +3593,23 @@ _git_stash ()
>  		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
>  			__git_complete_refs
>  		else
> -			__gitcomp_nl "$(__git stash list \
> -					| sed -n -e 's/:.*//p')"
> +			__git_complete_stashes
> ...
> -		__gitcomp_nl "$(__git stash list \
> -				| sed -n -e 's/:.*//p')"
> +		__git_complete_stashes

Nice to see two of these unsightly constructs go ;-)

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029327;
	b=mEB0iH8TQ/1paRYOk0NBHkQkLK5/FnC1aP0Qfwmr3FHKcNBLLaBc79g0OTFNgAKuUc4g
	 G79dl62Bfrb/ly6FgD77GdnWJ4kt579o2/Gsvj/IwTElWoum9mG3jtZT7mFAdEc0SgNXT
	 vTBeRK9vIINbsXk7Y8mGndLJjmWoBVExU931JOsMFkUMLKr1QIIc0kpKbW8bucNTztDQR
	 fqhqG8lY4m8KU5aB1+uCnEDJTCVmtrLYVtstRbZZTMbXXxnck/aKNa67kyqINRTUbxSut
	 BkVZMKMO5QRwQAe0X3lui6XS1in6/8PciiDh4GEJk0j9oIqRceM4UpSWOM3iwMgwtJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029327;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=Ret1uc3R+rNg0vRXPcWBXWe/8MorHP7vVnomslBpU40=;
	b=WOxsFFM/0wvOLHdqhHZI6SGLE3CiWmmSqXa07Osw/6FaYV8NX4ysj/K4TS/1N05tUzuM
	 hv0cfMQujMlmfWkAfu8x6IzgVPUvpSZ5C/ck6QeCVgVpiFTYgf1CeqaxL+GhRzLulBC6T
	 VpRbh2hIJBzLKt7eQ/RkiLaqhlTHFrRaTen5/8HIZ4OFiIP1T0FRlWwI5yDWMKiKWmpTL
	 bLIb+IRV7SyvV6dO4Bask//EK7OsTyMMEQ86nRzCtlRvWgYm9qDOdi1PCiNW7NUg7k+zI
	 lSoXFgeBN6eJ0ZHiHMlTafZD+uIPhdeD1ccX2JWtbNBPsCnkeMJfvvzmeKWVbuT7HkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OFReAgrU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eRsuodnx;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CC606A330
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B2CC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OFReAgrU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eRsuodnx
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72FE41400135
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:15:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 14:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795029325; x=1795115725; bh=Ret1uc3R+r
	Ng0vRXPcWBXWe/8MorHP7vVnomslBpU40=; b=OFReAgrUNIDrJ/Fs0Mwx912b/v
	MqiAY87INz1G2Mp+RmoIylg/elw0SKgJFP0BQtaBTG9Rupk02chmMAfRk/U9THBQ
	svp4sNYoLbK6WO1yipW7/quYk0YVilpkyrUoOX+/57HdX5kxh43y/sVsi9Mbij8+
	/T/pWv36yJjy3KQmCMnCUloXxqA0wWpPW2LIDJ0MFapdjof1IxQSZPmFltrz6rIb
	qiah+gGvN3+jQRTOQ1jXP0KePoTS5oyygkZmU+qqkP9QxhtjFLP+H2e3T8poYgSj
	SljruU0D3FalHPjb+X0BpCwRsARfgugtm3NFtHWzPAaG835sZ7geUvcBjjhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795029325; x=1795115725; bh=Ret1uc3R+rNg0vRXPcWBXWe/8MorHP7vVno
	mslBpU40=; b=eRsuodnx3mwN154YpiUyOr1zBy+aW1lGfl41gAJXecEoXxqaByg
	hkmaXJYwSH4FLmC7NRdvvejteNaI3hjddXVHH4KkcuzVmuEo3X3TazHhc04uUPm+
	Uouj9kb/fnReAF1/7TFHSQBpJTI34C52302FhBhvwDCFAHyxJkgMu64L+Yw1U6j/
	Avg+yJjX1yR0z1zZfvBMz5LaHEtpn1PxvAkv6n5lG5QtuFJG+ydSn/ehPFtmcAGT
	r4oqHLHl1wwRIJ8aG2N9/5fNHgu/dZKxUjlLa/MatLnYKbGn1Bpa8zMf7+LsToLv
	GaiQyhEk9GMtnrWaGCsvfq9AmgNHvfWT6QQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795029325; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MIgAq9n085VfrYCXUWSp0gdMS1NF3eEtuWNNVjcJovic9Cc
	AYpH/q5jAhITHukXc+1+lGnUn7I9GZdhuCwOiNpFpM16ab6uJcZZoYxy+lHNC7uG
	tuSZa6dKKfiKGssb6gXdGrO0BQaAFXg5rvpq63qgkNFR3PknRwgpSgIk2TNx4Tzf
	mRh44iPe1A7UXGSNqyoUXZu0A6UaK4LN1XM007+E1nq1PUE3Zc2HVsWd3h5k5i9i
	G+yNTx3oPZJ84lUUqlBOo4Mtlqxb00j/fW2tY2vp70zyc3zVi35QHO0HLzN2ELHS
	l4chczQfgvQ1VeDkICcOT6C8kyY1YKIRJPO2yIw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cpFl37P2KjiorydqTT+04yzQKSE2yfFMKhoauJHjZcs=:wdjEypsfZkrmQvypxpQpLHEuCvA20zRevF0+dKIs0LQ=;
X-ME-Sender: <xms:TPn9aick6DxjaEdgH7pOoPWZ2SjBi5BO6xDzozKOd8d9s3WrolRVTQ>
    <xme:TPn9aljeM4kOzZFhhhDXwac3TO1Rf7ifJ0CtlbIlwTM-8rT-NbKk_mFxIImCYO6VG
    IZ0XaxfAfljbqkoOEgVGAtx-c0ny91t3U2WRhsxqfFTwity3IXfSlE>
X-ME-Received: <xmr:TPn9aqyKbrSshR7H5ghPN1uedJOmy9SP0wefxLlNpNuB90jY6ySxFATI9mevc7Roj6-tcVNkZSk3Vbmr4y9oc4hrLhorjTYXC7NK>
X-ME-Proxy-Cause: dmFkZTGQQZbGf6akFg9y6SyrdYYYj0/emgXn4hONBAKItW2/cghALPSeMrR5PcYmxIeJdN
    YfA1k/yIsZrH1alxsK37ks1X38wOBR5zWjb6vDoRzxkmXoZEEdFZdofdbcbQ5Ittij+kpn
    K1nrWMXE0Iarb6tlRxzns2jzltWImX8ZnxbpQgH5tEqeJQJ7igClx2hZf3JH9Cx6G6pm1+
    +YZrBVMfkgVI/QCoA9/GhCedr/mQRtAy1zyKNVHs4jdd4nkcLd8LBTb//Ata+gFnz/2UKZ
    rJAXJvgWszIn0C9fflIDFRlrf6tSc4OMsqyu/suIoE3ep4OUWdal/E2WFm/YZ+zwPiSVng
    hGR2Xcg3XOvyXjk9D1/5XAGVoj9EV6ynFsTmm0EKdYH5IA97//UGpttaiPq9S2N5H15do4
    RbBRAm5uoiRTBioyXJygpsS3y8/zkHV0a46Cn/vNQQz7cvW7yZZPlBC4jDRMQCDnSnzAuG
    bd90jYb2XPN8eRwoG9qFnXGvqSUgmr3jw+JwYs/dlbM/vCvkvdyvmX0PyKbMSWjcYBwQqO
    CHUBBRN7LNvH3RBh67WqNrRDpm/GrZkyURBVQGQOMhUUk5gccNGWzPLtS6guSkimyGFGZX
    xm0MZVvLMH5wak29vyegFL7EMe7S2R35hH69AE0piZrFj7jpQQCxc8qx6L7g
X-ME-Proxy: <xmx:TPn9ahOyZ7Fsy60BFziRf9UwJvSXOB1FraQscuMp_VAgY6liHf9M4A>
    <xmx:TPn9arVasGQ0GmHG0rPeUOI8sM8xenWIGuWigaoMunkSkgSbrpl__g>
    <xmx:TPn9al1BP-Qmh9LL0U9ZUsRlJA_TY3dvj1U643v8BI0lTZE4wCY0bA>
    <xmx:TPn9apo-qNZ4Aj4gBphNNocKAdhxQaKaDwoZllHsRkngk-eYLV2sEg>
    <xmx:Tfn9alIyqa942rbM73d9IKT1pjJsfUSUxHlMxva3jximY3FuEN_szQME>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 14:15:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Andreas Wendleder <gonsolo@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] submodule: return an error instead of BUG() for an
 unexpected git dir
In-Reply-To: <20261118163249.1693361-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 18 Nov 2026 18:32:47 +0200")
References: <avuJBGlB3pRU3JU0@pampelmuse>
	<20261118163249.1693361-1-adrian.ratiu@collabora.com>
	<20261118163249.1693361-2-adrian.ratiu@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 18 Nov 2026 11:15:23 -0800
Message-ID: <xmqqecci54tw.fsf@gitster.g>
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

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> 9cf8547320 (clone: prevent clashing git dirs when cloning submodule in
> parallel, 2024-01-28) added a caller that passes a path read from the
> gitfile, which made the BUG() reachable.
>
> Return an error instead of BUG(), so the command dies with the same
> "refusing to create/use ..." message as when the submodulePathConfig
> extension is enabled.

Makes sense.

The above archaeology was quite illuminating.  It seems that the
offending commit came without the usual on-list reviews as part of
the Git 2.39.4/2.45.1 updates.

> Reported-by: Andreas Wendleder <gonsolo@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  submodule.c                 |  8 ++++++--
>  t/t7450-bad-git-dotfiles.sh | 14 ++++++++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 1302c11ddf..d00d820d42 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2410,10 +2410,14 @@ static int validate_submodule_legacy_git_dir(char *git_dir, const char *submodul
>  		BUG("validate_submodule_git_dir() must be called with "
>  		    "extensions.submodulePathConfig disabled.");
>  
> +	/*
> +	 * The git dir may come from a gitfile on disk, so a mismatch is
> +	 * not necessarily a bug in the caller.
> +	 */

"is not necessarily a bug" is not incorrect per se, but it is only
relevant in the context of turning what was originally a BUG() into
a "return error()".  If this had been written to return an error
instead of calling BUG() from the beginning, you would not have
phrased the comment that way.

If this if() statement needs a comment, we should state why these
two are expected to match, or why it is an error if they do not
match.

>  	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
>  	    strcmp(p, submodule_name))
> -		BUG("submodule name '%s' not a suffix of git dir '%s'",
> -		    submodule_name, git_dir);
> +		return error(_("submodule name '%s' not a suffix of git dir '%s'"),
> +			     submodule_name, git_dir);

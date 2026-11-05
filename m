Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917597;
	b=n22pvy8QWOsx6xmKCLQ12TAN7N4iDyLWYDcO+GA2L2sw1rpmHbmG6aj8LNkwwZsvmnsl
	 Rsrmj+OiMR08+MtcSmwuZK8dLzE6B/uXNBKryNJZ/i9Ciu8EeiLNJROx4BQIfopvjNlck
	 kqwbQdm/EZbHGru1Dm/CnGPAe+PLxA3XFS9sHbb6EeIGmEfDhSPtfyOX94MnichsCbOoo
	 2AU2C4HY36J8nai7SYx6hlEtUOF5UjpngzKo00VRxAnx41ezHqqtcq92GDCifPgferPjn
	 BP2quhYydmdKrSm7fYqc4hYgPzs1ESESRpdSri+XFJHOrfFB4VC+M39JSjPtoBHaHuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917597;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=YEoRTvAduevpUtXnJq0wOJTM3y/VSUTthCUJM8taJjg=;
	b=5YOb1KyLIdkcjawIdmfWmaQv7nKdsE1xeShWdV0bmUa8t2w+1zLVApA/M2cP0ej95zdu
	 E3r92V9B9AxRtDbMax7Z+2AJCqjKSCAIggzft1dhTwFbVaPWdzqUkqSYHwt3vmcwh1Ait
	 TPStoPMG2Te3SEVE9YFVIvlzrjKjzxSQ6y64p+JK7KJGbYjR1s07rSoqRvd6S4higvZmj
	 umsgWuaQCbQOTqLAfJGoKMRM02R/yNXIpAWbCVVQE3Yokkd8lRqKQ9+7ked+X936Wn9tZ
	 0S3c9fF20rF7XQjxTgON0p6Cshqw7CMiO1mVFREZLRz4WOrpvph2GSi5omr9VM21SoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Fu+MV6HD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YSxfbARY;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42F606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD42F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Fu+MV6HD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YSxfbARY
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58D9F1400126
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:26:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 17:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793917595; x=1794003995; bh=YEoRTvAdue
	vpUtXnJq0wOJTM3y/VSUTthCUJM8taJjg=; b=Fu+MV6HD2cuDtO7OWmvbQaTpoe
	XmvjyrW+M/n6jyK5cVHMplDv6kfoEXALT8fbbzrsTJd3/70Yp7gtZkNjtvd7/FMl
	6CKlfdt8tnCNoFh8BdllySL/htNBIe7Yb3ZrbDvumfZYnPiGvy0epIZDa7D3yj+7
	Q5gvenzkuugWvmHIYg66y7djUwkVGygMiJ1HKX/0sJQngAalEG2d4eO+eaFJKjoY
	LvWroIF1Csthdhowc/ja+KX7RAOSnk5gS3+JPUo6lCb1eDQFb7IkUp+G2mLI7uZN
	weuOwnOf2Lfxwfg5Io6/CVk0EjBbfodvp3HVnN4uDTmxQsMzQVj2yMSKIF5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793917595; x=1794003995; bh=YEoRTvAduevpUtXnJq0wOJTM3y/VSUTthCU
	JM8taJjg=; b=YSxfbARYhLhc3ATCyb6kx9hH0pwOof8uMXG6GRh82k08iUGN96x
	UEskgfVB14c8NCbxO84lqeZyGeHjemK6ahB2y5NYGA0fnIOnC+4BvGDEZRxquG58
	4W5VZLvsSa79wwnsY/GUabSVQJzes+4yRWlcguD0UGdEypI/qqJBDMAtn5qgXoy+
	Ik5lbmmgbtQkzJx7Y4ogt/COD8fK+F9caxPJRUSBDAykAZfaHFxwAZ+0vEGR2NC8
	XPeg2lyOV4qpbY/EttA9LqjM5MphcFLMCrrwHeEAMOfS9vRLbWaAD4buoNuLOtoT
	cF7EXIUt3k1f3uI0UhCUzaEpAM5t2MuPv0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793917595; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dHDRUWrXpqKdlFpVDAEFlPIyJSC+ETpDgrkVmY2ECXCWtEq
	BG5anBGrq50AZqZgq2D8RrpPXn3v9h6AGr5qfVXqhHdYXmmbcOzvyND9sMREFH2b
	gUXZrB/BNnHrcSMQRcE8xDhd8qWcCbt2K6XgVs1AkWdN9p0j4vosDSjFUN53+46U
	+HPxLxPFP7V3dtP1LbPqa+8eygAzrsqC90WQHMp/RRBbkTf2r+g2ykz5pcquISdb
	xYmdMYR6hJlPbUGEDJjTh7DD6iP4sLpX34K3AitaaNqF9Ep3lqaoEp/yrfUyej/G
	3fdhP1P0Lm2tbX5LLzoXeHR6k+XUooqHCXMjFyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EsKtoq/geMrS4/zDc8xS+TRt7FT8CW2ldf3HcFviYh4=:RX+ud9Z/ZYq+RXk0LWCl/V3FmPtA7fL6KilLtMSOkWk=;
X-ME-Sender: <xms:mwLtavtx57k-aoJTGjpkBGpKMoIOGShb0wSgwNteMIWwnJ0YIg0zDg>
    <xme:mwLtan4BKYc9Edo5XuF1qC-X47ZOAafR9SrQ0Olqxdp9xZeFaKyZIlX-sahrzqb5a
    cOrVgY_kFbJ5vC4gQpGgWCZULFF5RJpQXaN6o8DQT8G_HRbCtF0yw>
X-ME-Received: <xmr:mwLtagLfcjzkXyqKJKWgtAAKOFFiW1Hj9L7XSio2_Q8IwGh98KPmXoj0wbvfxrtKNdAdO8MXp6ppoAAxvlaytyRFntGtbL0mSLac>
X-ME-Proxy-Cause: dmFkZTGP6N/zvmJhDuhLJGAqkDsTRaZT4K5hzxeDNZpDhB9cs7UWAb9PrAtmktQoQD4IjA
    zc3XsceA0cQGoNyi1BCYjznJUgGhUb/9X9WT4l/f+niFQMB9AKY75bzQbTR5sO2+0QJ3hb
    mnjs8Kq2xqLF+6j0eIQNMPodfLDtz4tki1UOor28dyK7Miv21DONsKkQTLnWfiopEmYWNE
    eXul+ixoJcr+PLu06UU45bz41oD1WD+X/1ocDXhc+2QKqq5y3r5wwmkVVy5LtDavA/7JXz
    jLrFDz1dIsh+P4RuWUYYCRWuYJaPDhZAPufm0S/097jhGvJoEh3DhRIyRMPf4naMs/uUkL
    KYnL8LfOlJsSVp1utoobmDvux9fNM0DzKfjMFvCnx4X/PaTIvEt/OXug+wDN4N+O0mz/Pu
    HkPjjb2yycVmcgPd7nxkp5ie97YcaaHzVPWesdH/44KYxQzr/0Nb47K0Ohgpj/yfKWzV6x
    3gHWAax4xBhFzW06GPGA3YSkihzw08egW4bZCH+g/Qa9K2V6lXFj3we3n2LDv3k5ReQPAW
    ZilDduvTibU2rOD3D/gr0iV89DcZ87XVVvANTASzmHHr4MOsR5vuPmVU99N26munGNCKbH
    Z1nHXqQEBk8utks92UI4Ar2DX/OQUYJLf+s8moAiHVC9zUvZqoTeXsrPeIUw
X-ME-Proxy: <xmx:mwLtan5D5yv3syEV-llenLlS-ut7dyfZ7BHjZhGkSn1NXNhcmUHDbw>
    <xmx:mwLtajxspF7HCFH5RDEeVZp9JXXFWpsuoHcKE83SDGSPgBr0615UdQ>
    <xmx:mwLtarZ-Id9XxtgLTq4l4nA32Z_srYXXO_VOzz4b4sC8l7-c3eoRDg>
    <xmx:mwLtalSBtSqzR0khDo5XWUQeh5t1x2GY83mjRoSm1J0wmZGM73P9AA>
    <xmx:mwLtavj1fXazpGpkKgyiPAITO7RVAi0OUsWf2_f4znbhJZJtbDGV_4Hk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 17:26:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 03/12] refs: stop using mkpath() in refname_match()
In-Reply-To: <20261014031347.50433-4-jon@jonsimons.org> (Jon Simons's message
	of "Tue, 13 Oct 2026 23:13:38 -0400")
References: <20261009192953.81794-1-jon@jonsimons.org>
	<20261014031347.50433-1-jon@jonsimons.org>
	<20261014031347.50433-4-jon@jonsimons.org>
Date: Thu, 05 Nov 2026 14:26:33 -0800
Message-ID: <xmqq1p8yrk2u.fsf@gitster.g>
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

Jon Simons <jon@jonsimons.org> writes:

> +/*
> + * Check that the string refname matches a rule of the form
> + * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
> + * "foo/%.*s/baz", and return the string "bar".
> + */

So would "foo/bar/bee/baz" also match and return "bar/bee".  Is that
expected?

> +static const char *match_parse_rule(const char *refname, const char *rule,
> +				    size_t *len)
> +{
> +	/*
> +	 * Check that rule matches refname up to the first percent in the rule.
> +	 * We can bail immediately if not, but otherwise we leave "rule" at the
> +	 * %-placeholder, and "refname" at the start of the potential matched
> +	 * name.
> +	 */
> +	while (*rule != '%') {
> +		if (!*rule)
> +			BUG("rev-parse rule did not have percent");
> +		if (*refname++ != *rule++)
> +			return NULL;
> +	}
> +
> +	/*
> +	 * Check that our "%" is the expected placeholder. This assumes there
> +	 * are no other percents (placeholder or quoted) in the string, but
> +	 * that is sufficient for our rev-parse rules.
> +	 */
> +	if (!skip_prefix(rule, "%.*s", &rule))
> +		return NULL;
> +
> +	/*
> +	 * And now check that our suffix (if any) matches.
> +	 */
> +	if (!strip_suffix(refname, rule, len))
> +		return NULL;
> +
> +	return refname; /* len set by strip_suffix() */
> +}
> +
>  /*
>   * Is it possible that the caller meant full_name with abbrev_name?
>   * If so return a non-zero value to signal "yes"; the magnitude of
> @@ -662,12 +700,18 @@ static const char *ref_rev_parse_rules[] = {
>  int refname_match(const char *abbrev_name, const char *full_name)
>  {
>  	const char **p;
> -	const int abbrev_name_len = strlen(abbrev_name);
> +	const size_t abbrev_name_len = strlen(abbrev_name);
>  	const int num_rules = NUM_REV_PARSE_RULES;
>  
> -	for (p = ref_rev_parse_rules; *p; p++)
> -		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name)))
> +	for (p = ref_rev_parse_rules; *p; p++) {
> +		size_t short_name_len;
> +		const char *short_name = match_parse_rule(full_name, *p,
> +							  &short_name_len);
> +
> +		if (short_name && short_name_len == abbrev_name_len &&
> +		    !memcmp(short_name, abbrev_name, abbrev_name_len))
>  			return &ref_rev_parse_rules[num_rules] - p;
> +	}

OK, this is the crux of the change, I guess.  Including the change
to use correct type "int"->"size_t", this looks very good.


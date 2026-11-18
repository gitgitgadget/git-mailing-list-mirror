Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028514;
	b=TxNBQyUeU67vsHKnj+wSdVs27aqYQzQ9n4hD6uanTTIV2VzxTwVDUu4jPD8mane5TD/I
	 3Hwhi2eG3FXVA0eiWzeQLDxjs64hHoNmMotTDXAIK9xA1yv+IdSKEzWlLnuyEb6zX76qI
	 app//nOtS2D4/yoVH2aFJZ2uxr9H/sYhoXKaAPYPvsNA8EwmLZCyoU6iPFmPQahhpqEDL
	 5FhcmpUxr2vpof89YDrt0abSvElyDzRgv05F7n6ot9kVhRmL+G65E/v9IbXDdutr8rqc9
	 dGf4o3M8DQcRF0pHgqteO7wNo2EJGzeIUwFAVjcd2mDQ7kJckpDeEwEk2dGTf9bskew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028514;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=MlUU/Y7krlE8R9OZo3fTEl2ari7VAOgrp4qKEYaelOw=;
	b=l9vMq6wbHrhyJ7D+oj5jKkizxl9DAcllLuSpDehVeZt8WXRnHszeJ4meaX8c1EgoQoPU
	 +tocgveGWsgi5WxoCsltSIHh8AucWCYK+MWCMHZo1QZe8Scj8Iw+5zD13zJoRTPnEb031
	 x62y0y/JFO2b/xS9bQN9hGcTouvx4qhKpEE3nz7WG2VbGP231lOthRzjLzMaMmozq2pLt
	 mV7Qn96mjIDinfWoOcDz+KBQ6WdUUjVeouXvfbWxTp+1Y7//xrRl+eiAaOAehLXCZ8vSv
	 liByMW1YMR2c+2Rgo/68QQrPuwNEH7Vn4Arco0Dlltu3AqRDKQZyK6T50WTvjF0SDxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZKTwsHf1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XF9GYGoE;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F237606A337
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F237606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZKTwsHf1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XF9GYGoE
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 83CABEC009E
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:01:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 14:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795028504; x=1795114904; bh=MlUU/Y7krl
	E8R9OZo3fTEl2ari7VAOgrp4qKEYaelOw=; b=ZKTwsHf1POqMG/uco4/a+nzdDW
	s9J/yZLcXptlBYNQCmESINqVaKx0xzKNAbyWLi2BTZcOr25f18/qLFNBQJLj4pWU
	mXIuPlh+RbB9BfFebgSBRaoMbBfy5S3329M6sr/kvzkVicT8oFL5RAjgWTzr4h6n
	mBc37K09FbX99XoGmqw/bhUxtLW1zvkVp/kp5qiwbGmt2TMY9nJ5xbQP9Uz5hsXc
	uKEL7P+0+cNEmHqzH7AFRbqhXd2eGsJANXDunHMs91eeEAY58sIDE/dijQhGD0Nd
	BAppzoHVsB9qjihXpAUywcFl5J2qSJ9QQTge24a78Q/4YMlbZeIBCwD2WetA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795028504; x=1795114904; bh=MlUU/Y7krlE8R9OZo3fTEl2ari7VAOgrp4q
	KEYaelOw=; b=XF9GYGoEfJAm7TOps0TGC13CMv3dsVXRQqKxvD1GOCoBvVaJaB2
	OfDQQAerOASPdjmOchJaGTxsUoL9Gm2cNQLzZZYxSKTZt8jFiY1rt4s63KSmai0t
	wjI/jvkYX3SyI6Wn0kqIpUgRU6hl+es+gAcXCdsysu6M3rQtsGew3GlzE1TIYVX0
	fBB9gbDdjw5uRGJUbRdu/1L8vrN2g7vLeO7Atyuz6arsacm4rGkG836nrTmDRhsO
	rAfAR0WSMGTi2sZ3pn7maiO2RY97Jr/IoN++XciHYdgUWQ2tCDRwBzbzmpijjARB
	kWOKih1Z3kTww6tYsX+xvAt33nFab5OGpLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795028504; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NRsNuLTr61bSdxhYdjJ6tKArhWElSboa2p/xKjs3CBrETUR
	ZUiCe8iddzv7YHX7O1dKsS76Trnmj9ajlAXYsOwgLnwaRRst50bqtPYnWtgODL95
	1bYpPNRIzSRvoM5qceS07gdpU39qx6LoT6S5qD7yj41Sk0rN5g3BQF8w+6TFprCy
	ft0ZS4eYxw+4mT+6R5+1Pvnxn8gI8eWB9WVJk7FXMvoKU88aNs5uQJ5nSWoRMfq7
	0KCAyhC092LB01jY3aFj0BlYBIYCwUsoWq7ccdhsrINNjQ8ArIcd83SYF71h5SvQ
	mFI1cOQz3z+bKEI5wuWwFXNiIf4hBEOejt5tSBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HpP7Y3hDFHITUAYzQrOE7OYgwFfuLRbM6sMdIWpzB0o=:V/f7e8iylVHU7AQ5rImr5ZOCqPjxqX/E9xqgpxpqHIY=;
X-ME-Sender: <xms:GPb9anN2S-j-kbaBVrLRDXkXLNak5FsBrGdbYkd-3YrsADVUfNYmSw>
    <xme:GPb9ao2nvbtC-7mvGjGHCG9n0z3xVGq5QJ8zisxg9is9RRm2lYMP4sOwcSmKaZlQr
    yvHNCTXwXnm8vrx03dk65sC6A59nQuP4oGfTi5JOADNO90EZ45l8w>
X-ME-Received: <xmr:GPb9aumXV7PxTouEcDkRBLs4bLIUpwFh_HCxt8-7fbAqpVnA5uCF-JMAWYktdaE4UBhzvdB1clfTdpt8P4axeXLwK8YyqUXtZpht>
X-ME-Proxy-Cause: dmFkZTERDxOdOEWiz8t+ZsMaPf4eWPt6i3DktU9icg3DCHtn9LUtukbrB/IxZLKO2hiadM
    yPbGzukt1IP/+Ch7q5JL6XkXwOz27FMZRow2rkTCvsDcHeD//nBkWBli4j6Pv01pGKLp4R
    vLZpPIa+arWBlTO2N02zx8DnmYxYTIu1bplERGjl723hlJxVqvOtMZ+hPryKxGoKNKankC
    lFs9J0EzKJ3i9APc+egQB1wcKq8S0oRi4N2YLaG1Z6BazwHEPW6ylawgLiBVaH7j47DnOD
    S++eKgQ9jHKeGItqz+lLsBdYTcWv+KWrjloITKpxKcpVi35fmvWUpgxlsy6rAf4HHTz7s8
    LLBZ7yE3QUff1ADIu5c55VsIa6Nu5N9EJz0P8QE/J0tT6t2ELsLu6rkPvODoZWkh8fREDG
    asG5sX5jq13zSMtL0MItoaT2MUOObVcXoqVEU2BImZJwf9JMeFnP+NxtrAEtuVXPU4UzB/
    qn8pSQ667/VDv1aXWXmb136F0OOTiQMqyuVhoFLwOMpV7AgrRVRCPHC2+rE5mB0IBSZcz7
    2NkWQDjvqhHXleGfO4/G7AgrYFv0zIxTPXMQr73+gA2PaE9APPj361YraqTNcXSgeLnsa0
    yb4HMbpN4fMCJVudeE2nM9tjZoqBdChdWh0+p6dFzImHhMDC0BsaApMe9tBQ
X-ME-Proxy: <xmx:GPb9anUuNK31bhRQnSVeJ3fV0Q033_HSy1pK361PKS-_jwKTRHm9uQ>
    <xmx:GPb9asui5h-T1swNTmwxxOvOUslmNwDm8JLGUy4ktAIf_lbu0FfJhg>
    <xmx:GPb9aiYMluz7IjZdXFOekz2LK7fY2ynshIdhhlfYfESoWenCBbujLQ>
    <xmx:GPb9ajWYDgiHH63U3JC9vUKVgoBwCT-QaivmZp45Y3EDWG3ZHWdkgg>
    <xmx:GPb9alv0o66EzwstQRQG_ebn6Eu69UAfyUQZcDTxFeoEtOoqbb-uQCo4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 14:01:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Maik Riechert via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Josip Sokcevic <sokcevic@google.com>,  Maik
 Riechert <letmaik@outlook.com>
Subject: Re: [PATCH] diff-lib: skip leading path check for fsmonitor-valid
 entries
In-Reply-To: <pull.2318.git.1795026168007.gitgitgadget@gmail.com> (Maik
	Riechert via GitGitGadget's message of "Wed, 18 Nov 2026 18:22:47
	+0000")
References: <pull.2318.git.1795026168007.gitgitgadget@gmail.com>
Date: Wed, 18 Nov 2026 11:01:42 -0800
Message-ID: <xmqqse0y55gp.fsf@gitster.g>
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

"Maik Riechert via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index 086476bd77..3730e04149 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -43,10 +43,10 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
>  {
>  	int stat_err;
>  
> -	if (!(ce->ce_flags & CE_FSMONITOR_VALID))
> -		stat_err = lstat(ce->name, st);
> -	else
> -		stat_err = fake_lstat(ce, st);
> +	if (ce->ce_flags & CE_FSMONITOR_VALID)
> +		return fake_lstat(ce, st);
> +
> +	stat_err = lstat(ce->name, st);
>  	if (stat_err < 0) {
>  		if (!is_missing_file_error(errno))
>  			return -1;

Now that stat_err is used only once, we can retire the variable and
inline the lstat() call inside the if() condition.

Other than that, assuming that the CE_FSMONITOR_VALID bit is
trustworthy, the change looks OK.  has_symlink_leading_path() would
be fairly expensive and being able to avoid it is a big plus, which
is done in other code paths like read-cache.c:refresh_cache_ent()
and preload-index.c:preload_thread() already.


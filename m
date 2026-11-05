Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886198;
	b=iAxJTclLNLoR0ZeWFVrSVShdd+vtL7BNRRzRfQui6nTZbOi05pVQf97FNReSUORhw0Jb
	 17w3iNFQCUhxVUDzI5QrD10YNCWw7HBVH3OggzKqJnsq86jpcpUqX9i+7xCUr1UHuIKtm
	 GU20V7Md/0xvuoaAdpWbw72oSIc9yyg59pYev474W4oxR488J5tK8VJitnaiJGU2Lw8hE
	 iJ+5awZHv/bDTlFw0tvVm4wTzVqa1e6YoCr9BNCfzDTwNrLnwEwbKGcnMhzLmZ3W0xgIj
	 Q/16wfoU7KNcnjy+iEeijWqz23tH4M1lGGnItLFyYVfLkTs50aMnCgY36wQWFew3GqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886198;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=irq2SshBi4sWJejgAWrMUu40DdVsz038b/VWXk9PTXM=;
	b=c11XpfwaUk0v06bzdBprAeD3G13Whk1/G8oU7TTikcMPA7I6aFTm4HgPOXdO726sRrtW
	 hXmRUrRkITs0pmyl83b6Tw26Y7oBeILt/7dJVr8ELD+OOSWyGsBD28fnuc1CdINxKBhQB
	 51BpzvnVd77EGEiPP7AJWCXeze1YdXFq/llrbcoJt5P14B1/HEBZF6XEdB4tsSs3jLKCS
	 9ZfdUuWEaEBlNH1G9GBWHdWGiTyKWdzAS2WhPZMNdZjOr826wbt4E3nFVjSzAsqBOdW7o
	 j+mSj/QjWKDnEB12q1Yc+gAPpqgOf6um0kPiC7iFzNBx6j4BsdYuH4fXN+mfRMLjDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=0UA4cWi8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sPwPq0lF;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376D606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F376D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=0UA4cWi8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sPwPq0lF
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D620140011F
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 08:43:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 05 Nov 2026 08:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793886197; x=1793972597; bh=irq2SshBi4
	sWJejgAWrMUu40DdVsz038b/VWXk9PTXM=; b=0UA4cWi81M9RfVJaVkRoIa/IWf
	Zfzmk89qXYol6My4RlC+V7HSBaw6REeZpqzts726WiFZl1d1TpWoPXKq0HlVOMP4
	pqfFvdiz6xQRtEvBA4qRm3e3/EL25whiPGDyPHaNY3VVDuK4CUUhVEhPsAEpTNaY
	kvJYfXbB0ZM7VxG4ehnBPjGBw+FegFaqrh4oefem//EtN1hMyyM3rqFtTM6Iy+Q8
	S8TM1IduXfd2C9h/ikeqzOfEQcI3h/YSQfGKw0u/YitDsriGGQWJJiysJZQy3c1Z
	ocHNNjSrqi5ndKnFEifdcjDthJp7C9yDVvTZ7EHcNwsAYnxnX9Elbwuxq0Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793886197; x=1793972597; bh=irq2SshBi4sWJejgAWrMUu40DdVsz038b/V
	WXk9PTXM=; b=sPwPq0lFCLl4uKMQZZwMWVBaKzH8MfpEZDzlDyIn+qyB2170Jxy
	fvheIXwZz+gYCLwrI61flIzr7q8ALsAtknoJ1VD+nMtn01xieUSkbJXnW23dMAUw
	ZNYxx1s09pKTNoCNfAWIAfdYomjC5SC82QO6q2DtfRg4ZYNW9AIyVDBfQF+g8aNV
	dTqegSMjDik/U8tlQZddmB0FK+RfA1KpKOYpQHH/dKjsk0Cjx7Gaffd9TBrlpQbI
	z1mNWyBkWwxByNvDF41PlwFzxqNNq4KMEPnetnfP/T+TEZgrrpw2MQpjYsyPa1sh
	Usk/lNrWZiOOLq8oYpPXJSLCfKK6dR39L+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793886197; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:eVBd++25fR9FBtLVfjr+GJFI1wNKD/AhpV2XUpsUEAMcrJx
	ld4UnBCOkWsXVXgU/K0sxKcQtVhsAHg5nfYSGtx/JBaNC/dFvcVt5WzkRJO5WRwg
	Oi2lnF+oZWGtaTlxDa4TA5LmWYJWv3mGLJta7xJGOk3A1VvsOhqn1oI/1jxP16Ap
	LsLtmXdORaot24RUuEmmYmGe1TnEW7ocXRqXJypDTxLmWBwila+oRvQjYv2obWbj
	dCZaJG6fKqjidcEps2FGZSzm+rPSjNsRrmxBnhQI0tckPDJuRIgFUCQfMVwRN4NY
	c++m0KVpvTahYKAjmcsvHi5n0qBwfiMmIYyiaSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6rFemaOb9diLF84lULMN+BuhngW6At8XNUlLs3nPCuw=:EnBcfmu7RW+qwkyBt3cqn6IDhPiaDf95Gdu8GhMPa2Y=;
X-ME-Sender: <xms:9Yfsaqp_PZEt0OH9gXLzBRTgpsbsWBqRpBoC7TNAXPBsYgCIAiCYzA>
    <xme:9YfsavrXyJczJ0gkQIEsH1LfMOjCI7ashB1MuCeFrwwcg4smFG705JVnBbXf6q8Rf
    _yuQTlzWOM3seFMkdueLkfBIdIVvhLrPz_DHjTiPWQ6xntYRqOEXQ>
X-ME-Received: <xmr:9YfsakOf8GaCU-2RcFG5rS9ajCbBMSBcYoMpKoOTYJ4hvsr2U5POzA>
X-ME-Proxy-Cause: dmFkZTGV35ez+6KUEBaeRumPeX7bthOsvZHN2eE8oh81HI7Un/qEJccgcmvamMDAfVpojT
    /43Z7Pr83dR7uwQj3veflD1eHBfBOpwL/24pqCNxdlJxaIYPQ4KVPwb2X+QPuNhvuzJSO7
    GgwyhOtcLG5UtIEFZE7wZ9qhqgvjxfRkJ1Tgy9om19PsGKH5gpgJUMbxZqw2eANeZGDEMJ
    BViPPgyxTlXj6ByIluoHLf/RW5dOHUCu3/XEW3eBnwyahH80uzijSD+57XrJ6y/KjS1J+O
    DT5j4iCubQBYjSPYf1GDHsL2IDMFbz+la1fxCMgOJR4/ydy1gwWOvqZHNiaS1o4ju1A7CV
    ZGq92CeTaFSSpvS6bH+SSq/NzGvre7vMHbbAZnX2lQsAKAVI0Evmx1J+VMcoKYtIXjDhcs
    icBnNR4LcKcIYCha9NGdKQlItJ7Y710Wa9c/qqY3zeHs4mhgujvzkz1A/Vn0tYF6MI+9Ir
    fi6v0jBqqKDD0jcGqnZHeLT+UjjXv4VOe/iKpyIAn+hC6h6749T19h+CPPpfxLkM/fTEfD
    J2uZ1YaScNx5UzMxf9WApsrJR9FjjND+amzgIR6/CKUSukpgttDatmcsnOwkodSeUgYlL/
    WiGerT7ZtLIOsS6nYpMMlBuFIoZsZrg2/+UAqYUG6Q5oZa7/VlYGKuOnBIxA
X-ME-Proxy: <xmx:9YfsaowPbshBoJBf2hWa3GzrELbMUqmMK4cmaez0gBGDElUObhVAxw>
    <xmx:9YfsalucJaMmrZQ7A_sMYH4Bh01r1BrNevsFiPtjYT44diIWphJAkg>
    <xmx:9Yfsap6i950zSxacObKb2oE9pY7H5u0gAVNz1zYQuzzeArWhos98vg>
    <xmx:9YfsasREHTR64DPx_7BMHqttimL79-F8bZnQ-lyyWSnE2NfSsF785w>
    <xmx:9YfsalakC2wVval8U5-4ZEJi7ZaYJ5Q0AL8gsDVIxT5M29QtHq0ghXOx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 08:43:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9531d9a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 13:43:15 +0000 (UTC)
Date: Thu, 5 Nov 2026 14:43:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] bundle-uri: do not die on unresolvable relative URIs
Message-ID: <auyH8BGzIsipPAJG@pks.im>
References: <20261028115818.410-1-aniketgupta3001@gmail.com>
 <20261103155231.381-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103155231.381-1-aniketgupta3001@gmail.com>

On Tue, Nov 03, 2026 at 03:52:31PM +0000, Aniket Gupta wrote:
> A bundle list, either advertised by a server or given to "git clone
> --bundle-uri", may contain relative URIs. relative_url() resolves them
> and calls die() when there are more "../" components than the base can
> absorb, so one bad entry aborts the whole clone.

Thanks, this gives much better context now compared to v1.

> Add relative_url_gently() which returns NULL and records the reason in
> a strbuf instead of dying. relative_url() keeps dying, so the submodule
> callers are unchanged.

This sentence is weird as it adds context that doesn't make sense
standalone. You wouldn't know that there are submodule callers, so why
do you suddenly make the jump talking about them? And it immediately
makes you wonder about other callers.

Saying something like "relative_url() is now a thin wrapper around that
new function that continues to die, so existing callers continue to
behave the same" would be way less surprising.

> bundle_list_update() reports the problem as an error and leaves the
> bundle without a URI. The download code already skips such a bundle,
> so the clone carries on with the others.
> 
> Name the URL in the error message, without any credentials, and update
> the tests.

Would it have made sense to split this out into a separate commit?

> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 56faf5fe73..50cc37bc98 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -394,6 +394,13 @@ test_submodule_relative_url "../" "$(pwd)/addtest" "../repo" "$(pwd)/repo"
>  test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
>  test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
>  
> +test_expect_success 'relative_url() does not show credentials when it fails' '
> +	test_must_fail test-tool submodule resolve-relative-url "" \
> +		"https://user:secret@host.example/a" ../../../../../../x 2>err &&
> +	test_grep "cannot strip one component off url" err &&
> +	test_grep ! secret err
> +'

Wouldn't it make sense in this case to grep for the exact URL printed,
as the intent is to verify that we print the correct one? At that point,
we can probably just compare the full message.

Patrick

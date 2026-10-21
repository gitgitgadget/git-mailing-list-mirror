Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604817;
	b=vyxsDTFN7DyglSVCtVbthnAd8c+5qov4LE9HuRHAwTASkX97J0niGwL1HDMg1U4uWDCD
	 fzSNtR9sGHF57NewVb2Oy7DfZxs4PsX9KQrk3mTDVyjURqK3DBkgpsQV7+5OcW+djL+s9
	 sPnPp8zkteUb6aStOdngKulIvv0ARbJD56rWWqdSam9xMjsuaOzj0y7V89SnHWkarfN9u
	 6iF7T0zg27xdj7toydjuQOc1jkoY6RFQpBo2eKHKx2JYD9iOoHTt59EWpr/iECFWVQKn5
	 E89l5ZbykUcJuqLxNX3iih5QppxrtLF3N+fCfzTrK8sGxrGFGN6kX6uVvO3+T78cnOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604817;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=80GvbI4+dJxIf2QlwCBWwd0a+mM4wYEwas7sdJMe4zQ=;
	b=pp9SuHFoWpniRbrh7T+u5BE4K3TTsiDIkM3PIiXKy/hxcd+is2sDN6T2218eNYs/bDpR
	 LcFTifV/SsQ3hoX2rRKM3RP1nqr4SLd+KmUZGsQFuBbFxsNB4tSPBVVBkKRhaV0JQGAuS
	 CA6RhZY60TyYRnUe1W0jDrshpdL2tV0V/qA2PRMpnPR8QNsE2ku/U9GIBquHl0JIe8i8Q
	 TMwv0QVG0mgKyQM/9ML0AeElrCMmSS2gLKqzqVrdGkimWeGwkDFvsJO0AQAqv2+oe2v72
	 pxJklKOGVwUmSQBzlo2k9rYfcoOy0uaxDFuwvvFrVhqeVeu3YQfHz5BHG/jp0h6V4qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="GrIOxUW/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aKv1XpWr;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410B606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7410B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=GrIOxUW/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aKv1XpWr
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E8157A00AB
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:46:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 21 Oct 2026 13:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792604815; x=1792691215; bh=80GvbI4+dJ
	xIf2QlwCBWwd0a+mM4wYEwas7sdJMe4zQ=; b=GrIOxUW/9GO7A8NhURsjq/z6l7
	2TYubfFsj/9aXJibeJQnw0/lutXrON0pxylDRxhVogR5bgtRLawf5Qfyq9SI9l/p
	e2QqHrksup+KmUf7CCOmoIrqYdFMLXtm/q/qGI1Xy7kc3IeR8sBEGZnZgz+nWDRO
	4hduXKT5n6ym0dIbr6ajLNuuZqx11gm3PJBjrXK5UT5YZLpgayTWCBIzXb4GqHfz
	HLcAr+Kv2nkKCaeWZa81j6V9bKlXjn1CQEMwFLwWPBbi0BeQPODsVJhKzGHXyE5P
	nVoY/U6N9E3+5DE77Sm1trNTVOZgjok8TuNzezovWZDd733Y10TgpnFO76jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792604815; x=1792691215; bh=80GvbI4+dJxIf2QlwCBWwd0a+mM4wYEwas7
	sdJMe4zQ=; b=aKv1XpWrykK9MwtkSLCr/+Mtpl7qzM2cYHfMn58C8LZNjprAw5J
	HCo9aTh/U373bbwCHlmBJwbl7y9t4GaPFyjBHQ5YZY5jR3j3quobbg8/T6BLPjnD
	TpeCV3wxKXrS0OXzXEVdflD1NivRE0pAD8hZgcppCuzkiMtsW1pFfmvy6Vt/4ChG
	1EL5Y+comnQ+hVmFunYwE7ArY/6UgOztwT1gBWi7+XfGKarxHK2lxL5BqzU/zQkG
	7+AcY3TcyDtDRGHuYcqNvSBcAkrvp4gTaFmF5PbfevsJgkR3nskrh6+OlL45xKZp
	OvpU90ApEprpiy3IhFOjSiNPhchdEhIB3MA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792604815; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:C5xGx9RRTJVmoArXur5aAPj9YEbvAD9YfksX5bme8w7nB2Z
	yb3NhFFiW+vrTiL2GTvf3Ttz0JxLlnFj6q5H1RJyjxN+URwEAqDEHuT1mmt1CtN4
	x3bvpDk/AIzV68NFlI0fBnbqvvAPFGVhuhtZfU2fnZGZQXVlGis5sJPRI5W30E9t
	FZk+RhDpI0LQCxs4gVU+U5NBN5mv7swm5YPuJG+68ZyloC951zM4UCTP3LEagojK
	IJWEO/EhyV7/MJyFVx3/D3/9Qp/zvw2ab/iWxGsDgUFEsTBV1Twnn/wGXJtkiepU
	UuY50OUeTCxlb4tE9HjO5w8DN6cUmyhXa2HXeTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ea32Ker9HNgx0uRCJt3PcZ1w4qnpEf4GPnevqueQ4a8=:UYvfPR72z25AYA3BMDTkV/pDavgh03ATtMotl27evnM=;
X-ME-Sender: <xms:j_rYatVO-c_neI_9zAAgyakk1r9Qg_QNOHqMBd271t0e4b2esaPbbQ>
    <xme:j_rYakmvhE_CYoIkOTkAHf-RmFrZzYH9yl17EOb5YL53PoSDrUyzLZB1rJpp15P49
    pLAXo1p7mKTH0pfL3jdPx2jcOscLL2r4PAl2xmQb-oH0w3pytD5naE>
X-ME-Received: <xmr:j_rYauZFMGSXBfeyVKUCM-cXahcs03TV3LaMwsO6Q8a5CCae9Zcs-uhJKN1a0LD_7M3DDQuiZrriXCcWo1Ge5D4RrYKqVJs0r0TN>
X-ME-Proxy-Cause: dmFkZTGoSlxgpRmmMPpqbv6K16CLyn75ooGGv/c5b9z72bOONJAPkJkW53lfjosdgvlmPR
    4pJfxyr1H7di6VYhH4cvdhrN8gsBkgGbQi8jlygslDlFXYO82/w4emrzmPQIvdzj7I+VoO
    LuLs2x+GzEymYy3Q7ncXVOEEVHEH+X2KYmCijPaixWiTQzCd5OHtsxGOwGSkwpAc6vNCMB
    gq986PT4+27kG+m43xrWRh9FtkSN136679OMRRy+oUrOiENmGD9u5WOU459SuK//lWlRKz
    lHCl4bd3xASumeF7kYpMIgjQjQ1fa1bks8Ibmw3cwrurilExLecz++We7yfshObQUH7dcH
    mXxc2QVXGjOBsGgR7FPknE2L6eGDwwFfg2N6ynZJqoVcAwWOaJoMMcYWx+jWZaqxWCd5V9
    +Pe+DWS5wcq+vOdBJiDBXob4hp0O0IhsUZ5kfLUif17V9nX7J/yHDBIxkBWY/JMFxaeN0u
    SN3sEVZS2BOiRN5eWPUocaQKbL+UD1N7yL7P7qcjmTkFUCXdmjEar7OmE6dn72P9MINb0+
    ul84j1Ncu1r9rk2MmW22so2zgiu7LrrvoKst8RsMJwg8LgNYqLnAd2r3SYLRzz9SFLVspm
    Ogkr5spEXgsvgXX3tz4OHvVTo9fprUuhN7JgR+UhSxregYxpdBR/cXwjDX/Q
X-ME-Proxy: <xmx:j_rYavN0gsTeePmkQpvtDHKvXVAslgxOkQBdc4fskWv5ZdfiMV5VYg>
    <xmx:j_rYajZT4xcgO-kl2a8NJukz2ephCTI5sQR8cKeop1d6_VM2_mMjug>
    <xmx:j_rYat0_60CU449DA7zpAYGAUzKsvGm5wgv-iktsimusHLW_u6FPhg>
    <xmx:j_rYapfSMQ3frDXSGltXxHI8nPn2pYESjAHGVYeyJ3w54g-LFbunlw>
    <xmx:j_rYalVmd4wn-CEg7sNXYyQfurQnHNhiECWqQorxXE3u3MmJboV-G9nM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 13:46:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #06)
In-Reply-To: <athRc1-tSEVgBupp@pks.im> (Patrick Steinhardt's message of "Wed,
	21 Oct 2026 07:45:23 +0200")
References: <xmqqbj8tckpu.fsf@gitster.g> <20261020185101.GA6367@tb-raspi4>
	<athRc1-tSEVgBupp@pks.im>
Date: Wed, 21 Oct 2026 10:46:53 -0700
Message-ID: <xmqq7bjbosj6.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 16cc5d5dcb..a19bb27db7 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -544,6 +544,7 @@ test_expect_success 'rev-list --verify-objects with truncated loose blob' ' 
>  		cd truncated-blob &&
>  		blob=$(test-tool genrandom one 5k | git hash-object -t blob -w --stdin) &&
>  		obj=.git/objects/$(test_oid_to_path $blob) &&
> +		chmod +w $obj &&
>  		# Truncate the loose blob such that its header can still be
>  		# parsed, but reading the object data fails mid-stream.
>
> Ah, right, that makes sense. Makes me wonder why none of our tests in CI
> hit this error. Weird.

Not just CI.  I haven't seen this fail locally, either.  Is the
breakage Torsten reports that the later step

	mv obj.tmp "$obj"

fail when $obj" is not writable?  That does not make sense to me.

> Junio, as this patch series is already in "next", do you want me to send
> a patch on top to fix it or shall I send a new version?

A separate patch on top is very much appreciated.

Thanks.

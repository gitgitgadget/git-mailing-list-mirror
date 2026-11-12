Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506840;
	b=aP6U2nok/UxJfrydgm3/NwqqqpYQr+oeyhBQeNKZha2hWz3PwwGiynjlPUyo0A/SCO5F
	 uyqGToeiTClmzbP7RLwy+aOati4s5pEp3oSkcUHtXImIhcUyxzwjMSrV/UxnhcXxPzBou
	 3vCKZv1x5Ja6Ngr8mC+1Qz5n7crDYV5Avd7xotqdCJWjxu7OBeOWCgoVjIS4zXoxyCeEs
	 wDM5dK65BfEJ2cSPBo/rbURUnVPUu658a7JvRTomxExje9sexflfBk9mqM4wS14ZWktIA
	 2bUoH7b9MWpv6cpTJ3MKiFWrfTtCnygzE1tmyqX7OYvghr0qAMsu4ZkNASA3mkXviFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506840;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=k+qGg8ySAG+7HVtco/AfAZJtSUcsv4jhYSeAb+Pvogs=;
	b=NARZLAUmk81zCDqwxp0gWz4ZDls1Ue3F5B8NnZv4VGOgVj6cgyfRWKpjnUMY8tT0kRu5
	 9AE01FUPZD/xMkDYEqMNgOp0MBDOgXL2CLCd/hlECWfTeHrv3lDR5AvpONkyBimqaqqJb
	 fBcUxITLLWdnxkik8jtxaGVALXGMUhEFeymclcopxnlB7Kvy8sh+Eov9NHNn90vhwD7uv
	 jGYRmNWUuf1atpfDStl8IpFOEp57A48VAOpG9p5MOzQxRI1SnNNwYO0u2z/nyeXFN7Nkg
	 lhvcnaNnLo7d+2AXkG3WnH8SVW7Q1Pz1Gduuk5Rp1ogBP0MMQsfl0GpmvHuGtPcNKDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C6B8vJ09;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zRtJ+7dh;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C73606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 18:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C73606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C6B8vJ09;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zRtJ+7dh
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C9B371D00170
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:07:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 13:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794506839; x=1794593239; bh=k+qGg8ySAG
	+7HVtco/AfAZJtSUcsv4jhYSeAb+Pvogs=; b=C6B8vJ09puOQ8xIrOE8tDg3p//
	CNFCFBLgNC/KgGG+C66E+ee1sjnDe9FgFuHjaqAnn1otjje5fPEZb+jAKpJBigEj
	pva3ikUzl/sdlr8RQUnE4n7IWtuNeiO0pu3SkQbhQUA12Lbbl4n8Xs0hqS3xADZ1
	br+zodQRS5dlTJ4hWlRM3pivd8/iqoCS1LU/7GPlYjP44Cq+lCr72vqoA2cs2v4v
	V4dY2WlK1bmYb8+zlRGuyJ/o9qv9b5d6Is+by6AItGEhvolgCex6obxsttx20iNk
	h2anXE4AviD1w0abX/x/uDeO4WX6GzcD5aXgq9zbdYe2incrvtsMB7akC/8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794506839; x=1794593239; bh=k+qGg8ySAG+7HVtco/AfAZJtSUcsv4jhYSe
	Ab+Pvogs=; b=zRtJ+7dhgZGnsIJqUZF2Y3Q+RrJAJSCk2EM0ulLn56Zd0SW3MEM
	hOtmxuBL333cIweCzxHHUFOCt1iijmymC3/reUD3/TAtXldVGC2HUijA+nnL6JAr
	WEusoIRHtKXVM5CUeQzqMmNRGEepo2l8YQUiDoF/qfT8UQXTXBLmXsfqK1L8whGs
	qPDqeFFAqUl821ncUcEl6ipZfAv/TNLq3uPJ8IEifZiUpykKnwVv3bW5YPVllyon
	fvk1YsbS8Q099ifwCzaZnX5k9D0QSYMubxSWovm+NiLlZDIOxrLi1n8tvHRdSr2W
	OqX8THRWihPzgawadm7lzP89b/hkgvCB1CA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794506839; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SWZGzApvNJg6+jQcfMs39ubyzl8c+FcDDIToY8Mhf4EPcCy
	goL9ILKZTo6MzleQWHf3o1b1XXXTmlQaSHicUidW8iLTTc8cvuK6dluSNJ5Nra35
	YM1zISqsiZZr2wvnbG3q06sH1L392woIFvlRoD+dinf5Kkk9AfeKS3giTJ1TC4P/
	PEt+KbS2P0xcCaKd0TRlCUeY7WlabXZnUrwhIyY+/HLU12fv+MwvIhGCTgVwcnkV
	Wd8kM3TI7m0cHAGv1yvwJMjYb2HiuDAQWNe2Xt4khsjtzM2y4szZuQQ3bq5X+mL7
	Zm6sODPXUluV8f9Pw7xFVO+YWfAorQ/hxLHIg2g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:1Lo2RPQe4siSDbcyJFoicstYKQSmorJFTOlUs7aCp/s=:PnbZnvtR2D75fCIKDF6+WSXaqZodAZG5pd2nUEHJTYo=;
X-ME-Sender: <xms:VwD2ajOzCiVhBQpwK3jX3RCOmvgOyYUScucN4-LDWurGWr7ydxNtfg>
    <xme:VwD2atAZ-10Vo1Knd2NP9L82gbS7FaBytfLC7Er-B3ld4UuWyh_zDDvZvMpIMCM6n
    U_bk2tek3armUqTPEBR6kCGuKtOYbUdgYQiX8DK8Cz_pbIbpozvaA>
X-ME-Received: <xmr:VwD2aoebZ1zEz1C42gV0gGujoxMNvbuDxytDsuh9W7daB-G_K3uE-U2R7KGYhcEyJs3ijd6prJVb3Wj7WOI0FbI44rHIKGpT9Y7a>
X-ME-Proxy-Cause: dmFkZTFS1ckMqYkIa1elKdFAWKfU3gb8T8c0Cc0LeZTjTT8kSeo5+rB5Gf2BvFhbV//3+B
    SzU3bhZpVdHelFTNp0KU+jDRo8yRXrJt6b4anRQRMxotc7HWiNuum+pngzYhAGwLRAXKyJ
    JHF0wTZJV9dHc8dpoC7oMsw58aAL9+mjNRM5WGHur/hXtT/wJDWSBNaTV8BzHzCufbHagu
    C3joCgG0nixduoIh7FZ6syNdSM63EkQkSevqFP4ejlpGIIKohAgeupdyB9spQ1mDnUHsfO
    lauIX8EdFe4ZJUOutP4UPdBX9szTBHTWbv71cKFVA8wxjzh68gzcc5uuvJxgdKpA/XHdPA
    K2QVUNFvxrfPDeP7bXlDOXCgIwU07McbuIP6aeWo9Bdu0vE9ULVTNia+/4f9Q8MGo9aFkI
    4710lLvDwTfgs3F0uR7QkJkZ/S40MG59s3WBOnowt6PYRx4adn+OzOXWfZtLTofiGyn+Ot
    q7+a6xlYGNcYKEsWqLth4lX5iJ6gyCpNCB+va9g601+U1j27vkZ+IQxNEAyPNepbxjsX9e
    bnkt6zPUd8+JDDPSjbSYz8Jo3/vt6bwfKfhQE2eckzocTLGF4AeRqJB93Pd2ZkGKYPVRId
    c2GGofbTJaSPfmHOS/779B9/Axuea1P0IkUfQzcNYllCdbMWKk9ClTHmmrtw
X-ME-Proxy: <xmx:VwD2akOgNVUOpRnGafAfo1fi_gnbV4mcjZzziihXsYS3LgKZi0dHkg>
    <xmx:VwD2agL903U807YrsNowewh2gH_O-Dy27IUV5lbl4aK_NjojkKZn3A>
    <xmx:VwD2asKDInvPM6QMJkpwm9RGANAOhvq_H0FsPfXhllq7vlp7hTP1Fg>
    <xmx:VwD2ai62raWYUZWK0SfWPzW72IF_r1C6QGOya743AjS6dk__O_4oGA>
    <xmx:VwD2aqchzSWMqBF92L46wGWgYe11THuK_PaRuEc9V2fzAl7r6BLnI2uK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 13:07:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Axel Rasmussen
 <axelrasmussen@google.com>,  Emily Shaffer <emilyshaffer@google.com>,
  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] ls-remote: add --show-object-format
In-Reply-To: <20261112085205.452463-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 12 Nov 2026 10:52:05 +0200")
References: <20261105104541.790881-1-adrian.ratiu@collabora.com>
	<20261112085205.452463-1-adrian.ratiu@collabora.com>
Date: Thu, 12 Nov 2026 10:07:17 -0800
Message-ID: <xmqqfqx5kjoq.fsf@gitster.g>
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

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> @@ -150,6 +154,9 @@ int cmd_ls_remote(int argc,
>  
>  	if (!dest && !quiet)
>  		fprintf(stderr, "From %s\n", remote->url.v[0]);
> +	if (show_object_format)
> +		printf("object-format: %s\n",
> +		       transport_get_hash_algo(transport)->name);

OK.  transport_get_hash_algo() just grabs transport->hash_algo which
was relayed from connect.c:get_remote_refs(), so even when talking
over an old protocol that does not explicitly declare, we get
GIT_HASH_SHA1_LEGACY.  IOW, no need to worry about hitting an "eh,
we do not know that" here.

Looking good.

> +# Run "ls-remote --show-object-format" with the given arguments over
> +# protocol v0 and v2, and check that it prints the object format given
> +# as the first argument, followed by the same refs as plain "ls-remote".
> +test_show_object_format () {
> +	format=$1 &&
> +	shift &&
> +	echo "object-format: $format" >expect &&
> +	git ls-remote "$@" >>expect &&
> +	for version in 0 2
> +	do
> +		git -c protocol.version=$version \
> +			ls-remote --show-object-format "$@" >actual &&
> +		test_cmp expect actual || return 1
> +	done
> +}
> +
> +for hash in sha1 sha256
> +do
> +	test_expect_success "ls-remote --show-object-format with empty $hash remote" '
> +		git init --bare --object-format=$hash empty-$hash.git &&
> +		test_show_object_format $hash empty-$hash.git
> +	'
> +
> +	test_expect_success "ls-remote --show-object-format with $hash remote" '
> +		git init --object-format=$hash repo-$hash &&
> +		test_commit -C repo-$hash one &&
> +		test_show_object_format $hash repo-$hash HEAD
> +	'
> +done
> +
> +test_expect_success 'ls-remote --show-object-format outside repository' '
> +	nongit git init --bare --object-format=sha256 empty-nongit.git &&
> +	echo "object-format: sha256" >expect &&
> +	nongit git ls-remote --show-object-format empty-nongit.git >actual &&
> +	test_cmp expect actual
> +'

And we seem to have adequate test coverage.

Thanks.

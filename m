Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394446;
	b=eaPXu3se6elgnbetlRWxJXH4jnvW3oBYf9JAAEQuNO+6QFCBCuin+1sw+2xYuLoycend
	 xDMb6ecALP5jZYHC7xss+xxrfJquoufGdm/yZ0FcjQ8bBCVryrJy3Ziy/RgD/f5Q96PSZ
	 Hb5TafzL9brqMtr8DzJUERvA1EX8ZqLavrrUWE+d9g/fPXccTKFtVX8ZeEDYM1rWSf6mx
	 QbiDJ4mInl2yGxP9arFjt1/Y28Nka9MuAy6I0O+NuAAVUMMWzC0wURJtbfU+Re9YBAxXI
	 sDxH5rRnETBjt5mw9KrSvhlwCuvY/AaBUoiFgoTiJbhVe5KNLq6XETFWGMVF3fHCdqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aXD3QZJ9U5Im2ds4/1AxDUL3BUG7P4OOuhTssXRy2ec=;
	b=cMde4nWSyNafi9pAZlME2eqdoh2qcw3CQy5/FSRNmq7gG7a/RdtJTOR1IyqWBxjj4/lS
	 crjSLMhxbS2VQeSmKP751ZHTmkIWgv8XepVLAyO+pKLtnZtuw3eS2VQb05HOgR44PeLrZ
	 JrZuyUUJLUNi9OQMq44IsKNN1zE9oREhQz9S3eETDu441f7x6LtdbwAjfNiwJEnX4tTjo
	 UfE4EjdPpC4P/SIzZepUXCa0riI7OhgjmHcV2+LhRM5hE+t/UehFdTCYeSP17Yf6oO8NW
	 IPHSoPAkNt6MBDa4/KTcycgsQnynVTK5xDlocIEZr85ykbb/ljJbze3fRwVfgOZ/QwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NFmKEjR1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FQDu4ZMo;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6B606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE6B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NFmKEjR1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FQDu4ZMo
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 027441400088
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:54:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 11 Nov 2026 05:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794394444; x=1794480844; bh=aXD3QZJ9U5
	Im2ds4/1AxDUL3BUG7P4OOuhTssXRy2ec=; b=NFmKEjR1C7zZoA44j4gWxtxWW7
	ACLZTMxqoRJu1q+/roJNrfTUW3cM16pKpyiozog85ce6wLIpoiXUhnMjA+yuHKsf
	rKIcwY5rEtmmnR5lDO0o4Fvaz7YmaVUZk0UjQMBzjsOIc9/6VBTRxPckEl25eI5y
	3CPet+jglzNu+MB4I6pmGf5q89wm9jPo24pxPkdNs4orm9CJheodWQo91Jz6FH6h
	ocbs+1wpl6719TOpz3dAOtyvmnhADnZsIjNs2v1dlcmWLwYr7+FmO0DanaP2Pwe+
	bfXe/uUk7Bhfwc/Lv2iooBlc1KLGSqnPPs3dJMglQLkgeIJnH+DkEuxG6Pbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794394444; x=1794480844; bh=aXD3QZJ9U5Im2ds4/1AxDUL3BUG7P4OOuhT
	ssXRy2ec=; b=FQDu4ZMoTwA0pFwAEKfhXrj/mBuNbqWdo6qn/DsEp4lVPiaVMve
	iarM6UEsH1BiVJsJE1DvXpOjEfPSU+IFixTh3IBXTPq9msNrR1qUCX3syGGYU8jo
	DqrZxGhK1g7xT6AOqn6Lf0Z8R38RSLhDbM2DXYX/k+VMw/sSDKP8Qlz9ek1h5Wsd
	aIVDYR5gCYLfvMi+nx1DopkP8VEId02U7FwZoYn8hfLryLbneXPEG2vP6pobJubR
	ZeMMiDS28mWNKya/k36Iy4AFYkZgpKGUgbGVhESN01dbIEF3CSNg17aDhdAdXrDa
	QD0tQbYecivOARu2t77gaGUOMf1RC59GArQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394444; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xT+2I0/wZu7cJFp6qcrrtzJXWLmhbbE3HuoJq7PGpK1rL8H
	8ODb4tAu2TgtDplg42QPKnS7+130MUuQ+8ZXQUcg24gec0S9cJvYPQtBrpKQdgNQ
	HPtcVGQ3TY05VUq1G6qONrSCL+GIKiQz6rF2KLzc5+SQs14eaSIHYsdHrbJs1Czi
	MF26ljqXTpJQZmrlcZWF1BRSbdHul+rPRAUwyf9BeB8cly47wFUj9Ov526bBxCyV
	xUlHq7Iwm7ONVeZvO0cI04zVWovs5raSpzNKDbtOe1EzniXM2XYECsvzxDK17rQM
	SojaW3GwDg5UiEHLpPxqlnKaLQfjfS0mFs2YtnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VuqnsdD4W13uYS5KCR23vYYqDV2ftZukvaj0CvcDbYk=:PBWNHV9dH56G0xGFwFlSLfOGe+e9/MCDCrmKs+qNy7s=;
X-ME-Sender: <xms:TEn0ap0UmZlcHkDhuLlVgT2PYgsN30astjoS7bhm2vvHGKuoYSLH5A>
    <xme:TEn0am-7mzDrd3iKmhUr9apSTXY7pW6jZC8OUGxRh2rqB60OvFDFVLZbUw2wT99KO
    PwnM95Crn_7FSTbuaeAfzsb0YRRk4IdrleP_YXj-O83JjD6Wv6Ev_Y>
X-ME-Received: <xmr:TEn0aiMbG0y_maLuggfX1myLMHG6a9LrpTx4-WhApaP6bW0ZfFeTWIQ4vqETc2wBoqXhCg>
X-ME-Proxy-Cause: dmFkZTFWJkaZy/xdhmOUSCA7vJUDlhRXkrFQzUtFuqQXTwIOb2m1d/EhkCrcaPd9d87xhW
    Tzllf+ogZfFvpavVTtv4m9LnVkVDD+W3DcLhqO7+IVd/dyx52c0dbRo5O5YGXrv/aqKISn
    3kjhq4lvA1c5QFhaeNfAd1uwpqpgFoqpWYpnuwixb2RPkQnxYUVCfj0uIdhXiw2e95z68A
    Bihb4k0vfDpVL72ddQP8i0g63BLs0m0ORdlNn7t3oysXR2XScwBFrUcceYGzj89iDqzy9l
    5OSCUA7c2xSqe4hp1N1tF2B75+dENVgMB6mJelwPlA3t0W4ZG1E2r5+vO6SXVEsC/EnAil
    sJA/at+XaqeJOv1DrX9SeYAR/28f6BlwYx+Wqwnt8z1L03tsdPr6GqepPZXmfPGsRfzlU3
    LGyD8dDwh9O3TchZuO1NoZLltNcqcQGkR0ObcsA/rxzqDTMauKybry6ubn272bT/7qpXZg
    alVCV+LlsrmifqPbziNcYrpEIZZuatDPJwdMNWiImRuKl+q6n28QsfKvlhML3clxxt62x/
    X5WejbTJcXaeVxwurhBhDceAHtNGOxW+fN4NfbPsdM0v3fpoH2ugTgAE/8YLGyJKerBRX+
    HpNv/gvu5O6VQBsDC72ITtweZ3+m3hWAaw1mKneMAmQXc3VM/KFdYekoOFsw
X-ME-Proxy: <xmx:TEn0aicq0aWYAFiPFSERqzM7r3fdrwpUI1VyiqBYuR7gMCJgPnroYA>
    <xmx:TEn0apW592iJhFpxHHSHAIJvH7jVHkb2UDhGV6Az5PhrOrBuCHXPUg>
    <xmx:TEn0aig8jpHI1i3RhsV5otacHhN-g5Q3eJHAQgJsSvWCK2gpeTSQJg>
    <xmx:TEn0ag_VtD7he7CBjvrapOtmW9WeZXK7J6O_DmrnlMM7JSKLVvJdoA>
    <xmx:TEn0atksaMGcl49hNnBoG4G5cG18U_iwsG0hxtowJMvS7rXh6Xzeky7F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:54:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdfd3cb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:54:02 +0000 (UTC)
Date: Wed, 11 Nov 2026 11:54:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Kristofer Karlsson <krka@spotify.com>,
	Collin Funk <collin.funk1@gmail.com>
Subject: Re: [PATCH v3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
Message-ID: <avRJPDEJWTGWySKp@pks.im>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com>

On Tue, Nov 10, 2026 at 06:26:08PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
> index b895436a32..e8d83d5012 100644
> --- a/t/helper/test-genzeros.c
> +++ b/t/helper/test-genzeros.c
> @@ -35,3 +33,29 @@ int cmd__genzeros(int argc, const char **argv)
>  
>  	return 0;
>  }
> +
> +int cmd__genbytes(int argc, const char **argv)
> +{
> +	intmax_t count = -1;
> +
> +	if (argc < 2 || argc > 3 || strlen(argv[1]) != 1 ||
> +	    (argc == 3 && !git_parse_signed(argv[2], &count, INTMAX_MAX))) {
> +		fprintf(stderr, "usage: %s <char> [<count>]\n", argv[0]);
> +		return 1;
> +	}
> +
> +	return generate_bytes(argv[1][0], count);
> +}

Okay, so instead of interpreting `argv[0]` we now just take it as-is and
verify that it's a single character, only. That makes users way easier
to reason about because you don't have to wonder about how the argument
is encoded. It's also extensible because we can easily introduce longer
strings or "\x00" and "\000" eventually without breaking any existing
callers.

> +int cmd__genzeros(int argc, const char **argv)
> +{
> +	intmax_t count = -1;
> +
> +	if (argc > 2 ||
> +	    (argc == 2 && !git_parse_signed(argv[1], &count, INTMAX_MAX))) {
> +		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
> +		return 1;
> +	}
> +
> +	return generate_bytes('\0', count);
> +}

And this one here is trivially adapted.

> diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
> index 0b27d75fe3..0b74ff6157 100755
> --- a/t/t0613-reftable-write-options.sh
> +++ b/t/t0613-reftable-write-options.sh
> @@ -146,7 +146,7 @@ test_expect_success 'small block size fails with large reflog message' '
>  	(
>  		cd repo &&
>  		test_commit A &&
> -		test-tool genzeros 500 | tr "\000" "a" >logmsg &&
> +		test-tool genbytes a 500 >logmsg &&
>  		cat >expect <<-EOF &&
>  		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
>  		EOF

And all of the callers are easier to understand now.

Thanks, this looks great!

Patrick

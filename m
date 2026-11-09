Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243582;
	b=0E7LduH1WAiqQWsj+gyyO/nRKVIFy+r6cNqBsSHWrabeBcbZvN5dsLmhL6eSfq2zz+7v
	 Kg6DMznodQa6QmqhzbJj6/0mbbbbyYR0WDwVeTVUU7MD4o3Bjs4+ueKCvyH8Iwm0ql2C3
	 ejT4YUbT3Nu918OA087VXI52CkPn26Of5hVsLMxJN7fYkE2MAuJP7KOXMwxK4d/GneOIt
	 YRgIi6i9pz8b3SSap9VsEtpsRZpPtYprR/G87Zt6d8g6+Ur/oB+ZxKjcfvJHIvIPuhfdw
	 lOoh7nQ1kBbymoBE+kJFBGomy5o3+WYMbmIf/6RNEGixuuGQ2aedK6IDEzbQ/khcbDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243582;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=lna/+y9ndpLXjUr5FkRd+aUv7BShwvh8e+OiwyosBAk=;
	b=piqhDLOrPjgaUc5I0V9D7gvUo28c2KhoerWcC4z5BKCMMLQN/Nxxi6yxTOgNtCuzN8Wk
	 dnCBAq2UJVwszd5NijOii2XLVIO9PsEQipLhxsBTkr0Eu1KOA5nZio4g5nOkwN7gVj5A/
	 sVUrRAPz3Rk2xUf8W34vVFze6cMNFbAvqizE4fnJ6jdbjcaVEJVOZAnAKx5+hkUXXjMv5
	 Kd+CVssuO3dUbOFqvV7rkQXRUAFpw2TUq4ra2KsPpNRVY3xM1dETt9Nf1y5NO7aZIT0Tu
	 a5n/kcoLcQf+zypW7Nzv8+jFaW2NllRRDqtcjMDL98P3v1/JCrl4hvl7MvL478CA6hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=K5vOioqG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qOdMNwDe;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E66606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=K5vOioqG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qOdMNwDe
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 56BAFEC0214
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 11:59:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 09 Nov 2026 11:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794243581; x=1794329981; bh=lna/+y9ndp
	LXjUr5FkRd+aUv7BShwvh8e+OiwyosBAk=; b=K5vOioqGCzs3573HURo938EgwX
	p1EvHt3cK4YFkk+rVxWtXZnN9ahTlG02eKEClAQCiI3KgjY6pTAXpQGIhBEL6Eox
	n/tPWOQDOQMoKL2T8U1l61TX96eQ3alb8X6DsE+hORgUrd7kBu15zmAQ5mITtcII
	ucXJAa4HwL9VBuTXcfxrWh4a7O/UIKGrczCYF3R1/I/o9tCZGdeEkVdkxDPNY8cg
	H4vSvUCzMQbKcqkQQnBmYgGeAsJLbaVgC4oxUMOdfspPP0T9layqP8Nr6vkn5Hp2
	o/o7HCJw7myeLNkoZSDnucJarlruIC9f3GHnT3lL8nAKRSN2wUhj5BKeq+3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794243581; x=1794329981; bh=lna/+y9ndpLXjUr5FkRd+aUv7BShwvh8e+O
	iwyosBAk=; b=qOdMNwDem5BFXyaWxmpVXit2EX1rYiDmPZ490xj3HENjw74nDyA
	ZSOXPzAus3qAPJovKpq6UvqOJ9QrZ3RKxzORtYofX2bKqt9Vwhngcbz2cwfo9L2j
	1Q/4idd3b25qatAY7+OcdikEmwwQC5I5QD2QAyqB8m/zRSzKFpnnX0QY91Haak/a
	zqUtivPHRvc3yt7dq2EStbPsWekcf/xD2URcWYFw17VbjqWJxINHBaFDcOHZqTru
	vKFSIhzEl6oNOxFIKJDsXfgiMSluYc9MDzaJ8jka6poDXxOfgvALGSi319yHZTXg
	fJdvXQzDyS0UKE5ctCW3y0qEwwWRGTUC8KQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794243581; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jghsVaS/WrBy2ORYlwZj3wGNow9o+afPLLXOF9usWTfqiOv
	Xv0cGYD6VsYysiTYLy2IqGx/I6uZPw3M1TQcXceLC7YFf+2hrJZ54AmAZrAZ9O35
	BMJVuc1fHYHxMItn0O361qREXsjwa0HTW3hs3uDdrh2XxRE6J/SO7phQX2v4Txzw
	Wo4Bw1HNAeRC6nGcpUUtsflrBjIeJR3OU5l0HAKW674Rl86FWEcgRHvhtH4tuS0v
	I4EPxDG8fbK5qXJ+Xh1Dipfl1wGhR6YIv+HYCGCP4+Fer2y5F7PIOnp98E67ruVM
	B4datsfGDEWq60/kyc63ZdlXj8WqcDlK/2/CtkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:eFBHVhi49qR8QqkEUSUukkvLN9H4jRZyzuBhkqgR7Vc=:FwbuYs+xQtKcyRIOiYz/sd/a9IDpmvQtrOfQhMcKhWA=;
X-ME-Sender: <xms:_fvxaiKhDAxIpzQS0Cs6QgjQerWrc-0VvAaSNc9tNoHbA-AXTkTV4Q>
    <xme:_fvxahAOqpwBBmd3DxmkthtV_JC32D_rhlltB4NAMxzn1CIbo9gw8CPfeLMgJ77Vi
    3OZ9w_zd4gQzgCe5Hzjhzzplin0Ki0uj89FkUbYFrQOhKRnbbO3WkKk>
X-ME-Received: <xmr:_fvxarDv3PZAkRO2f9BAxw5SnDUCSjRJW4IBHlr4qMnCEdY2FJZusExTwwk7MioG7V5O3TyzOsUJcC5izvoakNhvkJc-lwHTiS5p>
X-ME-Proxy-Cause: dmFkZTG3WU9Z6p26MUkH9ZbpBAry2FEQFBeqfm3sV8AOLG0grSuE5CV8Pk98P1SPIbI0dj
    9Gz0rTsSsBHB3gLshd35WtK5XGrTo6Cnhn42IFfhS4HM0pwB3A48B4cgztDiBXuUFHDEff
    6ikqeH3R8FDQrSE94PuIlUZQiBfOZIcYOnFRD+VnVpr77vpgio51Lj43fVDGkZtcgSjvAe
    RGh5FVo44UMpMr00edk1tDv87E2XIB74B33Aa8wc0XI2wt73x59P+NammLxBVo/AIkem1S
    58FznwzIMRMOSpesQQxLEFk6IL+0PLF4BRxEk5FEi9HEOe70FaFkCJFrRVmHqafpYIudps
    TvvgNCO4aHUChe2WU3e7S6yB2fAeGWgxcWR9OC7qdezwuT5M+bNWqlrxkMFTGySSUGszFx
    pXpqv2krrRS0WpnmlW234hdcfCnhfI9HXjo2ugMVB9SEfvD93rM/u/wbVdVzof2aKuurWp
    7pXazdv7uw7jZFUTlUCdt+x4ZJONlgS1+RYkvbKlM8qLHQ7/nF26Mdrknl/xO6+bxjMXz3
    nYzu5lf6S67MbVqRaZU/D9tXDL4pqF6KjkVXeVT7LACSyjXhscIFtxao+VtTk+KrY4qq1b
    BLufZcQnqfQqFmhQUJ76DB0lcZrNQR04bOUM8C0T3SMefkfo/X1OGftN3BTQ
X-ME-Proxy: <xmx:_fvxajBYS7fReCsizglnCX5sz-rFMz6iQN8YasouPEOIRYbZqOi12Q>
    <xmx:_fvxampppd37vYD6vja0lrVc6zS_pX41zijqbtxkp1YuuwWlgvsj4g>
    <xmx:_fvxatl31xlIZHbfDZJUKEjZ3g-xNUqsTTrqo8ji5YSxWG0w7Vl4Qw>
    <xmx:_fvxamxFsJYBdy7pfqfHwmuINrQsSPHPv8Z3AceiHTt9vi65KsT84g>
    <xmx:_fvxakW5Dn32nzLXtDZ4s3q6II9FIdZpObfNrHKAFq_4Zptisxy4f_d2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 11:59:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 4/7] t0027: optimize how we reset repository state
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-4-508832602d0b@pks.im>
	(Patrick Steinhardt's message of "Mon, 09 Nov 2026 10:58:25 +0100")
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
	<20261109-pks-gitlab-ci-speedups-v2-4-508832602d0b@pks.im>
Date: Mon, 09 Nov 2026 08:59:39 -0800
Message-ID: <xmqq1p8u0wlg.fsf@gitster.g>
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

> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 49dbf09da77..504a7ea54bb 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -305,11 +305,12 @@ checkout_files () {

A micronit.

>  	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
>  	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
>  	do
> -		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
> -			rm -f crlf_false_attr__$f.txt &&
> -			git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
> -		'
> +		paths="${paths:+"$paths "}crlf_false_attr__$f.txt"
>  	done

We may know that nobody has touched variable "$paths" elsewhere in
this program, but I would prefer to have an explicit "let's start
with an empty $paths" assignment very close to this loop to help
future readers.  That way they do not have to wonder and look all
over to find out after what string we are appending these filenames.


> +	test_expect_success "setup checkout ${ceol:+ with -c core.eol=$ceol}" '
> +		rm -f $paths &&
> +		git ${ceol:+-c core.eol=$ceol} checkout -- $paths
> +	'
>  
>  	test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
>  		test_when_finished "rm expect actual" &&

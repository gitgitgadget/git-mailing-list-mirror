Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221042;
	b=gKYIou+unZke7XITFzvDgb2h6LKYdzj3Jk4LxdwjrD8IBqtd9gQ4/ZOEwjnAzzWqUUhC
	 ETMHnkEq+aJvxRVF5wCelfG0mY7uQ7DqNGQqPIVq6jr7PcaqclCXnlUjT1owYtC0B+BZb
	 2FBMU1/m/iWZDHaR+PxHuZzIcLNF1TIMa7Ib36pLgM/PhsEshHdBifA+Znr+qsk3sTg9D
	 IRNFPN4BBcEXn8ihP4NxafWsvwbXGy58UbNYPlvBlh4FCzQSMDVTQF4Hfox3VRDv0wvc0
	 ZISyOZswfaR+fcXxIqB3yrRzTktY+FOxy1Rt+ETzHyT4WyUlVcLfa+BNY0r3SPcO2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221042;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5CfCitF8Z4/LaVh5QM4aJxDMpNASb19ne4Vwh2eMPew=;
	b=gq1069VZAf+hbtKQGrRmkQfkQAhC6kbkHv/hZHxsCXjkP2giHuu1NLsnsNYwQMZqjq1M
	 2GasW8y3lsg5WLZ7SEJTjXJlcn5od1RXt8KhjwPifY4zkfE20BnbiB2P8s54NCpmBWjT0
	 85w/DheH4L4V2eor5KSZcRqzfNn6GcQCTUMnPiSh8BvYNt+uIvAMi0W9ugbYmBCKeFQ++
	 a+7+HjgusUqD1EAAQv4QLaYzip1RjIa4iXVinZFyot5UeOA7iJSyOCBwGV6YAD5pUUXMh
	 HfSYVzow4iXRXo8JX4AgvbCNYfwropaTElAugnf+/wBI7l/+/m1EMMh8hyBtGkh6Y2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LDTMjmjk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ChD6qKSG;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EB606A6B0
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 00:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073EB606A6B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LDTMjmjk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ChD6qKSG
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DCBEEC08C3
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:30:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 20 Nov 2026 19:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795221029; x=1795307429; bh=5CfCitF8Z4
	/LaVh5QM4aJxDMpNASb19ne4Vwh2eMPew=; b=LDTMjmjkg4XSMalfuIFMhjyV7R
	mfzIlPAkVK5eG2mbbchEthf+EMaJ90G9DU8iZnwfEciRBRx7q9G+I6EPQFP6ESG2
	bLR3kEGBSeHnHOt1rZ4EFuleaQQMYxOZWstzI+gLRh8GIQAFAzDNlj2BHj/wDFMM
	a+Z16IvgtnK4jVD9f8FBV2fx6P9eaQ6Ft0K0T+VdzttvWFdAgTp6zWydaU7nvM4s
	mHAaS/7OjYK5fq7OKGvxL1GOdWTQiIr9O6L3/iyV1+NtDG9Vzhf7H9KCVLukrEjm
	QNrFdZ09KazlTcSs1dpsfW/fgj/JSoPKrgG++wqOfYbfQ1q09C/9ixR2cc5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795221029; x=1795307429; bh=5CfCitF8Z4/LaVh5QM4aJxDMpNASb19ne4V
	wh2eMPew=; b=ChD6qKSGqj6T9Z2MMHmPS/atNG8bEjW+EWsDy6oWr4xhCiLwt0f
	SaOGQiiXHtrdIhCiaTJ45OA9Dyj0c/vdBuklqM7Pnz6I7bZAZPe9+qZq8Atx5VwR
	WML1dNpniaaabwcp309D4QGDT8Ff/hMwMvGtxZrvwBmudvR3cMe9wxFa8AKHKc0b
	wDyp5UPPRv+pGDMMPEuu43RvGioiMA8TmtnlH4Ve1VBaVshUOniK6wveAqX7trRN
	eBlLHJQ+68X5FqrDS9gsOVWVJI8UTPmkAVN+ErWYiltkpIvTir+gxmec3UW3bxzS
	+twFdPH578kWpEV/b61a53fSmVZo88IDc2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795221029; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:envsJk9ntINmbgcMP793FajjsL9xIxmwcyrvSJntsYNKV+5
	x5nPdB0ASahYYahv9PRMdiJBw+3MVQnNHzRMVtM/sgXeYjZp2r61O9ZWRqpwuBun
	jtRr1vjtZH6Y54pgB6nkm/Rv6QsGEj9wEHbh8k27NoF6DzC1RmlVaOUcbxLEdnEA
	XMsuun9B3w7V/Bk72tRizZQELIUpg7+JgKuhScTpaRCodVM/VyQA9t4WYQOIeuLJ
	u7MTgs244O00s0zbe1rpWe/SN9BPKQxpsUKquA+cfo9U8B62NBbBW+INh5TgVp+L
	9FbTTdypBko3A65pBPtrIEAGRpcRGE07YkGs7/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:9JoDuVlk5kjl2LyOIu4IpPc0eyuvarx9+dS8/j9Kz+o=:/4bEAyF3cBO1l62Y/yaRlr13fzpOXOi0yHqwFhqXKaQ=;
X-ME-Sender: <xms:JOYAa7vqT3TLbnnRTIKWPaDVloRSEBZ_DcoSxFTmEM5D9Cu2Ke6T1A>
    <xme:JOYAawI1wNjqDJqHbm1g76ug-C3dX_53nFimcvnSCgxs3QyWrb5uOuOwbdqw09896
    QkRolIDoGukosDrkIbZOXnq-rkAWM_TOZ-h-rddLMR64OsYYyQJ6tY>
X-ME-Received: <xmr:JOYAa4m4Edy9t5cWq9HHAZ00yDFyMH43L_B-Qk0DA1yQmY-QEMAV2b9ZjeFw0GAzfovuvssVUJyIHF1hdH6XSf3kM55WQFtxDwl9>
X-ME-Proxy-Cause: dmFkZTEnXoeurzcPq9Mniwssz9ULipMkXoSTAE943AGIE3G9PmdshPEzqts0ddvJQEDLsl
    cLbZ+OOYUaG1dxxsFvlYpQM35YhnvmXMh2GLZTvdcA1mrqRqtYSKrwSY8am8VgtCuwx3dk
    OTa2UrrJsV8Rxqx/w3BYIRDOKX3Vze5DcAM+yQDy1IfYud5Fmyiz7zQMUuPrqGbOPHemyT
    ria7ppvtWvxbRi9K7x57mm4x+oESVg8M5pQI0kriMKbr14ELXa8h4GVxXS0p/RIVdDYo9S
    KdgtJPqVBUm830tYYQuL+fAECB6tyh7amz2FQ3SAH3iBwopEI8jrF/gnglp/3jmr1XzEMg
    c8hEnoOSQFh9DNRBCDW4pPaWvAFI6AzGX/yhz5+0ged7ddne1P2KXrgiPgN8b2TM5iTh68
    gJDlp6tbqLrB2QJyoC2l+H0wCHpQB5Ej0twFq72CkVSCVB7NnkmLhsmgVTWaveA4NzYIw/
    ERvMZ5qIea5HH9s0dyLhnVErVNH+V/74Tu7T4HXzWSSzrpgOcvv9R6u8m3OAwd8GR2ETRW
    ghs76yK7CCuj2X6Pe1RWGMUvsh0eIjbHVzQW/w8QaFFZXGOZGRtFl/FvQsWdmVFcuc0Ts9
    yksXDjIqi4OV8tep3Oj60GTSJh69Eg+ndS1ZujCbSXp3e8MlH88C/w7i3U0g
X-ME-Proxy: <xmx:JOYAaxIYkG-YKsDm3UmnxEwOoFo7vjrK2DJLRpu09jBMTJ4KbUYJig>
    <xmx:JOYAa946CCmq1y-hpY_RDWNPmGt-dCvUjELHVgghzpnpM00hxk20Pw>
    <xmx:JOYAa12jPDXuQcjN5aQDFaMWWX-2GNfgFPBzgVcOXPpmv-YiD8uarQ>
    <xmx:JOYAazeTW3M08gp9HWc7otvln4ZfzpYrOW8V7nqtCWUhJ9dgFHgxLQ>
    <xmx:JeYAa6mp_DcoxOfvtUH1ORlBzzvnQUc1qdkQ83-7iJoy3yditJ9FJ8V_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 19:30:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "Eric W .
 Biederman" <ebiederm@xmission.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] object-file-convert: copy unknown commit headers
 unchanged
In-Reply-To: <26080a7a386bdd0ae14725d2e731d1be81774d49.1794932695.git.adrian.ratiu@collabora.com>
	(Adrian Ratiu's message of "Thu, 19 Nov 2026 16:18:22 +0200")
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
	<cover.1794932695.git.adrian.ratiu@collabora.com>
	<26080a7a386bdd0ae14725d2e731d1be81774d49.1794932695.git.adrian.ratiu@collabora.com>
Date: Fri, 20 Nov 2026 16:30:27 -0800
Message-ID: <xmqqld6nm3fg.fsf@gitster.g>
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

> diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
> index 9cafcee509..fdb882c686 100755
> --- a/t/t1016-compatObjectFormat.sh
> +++ b/t/t1016-compatObjectFormat.sh
> @@ -188,6 +188,38 @@ do
>  		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
>  	'
>  
> +	test_expect_success "create a $hash commit with an unknown header" '
> +		git cat-file commit $(commit2_oid $hash) >../${hash}_commit2 &&
> +		awk "{ print } /^committer / { print \"x-unknown one\"; print \" two\" }" \
> +			<../${hash}_commit2 >../${hash}_unknownheader &&
> +		oid=$(git hash-object -t commit -w ../${hash}_unknownheader) &&
> +		eval unknownheader_${hash}_oid=$oid &&
> +		git branch unknownheader $oid
> +	'
> +
> +	test_expect_success "amend a $hash commit with an unknown header" '
> +		git checkout unknownheader &&
> +		git commit --amend -m "Amend a commit with an unknown header" &&
> +		git cat-file commit HEAD >actual &&
> +		test_grep "^x-unknown one$" actual &&
> +		oid=$(git rev-parse HEAD) &&
> +		eval unknownheader2_${hash}_oid=$oid
> +	'
> +
> +	test_expect_success "reject a $hash commit with an empty mergetag line" '
> +		git cat-file tag committag >../${hash}_committag &&
> +		{
> +			sed -n "/^committer /q;p" ../${hash}_commit2 &&
> +			grep "^committer " ../${hash}_commit2 &&

This "grep" used for validation will be flagged by test-chainlint.
Use test_grep just like the previous test perhaps?

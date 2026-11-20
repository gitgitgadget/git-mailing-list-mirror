Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213749;
	b=EEM0DWHwDWpGn7Cuo+woZTmPLfqaaxfN6t59nOPWL2C9GzSvegXkjkDFK0ZVrozN1Pr+
	 yeY3M8vW4khzXq6BQyeC+YnMLJLfDblj/z37Y9/YwomPl9b+e3kT6WKyWfiA7niZuK14N
	 QPFRUSTKRj52OxB4n1+ZBaZjh7+sHV5h0TVbesCCrrecLK+fL2fUBek+9c1XGvXbfdexl
	 jnCAk0A+aK0sUxbuxzUyuQp5q6d8hldPcBVRj/T3yJ5gY18kD4F+NEJCClYtQS0ZLXcZH
	 c/KVMexb11L2DW/NYqx6VekAfRQ0Ii0TZ8fgyYJ7vpNnGZAvDVp9yyOxTClTMqkAzxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213749;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=p+7wHaD4juDnPxRZSQiSFuAMkHpUVl3IdxJnIuL4g1M=;
	b=nm/nSoEo80sWxcTNtlXCSzALAlc7oNwAHs3o5oekEvOvipq0fvgxySBiWgNEWrID65k5
	 duLLaR8l+opRwxz9ghrY0QJOhnBQwYRpnVqgfpfcsm1XDIB1ZNbQ9DXkQD9OznVV318Lt
	 Xjw1HqKxgQ0COSNC/LnUPfxf2/0/YWU6SY22YD9KLO5ILIC6QLfaDW/vjbI4OKb1zzgHf
	 E1AmSanSXuk17oxj4eP3C/NLhdnH36sD87kO4d+k07BdGneBMBjDznL3fQ3WsRTlaGQq8
	 p0WDmgchWQG4zp3XXsJP0qj46hTerSDVRGLLpdA44QtKs2IKas6A+mcfEFx4Dc0H9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lRdKAKcf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lBHzciYx;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9E606A6A7
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C9E606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lRdKAKcf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lBHzciYx
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3ADB14001C0
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:29:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 20 Nov 2026 17:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795213747; x=1795300147; bh=p+7wHaD4ju
	DnPxRZSQiSFuAMkHpUVl3IdxJnIuL4g1M=; b=lRdKAKcf4WIyzj1vUdL5haGPzU
	pW3MUUjKDDsCEaAc1fK6cuUp3sfLruFvu3UbbC3u++sVMgwar84G2hutt8zuH4xc
	Gvc9W6R8xrX7b9SecKyUQSE1Uzuwp0Dl1g9J/PP2pmOCq/E8KWjEC7TFjy73eJag
	kqzy9yAmOZ/qCvsrgI4OEGcJxPy1Ok6sbpJbXWbZvgCHRkQVoDXnV3VLOqFKNhbh
	CgvAuHwehAt2Dz7uNDhNTf23TZqzzwNyv4i2m18ze12imtDHcem1vZPg0p61p9Cy
	CvIFhAGwsgS7VCBMMwC1HhxcmvKV37MqhMZhVuvbXPTNAyfMoT7lscAwhHew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795213747; x=1795300147; bh=p+7wHaD4juDnPxRZSQiSFuAMkHpUVl3IdxJ
	nIuL4g1M=; b=lBHzciYxDtIw8bgxSVdijSSKfr2oIuSCZC4mISLTPH8p8MqjxRS
	bCr3qJZiYHhmh7+yPgh52SvRqjHT09+Dhh+0d3rscycVWLEJp14BbaReTmP4Xm2S
	jnhMfWWIrWsrQ/3h9ZV2QrtdnUtXxnfJxM2n9XkNGtFwhGnLpzBLByqXPv0shAO9
	S/se374LxVsU5z/poRxk/K0JASdRa1a8Ir/kdfQRmXk4oBkeJwK+uLBmHm84QbKF
	eO3HPEgVDjbjV3OMT69JixfNKGQjZr5cFMAf0AGD5wMigLZs21qXmLGVXV/M6LLN
	4CC9WeL+UCDQmE7aokYUq5BppnNcMClkn9g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795213747; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PY06LET9VsJ2yJi55CXqTm6xcPsZIJVUvg7bK3pVdCDFSih
	GXiSPWNrrjL4ZDSutUl5+n8JmQC1uCEq9ABOIns8T8bFuux04VNrpMWjh8vI64SN
	/Ot4+OpbXTsAIldFqLSpJWZffptjEV1F9Q1xRIiBCI3Algxr9uRqPUR/RDaRs/3y
	DQ3pRspaxOd8HYTdjLpU1Myg3Px2VncjV7wGiMhlWJHktCwfrxXli7oI/Biroksw
	qM4yu+MaBSUgLTi7Z7yqsbRXekSixqj5mX5VGhTwTm7FsFJbhePdaY6t4h/2W9kO
	CQStTSQabrx2CO6lJSPIIwjxqukXgsCaWT0YthA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zaK8WlOnkZjsJ2UxjKa0GbAIPBDUHdG1q5JS6YobFOM=:QgFH+JS0mfoo2hRNHk7UOh6805WKtKc3ELrmoO7O6Ck=;
X-ME-Sender: <xms:s8kAa0OKWKVfaehB9tEZjQrVJ32nyYpi2rkGl5YWAuUlFyC839fIIA>
    <xme:s8kAa-pRIHpRzSCSEN07FYDxbGroZRbHvLB1LnSp_iGJcIku9glFxBH89WQU7Pg0f
    bslFXxxCVew2-QW8WAGTnMB5ojZnmA4oTKw44c19bYTgTXKME_usvo>
X-ME-Received: <xmr:s8kAa1F31sG7xDAaBM_iiAS8X3iMjYSuv_rjwS2qas-sgZGMCcCnzWgErTpNzXzvTNYkPpTlMqRd35bz7BFxmQanUKFn9nsJg659>
X-ME-Proxy-Cause: dmFkZTFeYUcpQvyHqECYOMDkS2bSL5XZ2ORxRfaWq6H+uvrzyd4x7xYgMHh18o4M0vgTe0
    V//QX/6zOo5rqWnOwJ4ThrEZ3E0X6FUqStEvCyuTTwECDbMQ1KgTcKTljGhK6FDinL4hCx
    83bwQBMgqcv+v4KDBxZcprRlEJmiERAm+UAXWDc9oQQiarwrgIi7mag4mZUxULeILwCBXL
    0s7e4lA2+E6+wuL6RkKognrrYzlmuw/GCy4F6dcWPZdfWYcvT8bU2v/4oxwE+A+TL/Y4A3
    bU+/Zs4LMOxf8QtihCd/zJKu2PX6QQ8UIKfALgYM/DDLpegY2p38S/hAfIY5e6gbKc38Yt
    KZJfFVq1SNm9CiWtiRVoDxurxIc1cdPoEGrGpCILF3gDMwtfXDb6YA2HBkVg1oFpD8mqu7
    ospLkhNflHYVreKpMIWn8rwFXZoI45Q0tcjenOSp8gEd9XQKc8gb/TTcOv6DyFm/NUazfL
    jcwSWH76+ptilT2+VyigdBJrk+ps/QDWXgaG+Zx9zY3j4ZQPT6M89l56TuKwVm7GZraMzw
    IbumBqdomWaN7l2S1oYfmJ3xMMzBNHl96CN/FZhH2q6SOf6w986lEZ/Rf8BnGwC8ndAh9h
    6cjVbfYtQk9TDkqDz+TW/JrWP2O85mXstALVoCgLHbBchQ130VBC2UTwi7MA
X-ME-Proxy: <xmx:s8kAazoDHVjc0Psl1O4RG3I_98dKxI4sH33Bxk8rndI1mX90ysDBqQ>
    <xmx:s8kAa-ZKLkFmEZtJTGv3x0Z3PI0rp0s14gfRPg5ghA3vX9D7kZP5rg>
    <xmx:s8kAa8WmOGf-Li0jVj8CG6z19L-gecyvnfaI6FEDCleO26wFlOE5aA>
    <xmx:s8kAa392mHrhusqN40BVeOfySxOlj54i30xAwz26NScIH7uFEtSFyA>
    <xmx:s8kAa3FwcRaxuxoHunO2dw-meOrxj_8nwhnmqJtemPOcxQT0YwN80bNW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 17:29:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "Eric W .
 Biederman" <ebiederm@xmission.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/3] rev-parse: die when --output-object-format
 cannot map an object
In-Reply-To: <5b9137274818319747b3eeafaf800ec6874df1d4.1794932695.git.adrian.ratiu@collabora.com>
	(Adrian Ratiu's message of "Thu, 19 Nov 2026 16:18:21 +0200")
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
	<cover.1794932695.git.adrian.ratiu@collabora.com>
	<5b9137274818319747b3eeafaf800ec6874df1d4.1794932695.git.adrian.ratiu@collabora.com>
Date: Fri, 20 Nov 2026 14:29:06 -0800
Message-ID: <xmqqfqwvnnm5.fsf@gitster.g>
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

> Fix it to die with the same message as pack-objects. The other callers
> of repo_oid_to_algop() already check its result.

Mimicking precedent is always a good thing to do.

> Note that this only covers the case where the user asks for a single
> revision, as it is the only case where rev-parse passes the desired
> output hash explicitly.

I cannot offer a better rephrasing, but the above is slightly
ambiguous and excludes "git rev-parse --ooformat=sha1 main next"
(i.e., two single revision requests are made at the same time),
which may not be your intention.

> All the other cases, like for example when the
> user passes a range, do not use the desired output hash at all. Fixing
> that would be a bigger change though, so it is left for a future patch
> series.

OK.

> +test_expect_success RUST 'rev-parse --output-object-format with unmapped object' '
> +	test_when_finished "rm -rf unmapped" &&
> +	git init --object-format=sha256 unmapped &&
> +	# write the object before enabling compat, so it gets no compat mapping

clever and clean ;-)

> +	oid=$(echo unmapped | git -C unmapped hash-object -w --stdin) &&
> +	git -C unmapped config set extensions.compatObjectFormat sha1 &&
> +	echo $oid >expect &&
> +	git -C unmapped rev-parse --output-object-format=sha256 $oid >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git -C unmapped rev-parse --output-object-format=sha1 $oid >actual 2>err &&
> +	test_must_be_empty actual &&
> +	test_grep "cannot map object $oid to sha1" err
> +'
> +
>  test_expect_success 'rev-parse --show-ref-storage-format' '
>  	test_detect_ref_format >expect &&
>  	git rev-parse --show-ref-storage-format >actual &&

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451119;
	b=oNSCAnm/UHAqg4misSprp5JfdVYeVnaB/zPjB5idNbsy8cxLwtFobsXrNIbi57hWPK2z
	 esJOWVBz82RSmFYduJzgidzZ759myHph4NVhFBLyhGb7cAIPc+e6KWYUIjXYH1LKMWup8
	 JQlXIpqTB9HwPYuVxXyziEYNx/SRjW7YVzZEScURWLCCUG9t14cP3BV8oD+LA1eyAs+24
	 QB/cAxojVa9A/UQlU7yFvIxfnTir+qcAt26Ljid4ErMBBMqVrwSL6PkuLYgC1SdeSrK+U
	 /ZvcL4z2eB7vUoaMJ9vrEoepI1xLiD47kN8IeE3sObE4XmWpsNbbQQS8zLQaHlbtkWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451119;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=IZdwqp123cz2SEW3icinqG/pebcsnedDp3WXZjQb14M=;
	b=wfEFPMgXP6rTTQ0OOLjoon9KNk6BjuGqlUBviPByQi5M0QloYf6j3OX9hsOFc6FSlV2F
	 2ra/VlajGhqwDNyGdl3tH2LqHBsZfK4KdvAeuHpRo8rmT2AX6OrBqGxAVvOKEFy8zOgXc
	 oHMYqbL0t1Tfb2jvxIuvPfNl3VIR1vJFf62iKEBznaiBWZHPdFtb2ek7HplLU0bmWbQNR
	 jOX3eTHZSDp0ykIo8zBkZH0+xCLMTR22rTdwKxP8YOJxIPZmMbVIP5jZaFczmXyCCwxDy
	 ZZdrfI1EmtPuUUj+gZkUcqToouyH5LcBvmSCqU+GXEDH5W7s1aJ0rC3b5I1fjKS95SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="ilg4Jq/E";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="N/ghPmGE";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E70606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E70606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ilg4Jq/E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=N/ghPmGE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD8CF14003D1
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:25:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 23 Nov 2026 11:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795451117; x=1795537517; bh=IZdwqp123c
	z2SEW3icinqG/pebcsnedDp3WXZjQb14M=; b=ilg4Jq/EJKAkoBxbgxJ+6LhiGi
	d7Lim0Oe7sFJa/HMspyZ9cA3LBvk18a0RQqTXqnpFN5O8fEYQpWLRL4tejiHDDgB
	hLXV4Rr8Z5DZhGVw298qHeqP1PNccM64I80Ywvit8bYbzPrZha8jQdpCtN3PjEky
	I/8232MQS2IZ2PtCtBH+7ptnRRmS1/faUeFlG3PY1Oxxu7x5OIZwDhxSUnlNDFut
	NoJEsGNwEP5zET5X7VvdsQaWRis46XxgmMN3O2iDn6s+m31RcYVGd8FRssbsoNoL
	o+n8XuARhgK88HVOlZUChVN7I+XpflVDRd771xXJ0xJAqqugOS5GSVxGOc8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795451117; x=1795537517; bh=IZdwqp123cz2SEW3icinqG/pebcsnedDp3W
	XZjQb14M=; b=N/ghPmGEGf//Q/WeCh30NjkotQynUQ1Y8N7o4hZ9jyTith7ZpTC
	FebqRgAF7Dp6EQQEvp67TO+mAcfrU2T1YkjKNYnKkJcRjZI79rjkZcZkKBNc5eoF
	E5Oz3rWaWoUFKO/OCIMZIedZho6UBa50K79GDKdMGgOq27lxzWBot8MUyYh2fDk8
	NeaJXNFEfSPr4V3hSaqmjRHUG2bsSpDXgIdjGI6PLuZnd52VNYzauseZCCe3zRYi
	TjdGLXU2VHClHDw4Ug6iXVDRFMKYQ89+7E2nCJDNHhPCkCXCYHorUVtKdF5744L1
	9foNmFjDGIRWCaEX0/BIHoMtRqBz3srR0Vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795451117; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MHtgfR7cKFtI3BZNlzMSyCdmO5N+elET6fGn0R7uThJsc5c
	L9pzRLFcDeVXtOc8BMKtyjzYsWbAGPCSskrJ6vdvVPS2/Acgk0u9GcWaXacOoF8L
	QjkbBt8zxS3TEQtgUPLk1aRU1DGIBM4vMhcdeSC2Cfb/5ACN2r53GQvvnksg0/di
	x4IRv9tX+R/KmF5ybDSA6mVUKE+m13A+l+wICSmQ79VNz+n2fiGheM0ZFid2u6vS
	l6sDZh+kAvqS2DohFq6Yo7PRuDcL19ePwD1atoU4LEMgiSoq5fiHWWK9wieZWbSs
	SqBow33j642Yant5WzELGoS81EU4mU+1HWUmRPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:13D+XZmVgy7yyfcb/0I/Lm8DVIPEqad+ImXTySWEPJw=:byHlTHyjHGnqMNkYciyKjhJ0NpWXDcoBQbb7KFLZKA0=;
X-ME-Sender: <xms:7WgEa8NS9YXUCHmXXccyfrezHsgvFaZVLD0YOFwsv7plkAOZoQGPVg>
    <xme:7WgEa51VwPIksdkWU8MNMYhWaQV0EbGBFDFtHFz-ctN7MjEWbcGyBEgZWfsN3SDHU
    l_spsyYLeXE9GlxMFoH2fDr0xtUCP5qa2unE_OFE8EygTp5cezueKY>
X-ME-Received: <xmr:7WgEa7kUnt5apEwqtuW5tsQBcCxVW0g2wzUi-F8kVZufYLOIRTBn0kS7IF9UjhctaaB_ri_ULwPObr0B3g8IEErYjWGXIqbvMJJMP4g>
X-ME-Proxy-Cause: dmFkZTGeEPi8fUiWKOWlnMkSGehlPqXoCH8b05op1COAM0eUkUi7p2ZgUuXHLjvRqwWnHh
    MSk98aCSzpHYQr0GyxGwnSuppixj5zGhnnu+1mSXV+7a7hl4E893TmoAbR4Lgbw1MRfvpl
    62/W0xJg90j92JLKuWzxiuPTaI3jrsVuLCr81a3iYaxK19GHwQzvdla5Jal9knvwucJ8bC
    PiX14AXEcYQUgGdXn71sCuBjvPgupx84+i7k9tcjJjqJ1JyDX/XXPot06Z0R4k7qphAwjN
    EjTusWkG/Yg8dubzy0UK+PxSWKbVP8depeWgA2gU9xUBOf/uUp0aoPjRSwQFbGY5q4HMjn
    yF8LxwX8dgA2+k3Al06DVCEPJFBMVax9WJZjSoge0gLeBmmh7RZV7YU2JfWl3+i7q1U7fW
    TmPGxM2J9XTw+XptFIQrUPIjdIfwBs2GspubWWmcLcSL9laMu21IU0nd+aB/lPxwK+enLZ
    1cHnuz6XGr7h7CzOZMRHNeft9A/RmJ7Nen35uWuqKt+1StNuQaZ8VMy3GibnaABT9Z9nJj
    7IDyA/l4+Y4Q3l5aeopGiwkbhiOI9/a6ZmaK1nUqKD3QWWxsJzLJGn/qCiSakDbyyVfraq
    Jz1GZ1tk5O6N82Rewj6mewCv5a5f39JTLDKYU4MsdfWVEJvKpS8TRYUZjbIQ
X-ME-Proxy: <xmx:7WgEawUzGt6UKthPDEgpGFIHiNA7Vtxcg7DRPyJsXHjPje14kx2BMg>
    <xmx:7WgEaxv0r64Tkd-obINwzhuowTdVp81k3AowVxfJbCpNYpvcYWFIPA>
    <xmx:7WgEazaLG-2L7LcGTWSwMli4qOc4I3Xxb1LusLdTAyZevm693-3Lig>
    <xmx:7WgEawUSzjOvdxXF4Av0x3OaaeeFThT6DlutUsDH4F0-G7KkWtUq8w>
    <xmx:7WgEa7Hgh21HCDvEgLRIGg41A277KmMAOopHwg6tLyAxi_yIQ_ach5_P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 11:25:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: [PATCH v4] setup: fix hash algorithm detection
In-Reply-To: <20261123011403.720209-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 23 Nov 2026 01:14:03 +0000")
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<20261123011403.720209-1-sandals@crustytoothpaste.net>
Date: Mon, 23 Nov 2026 08:25:16 -0800
Message-ID: <xmqq4id7bjmb.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +test_expect_success 're-init does not modify hash from config' '
> +	test_when_finished "rm -rf repo" &&
> +	(
> +		sane_unset GIT_DEFAULT_HASH &&
> +		for algo in sha1 sha256
> +		do
> +			if test "$algo" = sha1
> +			then
> +				other=sha256
> +			else
> +				other=sha1
> +			fi &&
> +			git init --object-format="$algo" repo &&
> +			test_config_global init.defaultObjectFormat "$other" &&
> +			git init repo &&
> +			echo "$algo" >expect &&
> +			git -C repo rev-parse --show-object-format >actual &&
> +			test_cmp expect actual &&
> +			rm -fr repo || exit 1
> +		done
> +	)
> +'

error: bug in the test script: test_when_finished does nothing in a subshell
not ok 62 - re-init does not modify hash from config

I think it is test_config_global that is getting complained.  Perhaps
something along this line would fix it.

 t/t0001-init.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/t/t0001-init.sh w/t/t0001-init.sh
index 5def3f98b7..58271c8fac 100755
--- c/t/t0001-init.sh
+++ w/t/t0001-init.sh
@@ -638,6 +638,7 @@ test_expect_success 'init refuses to reinitialize with different hash' '
 
 test_expect_success 're-init does not modify hash from config' '
 	test_when_finished "rm -rf repo" &&
+	test_when_finished "test_unconfig --global init.defaultObjectFormat" &&
 	(
 		sane_unset GIT_DEFAULT_HASH &&
 		for algo in sha1 sha256
@@ -649,7 +650,7 @@ test_expect_success 're-init does not modify hash from config' '
 				other=sha1
 			fi &&
 			git init --object-format="$algo" repo &&
-			test_config_global init.defaultObjectFormat "$other" &&
+			git config --global init.defaultObjectFormat "$other" &&
 			git init repo &&
 			echo "$algo" >expect &&
 			git -C repo rev-parse --show-object-format >actual &&




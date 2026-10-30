Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360683;
	b=hi3Ko4AnUkwkbCIvyCtlU17hmhhHrA+kj7lU9sSWw8DAcV7lGoJ+B9ZqMdMCHmFG326v
	 XabneaaZSooxW1fWfjD5xeYv2JkNZiA+bI6Cr9jqHLupd05tnnHQQVjhD/FFIW56ZVA1Z
	 qTK1th0fE3D9heioBq1J+qPBcaEvvv3JdF+AK2gLvdHq6rHwuTx7dKBFAyAfFi6gAgFnq
	 bCQVRk3GJGeKLncRYtBlAUO8LUf3x/tbQR2nOrmWB7Y5z+feSqOcqMc+EifS2xlPAj+X3
	 u4fY4kjsvHWlrsPsnzJzE7g3WiJYtSjrkTLiZueZX2e5cZ9TCMqAAZA4xJFtd2R1BqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360683;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uF6hO61BEUX/d/lC2a1EFppSpga5TcespB/emHrmVDM=;
	b=jiLLBiYue/Vx4q2OUKausMlNvTck4OtCA0u7wQRwiq8QsexqYAw5by0/jOI1W4CIJ02H
	 xf0AcPBipUeSruPDyJlGU1ZxrcLUx1V6moFCSAG6lp1StIFFrqpVNrjM6ICA62ORYLgfQ
	 T+dMpyBU05gJC2gIsOUydLBLbxTLMaUqqvowUnwR7Y/fADhjeg8IU8scmxfsMZy+JdTx6
	 P5nnOJI5fuKkiKABG7pPY0OsHIyDlKq1OZ3JoNBEaaLwi61Y2vjChha6CXE3h/64NLtLh
	 3HjVogp6UIhNomaK1EzhRl7dT6LkcQym5ny8h1xNNfF7HHSr9s+KDh+YurE69HfY+pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OsC7voQO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lOmIwyjX;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68C606A31E
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE68C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OsC7voQO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lOmIwyjX
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3842D7A012C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 07:44:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 30 Oct 2026 07:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793360681; x=1793447081; bh=uF6hO61BEU
	X/d/lC2a1EFppSpga5TcespB/emHrmVDM=; b=OsC7voQO1Zo+kDpVsqNZAxgYX4
	nlhTRLCPxLtezHSSLwNnlU/ZFt7sy98WKFbkeoaSVKKUrizAGCLSiQwD96jFhllw
	H/CypOkzZfpOZC/nvd3WqJs1Rri9ALQXdbmRyZJP4LF4fSSFkyIB0HyZDC1S+cup
	8zbbfGIOeVKk9iKENBBQ+1tEHkgYgUthyh+RbSSLYXJ84Df0v/PT4NGCWXw2lJ+1
	SFx7sF0xgerWkmB1L9WHADWIvCveRNCyJxodFCPMxfvq3hbn7uzEXo08TAnyjOAD
	3QD7qJh49oBCLpaWEOSCyH/ZN4RFERByCjJGOoA8PuFJBpF0+EdeelBSh3DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793360681; x=1793447081; bh=uF6hO61BEUX/d/lC2a1EFppSpga5TcespB/
	emHrmVDM=; b=lOmIwyjXjM3wTZT386jBbTetaasz1rxbeEv7xWRy/SQFi1gzlTx
	Rgg5DzR5wnhwXrpp5g/OOCwOGyWlhIZT6sbd4W+7mdFj0VhpqJZtUfsOjLt4cRLa
	SjyJnOtMV63mbaM2CJtpERZYYYZ+yTVr9ufxj+vUV8bYsLigSWAMvp1/FngGRc7x
	u/FW1lnNItVCzc0bo3V7S7l3yfN0Vwc7J9xFmd+/qojI6zNdj50WX6NMHP44cTIa
	y+QMxp46TZNI6dzOPNHtTnk9KRnq1X9F2N/5l3J2uMpq7XMXafAThEUNyMJaaJEk
	WYK+cBnlKxzKvAnUO7vuSYF8/GOQwTTBgcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793360681; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:a1MlKjDK8bfmoGrX5iomKDMJ0cHKvQ703N/3P4NaHejjwkK
	Fp5Rj6QMAcXbiIc0yI5ykiC7Xok5O9DC2an7GaZ2fbP51F1eRb7PWyF0mm1HH5Tn
	BbmzUHzRT1j5HwbNd7p4X4Q3hT7fT/wk/NJJXogkpCAiI49D2l+T3/iI+0n4u6Tr
	x62ALsmQHN4HBnIgX6JFeKqyJmvpz3we4lCZH/BPZAVtnZh3DKz4X075N+ckWBdo
	d7aItx54ceDptJyxhSJWGmf5xZvK6kDDV0XkRo1pJP0c9aJzaNujhPTF/7hoZdra
	mBmNC+JDtLDOkLpmg86YSmnA2fMOMviXmQk1cAQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:j2897QwMj20BDN9hpe10ujqXooUwfB/cpNUZHj6Uris=:1qqsPGNbB5JTv6/BAsDX9OMz7bQk2HN7dO+c7MSa5U8=;
X-ME-Sender: <xms:KYPkajuiI7wzuiN4txeyf8uuca09Jw3l-3l8Mn-W7xOZLj831E52Aw>
    <xme:KYPkarX7ffKYndfdZ_FAHBZMsq5FtTcOe3OqUXwofq6ucj2gsJJ7qoFwIXk6pAD1N
    e5Qz0p4vRQNNHfBVp937UxplORGB2TEZW1AtSNoiUOwrFlLMDiJ1hE>
X-ME-Received: <xmr:KYPkavFctxPODyyLu4si1WWNE6zYha-eneAbNJyCXCYchl2LRTIdanBKG1eUfnTsaTOyfA>
X-ME-Proxy-Cause: dmFkZTEweYRmagK+U6NI40C2gOY56/U7LG2BkHRYtHGegF8oYRz9i4J2vGpEgnudzkTbxw
    S+05SZ6tnysqAiIuvW0rwxSCZ00N22HDFMiHosy/Ua4cl6RIbsjuJ/uu7lp6OCXbAHqwkT
    6QXUlJGPjy1NHLsRNtVlr5IhsX7e34mkzuRSD0q6qfCPSfug2rRloXJkdp42sa5WRXVz1s
    OB/Vtpd017fmsUWB8n51/KGmPksOVmgNcVVsvnKkP1w/4p1Gl3FFTMFj/yE9SGa9bGqYZd
    DEAc5WEVzqrmu52PmOXcyz83GCHyepZh88qBQqR3ddvqbZWDlNCiYkOIuK5E9t2uSo9Um6
    HiVIgMYoLTUOBe5foGA2aWC2QphM1FwvnZmsHBYBKVVFZ/M+3xJ7SnV63k6y9sfdSKnfWd
    VSkZIRzACelF+7cfgFIP1H56F80BC9a3ucV3oR8FvnyVa1BG+XcS/Fl5KHIkosBnU9LMWk
    ORzOZpg3t9E7OQYBLgr4Qs3fOy/OjtjtDWiX/qNwyM2ZbHQYQcV4/g0cTEwQnDrU8dogPC
    S/QEoNhfSI2kQYDjrGL6m4WWDLgZJZZijIcvy1BkvFn+uUzLFBkf9p+qKljsk7VCX1OLWX
    Lgfp6AJFFkjwJHn2ShOYTbjabTpdtHDW98JxHo0AA2zWYUdZaMmNTp6BIL6g
X-ME-Proxy: <xmx:KYPkat1CYFTSYRzoctVzMxVltGLK2C1SnjdG1VdRBWq2VmtSwKymIA>
    <xmx:KYPkahPD4Of1DzmBqYoeoL1Lx3UumIZF5IetjCCSoaMbcK9iyHSiDw>
    <xmx:KYPkas56dv3M3U8nFG4Dza1SfQE4TTLM7c45A4EEAZYP7l5i_ZV8mA>
    <xmx:KYPkar2l6I2zgab6G-dhalA5QQUQJg_GHoSNpGYEkq9LJ6Z57iMwIA>
    <xmx:KYPkarSFzLheB7q50lLlTLDNuzrpJhpmKC9WsqqrdsHl-99UwJpGm4-P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 07:44:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6e97cd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 11:44:37 +0000 (UTC)
Date: Fri, 30 Oct 2026 12:44:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] odb: use size_t for the length of objects to write
Message-ID: <auSDFRHpLy65PMF_@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
 <cover.1793352943.git.gitter.spiros@gmail.com>
 <8fcb9f10f13962acd5cdac652bea8fc4164f2e78.1793352943.git.gitter.spiros@gmail.com>
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
In-Reply-To: <8fcb9f10f13962acd5cdac652bea8fc4164f2e78.1793352943.git.gitter.spiros@gmail.com>

On Fri, Oct 30, 2026 at 10:58:50AM +0100, Elia Pinto wrote:
> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 463b38f990..0a89bbb455 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -297,4 +297,17 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
>  	test_cmp expect actual
>  '
>  
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
> +		'write filtered files over 4GB correctly' '
> +	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
> +	test_oid large5GB >expect &&
> +	test_config filter.null-filter.clean "cat" &&
> +	echo "big filter=null-filter" >.gitattributes &&
> +	git hash-object -w -- big >actual &&
> +	test_cmp expect actual &&
> +	echo $((5*1024*1024*1024)) >expect &&

Isn't this the exact same as `big`? So...

> +	git cat-file -s $(cat actual) >actual &&

We shouldn't read from and write to the same file. Maybe write it to
"actual.size" instead?

> +	test_cmp expect actual
> +'

... can't we `test_cmp big actual` here?

Also, it might make sense to use `test_cmp_bin ()` instead.

Patrick

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402963;
	b=UpfHVtsMNiPYZOrxGTscjMsvEBLUVlBs9GMkDn7NO33f23aq4bf3y7IOXWj80YXIaIob
	 KQQWPeYL1b/g6paHr+JKHq8sKBmKt9xZi4cxGlRGYlVVqJtxUU1yg2GTkn3034rGEyjAl
	 rHJfWCXZXsWRjf+xacKksFR2oFPrpR/fCGPSHfbRTbfGIg8Ji706nx7zZobuyh1AI35lH
	 s5QpMXoOEXnZxnLDBAficLjBWuTw61807cf/SLynEqhv3vRHvqJgYSCPDZ8dZ+at73Nol
	 zqzoNoBPrGLjvijmEnkes6TqPKOewyRMPTZ2OMKSSqMq+0/s8web+j3Vg2mI7+MCiUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402963;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x7qiHbQ0XadT/Tn7x2KT04W7sWm2SzNrF3rnoH3a+eM=;
	b=5Ipz98RLswHc7UN+WUFtkhjUDYrhPP96l3mRagocG3uW1QlsC3nsbojLavdgAsOnUtje
	 5yyDN9xyhKxsTtD57xP3Qkwdwy0igAmv4tzT6QFJ/ujR7eI2aZ0m5ONUbU4Q8Y+btJCRi
	 QfMc9ht+1mXoOxaGwwO5ogpbGI7hGjjlezkwNiigC8P2TkoMQxP756XYtidNkKvEAA2jH
	 SFHSJkl1CVkBll8H+MUTkBOx5jckfkoamHK//pyW+q3+DyzBuxvtonP/Oyql0BJOF20RE
	 lk+q8sn2EKS4kV6fVTFSTZsqtD281IYLuZa0HXlMNy+hBWFxO7as6/+hTQmJu/yYepg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=iGyiwjcN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qFQIA45c;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2258606A32E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2258606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=iGyiwjcN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qFQIA45c
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 511357A02C3
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:16:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 08:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794402962; x=1794489362; bh=x7qiHbQ0Xa
	dT/Tn7x2KT04W7sWm2SzNrF3rnoH3a+eM=; b=iGyiwjcN55qCfJB+U0gCK4PBHH
	9x/Gv+UpNyYetRn1Vq0Mq++r1epRVkZy6asYqcUNjkZ8VjSgPlydA6GF82WxvOmk
	JXSgtmr+M84uDua/I7W3zI5gc8+E7USLmOI10jxd97upkRqezUJW3VvUbS39w6rJ
	F64ThSln+M8vHbgm5m7LyTlOTDo8T+bnVNk3kaBtYjTmI2x9xTCjWQXsph9jIKM5
	2NK71rqwiVeyVZyuuP6tVVhndgam90FA5gd9b8VXQcNSgoYHdBpScIM0Gq88Z7qg
	7ONWolQsNsIFW5kkWd7f45RRQrVy8Ldr6JzzZSsX8Z2gGFxYzow2A7zLHDIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794402962; x=1794489362; bh=x7qiHbQ0XadT/Tn7x2KT04W7sWm2SzNrF3r
	noH3a+eM=; b=qFQIA45c1gYMTSVZZp5mxpiCSYDy6SasuTdgn8O9kKRX4EfZ92W
	YzijRe2VFaKujNYrVTwh9t+Khbgjnv2SE3wl4JM36QNgEdmP93m5vwJQ5DtNp6aB
	ha24lBA+2bMrBj6cq47DgbBvhPsLlNhvfa7y5ogAQugCwR3dBh8S8hoLjO8x9hwx
	fLuYVOch+XasMsV+6H5N44lL5u2GRQ0bn92Hdpm1e/5xtSEzjsTLRjc9fN4BtDds
	OxnUl9b+IOIjytjh77p9YrUt4skQjyMV4ykHhrSPPKco+GuHCp86SfgEXa4qtXDN
	r9jDYsF06Ud50J8W2SEoNX0AvyD8R3xUeiA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794402962; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:sIEARnausBek7iL7xnRoY6zg97ZmbC5+A+LSVATinxrxWyG
	v6btdVykt7aKZE/d/4OscUdfGRU8XoPEh6Qa3qApHMPkMXNbzuftBUO+YJy7pjsE
	xSmFzuVPXsdp1VnNPM4wHourGjaAqYQx0o4CKlV/t/EfLyLngZ+qEp2S6er8cl7i
	yhJmmUFoz5I6gCiw+m58O653AgneQCjSMloWnwmviRVn6+v31u3TC9a/vwGaPV5e
	Qgpw5QV0qaVVBTRicO3stVpnjQMj3Lm4hq5Fc53uVOR2f7mpdo/r2H0tM+6cadrz
	cde8uVXzR8aIhXf/mVgmT3xFqj1LgpFdkgkvE2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IFHrhTjHxZtMBlq2P/GiF2idJbkAHQ6WMPo4QAKnk7M=:k1q23jwRblamIN7zu2iGd1Sx/48YQLfMIfnhCqtKUpQ=;
X-ME-Sender: <xms:kmr0auuHL7BcK4B5ZcLe9xD0Po-fTLfn5C3MyS8_KJly_jGCCgbl5w>
    <xme:kmr0apegkadRtfWVvqxqnuxsKXeBUWzJ2BpWEKXwWIhYxcV9t-pcKFImaMZq1CVfP
    q23Gg3BONpoUO9i-IJk3ptPrvYEyWaLg_3twoIT9tHJzVl6wnO7gbQ>
X-ME-Received: <xmr:kmr0anYAxmAn6I1mBrr8TodnN0dA1veF9ozEUffyQ3qX1Y1yI6Ozm7UEIO-da_HFgfqGFw>
X-ME-Proxy-Cause: dmFkZTFeqZEAe0nUO1WoyCkDLskd6aZUku90jUZex0S0Odlg1eglc/rgiwI0CkWNfkKm8U
    8PvtvqtQMDKqjLE+ewcoUE1j+3p7Z9Y98d8oOKAL7xWCG3UKswVfs784SEQqPTxikGrhHb
    mlcmep2dyrFeb7eA/MayX6pWfSYbcx19JoHVXM4S76lQQz5S/nC3rJGfuISCOcGXoWpBdI
    SWsv2dqTN1Fpgjy1m0+rtC2xgXP+130fgxfJbQKR7kygPeAnSXM/KzZxlxdyLnrkqdageX
    fAziHR1Yala06TlVc1TwAKo9gFuacUV2DrHFMy56HwR6T7Tthq0nJWHz5lyX4A6gh+ZvCO
    TTrNZspMdg5wivSni7l2t6tcpAiLfGfRLsquFxOFiyyM9zD5hx6wM1fyCUXP+KXMDv9Rlt
    JyxgX9XJV6zRZJBCHWjQcRAVMtsAvtqia2Qsi5DKyjuqnDo1P25gCepXingBTotgAPXlLc
    9PIK5Tx2F92OtlwMtU1h+9oS3LQ85G6sbSC6NROgxl6NM9azbOzG86l9UsYDWpaFbAj9Ht
    doVJ+6ytEbSnVxj5eNDlnxvomcLFfgVbrpSJOi3nujJ2NCV8w9Dt5rKk64DGRs9upMNR7P
    9Rp5ASeGahI4oUGB/ZkF6ytQ5rzrJfQZXmOjn1QMnlxrQtB/aBznDz3yaLyQ
X-ME-Proxy: <xmx:kmr0akV_WgERy1NLM-BQtSjoMHtOsM3a1HZ_2KCLJW2pc6AeQIYDpw>
    <xmx:kmr0ahisQvXVnlQGhE6l4bz9bEYDwr6RJfFQ7dhPyxNp3zxcu_bAFg>
    <xmx:kmr0aqXBuGcwZKNyk6PepGbOxImAdFG0q-2XkNiYMlFrAWaVNPtokA>
    <xmx:kmr0agNkVZ3XvCIKNAaTPao0uyEJ7Q5-ZAHr76tw3oGfx4zy3S_l6A>
    <xmx:kmr0apfJz4m-MoTd9YC_4qCn87BU_bEsbcAc41ZM1B_x2TBJtPIjv4W_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:16:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a79f2b68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:16:00 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:15:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] object-file: rename default transaction prefix
Message-ID: <avRqjlLbMOfFRQse@pks.im>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-2-jltobler@gmail.com>
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
In-Reply-To: <20261110002251.2007617-2-jltobler@gmail.com>

On Mon, Nov 09, 2026 at 06:22:48PM -0600, Justin Tobler wrote:
> By default, the temporary directory created for a "files" ODB
> transaction has its name prefixed with "bulk-fsync". This name dates
> back to c0f4752ed2 (core.fsyncmethod: batched disk flushes for
> loose-objects, 2022-04-04), where the temporary object directory only
> served to batch fsyncs of loose objects.
> 
> ODB transactions have since grown into a more general interface for
> writing objects though, and the temporary object directory is not
> inherently tied to how objects are synced.

Right. We don't really use it for a lot of cases yet, but we anticipate
that we'll start using it more often now that it becomes more generally
useful.

> In a subsequent commit, the
> temporary object directory is created for every transaction regardless
> of the configured fsync method, which would make the name misleading.
> 
> Rename the default prefix to "transaction" accordingly.

We could of course change the logic so that we make the prefix dependent
on the actual caller. But I really doubt that this would be sensible, so
I'm very much aligned with naming those directories more generically.

Patrick

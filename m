Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685669;
	b=22OsoWIJrE3p+IrFINsp5ZfYYYg4Ccer0xkT37qhADxTQ1P42Q50czEV11a6b9UkCa7m
	 uJ89VsB+pln9IVJZx7be5qfzuEyunR9euCH9ECPu7ZeH+urWcB3WbvBCqQWg9hzaEPv9E
	 fUhi/ySL077xSQ5hux5NJJbKH4wKJYhwstsDBQ1s+qXhGRP4BAm9BZ4EEXuibbA5H4jAP
	 d/mqzTVQGAUbkZpvDZSz0ndw3gGCxoDtLNjbRFXz48+Iz/IbDXAd1T+I7i1TggkSl5jLc
	 p1UCQv/4nwFFuJAKdFBoahl1EEfd2Y/G0S39L1Wj5y33dCLtseSmY2ZWAdB/cYyzcHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685669;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2RwDtQ6QoliV7GcPTyl89pe5Ek4bLrnKpFnYa5EsSqE=;
	b=RCQSWTCG2ispM0w3Sz5vincWjsQY8rTOkb6LWqiPhPfmMVWbW4kjp3gVSI1Rpq0V7UEL
	 B70Rt/SdZLQXlamQgTZ7mOBf6UttS61AkLeO7VpueIAPN8Ozfi0RlCPW/cdf27TLJ0AsL
	 EKWRqWxSwQODf7B385JnWiuiyAs7kfagWPZ17xGakd5v6Znek1tl0K8XCvsgv7IsyBzk5
	 FOt9vAaiS3/ykxR2QFH8SOLwuIWmj2irOHAO2u2+leBt46DKtXV6fnR8dnjgbLdNbQdga
	 WB8BT9PqDG+jxtH9xldzm0S89OOMq2o2Bjp/k7NTqdEZT+USpbJqD9yKyeSSNHG4B/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=niS8LOm8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sFSatdG2;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E04606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 19:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10E04606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=niS8LOm8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sFSatdG2
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5ABDB1D00033
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 14:47:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 14 Nov 2026 14:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794685668; x=1794772068; bh=2RwDtQ6Qol
	iV7GcPTyl89pe5Ek4bLrnKpFnYa5EsSqE=; b=niS8LOm8wSEkkF+D2Oz4EYJlgp
	J40vIQUIQzoBsQfrD29U2YHEKhG/+b83z+uYYNarXgIIsrHCILZkbNfqKc2T+qAP
	HPRNF7MZWCgWCyD1d/6NjToXl3KirKxNM72MvjyrUAipNcF9mZpddkmG/bWMnt+h
	ED6Uex4vdN2nYqxjOALdV5Anqt+d7vptKpL4fbzwsm3GBB3yXmILttmzD0q+12YK
	pu5rQTcBXdTLDO3KUezydZIfLRiTrZgtpcZbC83CSI88QO64wwCav2XZWu1727UV
	NGZ9AnJRg7Fs+5yO7cGV1VlyCmKY28xcMxH48peeI0PYq5cA2fS+gddORNDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794685668; x=1794772068; bh=2RwDtQ6QoliV7GcPTyl89pe5Ek4bLrnKpFn
	Ya5EsSqE=; b=sFSatdG2UI7ItlCc8LjknSUDsS3mZsHvKyuxEpUddzvtDucdWXt
	1xmOhxQJCI0U/PEXRWQDB2whYldotIypHljJC96tVQOVMVjZxAxvEl8tO2LjSITJ
	NtKjNJ3k/anRGx1FogG9UOxubFQL9a8ppYsZnDMwyBWTUaI5ox53g9xNhHcSILG4
	VVciwQUeKzTXVHlW0Z9zOQoGtQ4mnVZ0NJ3MFSFpBKC5olADQV05VUDR4KgETR19
	rwFfN7qX0FPrTXNeKk+le0WOsrPUplDaGbjI5bqyuOHNyjigoQk2ddwPAKs9lyPW
	vZM/DMdDs8/E0gVKYd/b5BKJpE1SkIc4xJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794685668; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bcmzUIM3Vb975P3VEA5f9gIhcF59X163zByfGZk2eEDCfg3
	ndT+eO2fNKYKJMByPZk3f66bDsublWPyST37hKWjfAIesucSVEGST0wgtagjS06Y
	xVeQLnwSQMdZRJ1B4zelxg2KC/eL2p9MD+taWu91mnYJTLy8ngnChL2vHNgPpKhP
	9a34SuPJ+bYkhv+AQaiv3lfX2EAREqhwgzLMpGp133nQD2Cg93SsWjx9WEVxkSb8
	AlTpTsSFdyH/Osq9Jv9GZbN0tWBYMj7Aa2acpqn4ylcdjifd5MNzg5PX/4Hq86kB
	JE7iRbbJavI2gAAsdXDasw5SbqZwIEUxWF7BrGA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:y6Vfir/E52Ul2Zj/letULfo98gJmWNveD+eXUG2DfoM=:2RwDtQ6QoliV7GcPTyl89pe5Ek4bLrnKpFnYa5EsSqE=;
X-ME-Sender: <xms:47r4aj-krXv20gqA0IWY9DCVwczVv_t8Z80Cp8J1PNJrRv2Lr2XE6Q>
    <xme:47r4ajbKBK68qzmz2ZPteJe0ncjQXoswYdZGe1iK88bsY65Et7Fs5t2FCMsrSqC3_
    4SDuOfAoBQeEtTfE738vMm_QwA_0kWeAgNQwZNxUhy65RbnKGCAOzY>
X-ME-Received: <xmr:47r4aq33QeyyS5vKt6nhjsmi7T31ulEJVUZ-8drmj6Rs4yjunmuexgjpMC3vbYzmk_1gbVscIOlNwYeKK0Y3GsmjKo86QG3KZkSX>
X-ME-Proxy-Cause: dmFkZTF9M6VxgyMlPr5Lce1F6ZfyZH1R1b7RuEROTDwUJRMIB3kAiyz9gTU/qZN9u1C2oT
    FQFyMUma/lZXV1dfXL/G6RIq4ygYNzJBNFTmpKQ3g3tXMrvBL1ynan3cNW2avHQQg4C/R7
    deUlcnz6B6NurKqtXfSPXwulthiAegFXKeK4MpiEf+IHhc+F3JshYQzNlwQ3cTDSucpufR
    R9sTkYR2vh3W+TMHR4zowW2zwk7tmpD0Pl0U7piA3i8/ViPrU+0nzs3GqiFeZELVXe2jR2
    MwK103Zimh1SAeRMwPqSUfTAo+ECw2GAExx3MXsbuCXE5e+9Jimy46XZId4aNpTSPUDpZQ
    89LJhZEzONZIAinKyKxj5pmacY1Y9+wkD+uM8cpoBIRoLg4lgKFnVerzzCBB9c78Wbzf5r
    0qBSQ1c2UaTtQGJOEeqdClZYfsoG+OSUitg6yYg/TRy+bxCnvVDrC8aQFA8/faODR+NqwP
    rvq90y2evcieDx2kmvdHE76O0fOFkmeuL4PohQuaBHMX3oSDvzBKvBVZrizs/CzGuV6+um
    uXvobQU6r7Wlbhjcgai0LChfzXC4qwi0NVzixSZVPFwFiVLxgHPPs/UqE9h/niUY7tkHzE
    ROQPqgviJWNTAUnYFa26nxbujrikgAmMU11L8fsfpkioE13boNf59n0WxeiQ
X-ME-Proxy: <xmx:47r4amZSBRqAQcO7S9MBwBedjhCEPsw0XP_4Bbuzkap00VcWgKIDWg>
    <xmx:47r4aqKIyawZHf8tBUTLJeJdLxJMhlrSjsNZ4R_V2tucWXgAwIAi-A>
    <xmx:47r4atHXGKOzGWFK-2iSebgGDrln-DJyqC-VB09mwDziUAh-n_ePJA>
    <xmx:47r4apsgLgS-uvknq8TIh0bn48gANVfkiOsTmwRuMrHQs7JnoahBVQ>
    <xmx:5Lr4ahLG7mGnoUzp1N3viAlgONxb9h6Fn77K75v53pFoQnycY90Zv60h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 14:47:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: YikunWei <YikunWei@126.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Eric Sunshine <sunshine@sunshineco.com>,
  Bruno Haible <bruno@clisp.org>
Subject: Re: [PATCH] doc: include fmt-merge-msg config in the main config doc
In-Reply-To: <20261113144543.46713-1-YikunWei@126.com> (YikunWei@126.com's
	message of "Fri, 13 Nov 2026 22:45:42 +0800")
References: <20261113144543.46713-1-YikunWei@126.com>
Date: Sat, 14 Nov 2026 11:47:45 -0800
Message-ID: <xmqq33t3p53y.fsf@gitster.g>
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

YikunWei <YikunWei@126.com> writes:

> From: Yikun Wei <YikunWei@126.com>
>
> config/fmt-merge-msg.adoc was only included by git-fmt-merge-msg(1),
> so merge.branchdesc, merge.log and merge.suppressDest were missing
> from git-config(1), the central configuration reference. Include it
> in config.adoc (alphabetically between filter and format) so that
> they are listed in `git help config`.

Don't we include merge.adoc which in turn includes this file?


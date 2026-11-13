Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591285;
	b=O67ywnkAQb4KiYoiJMR8yTFPLiPEMUXbnJxoPo/M1HrwoLdymNPDsVIZVpYj+eU7lm2C
	 YmOyxDjpTzmNYkjjHYQKXRMMUTslGfx0M/nzwk84X2ZrsUtRUGuQzK3FYqsKJ7RN90QKB
	 lBGMlrEI7QftwZyXT3pXbjhj/02QUcnoi5AL6SiYfMwaJwMOdV1N6vGyZbDKUKfoNEAwH
	 6BWEOKbAJmQGB3xApFK8+1JDSoH+m+N36kmTbNHFMT4KkZ7/oUEoNBcuqxF51//GNAwqW
	 Sm3zG2Ocx4WOWwSI8zgI3aF75B42nNvlQKcCKIfuE0Ag7j4N+rtM0ZKluTtpEyJTApQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591285;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ytH4LQtt55bwfXgEsD1bI86TzRHzNHBgLI3HE79poyM=;
	b=eOkPreevb1piq5Bd0v9NdDqi84cczBFscPKdaKthGlVgqzPnwb2BCCPRuN0jTqSsgv5l
	 8PsFK/Eto/Oir8YGt+uL6OD+NvQ1madbljyQc+B6rc6RCRkXC7vanPgSzQkgu1hSYnhC0
	 dqwCzJgCdxU3g36kz7JWanVFIYFD9EXDFIx5GVK3dhdARykSlOvxCAAQKFayZZkjP2et+
	 4gH+ddGVLyS39O2GV32gBFUDw79OMRFy4JBrGDukgFR4PP2Z9kpPS+w1tmL/8z64vVy1l
	 ZeApf/K67ftaEBkjpgEkL0cp05s/IiCyJdE/YwjIK7/gHXG9FmifY442eHJ5hNxwSig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=k46dpRvZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5pCXhN+R;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5456077D53
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D5456077D53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=k46dpRvZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5pCXhN+R
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2ECAFEC0074
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 12:34:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 12:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794591284; x=1794677684; bh=ytH4LQtt55
	bwfXgEsD1bI86TzRHzNHBgLI3HE79poyM=; b=k46dpRvZmPNQXb5mmyyDDOIbQw
	/A5qxAs32i9N/sie0+MeNHsT6/MjIbvKTlzkEPN10vTph5ZkAMNEPwDJT4G89X42
	pgPbi5TXSmCwSQOurimIxa1tAF1IBVbNZ2ykp/UmRTxET0XbXaOZK65yENNQ2C4s
	rcXgdt/GpFMswCrJE9y5xqQfxfFJDtASWXSudp8TQj0JKtIn71SiWBvH3885hIXh
	uQM/5usqdI613LLwRyA7fM23SIRLIhdzS7+yxYhcXgqANpivZshSnDhBIFnNORNL
	dxrgCavhx1AvB+KmyeXKmpQH/lxEtZfAXREUk1jvDo5Xv2I3a7FPfsixpYWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794591284; x=1794677684; bh=ytH4LQtt55bwfXgEsD1bI86TzRHzNHBgLI3
	HE79poyM=; b=5pCXhN+RNkxgORafyAhwNHBabDObWXGIwkH1QoA/I0DYPaoI8gp
	O6D78GLQ3SFBN5szUzwCM/fpqXpyRpcLCKT8KmOfMR6TN85OoKWMiYoNeyBqEBau
	KCGusd8XxtlV2bqPpFGraUczxO1yBsQa/EuOXZApsQ1PaQNrGoRhf7OOGgjGYLWH
	UKIQ7beLhd75lCO138uhVRQcFTI1AHsdxg7I3kUsvytwxi4GOa3Lae8DIms0ILNr
	9wCzFVCXQonCAhslSrKQzTSRvmrU6RsOfwZIqICZRN86FsMF+xWIJdNPA4kBkkut
	3+Fz27S0zSPia4Y+yb9ZRpaKTkArC/UVH3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794591284; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jCjhFR2POuWk/Wy0d43gligWQanYIvHQVljoLfFCooFgXS0
	aR1ew96u6dom/G5SdfSDDTA2vaggewpdSXoQ0U8Oyw9NWxJQ19r6lKQPaxvH51sW
	XIkzsVIQmyajtPrCmsiI/eR+wnHA1ore03XSQ7YvXNRUDn+h/BeHkN0r6aOU8o2t
	l+2U8SkKabz1wKR2XR0Zlw8O+sss/p/gTcFuEpnUm3UGqhqY7JZH54Agfq99dkHo
	/2+Okw2DV2AO3IghD6RNPEZlF5YqQBTu6/lIYfja9IGtkgJfbQDDEMMXMC/VUEBg
	5wYxZk4NR6Gct5NpYt3nSZ4rUKveHOe4zSYywPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:egMaj4E6z9rpORF8Id+HIISK9OXZf4+gW7q9sjUAs04=:lx5YTeUA58kpta/CYSjEN1xK39UeedOljBi+U5OrdTs=;
X-ME-Sender: <xms:M0r3auKHuWRtHrhjf030C6m8h6drCVDZ4MEuOXsXjYrPd7pImx_yow>
    <xme:M0r3atnePYXCG9mzdR3fzCJ_61qbt3awnn3o2M153MQ6HSgGO8HvwDDOa5v26BpDS
    VoQJR2nXHcrS50eUEq1_X9YnTrWt8vUKK1b0xQd-VDzOjicwYhNAPw>
X-ME-Received: <xmr:M0r3asHgGCTZhSh7z9yoOnkXUxIPqtAYF2B3JxDUqv0AxmhRhOeK9DboDqWt2vrrC8K1OH31MQtLWfGdRnHGYTixzeXfLXI_Bo-3>
X-ME-Proxy-Cause: dmFkZTFFqUgRawEmMGyRJq3NMWBy7PBk8DBckCg2lJBGCieVys6RKmr3hNPpg/tiOLSg+o
    ieWpAfjthU69+YM44rsR6DKvSLgSR+ZVvvxn28DpWCStsS0mOHb+GFTy+Bg1R0zI8QYi15
    0zgeaUjTQelD65r+1ZnbqqwsAtTjF9K2ReN97ujjizqVR4S4HMSu7Dn6xhVmCE2+sBR/Bl
    VUAp9cxRlFlhhHZSnnHnZOcJtHKXVpOS4uTOTKwrQ29snDdkGQQ8C5nFTS4gdQEm6FYwwo
    TcFXQ4Eg6pseBE1SX5w5NngAe7iZTdlViT0yxbW44cPmezz2+6luoY1tahF/DsFZ6E0Pe5
    2/leWuTqhSQkdTS+wMKj53m8+HXRT+iRyuS9N9frxczuDE3rXMeCZ5fhtJogpaGY2REXA+
    JilCwmdhUoM/VQWzCiDjCDlzvHDgu+UH7DSzAFVsy5PCpnhrZ5gmzw+Ummto4r8Y9cmZVc
    cnzS9rGy7J0GZoAIIuO96PF/hw1GKD+YG2V7WMQQTAWuQHc2xXpd2q/+5SgNnnM/S9Bppx
    bTGqRjRRXMwZZz2S06ft0qfgReG15T3us48t1DcvFE4j3wMRuP2ALH5m/HgBaMnrtT9vAS
    PProva5ZvAGvciPYP20lmd6BvUFn0Otyg+2QVqt/48PwczGKWFCFxVXH9LPg
X-ME-Proxy: <xmx:M0r3atGbOzExca3kogI0BfKo2z23kYF7kpz14O4SMR7Hfpd083Nfvg>
    <xmx:M0r3apOZbNHQchUgnCihyU-62j_dsubGxrtgH-I6u7_nZNE80-Q5uw>
    <xmx:M0r3asH2TNXdYX60i9_iNyKZ9lPObSnexv00i3Ew0oqT-okzPyR9-g>
    <xmx:M0r3agOANT39wufKhrcOSF1Wur50XX0yDESCfFFVhhmJ4yrzjcwy1A>
    <xmx:NEr3auPVlE1nBnmtU8K0pk9EdmTVCJqHZGKs8mr3LlJ4pXeDhWT8jLjB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 12:34:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #05)
In-Reply-To: <87v7613uyb.fsf@dev.null.iotcl.com.invalid> (Toon Claes's message
	of "Fri, 13 Nov 2026 11:08:12 +0100")
References: <xmqqpkw9fwc1.fsf@gitster.g>
	<87v7613uyb.fsf@dev.null.iotcl.com.invalid>
Date: Fri, 13 Nov 2026 09:34:41 -0800
Message-ID: <xmqqv760eitq.fsf@gitster.g>
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

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ps/odb-loose-stale-cache (2026-11-04) 2 commits
>>  - odb/source-loose: fix existence checks for newly written objects
>>  - odb/source-loose: extract logic to retrieve subdirectory bitmap
>>
>>  The loose object cache has been updated to track newly written loose
>> ...
>>  source: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
>
> As various other people confirmed, the changes also look good to me. It

Thanks.

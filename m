Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018240;
	b=HqOph7tSsSYv+CEFSApFm1/ZNAEtYA8DMzRKTy03uLGqHH4/QE+IQSQDaVtihkG2dbkL
	 3RJmoB9BnICy5gPCTAKQOQR6d3klKx0ea08cPQPaEKr2CV+X1mJJuOBzDQ7p4JcGhuE8p
	 Kp+Te7SqOxpvaQ3UpLVkGhPYGwNHgO/H47XPA94S4Gu7czqlWF2t8R2MOiKqjvduAX918
	 5E6Fpx1Qabwoc79svlnwlgdoA+/KZJ22lBWDz0bDqfJKICunvzV4FiZAMqeuhczoyH0uw
	 /SC8RLIVmSjrOT2CfC4ijHyuANQsN2fAdtK+syACoc3Yn1Fe9bz/E925ysL2VuHC/kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018240;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z7Nv8IUMDlS5OECq1xZM/AE4HicvLd+eJYT1weCf4s4=;
	b=GH6CNRB0vclXAEbmBOQZtE8xCDM5c8aKpikcDNaUM2RLbN2flT1c8rLsViBCXb1K7wbg
	 ZAlWEvNund3RDGVy1TfNOZijiKDRCLEnjG7LKWVgUAALfbRJxvdd4/DAB1nTLMK2jVDv/
	 anubRmNldrX1qAQrD9BdbXWqpPyKV9pUST5nYj2mjXLIf4IDmBDjwWjTywyUWpinT+Au0
	 zBPMq4tCfqq0s92I1McWspXGOjrCm4dlk0lbe8GLWpy3t24RoBf7fRcDqg0AiTv2EoV3i
	 JRPAkvGq0PWCf2ArA3j+KhWyp46GveGOzb+SDqPlAhmQhLVUkrATcqYIkGDcrgksqhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JObj6DBw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KOc93QjG;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137A606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 02:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2137A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JObj6DBw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KOc93QjG
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 41DACEC01DB
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:23:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 06 Nov 2026 21:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794018239;
	 x=1794104639; bh=Z7Nv8IUMDlS5OECq1xZM/AE4HicvLd+eJYT1weCf4s4=; b=
	JObj6DBwwwsLdbanMY2/NsNJs4tGwS2FVsdNwKD5z8P1rnR8lI+FsH4VxX0gGcos
	btnoySVLhCjzAWnA14hS7pCehbcWyREL92ya2RnyVejqunohVeOpvKEnikCQhZSl
	jsgnDbLW/WSSmJQK6HNDFW58hCuaf/h7Cbyx3A7eBRiNYg3fw7EilLSjtS6XiwYm
	6d3fKfvImFqxrY0esSjDyq/05JldyWbOvtxpbyrNtqATyZ08hFE4Qe3187DxWP7T
	GS2+ZGHT//7EEIz6LZzHVVbOiPIVjGGq0KPRTkZpAGU/wXbTa8JVF+98EcdSTH03
	4SZ2J7GZ0ZMuDGcXgiwJ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794018239; x=
	1794104639; bh=Z7Nv8IUMDlS5OECq1xZM/AE4HicvLd+eJYT1weCf4s4=; b=K
	Oc93QjGC3xKar/zPwgnDNYW1iNDf8eN7cmhUfDBdlK9UOddF3ElGyGGvi57YKFWv
	2pxl9p0f6n9esoGLfT520g2WT/Steem+er+Q8hxR9jgZj6DpoDW1Q13yBDeOQN/T
	zWVu/KYxaEyRBDDy/YZMMkJhaOcHEHUKYpTpzZ40RLcYR4ij0pvrk+U6yJEnwHag
	/a4jAS7O/2HCsiHUVO0xsPfmrgB/KzBNj3nU7kGW4kme4Mp/wRfnzxFqYrLQva4f
	Fwv3jF8RXl/lqNkhnlQllbDFSen3/1T0cz29vhLw1pEbormUwlAW649fDySap7Eg
	p959ZlvZ4RpYZxVyUSKmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794018239; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dXzGyGab23UkyO3q1zwUq6t8/YeQJm3Yieko75hM3MB/75A
	mLFcZc0kxxf6kOujBxx4l2vNyjQe9IZXtqLFjDO4VHnibwwRWCz3sWB2RLcvG7ti
	vq8NX1Y0H8zIOKzwC/wMhMc6NixFlKHKXgbpmapDUoeJitK744uxWzRU60HLebzz
	zyAEbexlNvV9QUV5JCul7Y+f61RE7r4v/KrlkO2RHrboJogenFydJsXTvsXfWjCT
	34EpujouraH1w1dqH5zq8DXIK0ukPqvZbCVIXDgZN1C83ybxb3DZxrQfhms3g84l
	lG19lcvjTFRegHsVcrzeU+2BoAaJNIqIIdyUiDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:derKTOJ8dPOHu45pEzZb43N5dePhZcuCQ8MvuyQRwao=:SHwYTqDoGIQ156919jR4pWO0RXHw+z/FmyXgvsMnTcc=;
X-ME-Sender: <xms:v4vuag489viaE2XlsCpev5B72kD_i-O1I81b7rTpAGJM7TQw_v2ghg>
    <xme:v4vuaowM4dbyScMn_iJ6eLZ0tatefnPOhtzYTDipw2VTrbKgz5khjSuqpBDWc6EAg
    S0CFfi0ZLfXINPPqu_JscH6Sr6ldkxGlcljhpP7rVcGrZoDx6qQ>
X-ME-Received: <xmr:v4vuanyyOks9MEbySCCzyLZ8KyNbxYumDRaoZVbwAHsaHk8gDymu5x9h0mbqKmbaCjAVO92lGUfDD4M77R67TNPdeJcFg5AGNL9B>
X-ME-Proxy-Cause: dmFkZTEUp3TBh16+41PyieK8HqDpcIDymsUW+eGlGDLb6M9sdtbLGVCGXvl1CTmvXyo80l
    7YWU87LbbLZe55x/RYASKC3AyStv3mmnL8PxMR2mXGjtiyD1h+AL0ZDLhYX0rjY2NddVDx
    EBTng6pgQF1yKELbM6z+rk0vX90uMubx3BldH6lQbNtEyziN8r7zEzOnzJNBI5hYCOjsN5
    SPDE2P7uVMYgEDrX3zR1xUupldZbkxxxyapPIZcmKR5irdfIUVBr+iOLy7tyvYfT04z/tO
    64W41amIZ4+Krc29Ym9nDM6AQ1bn9nNh2C3mmCUZIvmLi3m26XM2rdEWePp59vlmXUSfsc
    Zmh7jNOcwWzTq1zARfKlczB8AH5LufQpH7BtSaB0Tm91vKIoe5e48yvClsqu8Qzxq0lG9G
    sr7S7BGsLhDGu/scnp4ODykW42sL8VigxHFfGQyBwhyXri5RHVDWEyD9JChD3bnkhuY8EU
    q8Deq6i7k3H8RmXcIze9tx7nsKzyPzzsoZC6xytQ2fwPEATi0strts1x9bygQBxYyiIVqt
    JfSNPS0CJK1YSDhM+lcuVD4qPduXR7TSyeXRHRcHBLqnLKLDWknLwYvUD1y6gdz/wwhXzy
    AIy3kH68rcfI4kI3mzSGzm4TEZaIBc0YOX3pf6moB1dzOe/l59of+rxQ1XhQ
X-ME-Proxy: <xmx:v4vuagyRSlxYnprQzVrWSUFUD3B-Q0Ac8uV7BqdrFCkcyl1bYKGHwA>
    <xmx:v4vuahZHNp7W0QbnD-WMt7BLBIhOWmUZPdnSJ7cEigGJE9QEMAriyA>
    <xmx:v4vuahViPsHxHYdeJM8UGVbnc_Aa5ZxM2tHCfW-i0CTNPwr2ZTFIyw>
    <xmx:v4vuavjoQ0t-7d2NAI4QzE3MlQwpRGHUWCq6pp8rQvSw2S9JfbXUAQ>
    <xmx:v4vuasKJ2FiGXR5CksGo4S2NjvMyU_-JswMvxYZPP-uH4e1h5cIXQYQp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 21:23:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Antoni Borowski <antekborowski11@gmail.com>
Cc: peff@peff.net,  git@vger.kernel.org,  jpoimboe@kernel.org
Subject: Re: [Microproject v2] describe: do not translate --debug output
In-Reply-To: <20261016185418.162998-1-antekborowski11@gmail.com> (Antoni
	Borowski's message of "Fri, 16 Oct 2026 20:54:18 +0200")
References: <xmqqpkx9fq8o.fsf@gitster.g>
	<20261016185418.162998-1-antekborowski11@gmail.com>
Date: Fri, 06 Nov 2026 18:23:57 -0800
Message-ID: <xmqq7bipbcqq.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Antoni Borowski <antekborowski11@gmail.com> writes:

> The --debug flag is aimed at developers debugging describe's search
> strategy, not at end users. Translating this output makes it harder
> to grep for known strings, compare logs across locales, or paste
> output into upstream bug reports written in English — all things
> developers routinely need to do.
>
> transport-helper.c already follows this convention: its "Debug: ..."
> messages are plain C strings with no gettext wrapper.
>
> Drop the _() wrapper from describe_commit()'s and describe()'s
> debug-only fprintf() calls accordingly, and prefix them with
> "Debug: " to match transport-helper.c's style.
>
> Signed-off-by: Antoni Borowski <antekborowski11@gmail.com>
> ---
>  builtin/describe.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

OK, looking good.

Let's mark the topic as ready for 'next'.

> -		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
> +		fprintf(stderr, "Debug: No exact match on refs or tags, searching to describe\n");

Shame we do not have debugf() macro ;-)


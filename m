Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530947;
	b=sy4bT+W34TwKBLTEKj5x6ARdMO2Zu5yLCi5uSWC7GrQZ92YFQtzsmrurDCvd0tsB81WG
	 OwBduHGnC5UP8otgEQyfKyitrmumawY8+IeUWdskbaQlNy2u5lZIxz8A7pII4inZ9h3XK
	 1KSFSBRVAkonFy3aqfGlUHcANW0eKcR+QgtGxjGasHU6mBD50FgDhHmJTNbRMBqKeKbIy
	 tWQ6d0Jsm4bJ9+bEgF+Tusd8fQ9U1eu5PgzXwvAJlsoCX1E90rhCxBiI2WyinhB30Asqv
	 AX7pw6M86H49gwTvlQ0ASc7hl5hIFruWkMi5djyezQ4i9/0C8YzknbdnxoFo+nODkYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530947;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=cpKRX+H5VWMUG82T6KKFMd5bfMaJucm4dDcO5xzBWNc=;
	b=XLJlC2g6k4LXPVl6F478I3v0QW+E/WgfOQM4J0AQ4YuyQbd7OxnrtRNCAIQatdZlvFyv
	 +wTuuOOBxblBAyzKWPYaff7Ef0p8JtgDH/O9gE0NGSBuLqQEGuoF21dmVB9fqIgd9uWQI
	 mrCSAGT5prRLb7dnE4IFZsLOVaWeSYX+q3209DDcSHfs3qCAoqtCOZseQtpkVEPhn6Mby
	 eEW8gBk8SotTJmhlX1jBrfcK3+5P2xQoHKGwcMHKS5QV/xFHZ0ewgP8IYXsebjEuKWZQS
	 p3wGyo+lX4Yn1CYLtQM7AMwVB2B2xcnFCi9mAFLhO2DNbt7s17lOMgzdFf42/MDWX3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mrfEwvYn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aZy3S12D;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915DD606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 21:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 915DD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mrfEwvYn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aZy3S12D
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9D401400137
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 17:15:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 17:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792530945; x=1792617345; bh=cpKRX+H5VW
	MUG82T6KKFMd5bfMaJucm4dDcO5xzBWNc=; b=mrfEwvYnWFUWMl1bNvkt3G9LWQ
	BHOgPOMi6dhgdhbF569aDNnK5QCz0pgQRiL5yd7TSEnrc7OOZnDmtc8JaYOaOFoc
	JrnXRwr76AwHnPWOXtQCk5PLw4MpfhYECihPEbN5piXWDkbhHgh0dIMO0gsq2N3r
	9NhelepNebZ+7cq/1dIyVQk1uy+ICvAzKrdmgr2DbXnsCbwTDBrSPzId09LedTKM
	FjLKb1mz6Immre49Ybg0tHk6t2aWQ2S9a6Ai5WJbhV7L3NC+9FRL0aUlYH56nK+Y
	HiyYm9SekXrFKfOKdar5AbL9leK43r259aLvk4deefL0Wqd76vGCnkk171AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792530945; x=1792617345; bh=cpKRX+H5VWMUG82T6KKFMd5bfMaJucm4dDc
	O5xzBWNc=; b=aZy3S12Dt/psxniXAUHt8xbaYH/XoDaIoqMWkIKTaNLR/k8tbJV
	kitB2dlPLGCPQynWObCcZrrGGs3SbC7kulKo4sjSprwrPLGFmAPzVOD/KH7rl+m4
	wasDD2YRF27xnT4Jl7F9DOUn1XVuTbQWBHBwVP1BETmLd9apun9kO59Uw0uwzGVg
	9JGWoXvBWumrK+pwuH6N54ATYzVeWj/Hq3lnPbMJOxT01ExixVyocm+hiF+DgbrC
	GV8kv/VTC76YKtv5cabNAJTzOvrOeiqWE7K2euHlRugA/vhXiNI1k8vLeIDl6gVg
	AT049Ln1pM3IOA6nRE2CDOIGSW1P59TRGfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792530945; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MrpyUPuW+aKjnpLEoxc4bUaT+G3YF1Ihx5/vfqZjnT3IsQd
	6I8D3Es22YtwxScvoYtIJBrKOtcnsvIsTAq/NPg0EDR0JQnzTNPspVe4puJKV389
	yncdgbRHOw6awr6D730t3YJIV2dsUAkz59eI31/i15QI4kxvwVKdGD0FpHHe/p/T
	yHQA9xuxvSCLdby7SHUQF6ZyLafSFKy9U1uVtWNS8WRgPkmkUW5XOmIpk8isoLgB
	WtuuI2CTc/UMwuMnKVPYnMXWCRnK+Iu3kSYlr43I+Jf+3YOBO4CUiTexUcsYlR3+
	Bih25PBTxz+zoclbbDxAdOd04C4AFJjL7jGNUYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gFijEbPhlZwa22lISlclMQkOrDR+cBZrmNKSDfWsJPo=:41N/hdi30akR72KtI9hmpGBQ1CwOjTdaxQJz34jl+/I=;
X-ME-Sender: <xms:AdrXahaMiMBbmXv6UFZ7QJMpc1xlgElcPpprVXpRLtbNOI2Fy0AONw>
    <xme:AdrXaqptFd8Iap6uvqDY5tbv2su_MegdhtNV0-mYOP5On2ohYQKXDCkIt93Am922k
    BHRREzNdXENj8c2ZnlhdwqDr8PQxduLYUJ7i1RzP2DLIloJIcHbUQ>
X-ME-Received: <xmr:AdrXamNJoqzTv9e2d9WRZk_ifrcPk_EgNo4zSafUJHWptI7Kqc7i9qJfT2BMo0-kJbkwXEadccjmxEqMuF1x8IAlHTcpKU13Dw2W>
X-ME-Proxy-Cause: dmFkZTFskndhTBTQJpx7x9vdo4KiS+5urZ035JYS6ubsIz8RfgWBs2EbP3LW+mnv1KkVar
    Lx42UurIyfl5uP9zqn1YmqilDQ9IQ4y04P6lxtMaNknMwMEscOwok/IVHaF5akNlUfgTg5
    d4LHXDlyKTSafwxxjUciBHVkGtwkIEYTquDTa71AqJBuYai2b3Ux9LFG1WouVR9EU1mHom
    cNu8j/ad/71/NO4VINA8z3aooPT6Vo38PC3ewiiiy5uwdpxYUgDBpSnr+oOpTfqVbGbSNu
    uU9O5kcjifM+WctBo/iao+Qzkv9NLO2Lg54KvMIb2rZGrsGPMFrtm2iQvlpet5W2tUXSqx
    LfS4FKElBo4su6n9qf7g2tPBmF/IwlAAclnFHauD6TFhdxfjb7LMhGuEbE7bTVu7T4VvjO
    NB6wpaJ1Aqi1iUg66RL317egtVhXdQB2I2uaNv49D/o41EpUjumpihgsv8ixP20/+/n+hv
    PLR2T+NAYommapTfOO2LfwvIwmilpx/LgHXvMcKlAIMJqZPXgN45fNqpNejq+6LGQSkFjJ
    1Vkc4+y2f2Fu/Icp93IGyrkqiZ3vQe5U623Mi2vgvQfRVWD654j4joCdSKE4CYEfWBcuun
    8v5gqf9+2RnaEPNAd/TH0ZEAxR4Lie7FN4Nydb3+/a0Uui1/ClMzxSOCSY+A
X-ME-Proxy: <xmx:AdrXalqf-14U3kqlruEA7B8_7ozgmeXnN9RgdSp3jxv2LiZIFESY_A>
    <xmx:AdrXareJ-rzvEkR2iSfvA_UnSosTDLtH4nuo9jEzm5IHfTQdsPvx6A>
    <xmx:AdrXarRsaIe6TTHjlzrlptE9XLucXRAfIRMfoGxqfSxt6MiatVkAeg>
    <xmx:AdrXakZc6jpErcU6XDsFzFNG67PJq84Efuk5lZPyAi5trnuzsEACxg>
    <xmx:AdrXagVJXGcPIlSLH0YiLQYkMg2p7jT6pIZJWHSCp_9ZZWAOo8vEEmPx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 17:15:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Shardul Natu <snatu@google.com>,
  Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Makefile: pin cargo --target-dir to ./target
In-Reply-To: <CAHWeT-aD9pNEdWHVf+M9dXzav1P7dTD+h4mQ8c4gkrpvdYxTxA@mail.gmail.com>
	(Andy Koppe's message of "Tue, 20 Oct 2026 21:05:14 +0100")
References: <20261018205305.2634339-1-andy.koppe@gmail.com>
	<xmqq33u165dp.fsf@gitster.g>
	<CAHWeT-Z5OhJLYx21V417DoL3xOQJj6viUzCm+04iDe0zu=jVWw@mail.gmail.com>
	<xmqq7bjcxqkr.fsf@gitster.g>
	<CAHWeT-aD9pNEdWHVf+M9dXzav1P7dTD+h4mQ8c4gkrpvdYxTxA@mail.gmail.com>
Date: Tue, 20 Oct 2026 14:15:44 -0700
Message-ID: <xmqq1p9kt6nz.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Andy Koppe <andy.koppe@gmail.com> writes:
>>
>> > The problem I see with that approach is that CARGO_ARGS looks like it
>> > is intended for build preferences similar to CFLAGS or LDFLAGS that
>> > could be overridden on the make command line, whereas the target dir
>> > is a hard requirement of the subsequent link step.
>> >
>> > I suppose `override CARGO_ARGS += --target-dir target` would avoid
>> > that concern, but also set a trap because any subsequent modifications
>> > of the variable without `override` would be quietly ignored.
>>
>> But we are already tweaking it with += in the Makefile, aren't we?
>>
>>     # Rust flags
>>     CARGO_ARGS =
>>     ifndef V
>>     CARGO_ARGS += --quiet
>>     endif
>>     ifndef DEBUG
>>     CARGO_ARGS += --release
>>     endif
>
> Yes, but those are preferences that can be overridden on the make
> command line without doing harm (within reason), similar to the
> default 'CFLAGS = -g -O2 -Wall', whereas the --target-dir should
> always be passed to ensure the cargo output is going where it's
> expected.

That's fair.

So if we wanted to go that route, we'd need a companion variable for
CARGO_ARGS that is similar to BASIC_CFLAGS we have for CFLAGS, which
may not be a bad thing to have in the longer term assuming that we
would have more targets that need to use CARGO_ARGS.

Anyway, this was not an objection to the way the patch was
originally written.  Just I noticed while resolving conflicts
between in-flight topics.

Thanks.



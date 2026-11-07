Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018039;
	b=ar9wDcQyvykJJj2e3GTtFq24DcUc7wxL7+AKdxX7UU8A7A/ahho3r/yfasDiEHY2TrnQ
	 /0j66NJxuwjZO0Jc2henO0JrSTHtkUCwTTiOsOcWanbrG0IYBIzojQHI/XCITOfC33vxI
	 nFiunM55ZjjgbCC9Ih7SSwdPnV8Ekx3+kTeIT9U/9JCLKfUzcOJQo6Fmg0+4RaaLz72pE
	 8jtzNY4W+aupyYu3LnN9MAcXMmqrIEBu8alhwN+HBTaTIcdGD0HcGAYA5W3kwiStEkX/x
	 dxgGHXMkkHK/u0gR52XaiY94jpnTx/1OIFyESYUTj4KhJ7n23m3VoziOBHoVz3B7ivQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018039;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=R6gdLwBDPEDDr9NySC6r5pguKB0nNDyWcf7vriK/KcU=;
	b=no9arV0ji6qs6G6OkDywXvAFsdX6Lk+MQo3PLdjMeYdswTY3NrydyrSWQBZOzELB2rtb
	 ZuxnCfJuD/qfISR9uuy6xjeyjUQSA93bf7ADIKYbrCv9Eg+lYs8svjtn66TZUIv7UNDl3
	 KBYaSmTwY6B8TwufLiAw9zlDwtCamUmcVRmHnw6MEz7p35hYzKuMWttwT0ZiGZG7vYfu+
	 nW8CsXkhgNEdYL1nS5p1zTftZw26ylE/BURv2v/nId4I7fYGKIL2KUgfBcytDSAoKgWPc
	 j+Mcqq45PlUuS6wnRQeMHqhq9JUqatJn3Lixi0PGW+Y8Rc/lB1jXYXBpEXbdAo/ja6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=G90l2aNQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="d565/ktg";
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F9606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 02:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63F9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=G90l2aNQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d565/ktg
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E03EEEC01DB
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:20:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 21:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794018037; x=1794104437; bh=R6gdLwBDPE
	DDr9NySC6r5pguKB0nNDyWcf7vriK/KcU=; b=G90l2aNQN7uw0AUm6D1wCTMP8R
	LttG+58FAbP8eqL91RvWmT5lagW7/dGvBzqv28trYhpLCvMilGd+ldpQRblKxRwf
	Z4v/295gf3FXASWRq2UuIQUpkIwVQE2p0Mr0pHCP8LhIMZ6Tld1f4NYGcyCVzZI0
	AXcsI2gXpgs5omt9+zc2XbpyTkXZfdalUaGnUEjwUMvNdrEbtD0p9ovLNOtI8QNf
	te9grglim95BjpoLknBI7d+JJrl12lftZYb2C+18IIfBieN0slyqvuihzIUKGfsS
	+YyfKEtMc9IhdVRauqt354SYmQDoZRFTNn1OPXNjwbn0qVLRQPLiaqlBvUIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794018037; x=1794104437; bh=R6gdLwBDPEDDr9NySC6r5pguKB0nNDyWcf7
	vriK/KcU=; b=d565/ktgDZHphbrwNwy3Rsd3dcBcPTuiG258WGlx9pGz9BSFLUB
	2A/VWOqF7yDG3Cpj8K/yvW7hUoRHgza4StZ1Y3ziStSqK0Wpu6KYP/wrBaHdymvH
	qJmWlobCuwNRhil87c7GhhQrNDZttYxNfcRmKIbidU1J7CyD8ACAnmc0AaOD8JCH
	V7xFt67wCqYNny7caqlfH1na7eGOXk3f02c64a6UGotg4Fv53Hk5a6t/fxftF0CJ
	kI+l1ikW2IDNqZ5n4LaFstA7cXQRiTf3FYMHPpfOpQzpV1FAg5iHS3+cdAyoMF1B
	Js/ym9VKOSh0ca87h9EWKkRxIid69y6yrHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794018037; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Kg54uznMFk9tYEB1K3K/rksL9YueElOUoNsbRZ3GX2OG3qd
	vJXCPqKyLc/UpXUn+LTV6DAOrr7ryKJb+mpa8QC93WQdXx74Ygge9zZ5S04SuNwQ
	tW1+lqpybzkFEbq1SXMamIRsVR9RnPT1htvNHNYJh3iVgUvh3hf/W5JjhZGE/S4G
	MMJzTfPRAkXsDFXKCUsvalJgnE+/Hl0iJDq54AeA8GKrajajzavGQOu8rLUasFpq
	RrKABVz8EnlfxWD92fErOemWLykW4Pb8XhJfMtRTKF44jBwGnHvAzx9KbDHJgb/z
	960ZT6NtFi3AmvyzLjTCuflF9JrEw3JotTpU6Uw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HBO+f7YuAN1GokUNpyx3YxNVPusAKTOKCKbxuR7V9Io=:kkGpJtTJ0zr78kzK/N0ykbmwlaV7KmM0vc0D3x/1ua0=;
X-ME-Sender: <xms:9YruahrLC5cWM-a0t7TlmSg4PUTFqXJIBL_LgH6i6tob05ge_uBdOw>
    <xme:9Yruaqi8o8tBn8hHYQD_T-tiWPhUpvjn913tI33aLWAG2eF0yejQLcl8RTdSfB3IH
    tqeUuXR7tbNJ68_x6Wqp7W92Q-NgtiPio5HiJerzCIrOBlMVzA7xbw>
X-ME-Received: <xmr:9YruamjWKA5fPUy7K_0OuGNu4F-4Zpe0y3M_qggHmPF2td1i38Z_L-z-KOFhYb8f2oxyA6VOgO88xCL0lJxirpMLRADioKAa7-0U>
X-ME-Proxy-Cause: dmFkZTEW188DnOyPaQWPMSVU1QeOTIcaa43GnO/+DGG1UX/aNQqwAk3xM3fQ0rlY+bQgQN
    cbTIh2irNqGvK8197baouWnnaAH4QCoX7hDeqAoALQZ9nE62k/6Otx7zzcjO+NK47bfllF
    2MRztQQGVxA0V2O9O7Ar9iFebmE9YRzxGEQRQttXd2A4HAT9aqAo9HCS2XJ1xsN5g/QUHp
    S1IG2P5zvtM/JaA3ChkKGxDh2tsBr+XL0GG2lPVyfOYw73KW9evnfxuyecqbtJjXooDX2T
    uWC6bG6z+ylPs2DN9GgN8Q4Ov0unK37TzJwR9SxAg49oy4oG3Cgyyb2zZ51lLXix+V8rAv
    Gw1IrtFWfJMbwnU4uxuvG9OHZQpCEcOUPg+LOlhhJyIR4gXnq1z/85ybne8SoQ1N4g6fJA
    5jl+NMfNUgn7+HiyADutVNZM2HvIqhYDbuSSPHpaR+C1CB5F/l7I9T56w6DjDfQBgtzndF
    aAkmMktvHwyleRrPslUtg6cp7inOIv2qeAAbFC+irchPC7ZDqJZ5tMS6oav5jTPOaLyH7a
    agERsGGz/1cOIStFDKXvbjqYqe32BIGqNT0jVqF9DogNcg9bR2CxzpgVIEdP5Q3UMhsKSY
    ecGbwuVqPAXm99ob0alpQ3+RGN01IjTEjAbc4uk996rLwJwSjECysKpwTZAg
X-ME-Proxy: <xmx:9YruaojkhRXPFnTuUZ_2_pzhXWBNImvs66OUwVfMYxiBa8qm3HMYFA>
    <xmx:9YruauI6ykdseKlgoxcVscM98EQVNZ4be6v71VgRIk8rObnIK4uweQ>
    <xmx:9YruavF3VorZ6g6lLa99bEg4VEp-pOroKwQXyvS0AvLoUcK6v1cckA>
    <xmx:9YruaqTf-Hz3eYRAskChxqOKF1e88abRiDvV7lABxQgfp36OjCH8Xw>
    <xmx:9YruaqX-9diZ2J5CBSLYJx5KSZc2ORskhjY4HlVDQdShFizM-judMXaZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 21:20:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH] sideband: skip unrecognized allowControlCharacters
 keywords
In-Reply-To: <pull.2261.git.1792154374653.gitgitgadget@gmail.com> (Thomas
	Bachem via GitGitGadget's message of "Fri, 16 Oct 2026 12:39:34
	+0000")
References: <pull.2261.git.1792154374653.gitgitgadget@gmail.com>
Date: Fri, 06 Nov 2026 18:20:36 -0800
Message-ID: <xmqqbj81bcwb.fsf@gitster.g>
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

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Thomas Bachem <mail@thomasbachem.com>
>
> Since 128914438a (sideband: add options to allow more control
> sequences to be passed through, 2026-03-05), the value of
> sideband.allowControlCharacters is a comma-separated list of
> keywords. When the parser meets a keyword it does not know, it warns
> but stays on that keyword, so the warning repeats forever.
>
> As the setting is read whenever a transport is set up, a typo like
> "colour", a list written as "color, cursor" with a space, or a
> keyword that only a newer version of Git knows is enough to make
> every fetch, push, clone and ls-remote hang this way.
>
> Move on to the next keyword after the warning, and name only the
> unrecognized keyword in it, not the rest of the list.
>
> Assisted-by: Claude Opus 5.5
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>     sideband: skip unrecognized allowControlCharacters keywords
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2261%2Fthomasbachem%2Fsideband-control-characters-loop-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2261/thomasbachem/sideband-control-characters-loop-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2261
>
>  sideband.c                          | 19 ++++++++++++-------
>  t/t5409-colorize-remote-messages.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/sideband.c b/sideband.c
> index 374187402e..ed6840bf89 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -62,18 +62,23 @@ int sideband_allow_control_characters_config(const char *var, const char *value)
>  
>  	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
>  	while (*value) {
> +		if (skip_prefix_in_csv(value, "color", &value)) {
>  			allow_control_characters |= ALLOW_ANSI_COLOR_SEQUENCES;
> +		} else if (skip_prefix_in_csv(value, "cursor", &value)) {
>  			allow_control_characters |= ALLOW_ANSI_CURSOR_MOVEMENTS;
> +		} else if (skip_prefix_in_csv(value, "erase", &value)) {
>  			allow_control_characters |= ALLOW_ANSI_ERASE;
> +		} else if (skip_prefix_in_csv(value, "true", &value)) {
>  			allow_control_characters = ALLOW_ALL_CONTROL_CHARACTERS;
> +		} else if (skip_prefix_in_csv(value, "false", &value)) {
>  			allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
> +		} else {
> +			const char *end = strchrnul(value, ',');
> +
> +			warning(_("unrecognized value for '%s': '%.*s'"),
> +				var, (int)(end - value), value);
> +			value = end + !!*end;

OK, so this assignment to "value" is the only thing that is new.

> +		}

Somehow the review thread seems to have been sidetracked and left
the topic in "needs review' state.  The above looks reasonable to
me.

It might even make sense to allow whitespaces after the comma, but
that would fall into "enhancement" category, and I would prefer to
keep the change required to fix things to the minimum.

>  	}
>  	return 0;
>  }
> diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
> index 5da8b0ad64..6117579eb1 100755
> --- a/t/t5409-colorize-remote-messages.sh
> +++ b/t/t5409-colorize-remote-messages.sh
> @@ -190,4 +190,29 @@ test_expect_success 'allow all control sequences for a specific URL' '
>  	test_grep ! "\\^\\[\\[K" decoded
>  '
>  
> +test_expect_success 'unrecognized keywords in allowControlCharacters are skipped' '
> +	write_script .git/eraser <<-\EOF &&
> +	printf "error: Ohai!\\r\\033[K" >&2
> +	exec "$@"
> +	EOF
> +	test_config_global uploadPack.packObjectsHook ./eraser &&
> +	test_commit unrecognized-keyword &&
> +
> +	# Cap the output, so that a parser stuck on the unrecognized
> +	# keyword fails the test instead of warning forever.
> +	git -c sideband.allowControlCharacters=bogus,erase \
> +		ls-remote . 2>&1 >/dev/null |
> +	head -n 2 >warnings &&

A well thought out testing method.  I like it.

> +	test_line_count = 1 warnings &&
> +	test_grep "allowcontrolcharacters.: .bogus.$" warnings &&
> +
> +	rm -rf throw-away &&
> +	git -c sideband.allowControlCharacters=bogus,erase \
> +		clone --no-local . throw-away 2>stderr &&
> +	test_decode_color <stderr >color-decoded &&
> +	test_decode_csi <color-decoded >decoded &&
> +	test_grep "CSI \\[K" decoded &&
> +	test_grep ! "\\^\\[\\[K" decoded
> +'
> +
>  test_done

Thanks.  Let's mark the topic as ready for 'next'.

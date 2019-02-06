Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62ADE1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 21:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfBFV6p (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 16:58:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40973 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBFV6p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 16:58:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id p15so3019477edy.8
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7qvenCz9kBYdgAgzh0PZn2IjL9xf02GySU0E+7B3fMs=;
        b=KrOpwyOe+DtMxGq5qbFZ2+mYaIRYT50sFJW0fq8jGeGDgWSuTInMS1Fut3pCcMVpYj
         ELn5fKtA0SEzwrxRmEoDfKge550qHQK2a4kmMToNeZKtq9/654NvwCeQzycIcu1cs/mV
         u6R3Lcc+HCPZMSUuBYuoiYpIZh73j/2qhL1XFvmwpCuKVsl1T6MXbAbCGtIM0164u6J0
         NO4CNcFDsL/tJrBUwcBD0A/QXkaRNLrXcPhDGPXqQi8i+ExUIryPCIpaItjLyKzFpD9w
         RCE0axpTEsfmvBS2uNShpX3gGHvcA5+30kCgewZMbktdTGA6zjtfPf2Fn36cNNT4Jhmm
         SC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7qvenCz9kBYdgAgzh0PZn2IjL9xf02GySU0E+7B3fMs=;
        b=U2Rpj8k7Q23+vqr0Z13Ru4KfCeV8k7xhBnMqd+jBZH6bSEML9L7424kZ3/AQdfY8ac
         TrsVPbupQXadQaU/cErWiVo6tu7J/PbVEonjGm94h8SH1kxGuwBAlL5NYcIuVeChop+f
         JhSBEKhiowQE1Y9YxsFqQqdgbjLq108tM4mgn+dbw9KnB9u0/RN1QOtJQuYh2MsvaZZC
         vjXRze7ZWIFns5BI9DXeEiq/rNciwmAMCDkPnCb2i4ZddFUZQlPAp2hf+pThXBwSaJBS
         MPsL0bDGE/NkorgGUp6/i4fIJz81QCwIwXTcd5qprgCSqGNRos3+4YvmNVgP9Kqs0rwG
         g6ng==
X-Gm-Message-State: AHQUAubcmLLoQok8Pn9ACYHfs926WbNsCChcfzyJX3AhI5bu1UwY/dLf
        hk48Zd4Frlaw8RmwYw2B6x7O1oIM5V0=
X-Google-Smtp-Source: AHgI3IYmPZIIL7EV3CoHDfIjfr8XLBzw10RvOZOo3e4+5ePIA6yarP66U0i2sHPDWT7J1NLsX0qqBA==
X-Received: by 2002:a50:c2d9:: with SMTP id u25mr9969624edf.280.1549490322382;
        Wed, 06 Feb 2019 13:58:42 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f38sm1488683edd.97.2019.02.06.13.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 13:58:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 1/8] tests: define GIT_TEST_PROTOCOL_VERSION
References: <cover.1549411880.git.jonathantanmy@google.com> <6e0c6aa9a71d4192591ed406735684cd15a0e3b9.1549411880.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <6e0c6aa9a71d4192591ed406735684cd15a0e3b9.1549411880.git.jonathantanmy@google.com>
Date:   Wed, 06 Feb 2019 22:58:40 +0100
Message-ID: <87d0o4lgtr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 06 2019, Jonathan Tan wrote:

> Define a GIT_TEST_PROTOCOL_VERSION environment variable meant to be used
> from tests. When set, this ensures protocol.version is at least the
> given value, allowing the entire test suite to be run as if this
> configuration is in place for all repositories.
>
> As of this patch, all tests pass whether GIT_TEST_PROTOCOL_VERSION is
> unset, set to 0, or set to 1. Some tests fail when
> GIT_TEST_PROTOCOL_VERSION is set to 2, but this will be dealt with in
> subsequent patches.
>
> This is based on work by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  protocol.c                  | 17 +++++++++++++++--
>  t/README                    |  3 +++
>  t/t5400-send-pack.sh        |  2 +-
>  t/t5551-http-fetch-smart.sh |  3 ++-
>  4 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/protocol.c b/protocol.c
> index 5664bd7a05..c7a735bfa2 100644
> --- a/protocol.c
> +++ b/protocol.c
> @@ -42,6 +42,10 @@ static const char *format_protocol_version(enum protoc=
ol_version version)
>  enum protocol_version get_protocol_version_config(void)
>  {
>  	const char *value;
> +	enum protocol_version retval =3D protocol_v0;
> +	const char *git_test_k =3D "GIT_TEST_PROTOCOL_VERSION";
> +	const char *git_test_v =3D getenv(git_test_k);
> +
>  	if (!git_config_get_string_const("protocol.version", &value)) {
>  		enum protocol_version version =3D parse_protocol_version(value);
>
> @@ -49,10 +53,19 @@ enum protocol_version get_protocol_version_config(voi=
d)
>  			die("unknown value for config 'protocol.version': %s",
>  			    value);
>
> -		return version;
> +		retval =3D version;
> +	}
> +
> +	if (git_test_v && strlen(git_test_v)) {
> +		enum protocol_version env =3D parse_protocol_version(git_test_v);
> +
> +		if (env =3D=3D protocol_unknown_version)
> +			die("unknown value for %s: %s", git_test_k, git_test_v);
> +		if (retval < env)
> +			retval =3D env;
>  	}
>
> -	return protocol_v0;
> +	return retval;
>  }
>
>  void register_allowed_protocol_version(enum protocol_version version)
> diff --git a/t/README b/t/README
> index 25864ec883..21e941eb94 100644
> --- a/t/README
> +++ b/t/README
> @@ -327,6 +327,9 @@ marked strings" in po/README for details.
>  GIT_TEST_SPLIT_INDEX=3D<boolean> forces split-index mode on the whole
>  test suite. Accept any boolean values that are accepted by git-config.
>
> +GIT_TEST_PROTOCOL_VERSION=3D<n>, when set, overrides the
> +'protocol.version' setting to n if it is less than n.
> +

In my version
(https://public-inbox.org/git/20181213155817.27666-6-avarab@gmail.com/)
I didn't have this "if it is less than n" caveat. I expect that helped
with making some tests that were setting e.g. protocol.version=3D2 Just
Work, is that the reason for this?

Mine also had more docs here, but maybe telling people that they can use
"env" is too much...


>  GIT_TEST_FULL_IN_PACK_ARRAY=3D<boolean> exercises the uncommon
>  pack-objects code path where there are more than 1024 packs even if
>  the actual number of packs in repository is below this limit. Accept
> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index f1932ea431..571d620aed 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -288,7 +288,7 @@ test_expect_success 'receive-pack de-dupes .have line=
s' '
>  	$shared .have
>  	EOF
>
> -	GIT_TRACE_PACKET=3D$(pwd)/trace \
> +	GIT_TRACE_PACKET=3D$(pwd)/trace GIT_TEST_PROTOCOL_VERSION=3D \
>  	    git push \
>  		--receive-pack=3D"unset GIT_TRACE_PACKET; git-receive-pack" \
>  		fork HEAD:foo &&
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index a60dd907bd..8f620e0a35 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -44,7 +44,8 @@ test_expect_success 'clone http repository' '
>  	< Cache-Control: no-cache, max-age=3D0, must-revalidate
>  	< Content-Type: application/x-git-upload-pack-result
>  	EOF
> -	GIT_TRACE_CURL=3Dtrue git clone --quiet $HTTPD_URL/smart/repo.git clone=
 2>err &&
> +	GIT_TRACE_CURL=3Dtrue GIT_TEST_PROTOCOL_VERSION=3D \
> +		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
>  	test_cmp file clone/file &&
>  	tr '\''\015'\'' Q <err |
>  	sed -e "

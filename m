Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D8C1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 21:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965194AbdLRVyA (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 16:54:00 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36763 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935229AbdLRVx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 16:53:59 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so495319wmg.1
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N/2fpvATgW9SLN4RCUR7RQcHCI+1emti4yzncZcoqAE=;
        b=fWlXmrwOToA3Z8XkAr3/Y6U23n1HS5+TtI4APquMeQ0QOu8ExvmQ96JOCiS+pyGsdx
         sr/viQFZWiNQ5W8Omm8pQI3KO3tpx3CVQQkYVjih/v6iPDt1gbL4bxdgZLN/u+n2WYK0
         7+uB8i0uEhyoYG9EUs8GKf3oRHiH56VBh3Wl5dBt2s6fuevDQz52ZS93qvhgK8RrmXvQ
         O7DFoLvybJUJckhqLEyVRKgpRKNIOxz4JczvKryxlVFdMglgtZUuHXz66smJMFQ8g+mr
         wX7ZP/n9gnLPye8/CXgxE7bWxXC83qxDwZQ4uG3BJm0//aY4gXPBEEDxGTW2r8KT6lQ9
         8FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N/2fpvATgW9SLN4RCUR7RQcHCI+1emti4yzncZcoqAE=;
        b=A1YB/HjnIBoe4yWr5xH9Zd61aD/XEhta/7hPhne0fShVxw/IVkk9T0XCRWngCnbww/
         bNBvy7peVOWILGM/1l0RZlzk4fbUAZEzr8mC7wOtlVJBr/7xV9ooRKdT+XihOWav4sMq
         UbJI+2rZszi25kZJYYUIAOU961ryVBRU6x/z8lK3rI0zf5xEmd0SyYBUIL4fBuO2SOiU
         +czZzE1q964PzKGOfBXJIjYtEfjMDScHRo1qJiRTJSsmsB/DioJyGGK03PjDGun9MSmx
         MlG+xUpetL5rOJ03IGyrx7HlnA/XqVqg/yHTGtTVz5PnYymfrha1mMCHuuGSQeOA3DXA
         kDQA==
X-Gm-Message-State: AKGB3mI7j8LxQWVXXCjQYDTVB1ZKNBuo+COsEA+FxS2yHN/Sgs0YmLnc
        KbHrLETJn7t1oGYJTwSkwBo=
X-Google-Smtp-Source: ACJfBosIQLnhL6ssCVoUO/+veqtwEW5VKQq2+eyhKmGC3eCUgmaGmc3G8oBhfmnOmcGqdSH0LKvONw==
X-Received: by 10.28.178.135 with SMTP id b129mr666259wmf.103.1513634037592;
        Mon, 18 Dec 2017 13:53:57 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5261.dip0.t-ipconnect.de. [93.219.82.97])
        by smtp.gmail.com with ESMTPSA id k69sm234629wmg.8.2017.12.18.13.53.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 13:53:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/8] travis-ci: use 'set -x' in select 'ci/*' scripts for extra tracing
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
Date:   Mon, 18 Dec 2017 22:53:56 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2E7DCD0-E4E8-4898-ABC5-5C2E70284CFA@gmail.com>
References: <20171211233446.10596-1-szeder.dev@gmail.com> <20171216125418.10743-1-szeder.dev@gmail.com> <20171216125418.10743-2-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Dec 2017, at 13:54, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> While the build logic was embedded in our '.travis.yml', Travis CI
> used to produce a nice trace log including all commands executed in
> those embedded scriptlets.  Since 657343a60 (travis-ci: move Travis CI
> code into dedicated scripts, 2017-09-10), however, we only see the
> name of the dedicated scripts, but not what those scripts are actually
> doing, resulting in a less useful trace log about e.g. installing
> dependencies.  A patch later in this series will move setting
> environment variables from '.travis.yml' to 'ci/lib-travisci.sh', so
> not even those will be included in the trace log.  Unrelated to
> 657343a60, 'ci/test-documentation.sh' runs a bunch of 'test -s <file>'
> checks which would fail quietly if something were wrong, leaving no
> clue about which one of those checks triggered the failure.
>=20
> Use 'set -x' in 'ci/lib-travisci.sh' to get more detailed trace log
> about the commands executed in the 'ci/*' scripts.  Use it in
> 'ci/run-linux32-build.sh' as well, which is run in a Docker container
> and therefore doesn't source 'ci/lib-travisci.sh'.  The secret token
> used for the Windows builds is specified as an encrypted environment
> variable in git/git repository settings on Travis CI and it's redacted
> in the trace logs even with 'set -x'.  However, disable this tracing
> in 'ci/print-test-failures.sh', as it produces far too much noise in
> the output of that script.

I ACK too soon in my other email ;-)

Can you disable the trace log for the loop in "run-windows-build.sh":
=
https://github.com/git/git/blob/52015aaf9d19c97b52c47c7046058e6d029ff856/c=
i/run-windows-build.sh#L75-L88

Otherwise the Travis output look like this:
https://travis-ci.org/git/git/jobs/316791071

- Lars

>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
> ci/lib-travisci.sh        | 6 ++++--
> ci/print-test-failures.sh | 3 +++
> ci/run-linux32-build.sh   | 2 ++
> 3 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index ac05f1f46..2d0d1d613 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -22,8 +22,10 @@ skip_branch_tip_with_tag () {
> }
>=20
> # Set 'exit on error' for all CI scripts to let the caller know that
> -# something went wrong
> -set -e
> +# something went wrong.
> +# Set tracing executed commands, primarily setting environment =
variables
> +# and installing dependencies.
> +set -ex
>=20
> skip_branch_tip_with_tag
>=20
> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> index 8c8973cbf..f757e616c 100755
> --- a/ci/print-test-failures.sh
> +++ b/ci/print-test-failures.sh
> @@ -5,6 +5,9 @@
>=20
> . ${0%/*}/lib-travisci.sh
>=20
> +# Tracing executed commands would produce too much noise in this =
script.
> +set +x
> +
> for TEST_EXIT in t/test-results/*.exit
> do
> 	if [ "$(cat "$TEST_EXIT")" !=3D "0" ]
> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
> index e30fb2cdd..a8518eddf 100755
> --- a/ci/run-linux32-build.sh
> +++ b/ci/run-linux32-build.sh
> @@ -6,6 +6,8 @@
> #   run-linux32-build.sh [host-user-id]
> #
>=20
> +set -x
> +
> # Update packages to the latest available versions
> linux32 --32bit i386 sh -c '
>     apt update >/dev/null &&
> --=20
> 2.15.1.429.ga000dd9c7
>=20


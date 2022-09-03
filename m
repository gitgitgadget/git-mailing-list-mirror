Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFDAECAAD4
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 05:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiICFHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiICFHp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 01:07:45 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D1F4CAC
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 22:07:44 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id y15so2936207qvn.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jfrJjh32kTAyQAQ/cPMTIEp6ceJs1YpAg7kpkt6R3Ks=;
        b=q3/zXhEOQXuWUB9Yz8eAvWGxGmqdFKsFv9oeSAwZUsnaLpVvKQmgomdrfVDOEEl3h6
         GHRhJRTAGgOVZiG2WjA4GxFBHDS5+D7WnGX0RjIGvgmEUi0Pln2iOdZ9mQc4uz0YYOyT
         bhAR0E9YdRw4eTJdTKNaDQRNOPgvr74ClsvlSzcKRssAypv73CCZTFEUqeV3Cg1LGoD3
         Dzg/Xbr1MVUnM+5rFyAAdyJNVCClUX1IxlL0PclSuxw4h6I+nB4Zox4BU7GVjYtKc47Y
         HIA+Vx8Ay4kgJEesDV1V8L9ZdXhWm6S78bjljYCjbakWIYSabF9RQi0OObx5I9ezp5G6
         d1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jfrJjh32kTAyQAQ/cPMTIEp6ceJs1YpAg7kpkt6R3Ks=;
        b=396omu1Hpq2UCxpvZU2C/G08XOysVpizdW4Zf0kYhGLtoZGDAnj1gcAO9GmDo1eOHe
         RlvieWg1sG5FvbVAuMWS9AOvCBYD9cTk+9fT4Ky4+7Qaj0pDvibcLCyHSVZYJTNqvZ6Q
         kuBJApqx+dRqk9s0W1bsDcoXx9sQFGunqE2OfTQPQl0tpEmznaaR34Jyt+Ac7hsmWxVf
         ByBQ2gXR1hSHrJu6Gk8VdH+oxmdVGVbmBcst0Cr2yXWZyb8m8yQK5g6nIpJ7o+d+S1eh
         zaD0ZxiQaXFII4uiQlCw4sz2oA4ZLatYgDbK1iPvIaGVNQjz3vXWh8dYs2qUCX8EaMPF
         gi5g==
X-Gm-Message-State: ACgBeo3cJOCVUW7KwkdgPwDQCUN5P1b71Rovixt58OAq7rjOaAI2AKgy
        vb9vO9w92AGtE2kTKpYjn/pAzhZmRKjnJ3w3Eirpku36nEg=
X-Google-Smtp-Source: AA6agR5utIk14S0CGa6UfbwBC+v9YSE+JH3DBTu+98isPPLlM5c3TwNj8h3lBi1uLLTy4MmhvD9//T9lpWptfCMBWVE=
X-Received: by 2002:a0c:8b92:0:b0:496:c8ff:b4c7 with SMTP id
 r18-20020a0c8b92000000b00496c8ffb4c7mr30485237qva.115.1662181664067; Fri, 02
 Sep 2022 22:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com> <9589f2a6e495034cc4f45bd0bce80dedfcd30f16.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <9589f2a6e495034cc4f45bd0bce80dedfcd30f16.1661992197.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Sep 2022 22:07:33 -0700
Message-ID: <CABPp-BHAGb9RU2d7_1ZCDbgKj9aB0JkHUD9_mMnVL=EttqZ4Bw@mail.gmail.com>
Subject: Re: [PATCH 16/18] test-lib: replace chainlint.sed with chainlint.pl
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 5:30 PM Eric Sunshine via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> By automatically invoking chainlint.sed upon each test it runs,
> `test_run_` in test-lib.sh ensures that broken &&-chains will be
> detected early as tests are modified or new are tests created since it

s/new are tests created/new tests are created/  ?


> is typical to run a test script manually (i.e. `./t1234-test-script.sh`)
> during test development. Now that the implementation of chainlint.pl is
> complete, modify test-lib.sh to invoke it automatically instead of
> chainlint.sed each time a test script is run.
>
> This change reduces the number of "linter" invocations from 26800+ (once
> per test run) down to 1050+ (once per test script), however, a
> subsequent change will drop the number of invocations to 1 per `make
> test`, thus fully realizing the benefit of the new linter.
>
> Note that the "magic exit code 117" &&-chain checker added by bb79af9d09
> (t/test-lib: introduce --chain-lint option, 2015-03-20) which is built
> into t/test-lib.sh is retained since it has near zero-cost and
> (theoretically) may catch a broken &&-chain not caught by chainlint.pl.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  t/test-lib.sh                       | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 2237109b57f..ca358a21a5f 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1076,7 +1076,7 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
>                 "string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
>                 "file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
>         #misc copies
> -       file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
> +       file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.pl DESTINATION ${CMAKE_BINARY_DIR}/t/)
>         file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
>         file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
>         file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index dc0d0591095..a65df2fd220 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1091,8 +1091,7 @@ test_run_ () {
>                 trace=
>                 # 117 is magic because it is unlikely to match the exit
>                 # code of other programs
> -               if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
> -                       test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
> +               if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
>                 then
>                         BUG "broken &&-chain or run-away HERE-DOC: $1"
>                 fi
> @@ -1588,6 +1587,12 @@ then
>         BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
>  fi
>
> +if test "${GIT_TEST_CHAIN_LINT:-1}" != 0
> +then
> +       "$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
> +               BUG "lint error (see '?!...!? annotations above)"
> +fi
> +
>  # Last-minute variable setup
>  USER_HOME="$HOME"
>  HOME="$TRASH_DIRECTORY"
> --
> gitgitgadget
>

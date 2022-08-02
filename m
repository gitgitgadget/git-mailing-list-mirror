Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E05C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 22:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiHBWbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiHBWaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 18:30:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA08CE98
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 15:30:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 137-20020a250b8f000000b0067a5a14d730so1493030ybl.12
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=yKqn/W2nObmHDAQeDyjMYgMGvOai7VqgE+V4mT1ZT5c=;
        b=qTrvRQpgBA67Bmgh6FtY8MonyzbHEiSkJqJOSYQJdxHPiBmWALDxatNtcyRdazk5+z
         Uuj3WpYNW2jwgFEKUybVgDZx3K48rXBkOVdwXeRlwzKxK0QiCBJWUuOFRx3pD6GAS0OI
         octiaNzgBDqFSmoEpdwSC7dn2HaNIrry9tyzEy0Zfjz2xCSYb3iQAk3cMXntWbHOrZ+m
         gSJttGpiwgbq27gnLHJHRbfCL+K63kObqfSBxsLzzE9Rtk8547c7Ic4u+1JGqsR2dU0W
         GS7QnKFqZxFsPMGsnkAzCzxnTVDtwwHLsoSRDMtUVHCSc/mi9LxiyOOT4Ctinv2JUqQ4
         bEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=yKqn/W2nObmHDAQeDyjMYgMGvOai7VqgE+V4mT1ZT5c=;
        b=fTAdY1xg8IUdX4lYn4l5J9yndvmxRgxgLp5MaqkdV8F9RCnbTJxfZVk0QGuXnn/QgQ
         eMdsBuBX1bI7qSwMmS3HR0WX0rXFoA1ETIcZnzT5ZVBFhHI/SHOPu3C4orwIkvv7GUH4
         YHd8o5N9E9UgNltNEviVySlzQfCe3n26R5yu8r5S3CDDv41Zb5lWPioFme/THqj8P0CK
         UD5QH0X74/tkt/Cbl3zQCJBOcSw4c5ewttjPKWN4LhbNAyHRcgXeG+MoPZXUFLKdLQF2
         cLiYMLBr+X5cqxVr4xBQU+67xblkdmqhObgK3Ik0+iogDwIHKnWBvd25GLrYW09bLOVl
         EwvQ==
X-Gm-Message-State: ACgBeo34G64AUEAikg91eS4KO/Bu9UOc+8nXm+QeqmZl3f6D/vFHCy7Z
        WT/XFzc8FYEo6nMHdomD1YWgRIUgELPA0g==
X-Google-Smtp-Source: AA6agR6LOGOaMMHGaAKRYvRpc7LPfmkgmHoZ4/WGUw9HHxb5aNUok63/0GTzkUz487HHDXmtL6yUgMY+twit5A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:ea8b:0:b0:322:f209:6bda with SMTP id
 t133-20020a0dea8b000000b00322f2096bdamr20594718ywe.298.1659479415920; Tue, 02
 Aug 2022 15:30:15 -0700 (PDT)
Date:   Tue, 02 Aug 2022 15:30:06 -0700
In-Reply-To: <patch-v2-01.28-daa5d3f9962-20220802T154036Z-avarab@gmail.com>
Message-Id: <kl6ltu6uth1t.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com> <patch-v2-01.28-daa5d3f9962-20220802T154036Z-avarab@gmail.com>
Subject: Re: [PATCH v2 01/28] submodule tests: test usage behavior
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Test what exit code and output we emit on "git submodule -h", how we
> handle "--" when no subcommand is specified, and how the top-level
> "--recursive" option is handled.
>
> For "-h" this doesn't make sense, but let's test for it so that any
> subsequent eventual behavior change will become clear.
>
> For "--" this follows up on 68cabbfda36 (submodule: document default
> behavior, 2019-02-15) and tests that "status" doesn't don't support

s/doesn't don't/doesn't/ I assume ;)

> the "--" delimiter. There's no intrinsically good reason not to
> support that. We behave this way due to edge cases in
> git-submodule.sh's implementation, but as with "-h" let's assert our
> current long-standing behavior for now.
>
> For "--recursive" the exclusion of it from the top-level appears to
> have been an omission in 15fc56a8536 (git submodule foreach: Add
> --recursive to recurse into nested submodules, 2009-08-19), there
> doesn't seem to be a reason not to support it alongside "--quiet" and
> "--cached", but let's likewise assert our existing behavior for now.

I think my original comment isn't directly addressed here:

  I'm not sure about this one. "--recursive" isn't a top level option, and
  15fc56a8536 doesn't seem to suggest that it was meant to be one (but I
  did realize that git-submodule.txt documents all of the options to all
  subcommands, which is very confusing.)

But maybe I'm mistaken and it's somewhere. Do we know whether
"--recursive" was always intended to be top-level?

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t7400-submodule-basic.sh | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index e7cec2e457a..b858871a953 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -14,6 +14,32 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> =20
>  . ./test-lib.sh
> =20
> +test_expect_success 'submodule usage: -h' '
> +	git submodule -h >out 2>err &&
> +	grep "^usage: git submodule" out &&
> +	test_must_be_empty err
> +'
> +
> +test_expect_success 'submodule usage: --recursive' '
> +	test_expect_code 1 git submodule --recursive >out 2>err &&
> +	grep "^usage: git submodule" err &&
> +	test_must_be_empty out
> +'
> +
> +test_expect_success 'submodule usage: status --' '
> +	test_expect_code 1 git submodule -- &&
> +	test_expect_code 1 git submodule --end-of-options
> +'
> +
> +for opt in '--quiet' '--cached'
> +do
> +	test_expect_success "submodule usage: status $opt" '
> +		git submodule $opt &&
> +		git submodule status $opt &&
> +		git submodule $opt status
> +	'
> +done
> +
>  test_expect_success 'submodule deinit works on empty repository' '
>  	git submodule deinit --all
>  '

The changes themselves look good :)

> --=20
> 2.37.1.1233.ge8b09efaedc

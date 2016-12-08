Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D931FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 00:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933750AbcLHACn (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 19:02:43 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35266 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932967AbcLHACm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 19:02:42 -0500
Received: by mail-qt0-f179.google.com with SMTP id c47so397344857qtc.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gMGmvUnH0pik6+NEK7Bnm8e+oj4jdbFw7CaMWVMGkZM=;
        b=a/HVoD9uonukcmpvbIhb4uDT5v0XXm+i7ZLr6eo1Q/4eovqrxDuI8JIRETY4c5xBdo
         f4CvfXdJ59HMEPkoDbzcO2G7Hx5iJoDVkKfe+poaLqfX7hXYZa5WuGQczsvvjw8BL2Zy
         OC5ljLF7zpuao/Vp9o/IrbFa+9sYMLbo/CAug6/ZzgBDlCM/Dl7kWyjFBCCl51cVO+eu
         69as8Lahpx3yPd54MPMCR4T/YvSQcTkFf42CqfIOz/iLz76RGQjvW1Fr5urf3vFKqGk6
         OGu2Fu04KlBVzsvMYuqUMBaBv+dyA1e929w7deWGZX3ya8kVS3oY1lCo50putoUQbDdM
         74Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gMGmvUnH0pik6+NEK7Bnm8e+oj4jdbFw7CaMWVMGkZM=;
        b=Q1W91OClkFO1wD1IWTU9/UX9fxTgiiTL0hBwMw9b/4zYop3hll8uIzZk0LBGxnmMBS
         VEPlLvoe1agbEBtdXD9tHMoc6PgWmKAh7/NcBAyng9ZklpQVbHNzfHaAnTPZQrUbGyN6
         MULHmmGGvsESmsFUhjSchKhX8GFDclu/oY6+muG76V/iHBMZFpuWYSMs2/I+lalWLDnj
         0c7MClZjzXUkcEqArar51VlRX6iTRrDIh9S0PGpjIKTUeAFdcYbDUjBmxsDnN8kXMIN2
         /qevivRqwcc2+YPCDcuinIGku9q4tna2qTPSFKz3+TA5AshuzdhMNqBmDaxIA5w/koVm
         iWIQ==
X-Gm-Message-State: AKaTC00rrcIZbRIsZ4KqUodxJRSprkbHIRD7N6gxYBgVnzPjy0x/2SvMZ4vvG7IZEHe5Jka9oQNPrMZ8MephRbRZ
X-Received: by 10.200.37.221 with SMTP id f29mr69062229qtf.123.1481155361486;
 Wed, 07 Dec 2016 16:02:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 16:02:41 -0800 (PST)
In-Reply-To: <20161207224948.7957-1-vi0oss@gmail.com>
References: <20161207224948.7957-1-vi0oss@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 16:02:41 -0800
Message-ID: <CAGZ79kaSVcf1zk4P1hWsU=aJG7G99qohhavBftmPxnrkjW+nfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule--helper: set alternateLocation for cloned submodules
To:     vi0oss <vi0oss@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 2:49 PM,  <vi0oss@gmail.com> wrote:
> Notes:
>     Resolved issues pointed by Stefan Beller except of
>     the one about loosened path check, which he aggreed
>     to be relaxed for this case.

I am sorry to have given an incomplete review at the first time. :/
More below.

> +       /* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
> +       git_config_get_string("submodule.alternateLocation", &sm_alternate);
> +       if (sm_alternate) {
> +               git_config_set_in_file(p, "submodule.alternateLocation",
> +                                          sm_alternate);
> +       }

For a single command, we usually omit the braces for
an if clause, i.e.

    if (foo)
        bar(...);

    /* code goes on */


> +       git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
> +       if (error_strategy) {
> +               git_config_set_in_file(p, "submodule.alternateErrorStrategy",
> +                                          error_strategy);
> +       }
> +
> +               free(sm_alternate);
> +               free(error_strategy);
> +

The indentation seems a bit off for the free here?
(The main nit that motivated me writing the email)


>         strbuf_release(&sb);
>         strbuf_release(&rel_path);
>         free(sm_gitdir);
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index 1c1e289..ef7771b 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -125,4 +125,76 @@ test_expect_success 'ignoring missing submodule alternates passes clone and subm
>         )
>  '
>
> +test_expect_success 'preparing second superproject with a nested submodule' '
> +       test_create_repo supersuper &&
> +       (
> +               cd supersuper &&
> +               echo "I am super super." >file &&
> +               git add file &&
> +               git commit -m B-super-super-initial
> +               git submodule add "file://$base_dir/super" subwithsub &&
> +               git commit -m B-super-super-added &&
> +               git submodule update --init --recursive &&
> +               git repack -ad
> +       )
> +'
> +
> +# At this point there are three root-level positories: A, B, super and super2
> +
> +test_expect_success 'nested submodule alternate in works and is actually used' '
> +       test_when_finished "rm -rf supersuper-clone" &&
> +       git clone --recursive --reference supersuper supersuper supersuper-clone &&
> +       (
> +               cd supersuper-clone &&
> +               # test superproject has alternates setup correctly
> +               test_alternate_is_used .git/objects/info/alternates . &&
> +               # immediate submodule has alternate:
> +               test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
> +               # nested submodule also has alternate:
> +               test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
> +       )
> +'
> +
> +test_expect_success 'missing nested submodule alternate fails clone and submodule update' '
> +       test_when_finished "rm -rf supersuper-clone supersuper2" &&
> +       git clone supersuper supersuper2 &&
> +       (
> +               cd supersuper2 &&
> +               git submodule update --init
> +       ) &&
> +       test_must_fail git clone --recursive --reference supersuper2 supersuper2 supersuper-clone &&
> +       (
> +               cd supersuper-clone &&
> +               # test superproject has alternates setup correctly
> +               test_alternate_is_used .git/objects/info/alternates . &&
> +               # update of the submodule fails
> +               test_must_fail git submodule update --init --recursive &&
> +               # immediate submodule has alternate:
> +               test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
> +               # but nested submodule has no alternate:
> +               test_must_fail test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
> +       )
> +'
> +
> +test_expect_success 'missing nested submodule alternate in --reference-if-able mode' '
> +       test_when_finished "rm -rf supersuper-clone supersuper2" &&
> +       git clone supersuper supersuper2 &&
> +       (
> +               cd supersuper2 &&
> +               git submodule update --init
> +       ) &&
> +       git clone --recursive --reference-if-able supersuper2 supersuper2 supersuper-clone &&
> +       (
> +               cd supersuper-clone &&
> +               # test superproject has alternates setup correctly
> +               test_alternate_is_used .git/objects/info/alternates . &&
> +               # update of the submodule fails
> +               test_must_fail git submodule update --init --recursive &&
> +               # immediate submodule has alternate:
> +               test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
> +               # but nested submodule has no alternate:
> +               test_must_fail test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
> +       )

Both the first and the last part are the same in the last two tests,
the only difference is the line with git clone --reference ...
Maybe we can use a function somehow to make this a bit more
obvious?

Otherwise the tests look good to me.

Thanks,
Stefan

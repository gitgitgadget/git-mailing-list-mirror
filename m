Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444AE1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757274AbcIAVKV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:10:21 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36869 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755564AbcIAVEV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:04:21 -0400
Received: by mail-it0-f53.google.com with SMTP id e124so3589847ith.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IVzMfyWt3vfMeusgolnc1kUVfSWvl+1/4l5mYJIVA48=;
        b=hDoPrDelcMskUjkLMppvBVBzxZJtrRg1SnpIIBG61JWpTtFzzm206sfY0T+/k8mn2f
         WgbGAZ18DDLbVDPkVO45C49xf4XxOGLgaYROX1Sbksyh4yQuMRH313At/j00LdckquDN
         E6R4HIlbEN6xGyRjePo0YvC5XrCDps7KXIU+/qWPxGpVppRSdvRJP2ucugs7OLHQAYgi
         7Aw017/OIzByiMF2hdHKx7YU7zKQE1n29R8HqASkQ0rKP12/yBN8G2kJhW+0iS9PuRsJ
         8BKOOBNoYHMWdeV2oBAQbzHvZ2VMIyL7U86eLiWz3BdGCfHgHPwpPbH8yio7Yg2JxqNH
         FMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IVzMfyWt3vfMeusgolnc1kUVfSWvl+1/4l5mYJIVA48=;
        b=gGSTC87uZt8KVrkX22cPfF88gpmzil3BFAeKuOFrLnzzRL0End150qorMahD5PA9iX
         zPFfvvgBq8dxzME2w4pHeo031crg2QCYuqzGf9FA/bpYtEYpjJ6hKw/swju5u1upZciz
         1ccfmY2QYkMeI410IgZssMj4wH582J7oDMLwzRGDGoV9WCZQcvgWa7QNfWYfjBNcaiD6
         q0NfPJrF2c8xfbm1TxU9NjdO3Pl6SAj5zqibpfbBrvErYU6BZGHtPWEsAtD0GI1Fs7NB
         7T77hgdaBadEVrGA95MS9hvF9m3tFspB/AacIFHykrGCg+TXvi5PfkYfOQoFQ+5TgPp2
         p8FQ==
X-Gm-Message-State: AE9vXwOdX2nhpK8VofTh4i2o2J66wJnV53hPzj6YTfL43LAdNw+ejCFKF7qVNJcJfR7upjSUfSfEYgaTOswJEz5L
X-Received: by 10.36.53.14 with SMTP id k14mr40390543ita.58.1472763848629;
 Thu, 01 Sep 2016 14:04:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 1 Sep 2016 14:04:07 -0700 (PDT)
In-Reply-To: <xmqq4m5zwevl.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
 <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
 <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
 <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com> <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
 <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com> <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
 <CAN5XQftt3qVoU9gB2oyimY328VK0W6xq5FSCQYvcB9dEgkxVWA@mail.gmail.com>
 <xmqqmvjrwjwm.fsf@gitster.mtv.corp.google.com> <CAGZ79kZnhNVBy6Oqt=x8m0jZj_tGNkMPPBBr+aL6DToOYtv9vQ@mail.gmail.com>
 <xmqqa8frwhpr.fsf@gitster.mtv.corp.google.com> <xmqq4m5zwevl.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Sep 2016 14:04:07 -0700
Message-ID: <CAGZ79kaVBX_zLsSwkz=d_JUfvkeYHyZ1kkYm7Ae_dGBfFarDCQ@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Uma Srinivasan <usrinivasan@twitter.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> The final version needs to be accompanied with tests to show the
>>>> effect of this change for callers.  A test would set up a top-level
>>>> and submodule, deliberately break submodule/.git/ repository and
>>>> show what breaks and how without this change.
>>>
>>> Tests are really good at providing this context as well, or to communicate
>>> the actual underlying problem, which is not quite clear to me.
>>> That is why I refrained from jumping into the discussion as I think the
>>> first few emails were dropped from the mailing list and I am missing context.
>>
>> I do not know where you started reading, but the gist of it is that
>> submodule.c spawns subprocess to run in the submodule's context by
>> assuming that chdir'ing into the <path> of the submodule and running
>> it (i.e. cp.dir set to <path> to drive start_command(&cp)) is
>> sufficient.  When <path>/.git (either it is a directory itself or it
>> points at a directory in .git/module/<name> in the superproject) is
>> a corrupt repository, running "git -C <path> command" would try to
>> auto-detect the repository, because it thinks <path>/.git is not a
>> repository and it thinks it is not at the top-level of the working
>> tree, and instead finds the repository of the top-level, which is
>> almost never what we want.
>
> This is with a test that covers the call in get_next_submodule() for
> the parallel fetch callback.  I think many of the codepaths will end
> up recursing forever the same way without the fix in a submodule
> repository that is broken in a similar way, but I didn't check, so
> I do not consider this to be completed.

Oh I see. That seems like a nasty bug.

>
> -- >8 --
> Subject: submodule: avoid auto-discovery in prepare_submodule_repo_env()
>
> The function is used to set up the environment variable used in a
> subprocess we spawn in a submodule directory.  The callers set up a
> child_process structure, find the working tree path of one submodule
> and set .dir field to it, and then use start_command() API to spawn
> the subprocess like "status", "fetch", etc.
>
> When this happens, we expect that the ".git" (either a directory or
> a gitfile that points at the real location) in the current working
> directory of the subprocess MUST be the repository for the submodule.
>
> If this ".git" thing is a corrupt repository, however, because
> prepare_submodule_repo_env() unsets GIT_DIR and GIT_WORK_TREE, the
> subprocess will see ".git", thinks it is not a repository, and
> attempt to find one by going up, likely to end up in finding the
> repository of the superproject.  In some codepaths, this will cause
> a command run with the "--recurse-submodules" option to recurse
> forever.
>
> By exporting GIT_DIR=.git, disable the auto-discovery logic in the
> subprocess, which would instead stop it and report an error.

and GIT_DIR=.git works for both .git files as well as the old fashioned way,
with the submodule repository at .git/, although that is not really documented.

>
> Not-signed-off-yet.
> ---
>  submodule.c                 |  1 +
>  t/t5526-fetch-submodules.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/submodule.c b/submodule.c
> index 1b5cdfb..e8258f0 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1160,4 +1160,5 @@ void prepare_submodule_repo_env(struct argv_array *out)
>                 if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>                         argv_array_push(out, *var);
>         }
> +       argv_array_push(out, "GIT_DIR=.git");
>  }
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 954d0e4..b2dee30 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -485,4 +485,33 @@ test_expect_success 'fetching submodules respects parallel settings' '
>         )
>  '
>
> +test_expect_success 'fetching submodule into a broken repository' '
> +       # Prepare src and src/sub nested in it
> +       git init src &&
> +       (
> +               cd src &&
> +               git init sub &&
> +               git -C sub commit --allow-empty -m "initial in sub" &&
> +               git submodule add -- ./sub sub &&
> +               git commit -m "initial in top"
> +       ) &&

This is not needed, as setup() set up some repositories for you.

> +
> +       # Clone the old-fashoned way
> +       git clone src dst &&

if you don't go with your own setup, maybe:

        git clone . dst
        git -C dst clone ../submodule submodule

    # and further down s/sub/submodule/

> +       git -C dst clone ../src/sub sub &&
> +
> +       # Make sure that old-fashoned layout is still supported

fashioned

> +       git -C dst status &&
> +
> +       # Recursive-fetch works fine
> +       git -C dst fetch --recurse-submodules &&
> +
> +       # Break the receiving submodule
> +       rm -f dst/sub/.git/HEAD &&
> +
> +       # Recursive-fetch must terminate
> +       # NOTE: without fix this will recurse forever!
> +       test_must_fail git -C dst fetch --recurse-submodules

So in case we'd break it again in the future we'd notice by an
infinite time for the test suite, then we'd notice this comment and
know what's going on?

I would have suggested to run this actual test in a subshell and then
check if the expected failure would have recovered after a second or two
and depending on that trigger a test failure.

But it doesn't seem to be easy with shells, so this is fine (even the newer
signed off patch, apart from nits above)

> +'
> +
>  test_done
>
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B0A205C9
	for <e@80x24.org>; Fri,  6 Jan 2017 01:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdAFBcZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 20:32:25 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33229 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdAFBcX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 20:32:23 -0500
Received: by mail-qk0-f172.google.com with SMTP id s140so38716152qke.0
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 17:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bkoWwRkiwAMaGJlQsT2FJ03RZPNwSWwS/d6ONKv4vMg=;
        b=BOi3fLhwhtB6Bbe7ECe/akykd4RSUClqMUFChrp71xDpo2R2UbKZ2mgpRg82kLW2cK
         2t7m+kZLsGvxBHIDaRofJpHFEcADva4Oj3j1MyX3uNy7mFdSYTuaU/nbmm4mFKLGV4Kg
         GF0k/P46TqdgU1s/MBtvFkS3Hg3zfVP6cPgg0n7jArm8HRlAuJHz9+mujcutE5oU4rnu
         BRVh+ysYf1iC6ziwGR/dGEpDVECnuSqQ2CgiODtlpuYltPT6NRy2htebQ6wA2X5k30aV
         W7zmMqO/eMswu6NP6XaHFwZP8EIN9vfM9aKOFlwKG8aa8FOwMNx53azHxAc53QOqzJWZ
         NFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bkoWwRkiwAMaGJlQsT2FJ03RZPNwSWwS/d6ONKv4vMg=;
        b=IVHma6Z62jNkWRjiFtE76xYslq79+RhByYYoYbcZMZaGMVw0/obCBtKG9+apl9apyF
         cVB8OkzevcABQNbYkWNmDcHginuFcP2YtMBsAyZBLYe5EHScV0Mizs2WsGm6Hh4unp0V
         lJ9gtc68w8sIN+e0l2EWSOheReL1LGyOXxdncwsq+VIbJgLmxZ/q4C4VX5XWXmvF76Jz
         MZ0Ll0oBHXqENqcdAGKEs+xouh/mrt0v1rFbzJV+JNjF+cCo/Lho4x/sLqS2MV/VhzLp
         W8VGE3xOfwa/kSEhuff+E6Dq0dlztrF5NqByaf6fvJQbTOQELYpb+KQD2S5N1pypIwOG
         pEqA==
X-Gm-Message-State: AIkVDXLTR6acIm5x+oAoiSeidPrSVgJigDlU+V15XLEGSquN5pzLDlTSu8xND3NLaIy3u2l6sSd+tadFBtjrD370
X-Received: by 10.55.105.129 with SMTP id e123mr77742267qkc.173.1483666309880;
 Thu, 05 Jan 2017 17:31:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 5 Jan 2017 17:31:49 -0800 (PST)
In-Reply-To: <20170106010945.79382-3-hansenr@google.com>
References: <20170104005042.51530-1-hansenr@google.com> <20170106010945.79382-1-hansenr@google.com>
 <20170106010945.79382-3-hansenr@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Jan 2017 17:31:49 -0800
Message-ID: <CAGZ79kbRee+3MbAHCSFB0QqGMMF5bcZMiEHV-coRh87vFfq0Ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] t7610: make tests more independent and debuggable
To:     Richard Hansen <hansenr@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 5, 2017 at 5:09 PM, Richard Hansen <hansenr@google.com> wrote:
> Reduce how much a test can interfere other tests:

A bullet point list as an unordered list often indicates that you're
doing multiple
things at once, possibly unrelated, so they could go into different patches. ;)

While telling you to make even more commits: you may also want to make
a patch with an entry to the .mailmap file (assuming you're the same
Richard Hansen that contributed from rhansen@bbn.com);
Welcome to Google!

>
>   * Move setup code that multiple tests depend on to the 'setup' test
>     case.
>   * Run 'git reset --hard' after every test (pass or fail) to clean up
>     in case the test fails and leaves the repository in a strange
>     state.
>   * If the repository must be in a particular state (beyond what is
>     already done by the 'setup' test case) before the test can run,
>     make the necessary repository changes in the test script even if
>     it means duplicating some lines of code from the previous test
>     case.
>   * Never assume that a particular commit is checked out.
>   * Always work on a test-specific branch when the test might create a
>     commit.  This is not always necessary for correctness, but it
>     improves debuggability by ensuring a commit created by test #N
>     shows up on the testN branch, not the branch for test #N-1.




> @@ -112,6 +146,7 @@ test_expect_success 'custom mergetool' '
>  '
>
>  test_expect_success 'mergetool crlf' '
> +       test_when_finished "git reset --hard" &&
>         test_config core.autocrlf true &&
>         git checkout -b test$test_count branch1 &&
>         test_must_fail git merge master >/dev/null 2>&1 &&
> @@ -129,11 +164,11 @@ test_expect_success 'mergetool crlf' '
>         git submodule update -N &&
>         test "$(cat submod/bar)" = "master submodule" &&
>         git commit -m "branch1 resolved with mergetool - autocrlf" &&

> -       test_config core.autocrlf false &&
> -       git reset --hard
> +       test_config core.autocrlf false
>  '

This is the nit that led me to writing this email in the first place:
test_config is a function that sets a configuration for a single test only,
so it makes no sense as the last statement of a test. (In its implementation
it un-configures with test_when_finished)

So I think we do not want to add it back, but rather remove this
test_config statement.

But to do this we need to actually be careful with the order of the newly
added test_when_finished "git reset --hard" and  test_config core.autocrlf true,
which uses test_when_finished internally.

The order seems correct to me, as the reset would be executed after the
"test_config core.autocrlf true" is un-configured.

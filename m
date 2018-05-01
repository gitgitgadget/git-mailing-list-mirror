Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7C91FADF
	for <e@80x24.org>; Tue,  1 May 2018 20:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbeEAUsv (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 16:48:51 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41371 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEAUsu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 16:48:50 -0400
Received: by mail-io0-f194.google.com with SMTP id e12-v6so15024136iob.8
        for <git@vger.kernel.org>; Tue, 01 May 2018 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KRBdAfydkrTMMNgNy4Ea7ux9yhw9Cencatgo64HLriE=;
        b=P+znurXjToqIQ6SKPG71At7mEuxlFo6aUSgoZ9isixPREu9WcHYIxPi80ls8f+utN9
         pZZ9uj1VKlm3K2HS/umhC/cDidFSjDPZDJ0GQpEsmjaZoF9pzJtb5N3RlKggjjyiNGcV
         na6i+bgTIlzsLenWL4B/IsE9cCndVk80QLv1Nhx5ttzhnH+N1DHxPxqbunvu61hzszq8
         0R/VqpFIhcndTjf8+2MDGLEH46lm5Gd+qTHGCrWree0t9gizjWTdCXnLOjyvyG/F3qBM
         /qZ8OMw1dV7rG4mF+3UcDQia+pZEGzMRc7GHgho5jWPdZsER+Ho/IqmmaYtoFriZdSxO
         XcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KRBdAfydkrTMMNgNy4Ea7ux9yhw9Cencatgo64HLriE=;
        b=Y1CJ6ezZRpRYayNNUm3S8csKN0ZKHhXilr1q6sa7KCuAAceTLJ6X+Hh43aC8Sst6zk
         MWty6kDAdVbXDlP0VXsQ7vIdMnwlftwq+tONU4Q+zmRJkTK6HM0yKmxXyvAj7JmX2qHY
         +A2ks0GQIwvfx5hOmY3qOj8JkTziccGDUwATpQsCAuRhc8YgMJsAKTRaVaCNFDUfX/hG
         bOAe+6qIVQDM7IC7nG5vYJQEWYyCI29WiusZ4Q9jUPzQWdHZIM/XEk0ur+LLXj6Gvm3B
         sq5xZVJmeaL+EqspZcmVgOVthFlEWUJvDDtGX/hE0j+ycgJhVCrnAcF9NJ8+vQyOjfyh
         2gQg==
X-Gm-Message-State: ALQs6tAXJKxNAZvGHM9lA9xePJaFYArjX0yKMqGZbfnXa9iohgKddEDg
        /BNS4NGRtxEAUviik3CJI7vvFIl9FV39Lq6JX1EnYPvx
X-Google-Smtp-Source: AB8JxZrU9EssAvGWjgEprd/XRDmpgR1ItTAUkwzxIeN3ABdYkbEEAadO7vbKh2spaFRPS1nOWt5szeggXdf0zs2JOJk=
X-Received: by 2002:a6b:35c1:: with SMTP id k62-v6mr9623246ioo.128.1525207729694;
 Tue, 01 May 2018 13:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7c91:0:0:0:0:0 with HTTP; Tue, 1 May 2018 13:48:49 -0700 (PDT)
In-Reply-To: <CAGZ79kbmVMgLWg8nW9Jnwie0vbfov7PaujMPeVr1oq5o24hcDw@mail.gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180501180908.17443-1-kcghost@gmail.com> <20180501180908.17443-2-kcghost@gmail.com>
 <CAGZ79kbmVMgLWg8nW9Jnwie0vbfov7PaujMPeVr1oq5o24hcDw@mail.gmail.com>
From:   Casey Fitzpatrick <kcghost@gmail.com>
Date:   Tue, 1 May 2018 16:48:49 -0400
Message-ID: <CAEp-SHXURpp3XuyHv-pNERRE8WK+o5ao8E2htDA3gdYZGAz5vA@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule: Add --progress option to add command
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I'll clean it up based on your comments. I based the tests
from t5606-clone-options.sh; I'm not sure why now but I thought I
needed that clone -o thing from there, but it appears useless.



On Tue, May 1, 2018 at 2:41 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, May 1, 2018 at 11:09 AM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
>> --progress was missing from add command, was only in update.
>> Add --progress where it makes sense (both clone helper commands).
>> Add missing documentation entry.
>> Add test.
>
> Maybe:
>   The '--progress' was introduced in 72c5f88311d (clone: pass --progress
>   decision to recursive submodules, 2016-09-22) to fix the progress reporting
>   of the clone command. Also add the progress option to the 'submodule add'
>   command. The update command already support the progress flag, but it
>   is not documented.
>
>> @@ -117,6 +117,9 @@ cmd_add()
>>                 -q|--quiet)
>>                         GIT_QUIET=1
>>                         ;;
>> +               --progress)
>> +                       progress="--progress"
>> +                       ;;
>
> The code looks good, though unlike the other commands progress is a
> boolean decision.
>
> If we want to support --no-progress as well, we can do so by adding
>     --no-progress)
>         progress="--no-progress"
>         ;;
> and then the submodule helper ought to cope with it.
>
>
>> +test_expect_success 'setup test repo' '
>> +       mkdir parent &&
>> +       (cd parent && git init &&
>> +        echo one >file && git add file &&
>> +        git commit -m one)
>> +'
>
> Coding style:
>     (
>         parens open on its own line, and its contents
>         are indented by a tab.
>
> Instead of coding this yourself, you could write the
> test as:
>
>     test_create_repo parent &&
>     test_create_commit -C parent one
>
>> +test_expect_success 'clone -o' '
>
> What are we testing here? I do not quite see the connection to
> testing --progress here.
>
>> +       git clone -o foo parent clone-o &&
>> +       (cd clone-o && git rev-parse --verify refs/remotes/foo/master)
>
>
>> +test_expect_success 'redirected submodule add does not show progress' '
>> +       (
>> +               cd addtest &&
>
>
>
>> +               git submodule add "file://$submodurl/parent" submod-redirected \
>> +                       >out 2>err &&
>> +               ! grep % err &&
>
> We're grepping for percent to see that there is no progress. At first I thought
> the percent sign might be a special character, had to research it to know it's
> meant literally. TiL!
>
>> +               test_i18ngrep ! "Checking connectivity" err
>
> Makes sense.
>
>> +       )
>
> We could omit the extra shell by using
>
>     git -C addtest submodule add "file://$... \
>             >../out 2>../err &&
>
> Why do we need 'out' ?
>
>> +test_expect_success 'redirected submodule add --progress does show progress' '
>> +       (
>> +               cd addtest &&
>> +               git submodule add --progress "file://$submodurl/parent" \
>> +                       submod-redirected-progress >out 2>err && \
>> +               grep % err
>> +       )
>> +'
>
> Thanks for writing these tests!
> Stefan

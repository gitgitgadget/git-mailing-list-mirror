Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC68215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbeEASle (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:41:34 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:39481 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932093AbeEASlO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:41:14 -0400
Received: by mail-yb0-f177.google.com with SMTP id q74-v6so4440349ybg.6
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xtxFIsgL1LIf+ugwFLng67Qy+n9dNT62wiDIY6BVgZM=;
        b=kppYuO0Ucbs7LPnqW+Wt/6p6Oca2Dfv7oUSkuwiE++14YIAd3ks+ZA26WylHt7JNEQ
         cYrdb9mFZiPY/X+qC61u7KIXOqNJtsyhHLn9srEu3sB9WBhp587YLNL4PCfhDb79vKUj
         1QxwxVdt0VEB4tyrX5dDarAN4MPAFHrEml9d3pYIV4VEIk5l6o8F2nwjx8Gsn/5bkmMB
         +O5KYKs+JOCEK8qpjlFCSxAxHM39qcjzV8njpwu6iGj1YlUYpHH9/3B0zS5B1QuzhtQV
         6eLBBotJlh0NW/w/6tDKLWgjU9DjQh4CXAW57Y/YowxIRjf3KPC1dKD+MG9Ppwrb4DlK
         dvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xtxFIsgL1LIf+ugwFLng67Qy+n9dNT62wiDIY6BVgZM=;
        b=Dbal+DHk8gfcWKVB7bi8UWLvT8E/irkkubsvqbxgrWly0dr8Esl7HFTz0lXUARG2P2
         A7vUOshYxBeBBRMSf6YKq9/A6R9SLmw4TBu1/rTrUaqYmO+m2KNS6iE7Ue+p/D1xTaL2
         owkFE/8hfpEnn69aPA31hYC7S8TfT9YAmmKcqxb/8yzEq4kzh/IHA+YlTJ52FQe96lEK
         hNBJyzeBPVCX0AKPVh2jCnQSm/keTkYRAZ6hMMjv6buyI0RGQsMtDl2GwAU4+G0hKBV9
         yaLDnBnP7E0WLZk1ZkzhVTsNw4rSh5AKxGNhZfKMgyL2JF/PkZUT3k15V7AISZBwxTi1
         O/CA==
X-Gm-Message-State: ALQs6tBDSJsb5YMOIY8Y5qEroZYu8QqH0Cz9JqJhcL56w+SdTiIX8lAS
        hOCPSPM1kDePem8TT6rmGUcGuTv/KjyksnW5Evptww==
X-Google-Smtp-Source: AB8JxZramlmXXxbnCAHTvveExWyoyDpU+tvCVx6BL7ayRj/3TQ1y/HqMDm7iDpsERcrhPclpe3BPjS/8WEPoi6I+8L0=
X-Received: by 2002:a25:69cf:: with SMTP id e198-v6mr10732797ybc.247.1525200073373;
 Tue, 01 May 2018 11:41:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 1 May 2018 11:41:12 -0700 (PDT)
In-Reply-To: <20180501180908.17443-2-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180501180908.17443-1-kcghost@gmail.com> <20180501180908.17443-2-kcghost@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 May 2018 11:41:12 -0700
Message-ID: <CAGZ79kbmVMgLWg8nW9Jnwie0vbfov7PaujMPeVr1oq5o24hcDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule: Add --progress option to add command
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 11:09 AM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
> --progress was missing from add command, was only in update.
> Add --progress where it makes sense (both clone helper commands).
> Add missing documentation entry.
> Add test.

Maybe:
  The '--progress' was introduced in 72c5f88311d (clone: pass --progress
  decision to recursive submodules, 2016-09-22) to fix the progress reporting
  of the clone command. Also add the progress option to the 'submodule add'
  command. The update command already support the progress flag, but it
  is not documented.

> @@ -117,6 +117,9 @@ cmd_add()
>                 -q|--quiet)
>                         GIT_QUIET=1
>                         ;;
> +               --progress)
> +                       progress="--progress"
> +                       ;;

The code looks good, though unlike the other commands progress is a
boolean decision.

If we want to support --no-progress as well, we can do so by adding
    --no-progress)
        progress="--no-progress"
        ;;
and then the submodule helper ought to cope with it.


> +test_expect_success 'setup test repo' '
> +       mkdir parent &&
> +       (cd parent && git init &&
> +        echo one >file && git add file &&
> +        git commit -m one)
> +'

Coding style:
    (
        parens open on its own line, and its contents
        are indented by a tab.

Instead of coding this yourself, you could write the
test as:

    test_create_repo parent &&
    test_create_commit -C parent one

> +test_expect_success 'clone -o' '

What are we testing here? I do not quite see the connection to
testing --progress here.

> +       git clone -o foo parent clone-o &&
> +       (cd clone-o && git rev-parse --verify refs/remotes/foo/master)


> +test_expect_success 'redirected submodule add does not show progress' '
> +       (
> +               cd addtest &&



> +               git submodule add "file://$submodurl/parent" submod-redirected \
> +                       >out 2>err &&
> +               ! grep % err &&

We're grepping for percent to see that there is no progress. At first I thought
the percent sign might be a special character, had to research it to know it's
meant literally. TiL!

> +               test_i18ngrep ! "Checking connectivity" err

Makes sense.

> +       )

We could omit the extra shell by using

    git -C addtest submodule add "file://$... \
            >../out 2>../err &&

Why do we need 'out' ?

> +test_expect_success 'redirected submodule add --progress does show progress' '
> +       (
> +               cd addtest &&
> +               git submodule add --progress "file://$submodurl/parent" \
> +                       submod-redirected-progress >out 2>err && \
> +               grep % err
> +       )
> +'

Thanks for writing these tests!
Stefan

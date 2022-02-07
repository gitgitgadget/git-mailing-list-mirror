Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9CCC433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 12:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbiBGMDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387885AbiBGLmD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 06:42:03 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F8CC0401C2
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 03:42:02 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c6so39039550ybk.3
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 03:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vXjfIoUvMGbHDLnYZVf4lVUJGXq1b4eIj6TMuKlWb0=;
        b=bE/9qorLyH5zksLxU1HhEGne2rHyBRRvuDAYcqnJSpaw2mCbM+VOcx6p7YVCQqA3LR
         14F4ykFXwPYIN3j6wdc5NFfslWQux40Ye/XCvaF6OJXmfz+npPCC9dSgyRIxOL7MJAfu
         i5gmQiwtPCyPAKWOz3NVF4VtPX/bgHMLbVZnjwUpR6HTOchKuXXn3Up/8tAJJZnvxBoQ
         LrtQpKfrqUCuhvN1xqpjtxrmx/VCm1xKd1/GnVbb3aGCzDSKVyiXy2CHVhYcWrzPNEnK
         sCQb+CVVXB4NsKAq+QrXLjiP3B6zpylGYdcYjaJk9HCA8geKpAILFdEsvP+NI+UUnR2r
         8IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vXjfIoUvMGbHDLnYZVf4lVUJGXq1b4eIj6TMuKlWb0=;
        b=zwRFBTEvAoPiR83+klLOt01HPRHJ6v2KUIKlwGrZoCdyrGKH/aIfWTbkT9r/KZUca4
         jJJcPeka6/v35VEACw+bXxByIEE7TE1jU+5Ha4yQ33V8dhPeHes5ki7LrfPiMPQz94HY
         RUx8e6IMObProombReKNFhozNu4LaD0ki02eTUazfdBjNq5GxXLxC+PfXoG5VupZN19L
         VW2i49mzEGbZGmRtAt8KGZ8CUwP9zpAW6GxZ85iORpNtAjFfHJBMeM5bf0gngNfXE3JZ
         /QrigEoZRu/alTfTp1QVw9m7Nb5j9zR9u/ki8oS/8dy4lsRhMj91kMtqQ/YhsD+0elNU
         Q4kQ==
X-Gm-Message-State: AOAM530XKAgkWD7YmzqzIE7H4RzRTdJl9v/ddMBc1YhNFn5fhZuLM+pG
        db/auzcQwJEwy42wpi21gFE+kPcOhT8B0oZSOaGcxoxHXIw=
X-Google-Smtp-Source: ABdhPJyWXdVbFYE0OWLQi9kLcTZ4GTAVe8p0HhDN5NtO0fsYroJEWoiDj8YAUDzn8ATsRnLuU5YjQCIKSWTr97sw1Ec=
X-Received: by 2002:a25:6ed4:: with SMTP id j203mr10050174ybc.415.1644234121605;
 Mon, 07 Feb 2022 03:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com> <20220202064300.3601-1-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220202064300.3601-1-shaoxuan.yuan02@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Feb 2022 12:41:50 +0100
Message-ID: <CAP8UFD2e6xEQa7045Mup8LAHBs=B9EwwvZcLMsp43OM-dsY9eQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] t/lib-read-tree-m-3way: modernize style
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 4, 2022 at 6:00 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> Many invocations of the test_expect_success command in this
> file are written in old style where the command, an optional
> prerequisite, and the test title are written on separate
> lines, and the executable script string begins on its own
> line, and these lines are pasted together with backslashes
> as necessary.

It's not very clear here if "these lines" means only the separate
lines with the command, an optional prerequisite, and the test title,
or if it also means the first (or maybe many) line(s) of the
executable script string.

> An invocation of the test_expect_success command in modern
> test scripts however writes the prerequisite and the title
> on the same line as the test_expect_success command itself,
> and ends the line with a single quote that begins the
> executable script string.

It could also be 'test_expect_failure' instead of 'test_expect_success'.

> Update the style for uniformity.
>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>

>  for p in M? Z/M?
>  do
>      echo This is modified $p in the branch A. >$p
> -    test_expect_success \
> -       'change in branch A (modification)' \
> -        "git update-index $p"
> +    test_expect_success 'change in branch A (modification)' '
> +        git update-index $p
> +    '

The above is not just about moving single quotes from one line to
another, but it changes some double quotes to single quotes, which
means that $p might not be interpreted in the same way. This is not
just a style issue and it should be explained in the commit message
why it's ok to make this change.

>  done
>
>  for p in AN AA Z/AN Z/AA
>  do
>      echo This is added $p in the branch A. >$p
> -    test_expect_success \
> -       'change in branch A (addition)' \
> -       "git update-index --add $p"
> +    test_expect_success 'change in branch A (addition)' '
> +           git update-index --add $p
> +    '

Here also some double quotes are changed into single quotes.

>  done

>  to_remove=$(echo ?D Z/?D)
>  rm -f $to_remove
> -test_expect_success \
> -    'change in branch B (removal)' \
> -    "git update-index --remove $to_remove"
> +test_expect_success 'change in branch B (removal)' '
> +    git update-index --remove $to_remove
> +'

Here also.

>  for p in ?M Z/?M
>  do
>      echo This is modified $p in the branch B. >$p
> -    test_expect_success \
> -       'change in branch B (modification)' \
> -       "git update-index $p"
> +    test_expect_success 'change in branch B (modification)' '
> +           git update-index $p
> +    '

Here also.

>  done

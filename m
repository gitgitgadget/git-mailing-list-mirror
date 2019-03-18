Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F4F20305
	for <e@80x24.org>; Mon, 18 Mar 2019 15:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCRPif (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 11:38:35 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35097 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfCRPie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 11:38:34 -0400
Received: by mail-ua1-f67.google.com with SMTP id f88so5423117uaf.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gu16S/lIlcY+vf37Weo/R0vPgwwCgoVNl3i+IToRvM=;
        b=Szt1FnnoFa2l0Fyqegidbi0zkEUGUToddUsEKcOArKuNc8HFOTjy1P/7ww82Bo8Td3
         F9ZQtC1gZay3AAxexhKT3f8KBh4qiZnQIqSuNsXwXGY+dj7BLnCQou87/XHyLk3IROmH
         +rQwTA98nr+g7JKkERc/ECdl0rZiESNGK/OqMC8xODrhLeRZfFOdnToTjpqv1IKULczL
         ACvPcfcNCRzuIKFYHyJyx/V3USMZSmt8VQoACZdCRXSTlEJXO6KvBWJRnmqDAnNIrknK
         NjdCrASgOTF+tARs7FSy4rbSBnmgESczFOyN45NEsTON5DCxKAr8KqZWqIzHeipY6zqD
         T0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gu16S/lIlcY+vf37Weo/R0vPgwwCgoVNl3i+IToRvM=;
        b=L9CxVW0h03Fbu5jBq/FfufALCXexLOGuILihmHXYGs9YjpVsdB68fOe64T/zIpy0dW
         GqZB7Z1S1GKLemxMqalpDCZL0Oc/xw4Zi22NgXN/NtlpXAKb1KqX4whdzQ5WWwnI34jS
         X/sG5kIlqcDfPBDSVQ1+gIh+nfjPg5a0PtcsdBPYbvsRFdC+Pi15xdDjbCUac3LDqaiG
         q2v9hiNhjSP8F20t9mJc9ZxaoEsQ9RHOwCPtLztAFUDMKmNNWtLNZnXETOI7YycOMcEB
         mrgQFdV+4NAeT8S5On9I8HploNI09V+CjiDyx06zEPQ30viVwCApPctXclV/WmlPiLG4
         cz4A==
X-Gm-Message-State: APjAAAV4N7rBStrVwsWquoRHldpS6BPTGMbA2D5A6Ex5oakMgkIrnFFE
        u1QfT0i7CJ5t0MS9P4fETpW8Ab2Q5dn9HidbfY3aBw==
X-Google-Smtp-Source: APXvYqzuShvx0Bx9T5dJVsXzKAtGQI5PiPGfY42Jp0rXL8Zar1GItMqBvLXHx4/9DlCwG27BcD/+33oiTj0XnzsQmPc=
X-Received: by 2002:ab0:85e:: with SMTP id b30mr6547399uaf.108.1552923513148;
 Mon, 18 Mar 2019 08:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190317230239.10131-1-tmz@pobox.com>
In-Reply-To: <20190317230239.10131-1-tmz@pobox.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Mar 2019 08:38:21 -0700
Message-ID: <CABPp-BGY_SSJ5GsCz09jDgBzX9Xmbpd95bYcfK4FbpHfgNQgRQ@mail.gmail.com>
Subject: Re: [PATCH] t4038-diff-combined: quote paths with whitespace
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 4:02 PM Todd Zullinger <tmz@pobox.com> wrote:
>
> d76ce4f734 ("log,diff-tree: add --combined-all-paths option",
> 2019-02-07) added tests for files containing tabs.
>
> When the tests are run with bash, the lack of quoting during the file
> setup causes 'ambiguous redirect' errors.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> Hi,
>
> I noticed these failures while running in a repo where I happened
> to have TEST_SHELL_PATH=/bin/bash set.  I wonder if we should
> have a test matrix which uses bash to catch these sort of things?
>
>  t/t4038-diff-combined.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
> index 07b49f6d6d..d4afe12554 100755
> --- a/t/t4038-diff-combined.sh
> +++ b/t/t4038-diff-combined.sh
> @@ -480,18 +480,18 @@ test_expect_success FUNNYNAMES 'setup for --combined-all-paths with funny names'
>         git branch side1d &&
>         git branch side2d &&
>         git checkout side1d &&
> -       test_seq 1 10 >$(printf "file\twith\ttabs") &&
> +       test_seq 1 10 >"$(printf "file\twith\ttabs")" &&
>         git add file* &&
>         git commit -m with &&
>         git checkout side2d &&
> -       test_seq 1 9 >$(printf "i\tam\ttabbed") &&
> -       echo ten >>$(printf "i\tam\ttabbed") &&
> +       test_seq 1 9 >"$(printf "i\tam\ttabbed")" &&
> +       echo ten >>"$(printf "i\tam\ttabbed")" &&
>         git add *tabbed &&
>         git commit -m iam &&
>         git checkout -b funny-names-mergery side1d &&
>         git merge --no-commit side2d &&
>         git rm *tabs &&
> -       echo eleven >>$(printf "i\tam\ttabbed") &&
> +       echo eleven >>"$(printf "i\tam\ttabbed")" &&
>         git mv "$(printf "i\tam\ttabbed")" "$(printf "fickle\tnaming")" &&
>         git add fickle* &&
>         git commit
> --

Whoops, how embarrassing.  Thanks for fixing this.

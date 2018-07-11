Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F0F1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbeGKPud (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:50:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44042 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387632AbeGKPud (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:50:33 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so50078788oih.11
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4vaK6LMqDXRF/KHDf+DwWEBylhvobHiHKauZhi/RUw=;
        b=Aux07JDQt0oToNuHui3RYp7orQa1P4Q2QGawZGn1Qv3EznFUr4RzqZjLhxujVLd+y1
         L5gpD9t8AZ2x4TTIyeDZh+EbgCHQRVIc+njwJU9ZDPe8dQZXg7qUecOsvF+V8EvTUIW7
         UAQqE97Gfn0BSrgsRLyMR6KReW6MXzMBFfHtsIUz1AXB8jCMfcuhSMnvyI7y2HwWMSrf
         SsU7B2DnuOqeiVzGP7snp0+ySvGivmkRr1Od5CtMwNSa2XApOL9ZtVyh2OniSctlLe4L
         imlje1c6LUdHz5kF1UUGzPFQXz4SOgdt7EP+HDgtQv0j1PfW0RjFYNsUq67wocSjrq//
         knRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4vaK6LMqDXRF/KHDf+DwWEBylhvobHiHKauZhi/RUw=;
        b=YX6Y64UjFTWiHHU5z3mI9JP2DfX4w6zhU8lvHF8gPjU6sZx9QZFRy81KK9CVSzWwJo
         ZhDtTXQn/QKas3bF7IMgiRce7Oaw3XDIRyDU71XlCM6/aQ4ynZab/NaWMVLCRQEnv57J
         iTFeGYWf9Vt2pyKX1eqPH0O2xe4pxR6dqo83qENt0Dekav+XSJ7QWJZzQHlGhUJNUOM2
         6FeiuiWyJu7ew6AOYP7R7hD/Be2qkeSZPx6or5CwHrrhbEn5tznHNVif33Si5sSPXs3w
         Yw2YSuoHH1A8YRM4fSx1B9cjSAesmw5vxundCcFIOsgYBAUV/7gTq4XBGxQSeJcDnKhg
         jlmQ==
X-Gm-Message-State: APt69E338kjU5emPUqg73HjJQPUxOZwmbfyPh4RV4uXhwV9EB9SW3sQ3
        WlgnlmatzOIfb45yNyDT2K36oMBaz1fyJUAxH8E=
X-Google-Smtp-Source: AAOMgpeoDBmJXlKJAmo2V3dBRqDagF8TDXOkHp73yU27wCpSqk7LylNi+LvgTJvkMtZ0UiyeEegOUB2ShVvozIncdrQ=
X-Received: by 2002:aca:d682:: with SMTP id n124-v6mr34400623oig.32.1531323937179;
 Wed, 11 Jul 2018 08:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180710154106.5356-1-wchargin@gmail.com>
In-Reply-To: <20180710154106.5356-1-wchargin@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 11 Jul 2018 17:45:09 +0200
Message-ID: <CACsJy8CBJvpKAAtVjrdcuO06WossxcMmqwmSRL9Shr7g+qVySA@mail.gmail.com>
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
To:     wchargin@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 5:44 PM William Chargin <wchargin@gmail.com> wrote:
>
> This patch broadens the set of commits matched by ":/" pathspecs to
> include commits reachable from HEAD but not any named ref. This avoids
> surprising behavior when working with a detached HEAD and trying to
> refer to a commit that was recently created and only exists within the
> detached state.

Cool!

>
> Signed-off-by: William Chargin <wchargin@gmail.com>
> Based-on-patch-by: Jeff King <peff@peff.net>
> ---
>  Documentation/revisions.txt   | 10 +++++-----
>  sha1-name.c                   |  1 +
>  t/t4208-log-magic-pathspec.sh | 14 ++++++++++++++
>  3 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 7d1bd4409..aa56907fd 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -181,11 +181,11 @@ existing tag object.
>    the '<rev>' before '{caret}'.
>
>  ':/<text>', e.g. ':/fix nasty bug'::
> -  A colon, followed by a slash, followed by a text, names
> -  a commit whose commit message matches the specified regular expression.
> -  This name returns the youngest matching commit which is
> -  reachable from any ref. The regular expression can match any part of the
> -  commit message. To match messages starting with a string, one can use
> +  A colon, followed by a slash, followed by a text, names a commit whose
> +  commit message matches the specified regular expression. This name
> +  returns the youngest matching commit which is reachable from any ref
> +  or from HEAD. The regular expression can match any part of the commit
> +  message. To match messages starting with a string, one can use
>    e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
>    is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
>    literal '!' character, followed by 'foo'. Any other sequence beginning with
> diff --git a/sha1-name.c b/sha1-name.c
> index 60d9ef3c7..641ca12f9 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1650,6 +1650,7 @@ static int get_oid_with_context_1(const char *name,
>                         struct commit_list *list = NULL;
>
>                         for_each_ref(handle_one_ref, &list);
> +                       head_ref(handle_one_ref, &list);

When multiple worktrees are used, should we consider all HEADs or just
current worktree's HEAD?

This is the latter case, if we should go with the former (I don't
know, it's a genuine question) then you need one more call:
other_head_refs().

>                         commit_list_sort_by_date(&list);
>                         return get_oid_oneline(name + 2, oid, list);
>                 }
> diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
> index 62f335b2d..41b9f3eba 100755
> --- a/t/t4208-log-magic-pathspec.sh
> +++ b/t/t4208-log-magic-pathspec.sh
> @@ -25,6 +25,20 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
>         git log :/a --
>  '
>
> +test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
> +       test_when_finished "git checkout master" &&
> +       git checkout --detach &&
> +       test_tick &&
> +       git commit --allow-empty -m detached &&
> +       test_tick &&
> +       git commit --allow-empty -m something-else &&
> +       git log :/detached --
> +'
> +
> +test_expect_success '"git log :/detached -- " should not find an orphaned commit' '
> +       test_must_fail git log :/detached --
> +'
> +
>  test_expect_success '"git log -- :/a" should not be ambiguous' '
>         git log -- :/a
>  '
> --
> 2.18.0.130.g61d0c9dcf
>


-- 
Duy

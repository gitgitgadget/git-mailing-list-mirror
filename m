Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DBECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJaSGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJaSFN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 14:05:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4D13EAC
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 11:04:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j12so11442393plj.5
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ON+v4sDQvXvFWt4lp3gi5a3URIHIZ9lk7++cu9XT9Y=;
        b=dvWU7O8s15IKohyvcefMiE5Du9Kk7vUoWOo0DsX7Hpzkp5dn9FXXh5Y0FvGFTl23KO
         KrAFqlTervBxMJ3iNYABfMKErXH+W8vvE/dP1X+r4toIw3RqW3XDQ1jg6oUgkOHs+Soj
         WFfhliXgKtN+wYcFSkWsfPwk2vUDD6ciKX0I3La7vadjNTNz06j/os3HeDRY002OPEUY
         M+sUYzU0qhrQAekJcdRXHZz4SlSWKt5cERyitkfCBoqGcEYrypnn4VyrJr0VcMugWVkx
         0MTdCSKcce2z4qr/ExogjV+TYMYS8EveRNox9tzHBDFK5L7qqrFSnNlsROtM0QZtE/nl
         nNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ON+v4sDQvXvFWt4lp3gi5a3URIHIZ9lk7++cu9XT9Y=;
        b=wLMRoSDujmuUJoBbcDG1MtGLP9aFnPJB4TuY6rzu/f4cqTcbyFVjXht51oHxf4fS9j
         npUXsmFAYH44JJd3e9sj7hpUd+sSwvhlXhhcAVo2RPAhUDdS0eAhRcRj+kwAXeZ4zgYL
         johhx0UmlyKrzOGNG6uN3HNoNSqqw9iD4QuajxszalWRvhVEwl1Ij6LOsUwVMa7izQv6
         NOyVaNpjnvci56j3O4ca4G7O9/V7/z/+BE128dF/z9FuPrIlOj4sQ77jMHqj8KOg1iD/
         k2J/6GgtenMJbIcblNvY3ot5y0E9OMJJCPG8PIKc9lbN4exvL63mBlphsE4FKuJR/WZY
         6Pvw==
X-Gm-Message-State: ACrzQf2a8NtNtH2RRUmLZw9DiHPlAxX9zn3MZLhLG9b7tHgPJwT5+gtV
        KB15Tv+O9PEtmUmqiPPMB9M6pu2C1Tyrtkchxw4t5Poe
X-Google-Smtp-Source: AMsMyM5xBXKUcwSogM1Yxxtp1fxnYjTEsBOqNqFFDeNFQuVf4c0JBCuvP6CHHw9kASf5uCEpCPoPKSitMz+6jOcFlx8=
X-Received: by 2002:a17:902:f791:b0:17c:c1dd:a3b5 with SMTP id
 q17-20020a170902f79100b0017cc1dda3b5mr15420191pln.141.1667239471972; Mon, 31
 Oct 2022 11:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com>
In-Reply-To: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 31 Oct 2022 19:04:20 +0100
Message-ID: <CAN0heSpvgtLG5o9i_cSbn0zHfNN+GJFYY6oBXmHUs8FniW5oOw@mail.gmail.com>
Subject: Re: [PATCH] t7001-mv.sh:modernizing test script using function
To:     Debra Obondo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Debra Obondo <debraobondo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Debra,

On Sun, 30 Oct 2022 at 18:35, Debra Obondo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Debra Obondo <debraobondo@gmail.com>
>
> Test script to verify the presence/absence of files, paths, directories,
> symlinks and other features in 'git mv' command are using the command
> format:
>
> 'test (-e|f|d|h|...)'
>
> Replace them with helper functions of format:
>
> 'test_path_is_*'

This is a good idea.

The subject of this patch could use a space after the colon. You could
also write "modernize" to give an order to the code base. So something
like

  t7001-mv.sh: modernize test script using function

perhaps. "Function" is a bit vague, perhaps.

I wanted to comment on this:

>  test_expect_success 'mv --dry-run does not move file' '
>         git mv -n path0/COPYING MOVED &&
> -       test -f path0/COPYING &&
> -       test ! -f MOVED
> +       test_path_is_file path0/COPYING &&
> +       ! test_path_is_file MOVED
>  '

It is my understanding that we prefer to only use such a helper when we
really expect the file to exist. If the path is not a file, this helper
prints a helpful message before returning with an error.

Here, this means we will emit this 'helpful'

  File MOVED doesn't exist

on every test run, when really everything is as it should. And if the
file is actually there, i.e., we have a bug, we'll emit nothing -- but
that is precisely when we would want some diagnostics such as

  Path exists:
  ... MOVED ...

to show us that the file actually exists, contrary to the test's
expectations.

Such output is precisely what `test_path_is_missing` would give us. :-)

My gut feeling is that where this patch adds "! test_path_foo", it
should use "test_path_bar" instead, for various values of "foo" and
"bar". What do you think about that?


Martin

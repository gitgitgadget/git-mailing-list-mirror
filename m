Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4390EC43217
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 17:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiKNRta (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiKNRtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 12:49:06 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1144E62EE
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 09:49:06 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 7so14297542ybp.13
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Etb4l8tUMckRLkPaK3l57bz+LX0ZSPZDGXTN8UUwj40=;
        b=d0pHTicG43VJLO3b4U4p5CWcOcne3p93+h8ORq2+nwWMHnmDk98GHNsYmB0SmX5qRR
         3qT/L8aLC0xGw9HiyDh8zuC3XhMuNuL98TAIdBZqekgRylWYwpUL69iT9LH1aPBZGqCC
         oDV9HbsBhRRwv68f1QYSE38rZCPGzAqz2ctKFlDos+oEN4ayaYIWSGA7pIDCAwGIRDOR
         I6B1dIPyhQUqEo1b9SZC9UC+JC13rgnokXHLFAs1ECNl+GEUMidnU3JR0xMFtUYf4LH9
         UgUMOvSG+cQY/bhk7eTp/zJeUAb0XG5osYUzU7oIL4FnTzF/DB/5bWGIfjZKbFGgn5wV
         7jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Etb4l8tUMckRLkPaK3l57bz+LX0ZSPZDGXTN8UUwj40=;
        b=5tRnzfbSZLhn1CqN01bjpJ3WCr0RXDBUtgCKwYeDXGVvBx3hduuh/MW+4JkuuS6Agn
         IJmQzVslGZ0DPpg3cds8QNU+WOSUzWKReF+sjWcVRqPdl3K62ltcjUHyVq0OyncLrf7U
         pnBfrRSJKL2e4sNbVEKeuDLG66dQW0+YLqLf6q7T20hWh2z7AosQ6/9/WhMqbmtpYrjh
         nMfd08i6EKT4OrnEyxUrIsDA/xobCG3AFfG15nZJo7HNWZLdjCzeUeV3buxDyTN58Phd
         XX9pqWZkVTBkawXatbUQQNabJE2ekYJXLinViOGvrIJaEwd06LcyV/x/iLbGbRxaT2AI
         3z8g==
X-Gm-Message-State: ANoB5pmSzyPcmjpC9cezEl/yBUfmR1Zjnu0Q96MdVHnbtJvPCqEdoXFp
        CoQjZzCqa7j02JcN7+PyhlIFGBe9LnEEz3QPHpTeKYp/
X-Google-Smtp-Source: AA0mqf5KLudQ5VMLfzezrt+foIv8lqX/k40RTHmUsNL7WrML9eMrRkGsbY7wxTg7f5IzbbA0m+ct+Px9XvxqyWkddIk=
X-Received: by 2002:a25:441:0:b0:6d4:41c1:8821 with SMTP id
 62-20020a250441000000b006d441c18821mr12904029ybe.447.1668448145270; Mon, 14
 Nov 2022 09:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20220916205946.178925-1-siddharthasthana31@gmail.com> <20221113212830.92609-1-siddharthasthana31@gmail.com>
In-Reply-To: <20221113212830.92609-1-siddharthasthana31@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 14 Nov 2022 18:48:54 +0100
Message-ID: <CAP8UFD1nhXnYUj9zsXwvf2tjeK1yimY3AwomU30wor1Vf-QPbA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add mailmap mechanism in cat-file options
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 13, 2022 at 10:28 PM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> In this patch series we didn't want to change that '%(objectsize)'
> always shows the size of the original object even when `--use-mailmap`
> is set because first we have the long term plan to unify how the formats
> for `git cat-file` and other commands works. And second existing formats
> like the "pretty formats" used bt `git log` have different options for

s/used bt/used by/

> fields respecting mailmap or not respecting it (%an is for author name
> while %aN for author name respecting mailmap).

[...]

> = Patch Organization
>
> - The first patch makes `-s` option to return updated size of the
>   <commit/tag> object, when combined with `--use-mailmap` option, after
>   replacing the idents using the mailmap mechanism.
> - The second patch makes `--batch-check` option to return updated size of
>   the <commit/tag> object, when combined with `--use-mailmap` option,
>   after replacing the idents using the mailmap mechanism.
> - The third patch improves the documentation of `-s`, `--batch`,
>   `--batch-check` and `--batch-command` options by adding they can be
>   combined with `--use-mailmap` options.

So the documentation patch is now part of this small series again.

Even if this documentation patch is a bug fix, it might be better at
this point to squash this patch into the patches 1/3 and 2/3. At least
I think that would better follow Junio's last comments about this. If
you go this way, you might want to squash the documentation parts
about -s from patch 3/3 into patch 1/3 and the rest of patch 3/3 into
patch 2/3.

> = Changes in v4
>
> - Improve the documentation patch to clearly state that the `-s`,
>   `--batch-check`, `--batch-command` and `--batch` options can be only
>   be used with `--textconv`, `--filters` or `--use-mailmap`.

Here I think you should say that the documentation patch is part of
this series again and explain a bit why.

Anyway I took a look at the actual patches in this series and they
look good to me now. So I would be Ok to merge it either as is or with
patch 3/3 squashed into patches 1/3 and 2/3 as discussed above.

Thanks!

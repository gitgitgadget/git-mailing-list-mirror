Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AC4C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 04:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiGAEEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 00:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGAEEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 00:04:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F85677ED
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 21:01:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ay16so1774771ejb.6
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 21:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvsteM+ESqyQZYY02Glcyt8tQ6mfhA9oKLbTfIrVjJ4=;
        b=knOcsgmiWfJSNWmMp4WRSnHP7jJssSvP4zuEeaf0zFUL6LKn4n0JKstKr5+c4YMxqM
         QVCxrKxu2ULXRSrQsXwcg4YWAulW5SIbNVGfom/SZirE3uSHaWC/5MMn2P6rWWyFuICT
         /jnqgbywJeFXTwqZjg7KMGTA7RVqL3aYMWy3LsiVSEFTe0Zx8aK7Cq1vVmMRYOmSlNYs
         r/GVs70hBliQmq25LhDnxRrHssYBqmSy/q9Sj11IfHs+2mNFtQARtJmeDwn/3/s9isbS
         QujaKVtUjVBcWvZeIUm8W7Fs3GCIJ+mnfZJ+cEpcE9gScDgIWPIiyl9yBJ+42sQCo94m
         pHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvsteM+ESqyQZYY02Glcyt8tQ6mfhA9oKLbTfIrVjJ4=;
        b=C2EKFhaLX+oMo7Xf+RC3MY0e5lNDD/mcp2oypJXoBoVsNTHWTuwk14cCCDPvB9oEni
         fiv95c9HR1EYzozKCqEKnOdaaaZRNaPMY/zKu1WVKf0f30P4rUwewqKiA65ugCGpZerv
         I1fl4mTWzjoqqEZK559RxR+hq0iLhG8E7bi0TR6jHEoq+/88XVYJMUO6FQ8XDAdi33Qu
         Elyimm7tEv3naemAxsyh08nuHeXwPi5Cx4KDCyAAZa+00FuRGCetFih0qHzAHURoLNyZ
         l1g5CxSIAjS9v+c8m3yjLIivs3OMj7UuDxHtZRQOZ1pnCueTH2jURhqIlbCtGZMCcxi6
         uB/w==
X-Gm-Message-State: AJIora+MarG1zuDItNhuw1+d3ZWDHP8bEgXhhTMhJwk7KupqeA+GoVnd
        6eF9loCuSmstDxTLBo5olPBd2sm1WXC2KlMIotJ6jgraQDw=
X-Google-Smtp-Source: AGRyM1vwjJZ/tE/vjjaH6qXnGXyYbC5v02DqmISJKFKfj6VXnBQpvY6aVbrhT3HZ7XOBk8pe0z4bxKehgErMK9SEN90=
X-Received: by 2002:a17:907:2ccb:b0:72a:430d:17a9 with SMTP id
 hg11-20020a1709072ccb00b0072a430d17a9mr9804534ejc.613.1656648104902; Thu, 30
 Jun 2022 21:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
In-Reply-To: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 21:01:33 -0700
Message-ID: <CABPp-BHX5H1co+cMS2LEt=NYB5==5e4YK_sK=h_O1-zxaNocAA@mail.gmail.com>
Subject: Re: Non-interactively rewording commit messages
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 8:35 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Hello, all:
>
> What's the best approach to non-interactively rewrite specific commit
> messages? In this particular case, I am trying to automatically retrieve code
> review trailers sent to the mailing list and put them into corresponding
> commits.
>
> For example, I have a set of commits:
>
> abcabc: This commit does foo
> bcdbcd: This commit does bar
> cdecde: This commit does baz
>
> They were all sent to the mailing list and a maintainer sent a "Reviewed-by"
> to the second commit. In a usual interactive rebase session this would be:
>
> pick abcabc
> reword bcdbcd
> pick cdecde
>
> When the edit screen comes up for the bcdbcd commit, the author would manually
> stick the new trailer into the commit message. However, I can automate all
> that away with b4 -- just need a sane strategy for non-interactively rewriting
> entire commit messages at arbitrary points in the recent history.
>
> Any pointers?

One possibility would be to tweak
https://github.com/newren/git-filter-repo/blob/main/contrib/filter-repo-demos/signed-off-by,
modifying the line setting the 'trailer' variable to make it be a
Reviewed-by rather than a Signed-off-by.  You could tweak the script
to also make other automated commit message changes unrelated to any
trailers, if you wanted.

(There's also the slightly less careful way of adding trailers shown
over at https://github.com/newren/git-filter-repo/blob/main/Documentation/converting-from-filter-branch.md#rewriting-commit-messages----adding-text,
but the literal appending instead of determining whether to also first
add one or more newlines before the trailer might not be exactly what
you want.)

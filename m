Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35495C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 04:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbiBHEQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 23:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346853AbiBHEQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 23:16:41 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E0C0401EA
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 20:16:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p15so48395252ejc.7
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 20:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6Ri3Q8RoyXrb4tg6BZWXKRLMz+Ng3CDPEbyfZH7GNA=;
        b=Lbqadn0apiehD01c6JhOXVNPQXtHfudHfb5Y7/Cg7IAlSF3aY1oakslnnAcKL7RI22
         5HmdpFWDA4IK0wDzZpR7BCw9wzG/zFT+bAxvSBLID+9FMycW7nwSNtNEQWpLL+N78S72
         AGHGc83pycAGNRcq+DTqyUh8Qp9xoUG9hOf5tuxC53RMI865EJs46dDakEfpZQMUXUZX
         zS84kwnmOxRjACeuWz04IGQGIGrjgCWcq1HSRq5xY0dwrdzePOPiOQDK5W7gXby5tMns
         tpOlxlVQuNWP0Lisu28X6PFn7MJahSv7JvF5vIKohdRAt5qusdbiExFU0ts5gPNJxN8c
         /kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6Ri3Q8RoyXrb4tg6BZWXKRLMz+Ng3CDPEbyfZH7GNA=;
        b=Ify2STC6OFw9sNdIiiGr+OdF0JytwMvlt5elSrtP90jiJQXF3DICpjfDhhuwgZcqOP
         11OjSa4X6TN1OwEuRwtAo+RghfahaYtoBxbwhGKDktUwAO3neTQbNbQKGJVOr8zTrAps
         B51o7m3qhBN7O3rwnEB6vbUgF9F/i3ZTLTPC6QYSE9rUcY7z5md5UniAonVgyCjCDBov
         wFUg8fCsvOCElAwxmpjEY+7zVEzoRS907ZGExqVy1Is2jjVp0TYR8mnjA7nuwYU5zEVi
         3zeoW+AJaxPXlYmKc9qIH5A1Pa622loF175atqKEehiMs4nFdabLIbd23vzUgbX+3weH
         cOoA==
X-Gm-Message-State: AOAM531HczGnEEb5S5SQDOA8dGv4OCgoOgveW3NZA5/d2XL4u7Ke6kIW
        V8S9H9aBFyi7dXU19tldID/tD6q+obB8ckY6Zgw=
X-Google-Smtp-Source: ABdhPJxya85/B7qV3QVIMl240TXrXsPUKiFCOJq5An4lr39BzThAp1Fgd0EH4j4GFAaC/rfqcy8FreQmOrmLNqBc4AQ=
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr2128829ejc.493.1644293797034;
 Mon, 07 Feb 2022 20:16:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com> <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Feb 2022 20:16:25 -0800
Message-ID: <CABPp-BE4w+kdk3sBRUTash4JrMf9w0eWzps=mqEzrW3zBSG4tA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] completion: sparse-checkout updates
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 7, 2022 at 9:31 AM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This change updates custom tab completion for the sparse-checkout command.
> Specifically, it corrects the following issues with the current method:
>
>  1. git sparse-checkout <TAB> results in an incomplete list of subcommands
>     (it is missing reapply and add).
>  2. Options for subcommands are not tab-completable.
>  3. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
>     both file names and directory names. While this may be a less surprising
>     behavior for non-cone mode, we want to only show directories in cone
>     mode.
>
> The first commit in this series is an intermediate step that fixes issues 1
> and 2 above and introduces a simple fix for issue 3 with some performance
> and unusual character-related caveats. The next commit adds a new
> __gitcomp_directories method that fixes the performance-related caveat from
> the first commit by completing just a single level of directories. The final
> commit modifies __gitcomp_directories to handle unusual characters in
> directory names.
>
>
> Changes since V6
> ================
>
>  * Split tests for unusual characters so that spaces and accents are
>    verified on Windows (in addition to macOS and Linux). Tabs and
>    backslashes are still excluded on Windows (details on why are included in
>    the third commit message).

Thanks for doing that.  I think this series is ready for next.

(It already has my Reviewed-by, so no need for me to re-give it.)

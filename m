Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F0B20248
	for <e@80x24.org>; Sat, 23 Mar 2019 09:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCWJQB (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 05:16:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40548 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCWJQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 05:16:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so969869wmi.5
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpiCO6ZiOgNCQc49KIluPO99/4dKIxEUfshRlfsjLH4=;
        b=LNfiyhmpXc1QoCD5yrj4/pijpLdj0SPBaJvP/dCXAF0WN59Gd96h+lIgls6HSjH080
         BLsxBlVnzoNQtoSwxKDVxrbv3k/mu8o7E98SKW++g1iPXGhuvrxI2O4rFLZLS2899lF3
         RS46mEc9rkHNv/i4niejwBEUUemteaU8q0rws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpiCO6ZiOgNCQc49KIluPO99/4dKIxEUfshRlfsjLH4=;
        b=ZJtHeVFma5l39paNy17w6z7URNBD/W5ykB6RHi44pFiFl7y2qxD5Ts5YSbwCR0WZDj
         UmxR8rS8rrcs2FODfhG3cFQCwXLR8XXv6ySFn2v1EYlws1ceZvm0NTrZy1/0JtbJPYA8
         M4KzHZyPdeJGdnp6AQwXtJb8Dpm2gj5ZdTYKnnQ04IMknk3Nyuyau72CY3njeiDpAHMk
         7rJuYVMCL8zRQ7UcvsuItl94r4CR3zKL72dxR5SWSf2fx0WTcRHTRJu5GrUwqosSXU3J
         20/bmpNDFXU+yUUSii3bTQJgPQcSTZcAeoUtSMdx3cDKg4uYAFSk8BTb3Z6d7aCT926y
         mDhg==
X-Gm-Message-State: APjAAAXHS45J1kOG/sifRNqV+lQ5SvkAFGJ5MBt7iwhovUMF3nj7dv3G
        5qGagpSIexr8PuAeWfw6pPTzTn881sPaoPnvsJSzAQ==
X-Google-Smtp-Source: APXvYqx974mm7dntv5UHyry1yVpZ+kf8xxDYUfBQ7jUmNF3iuGtLxdDSnXOm69O4kIu5Q1MXPzflO967uPFxe1ZelZs=
X-Received: by 2002:a1c:f906:: with SMTP id x6mr5452166wmh.142.1553332559146;
 Sat, 23 Mar 2019 02:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553207234.git.amazo@checkvideo.com> <e644a8ab4928349ed83ac9ab6ffdbcafc3a3a7b5.1553207234.git.amazo@checkvideo.com>
In-Reply-To: <e644a8ab4928349ed83ac9ab6ffdbcafc3a3a7b5.1553207234.git.amazo@checkvideo.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 23 Mar 2019 09:15:48 +0000
Message-ID: <CAE5ih7-W9vw4siwc=YQD36863LaCm1RzatAZ4Ajjk8MjYimOdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] git-p4: match branches case insensitively if configured
To:     "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "ahippo@yandex.com" <ahippo@yandex.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Mar 2019 at 22:32, Mazo, Andrey <amazo@checkvideo.com> wrote:
>
> git-p4 knows how to handle case insensitivity in file paths
> if core.ignorecase is set.
> However, when determining a branch for a file,
> it still does a case-sensitive prefix match.
> This may result in some file changes to be lost on import.
>
> For example, given the following commits
>  1. add //depot/main/file1
>  2. add //depot/DirA/file2
>  3. add //depot/dira/file3
>  4. add //depot/DirA/file4
> and "branchList = main:DirA" branch mapping,
> commit 3 will be lost.
>
> So, do branch search case insensitively if running with core.ignorecase set.
> Teach splitFilesIntoBranches() to use the p4PathStartsWith() function
> for path prefix matches instead of always case-sensitive match.

I wonder what other code paths break due to this problem!

Looks reasonable but I fear there may be some other holes in there -
quickly looking through the code suggests there are several other
places this problem occurs.

Luke

>
> Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
> ---
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index c0a3068b6f..91c610f960 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2721,11 +2721,11 @@ def splitFilesIntoBranches(self, commit):
>                  relPath = self.stripRepoPath(path, self.depotPaths)
>
>              for branch in self.knownBranches.keys():
>                  # add a trailing slash so that a commit into qt/4.2foo
>                  # doesn't end up in qt/4.2, e.g.
> -                if relPath.startswith(branch + "/"):
> +                if p4PathStartsWith(relPath, branch + "/"):
>                      if branch not in branches:
>                          branches[branch] = []
>                      branches[branch].append(file)
>                      break
>
> --
> 2.19.2
>

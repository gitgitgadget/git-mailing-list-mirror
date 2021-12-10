Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E90C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhLJDaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbhLJDaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:30:07 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D008FC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:26:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so25426974edd.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pp4jl6NngQZnt6YAQcuhrSg4Lct4+H3EeFu7/pC0oM0=;
        b=XUV6qlzxb7N3S+Mqit6W8/ZC4dCQgEzEveWTgicZFCt0t8mgMB274NH6REeDvqEGXm
         LqbEyjRT6k5rjlvZbZH+fWD0vUBxgzLSoi0lcPFX7ZcK59WfJ3HkKBVda7k5d4wh00XM
         vsFJzMylzDH/Wj3UwzodJB6ez0bguYe04sTAXYcKhxajua6lNpQA2K9OuJQuf65FNn/z
         bNL6LHL7knWVjt9hDOOAmIMr2Iol9hd+9XYUa52GZow5O7Jc1JqaWcl17C52loJgXhDV
         UaOXVBHvlE2ena7Fx5zAgC77e4VfSXSypeIUm2xqxBoLDz3vXrH4KQ9B2pZhTPEqZDWj
         1elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pp4jl6NngQZnt6YAQcuhrSg4Lct4+H3EeFu7/pC0oM0=;
        b=rWC2/EbCEzy1yZzaEvgDLNcP43AHoa15oonyrKbgKp516oV7MBOSt6oTJe5ndVNVta
         IbDminZw9v0S5lkApjJdZVZG/H85jXlwE/5PWZIjS+iY0Ppy8XZhn9I+rQ2ixfB6VLOL
         N+hmvwlde/4cXJeVyqixaYOBASTUrhejkoG9RQy4/uS0XdYyUlYj69WeID6EnHJd1KX0
         ZJIU4rr3zS2kwizGQyzK5kPhgATKUWalgiiithC5pJNkBNgUMCObKbeT3T3/0XXoivc1
         6OqVmoZ+crfOWquTzXl/j/XL0RWExyF7uV0I/iQuzz370lkrh0Qwe09ZeN6kHsoSdWtb
         iC0Q==
X-Gm-Message-State: AOAM530wRvrd47IckZmas13C7rCnAwBIqxuK5bUo+w2rtUEpbzNJyelo
        Ob0P0NxVfukGKplmVw0awhO8jbdylzc3LxVaF54u8edu
X-Google-Smtp-Source: ABdhPJy/0vVKYR5/fPl7leeKzzwksLX+Z+6zeQHQyownA9NHw1FBbhmKHa7e3fhREF1w6U++bOgs1PnMVvpWTqqRVIw=
X-Received: by 2002:a17:907:c0e:: with SMTP id ga14mr20398587ejc.26.1639106791295;
 Thu, 09 Dec 2021 19:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20211209201029.136886-1-jholdsworth@nvidia.com> <20211209201029.136886-4-jholdsworth@nvidia.com>
In-Reply-To: <20211209201029.136886-4-jholdsworth@nvidia.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 9 Dec 2021 19:25:55 -0800
Message-ID: <CAJDDKr5N-2WUaspsyciq3WW+pMW--Mjiu5+3F_gOmHYENAkCUA@mail.gmail.com>
Subject: Re: [PATCH 3/6] git-p4: Removed support for Python 2
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 9, 2021 at 1:13 PM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>  git-p4.py | 89 +++++++++++++++++--------------------------------------
>  1 file changed, 28 insertions(+), 61 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 32f30e5f9a..b5d4fc1176 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>  #
>  # git-p4.py -- A tool for bidirectional operation between a Perforce depot and git.
>  #
> @@ -16,8 +16,8 @@
>  # pylint: disable=too-many-branches,too-many-nested-blocks
>  #
>  import sys
> -if sys.version_info.major < 3 and sys.version_info.minor < 7:
> -    sys.stderr.write("git-p4: requires Python 2.7 or later.\n")
> +if sys.version_info.major < 3 or (sys.version_info.major == 3 and sys.version_info.minor < 7):
> +    sys.stderr.write("git-p4: requires Python 3.7 or later.\n")
>      sys.exit(1)
>  import os
>  import optparse


There are pretty large user bases on centos/rhel 7+8 where python3.6
is the default version.

If we don't necessarily require any features from 3.7 then it might be
worth lowering this constraint to allow 3.6 or maybe even 3.4 to
maximize the number of users that would benefit.

I realize these python versions are retired according to the python
core team, but I tend to be a little more sympathetic to users when
it doesn't have any impact on the code.

--
David

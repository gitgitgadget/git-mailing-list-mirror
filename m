Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E009D1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeHBVDz (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:03:55 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36553 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeHBVDz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:03:55 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so1698944ybk.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAZYACrp4W0YFhFrzdXQXFrDM49gtdlIRTLGlA2D6As=;
        b=CSOAbyS5uD1znPrpxEgIZFvgCyYNQgSRWqRZfykaWOtnECUAoAd+/JnPmPJWZY61qu
         Hu9USpTFv266rH2Yd9JhKod4qkcn2yctn6RJlvATEC6NvXmznBkrveKNLvz1/b0FGRdo
         gqcyu5qlst7Rz7ngQ8EtCS/T3+8ebo64DXOipjLYANTTr/4RTKp8a9c2kJKXHGe+z9p+
         Oq6xZRU+0zIcJsXQlQaB5R+iqNTJPWFSiujBH7KHP6MeCqRofcYNUHJggnQGOr6j9e5w
         xC2iHU/ueGOllS8BwszwgzqI/eWmP+v4+5gJQn6jiKJ4g6CD8QVQOxSV999rYpYUX2JI
         zfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAZYACrp4W0YFhFrzdXQXFrDM49gtdlIRTLGlA2D6As=;
        b=ILBI1oR9ojvQsAAhrTra7Ovl0Va0a8UG6GGJt39DORxy0ucZgd5ZrRd2TRw3m1w4HW
         rRE7bOstPjq2xfae2GL8TY+knMp/m28Hl0WQVp8x1+11JYexOoyLoQxc5XlPk6nGJc5F
         OWCejFcHBYhhDGDIRnN/ztJZ9OM8XhmdmMiUsRRVn+/ZsBjiljL8ZAuCGj7sKM0ZcHJv
         dubGCe1jNU3O8A/axP/KtkVF9J2p0bJT/FNeZzqJV+GSJseQasrQ+vxrCrNvEn/DSokc
         XyT++VQqBessI/6tOWSbX9/UX3aD/OglqqNDyf3z//5czjfHPvHD7jd0B8LfHdOFDya7
         45+Q==
X-Gm-Message-State: AOUpUlE7RQ3INTcFNUAT8oh3sah8XKwwyHRoi7GNKWMC0HpvnMP4KMCK
        WETQyWfoYT9rrdenZkl2cCos+q4kXkc3ZwO2518CcQ==
X-Google-Smtp-Source: AAOMgpdAEUda1MFGFfZW/9dZwVp+FMGM0te1FKJBC6biYYAZts7OB8wmLnVHBuPl8yq+erHAv7LRGLjEHnufY8e6mUU=
X-Received: by 2002:a25:3624:: with SMTP id d36-v6mr492494yba.292.1533237086827;
 Thu, 02 Aug 2018 12:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-9-ao2@ao2.it>
In-Reply-To: <20180802134634.10300-9-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 12:11:15 -0700
Message-ID: <CAGZ79kb=KgSSVXPCpa0wSyohpgywBk8c9P7Lq5BNJcdZ1exUyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/12] t7506: cleanup .gitmodules properly before
 setting up new scenario
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> In t/t7506-status-submodule.sh at some point a new scenario is set up to
> test different things, in particular new submodules are added which are
> meant to completely replace the previous ones.
>
> However before calling the "git submodule add" commands for the new
> layout, the .gitmodules file is removed only from the working tree still
> leaving the previous content in current branch.
>
> This can break if, in the future, "git submodule add" starts
> differentiating between the following two cases:
>
>   - .gitmodules is not in the working tree but it is in the current
>     branch (it may not be safe to add new submodules in this case);
>
>   - .gitmodules is neither in the working tree nor anywhere in the
>     current branch (it is safe to add new submodules).
>
> Since the test means to get rid of .gitmodules anyways, let's completely
> remove it from the current branch, to actually start afresh in the new
> scenario.
>
> This is more future-proof and does not break current tests.

Makes sense.

Thanks,
Stefan

>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  t/t7506-status-submodule.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> index b4b74dbe29..af91ba92ff 100755
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh
> @@ -325,7 +325,8 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
>         (
>                 cd super &&
>                 git clean -dfx &&
> -               rm .gitmodules &&
> +               git rm .gitmodules &&
> +               git commit -m "remove .gitmodules" &&
>                 git submodule add -f ./sub1 &&
>                 git submodule add -f ./sub2 &&
>                 git submodule add -f ./sub1 sub3 &&
> --
> 2.18.0
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA751F424
	for <e@80x24.org>; Thu, 26 Apr 2018 23:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757219AbeDZXAF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 19:00:05 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:44233 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756634AbeDZXAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 19:00:02 -0400
Received: by mail-vk0-f68.google.com with SMTP id r184so17083123vke.11
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 16:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZhQq+c3d/fIJIsgmsOhu0spBzoZBus+6A+qUhvuSQnQ=;
        b=lr4pzZL3AwdgSeFFHP0WKNGFzkw7vf8kBLL4iImfNbgExYTrXWj5f7c5k6NVG1fE7Q
         hw3IXvg8YRl8KZohke9zhzpRJwpT5ChFyfZp2srSHHh8M6nmafHUYBOXmjQIZ8Urqr3X
         Z7NWDI6Xopr4dr7m4+haRMO39Vrhk7YFgUkP8d50gi3JYULDxkXCaFbh5ZR6gWJDXCcB
         7wVhtMOMID08aQ5DfuN1KxuQseCztXbT7j3F+PRmaPhKoO/UYOsUGKQm5cLp2KQqit3h
         8fhNqp5LRYRpNg2f7eRrJ/SJ+YfuKGlhVFx+UqDrDryWG488GsWygB7D4bEhBTt22XR2
         /tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZhQq+c3d/fIJIsgmsOhu0spBzoZBus+6A+qUhvuSQnQ=;
        b=FUEXH1m0sCBwRtRUeIoh0w4iVsfS/2NlFNoW9h14MaLV+ybbrofOvacNdGQ2RjJD/Q
         7RmG/6y6OCdsjy+JDu2q3i8V862bEyL2uzEihx/SA8q51JhLyE0tjfTu7YuAXiTSFGU8
         GtseO+68blufuYPYshi2ycUcoV2KcJyDYs4roAxwwfwGTJ+D2MeYMDy9ykEy5YTXX1oe
         wt5kqEjRVFYYrQxXHydBruY77l40+3pFv9qs4xOvq1JH8EyCla6wEqGqkkZ2hDtIRt74
         UQcVSl0zHOt1zItUhMb6G3XACEf95w+D17OHm1LEyLfYEog0LKo+325DiybrGBvotZMl
         ABnQ==
X-Gm-Message-State: ALQs6tC57r422mbD8+zwf3cji+470pOABwJecahh2yosZ2PCAjUWQb0G
        uZf44mE4e/lrVZnevFrVmv42k5WQyCT1mzOuvTU=
X-Google-Smtp-Source: AIpwx494QPERl9TjTMDNfLl05K8TaWueOXFEBRgetxsE6LuBJuTRjvu69I3mvKZtfRyr2psbkGpOa8GnXkdeM4NqjsM=
X-Received: by 10.31.148.135 with SMTP id w129mr24684721vkd.7.1524783601632;
 Thu, 26 Apr 2018 16:00:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 16:00:00 -0700 (PDT)
In-Reply-To: <20180426205202.23056-4-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-4-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 16:00:00 -0700
Message-ID: <CABPp-BHg++tvbd+Y8xCCNmi+fAv_4azXCkCWDucFLDj1sXeWAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] merge: pass aggressive when rename detection is
 turned off
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 1:52 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Set aggressive flag in git_merge_trees() when rename detection is turned off.
> This allows read_tree() to auto resolve more cases that would have otherwise
> been handled by the rename detection.
>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  merge-recursive.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 2637d34d87..6cc4404144 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -276,6 +276,7 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
>  }
>
>  static int git_merge_trees(int index_only,
> +                          int aggressive,
>                            struct tree *common,
>                            struct tree *head,
>                            struct tree *merge)
> @@ -294,6 +295,7 @@ static int git_merge_trees(int index_only,
>         opts.fn = threeway_merge;
>         opts.src_index = &the_index;
>         opts.dst_index = &the_index;
> +       opts.aggressive = aggressive;
>         setup_unpack_trees_porcelain(&opts, "merge");
>
>         init_tree_desc_from_tree(t+0, common);
> @@ -1993,7 +1995,7 @@ int merge_trees(struct merge_options *o,
>                 return 1;
>         }
>
> -       code = git_merge_trees(o->call_depth, common, head, merge);
> +       code = git_merge_trees(o->call_depth, !merge_detect_rename(o), common, head, merge);
>
>         if (code != 0) {
>                 if (show(o, 4) || o->call_depth)
> --
> 2.17.0.windows.1

Patch looks fine but as a heads up -- since merge_options is a
parameter in git_merge_trees after the
en/rename-directory-detection-reboot lands, we'll be able to switch
this patch to set opts.aggressive directly instead of needing to pass
it in as a parameter.

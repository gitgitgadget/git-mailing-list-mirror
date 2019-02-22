Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC6F20248
	for <e@80x24.org>; Fri, 22 Feb 2019 20:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfBVUY0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:24:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36294 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVUY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:24:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so4029193qtb.3
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShMdX5IZoHmpbzG9rc/irFj+qN7umvV0HUUHQclIKGs=;
        b=M4FPdvsPeb1WxFqcpGPAksUk5qusebIawKV62kVOXFNEWHaZp+Ne7VWe1Phw/YbG+W
         yvQ2u2XcisWNinJuBHAHA6a2AqvoRHs8lV1AsR8TLIcM0JZXbKCT5d/FTGo7RSG2+zmW
         0mc3gx+hNVqvz3Iuf2EcgzoxQBp7qcBl2t00+NzLgwQIAbXrqH73rw0bMsiwtvND5hKL
         ri9h9o/EB4BLGINPk9kPMvw18Co6eLA7EUBfSoRiAFgyuHhfv6Q8BxojaaE5mmQCyFbG
         BiT6FTzbX5jcYBNDtFpA0QvM2Uc/0oWv+Q1lvvKvO/z6Pbjwo6ayXfeoMmwvLa9cHv38
         0ARg==
X-Gm-Message-State: AHQUAuatSsOq1DDozkyGMSIefRe5ODwo9q4ITo9XPYELmvrCXqdudj1A
        8VMFKAY31CkiHD0zsnhKQEEPOgO39Pp1lUv0ECM=
X-Google-Smtp-Source: AHgI3IZHxr7BvwYcexCmQv79OStzKHQxZU2S2ErsoL4l6Aw5k4nEH9AItYQdKyVg3GdJL1EgGpOIP3SGT3DqVtil0SY=
X-Received: by 2002:a0c:92b1:: with SMTP id b46mr4741575qvb.184.1550867065490;
 Fri, 22 Feb 2019 12:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20190222201111.98196-1-gitster@pobox.com> <20190222201111.98196-2-gitster@pobox.com>
In-Reply-To: <20190222201111.98196-2-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Feb 2019 15:24:15 -0500
Message-ID: <CAPig+cRhk-0LBCmUQ4LszJrnmnXCDz7HxWqDnKX53woBYhr-KQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] builtin/log: downcase the beginning of error messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 3:11 PM Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -911,7 +911,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
>         if (rev->pending.nr != 2)
> -               die(_("Need exactly one range."));
> +               die(_("need exactly one range."));

Perhaps drop the trailing period while you're here?

> @@ -921,7 +921,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
>         if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
> -               die(_("Not a range."));
> +               die(_("not a range."));

Ditto.

> @@ -1331,16 +1331,16 @@ static struct commit *get_base_commit(const char *base_commit,
>                         if (get_oid(upstream, &oid))
> -                               die(_("Failed to resolve '%s' as a valid ref."), upstream);
> +                               die(_("failed to resolve '%s' as a valid ref."), upstream);

Ditto.

>                         if (!base_list || base_list->next)
> -                               die(_("Could not find exact merge base."));
> +                               die(_("could not find exact merge base."));

Ditto.

> -                       die(_("Failed to get upstream, if you want to record base commit automatically,\n"
> +                       die(_("failed to get upstream, if you want to record base commit automatically,\n"
>                               "please use git branch --set-upstream-to to track a remote branch.\n"
>                               "Or you could specify base commit by --base=<base-commit-id> manually."));

The capitalized "Or you..." is odd after s/Failed/failed/. I wonder if
the period in the first sentence should be replaced by a semicolon and
then "Or you..." downcased (and the final period dropped):

    die(_("failed to ... automatically,\n"
    "please use ... branch;\n"
    "or you ... manually"));

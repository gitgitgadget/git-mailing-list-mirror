Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0A61F406
	for <e@80x24.org>; Tue, 15 May 2018 00:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeEOAlj (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 20:41:39 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45914 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752293AbeEOAli (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 20:41:38 -0400
Received: by mail-yw0-f193.google.com with SMTP id g9-v6so4159529ywb.12
        for <git@vger.kernel.org>; Mon, 14 May 2018 17:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qc0bGE8+KWWEbWSWeSxaQBzzqNxppK25DbL0CWIEiX0=;
        b=lGAAk752bcB+fSs8FaQ1m6T0wcf91mwjavwB2P7CVDU7tQlm0ZAqaKnHqDxPhWXFcq
         l3H+7ErNHlo2c4OZv0tV9xERvMSiZ2bNBDiX0Jm42lp5O99Uv8bBiITUJlo4oaPb0YA8
         x3vKVqYhrNxla9vjQK65Az6a21YoZWn3LD1ksH97ycn3ekHDPBpWb2aVcDJcsmkEHA1r
         VCBFtVRxCWe2z3dGQZCa/b2HoNee99QbSXiKq8EC3Gki9yEl5Tw9Coc6+YiOp6yAjKKx
         /Y+a2TKiF9R+YJ0+XfvHhq8+pRE/Be4SElwHzXTnEgBI/MGMAvpOYrY7+rU0Ro91i5xC
         So6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qc0bGE8+KWWEbWSWeSxaQBzzqNxppK25DbL0CWIEiX0=;
        b=gvEjBDCM7IUklf+ljHhguqzEo7TNa69Uor2Chv2LT/2pw1+HDj01QzsN3Aw2pE9hLi
         2HJQBFf0MIereB4zxUUchlVsFBXK+Ln3OvxtlESZXtmPjUMKlY6NNYD9ML0s1i491eRv
         LIaecFu0OUTOfgwmjBktLY412sqB0VW1OyIfiSzP99VggaAjs2UgQzSje3vVjkts3bm0
         KkjnCnB9C3hizIae00JHmOtK1tHN/C6cAWBw/OWrwiwH3fsf4phUQL/uqdBH1HV420BR
         Zmw9QNFj8DdoZupCQeMAd9CRSTYzmy6apUT0mWfq7O6e3qYeZP4BgfUCwbKaFuVIY+sZ
         qo+Q==
X-Gm-Message-State: ALKqPwcuE2oEt6/jfYWvhS/6yFXysTtESsZ0DELR2Oaj/Dz9zQTLAC+J
        pnadsOktgN+aeXRjC3hb22eqTcf/7PdgO6hgJgNC6w==
X-Google-Smtp-Source: AB8JxZpUXAC0zo1pr/JJfy+HNoOX6r47siZ+Y7I8gEwCEZkckX08LjHnXJmVwqtpxM8Xnrz7cxpahMIZUxTT/Bh/AZk=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr5492246ywf.238.1526344897932;
 Mon, 14 May 2018 17:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Mon, 14 May 2018 17:41:37
 -0700 (PDT)
In-Reply-To: <20180514205737.21313-2-leif.middelschulte@gmail.com>
References: <CAGZ79kaiFkq20Com7gOLin371D2KhTPG7cqn1mQ6OaFU12kKPQ@mail.gmail.com>
 <20180514205737.21313-1-leif.middelschulte@gmail.com> <20180514205737.21313-2-leif.middelschulte@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 May 2018 17:41:37 -0700
Message-ID: <CAGZ79kaKzahJ2oJ7qwerCS6m1c0MBiYiysf+HOU=3uRwfPqOkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Inform about fast-forwarding of submodules during merge
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 1:57 PM, Leif Middelschulte
<leif.middelschulte@gmail.com> wrote:
> From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
>
> Inform the user about an automatically fast-forwarded submodule. The silent merge
> behavior was introduced by commit 68d03e4a6e44 ("Implement automatic fast-forward
> merge for submodules", 2010-07-07)).
>
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Thanks for following up with a patch.
This looks good to me!

Thanks,
Stefan

> ---
>  merge-recursive.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index a4b91d17f..4a03044d1 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1093,10 +1093,14 @@ static int merge_submodule(struct merge_options *o,
>         /* Case #1: a is contained in b or vice versa */
>         if (in_merge_bases(commit_a, commit_b)) {
>                 oidcpy(result, b);
> +               output(o, 1, _("Note: Fast-forwarding submodule %s to the following commit"), path);
> +               output_commit_title(o, commit_b);
>                 return 1;
>         }
>         if (in_merge_bases(commit_b, commit_a)) {
>                 oidcpy(result, a);
> +               output(o, 1, _("Note: Fast-forwarding submodule %s to the following commit:"), path);
> +               output_commit_title(o, commit_a);
>                 return 1;
>         }
>
> --
> 2.15.1 (Apple Git-101)
>

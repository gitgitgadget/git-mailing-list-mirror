Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF81D20282
	for <e@80x24.org>; Thu, 22 Jun 2017 07:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbdFVHBh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 03:01:37 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34564 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdFVHBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 03:01:36 -0400
Received: by mail-io0-f169.google.com with SMTP id c201so17278890ioe.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k2ijUtS6IsmXkypNbViZKvW0mZEY+QjJ7QjtL7B+KiI=;
        b=hbz9EYD6sZYhYSYq8Oa2zTxc0Q8b5ww6SAVI61b7decWmUngZl8YUl38lw5hWRuQmq
         KZpZGqial+8utqHCJv5xIbeCXWQQHYAkihlCsdAdH+LI+dwtSsLaW5lPOwyd46dnJ21r
         pAVtHzugpN6u/Uvi0zh3Xt0uWfLhuQ/PDI0DMIEU0DGHjrXO+K9y1yg1mXduRcOz4jMR
         ScrSiSxQ5pJ6wE/0ligVvxXzJ2N4I3d8kJQBm1HXqaH4UNOLVORDuGBuj4kEnky1jOEz
         zcwFsvta2DFCIMdsUZCgBev4kWkD7B0Ehuh+21hBMj79jifirszcBRaEC2mWxFVs5wsC
         aNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k2ijUtS6IsmXkypNbViZKvW0mZEY+QjJ7QjtL7B+KiI=;
        b=sg1K44vAqOzRYhg3nBf+rDCCVMciT169dwjSE0Xh8xAIWZPdpviiWwwW8jJ4oTSE0P
         aSucaebtzomanIe5sBThXVHD3GU8i1LAstk5P7T1qZaeqwicq8D6uHeziUZCXhR9lKdR
         75ItsjJ8ejS6FDVZ+BzYeO0NaXFtZw1eLWucMVFrl22RcRjV54Rz/QlIHYolR5NZuGOg
         CnLQ2g4VbwF2lzNkMOZDr5ZPk3wJufGnImDwGP0EA5sysFsOVzhzxI4h0ZolBsA5ivrL
         vDJHNahv3O2xMYjy2EFBXDmS4xtNV11fIz8DMPODxi9QsFi2OsMR2QAXayuh+Rs3eJ4g
         EjNA==
X-Gm-Message-State: AKS2vOyEE0efupRU39vTPKwdPrtAoNGXYW/ZwTiih+NTG4xLcVH7gVDL
        d2L5WK16FYPUApftGs0Wbqy3VQYGJw==
X-Received: by 10.107.145.86 with SMTP id t83mr1004421iod.129.1498114895705;
 Thu, 22 Jun 2017 00:01:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Thu, 22 Jun 2017 00:01:35 -0700 (PDT)
In-Reply-To: <20170619215025.10086-2-pc44800@gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com> <20170619215025.10086-2-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 22 Jun 2017 09:01:35 +0200
Message-ID: <CAP8UFD3WN=Bik=EX5N4pQxEXu_S5zUyQTA7Km4V61q44crOY3Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/6] submodule--helper: introduce
 get_submodule_displaypath and for_each_submodule_list
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 11:50 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +       const char *super_prefix = get_super_prefix();
> +
> +       if (prefix && super_prefix) {
> +               BUG("cannot have prefix '%s' and superprefix '%s'",
> +                   prefix, super_prefix);
> +       } else if (prefix) {
> +               struct strbuf sb = STRBUF_INIT;
> +               char *displaypath = xstrdup(relative_path(path, prefix, &sb));
> +               strbuf_release(&sb);
> +               return displaypath;
> +       } else if (super_prefix) {
> +               int len = strlen(super_prefix);
> +               const char *format = is_dir_sep(super_prefix[len-1]) ? "%s%s" : "%s/%s";

Style nit: please add spaces around "-", so "len - 1" instead of "len-1".

> +               return xstrfmt(format, super_prefix, path);
> +       } else {
> +               return xstrdup(path);
> +       }
> +}

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2699B1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 15:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeIDTbK (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 15:31:10 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42565 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeIDTbK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 15:31:10 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so4301178qto.9
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUD3Ka05PUlV9FFm6btoT6c4NciAbAa5jRidvLe0U3Y=;
        b=Zm23jRXzSWNtwx2mxjRlkOX+ZHvxRgtH7Oj8bDPoNLC6WUJlCgXj047QoUHkgf19Nf
         SyJnm+fQeSjqFNi6w6KuY8fSZub4MaZChr+MQ8Xz2MvIXmOLwwp7of671IcvYWod3Jva
         kKJ5SyBWIGqVTKzgI6HbWaAj5WW5griHm/ryrZgysT+PBqMM+6e8kW7VJTh61orVdH84
         79pgk3gtn06Sm/FxjvtnfL+4vjwwvqGJsU2Dwgq1XgPG6JeMGi5b4cbz1dT580ldZxQ3
         OiJYn/52bOADjvessItzsOzgd39pVLV74+jHvgN3HR6MgXX0eaeZvw5LV1nKSbkc6IBA
         i5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUD3Ka05PUlV9FFm6btoT6c4NciAbAa5jRidvLe0U3Y=;
        b=lnpGWjrBsTEBVYFFIatisOofRWpko011dKAR95NSt1hvUIn2V/Q/VBY7zBNUbG/Laq
         PmlphvlgR49e2UI/eFM5K95wvyzOPjFtYsZlkWWUygiVYebfwe/GeS90R1Io+0VHYeoS
         YNmium34QwtgIEegNFkFaq3VkUSVwQ4UfQtrkX/Dkof+W+HNIQavOpePKcf0aaF/JvpX
         wbUiy6P2Avy2RzkgQMVU3ue99zpMRKEGd/GieQnr9oZrQKCvoHJUqgCWVK0P2LCxtXK9
         eTF3odfIlfkygItS0O9xwEhO++jZWoKTROdSEZCVeV4qDySSkkQ1Dv4IwCOfJCHUceah
         ql6w==
X-Gm-Message-State: APzg51BsJSfkqH1eGCVHm1Du9S4HTm3VFulw8FsjrTDXKuGHVNB2V0KS
        HbSxSjbngIDF3cw9mmu+cscSXbL4zZcirR30nwE=
X-Google-Smtp-Source: ANB0VdYh9SnJmNiIize55rmIO6sCmUpq3NcZYMpZvqFdqdwGuWQgWHkKgsJVE6zLnVJHVof02cYMbMn7ZDAWYOfnI4M=
X-Received: by 2002:ac8:3c3:: with SMTP id z3-v6mr4523275qtg.39.1536073540931;
 Tue, 04 Sep 2018 08:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <CANYiYbHmU=j+MwLTumJ+BK_0msyPBeux92wF8VqL9J04VOc-FQ@mail.gmail.com>
 <20180904141816.26398-1-jn.avila@free.fr>
In-Reply-To: <20180904141816.26398-1-jn.avila@free.fr>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 4 Sep 2018 17:05:29 +0200
Message-ID: <CACBZZX6Bm-xOO-mvDzmRAA9Xu6HrBr5z+39dp4t6fTTCmNHKbQ@mail.gmail.com>
Subject: Re: [PATCH] i18n: fix dangling dot in die() messages
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 4:59 PM Jean-Noel Avila <jn.avila@free.fr> wrote:

Your commit message says "dangling dot"...

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b56028ba9d..a011abfd7c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -521,7 +521,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>                 printf(_("Entering '%s'\n"), displaypath);
>
>         if (info->argv[0] && run_command(&cp))
> -               die(_("run_command returned non-zero status for %s\n."),
> +               die(_("run_command returned non-zero status for %s"),

...but here and below you're also removing the newline. Is this
intended, and does it work as desired afterwards? I.e. were we just
ignoring the \n?

>                         displaypath);
>
>         if (info->recursive) {
> @@ -543,7 +543,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>
>                 if (run_command(&cpr))
>                         die(_("run_command returned non-zero status while "
> -                               "recursing in the nested submodules of %s\n."),
> +                               "recursing in the nested submodules of %s"),
>                                 displaypath);
>         }
>
> --
> 2.18.0
>

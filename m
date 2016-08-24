Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EFA31F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbcHXHcF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:32:05 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34539 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcHXHax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:30:53 -0400
Received: by mail-it0-f67.google.com with SMTP id e63so1296749ith.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=28PguB6amNBkbnsTKCKCLImHJKvgecHFnkfvVNp0MOE=;
        b=bSpd8vCvoTfzpzVqAwR6ytPu8CCEdvcHKF7gexbgEiRRSxGt0faaB9dsY5Tit3pgQe
         9KUBMZqnID3l7CfS8nwVvhs4Vq0mZsvHYfE+X4RRBaJFsOQfqc3CiDQsURhCjLJMLHuN
         SD45/YgwNDYx/XFv7+gyEoO1Zyhb+N719MsrzKCFfyqpqBOygs2IjnH8SyC28ftWDHae
         3rMhSbNuR7bfzbsLYVHlZZvYtMLSPLh8/gHyhcU0j4a3cxYw/axcMdiRWQewjnT1W1ZS
         VDBZ4e2qQ1pZKTIqsHVCA4MlJJwIIaaNT1voVc1g16NAqiJkiVRDmg6vVgg9mHmH2+fK
         D1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=28PguB6amNBkbnsTKCKCLImHJKvgecHFnkfvVNp0MOE=;
        b=NB22dTCtHw227/Q4kGY3qpvjC6xWMrkd5oi7eOL/ahF97QrOsx+zjdQwNGVM/+bjFH
         US90tbHNbaFi0xkX+7URfoHBOMGi0dXxQVH1fIxWDjMADlDXz6gkdT2laFRuRanhoOtD
         1s8R1kbICG6NVpvcREeaCO5HNEQbiZayjIC5KPouuGeVrsgA1UPeBkyXRMaLUfC8e9Jg
         9B8Fn4mEhKgqPR7cC3SMvqaXjMXNyzc07qCG+TgCwg5wDeXFiKPuJ12jUyEyP/hrSyQ7
         K0JNHIww1yGw9wF5zD1z3xork2YRP15wzH/WGPUjKcDqS2w5TlKad02ks/aVhBKqvEr4
         kz9A==
X-Gm-Message-State: AE9vXwOmVZ/0gGJg2PEjLcRaWYI2HeQP3PKmwhoRMMLRE1032eXZtUGBdnUf3NE4CQUgWlYc0ilim0KLoSFJgA==
X-Received: by 10.36.210.68 with SMTP id z65mr2736808itf.32.1472023852451;
 Wed, 24 Aug 2016 00:30:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Wed, 24 Aug 2016 00:30:51 -0700 (PDT)
In-Reply-To: <416659fa3df92eabf3265ec079a6ea8cbc17366f.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <416659fa3df92eabf3265ec079a6ea8cbc17366f.1471968378.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Aug 2016 03:30:51 -0400
X-Google-Sender-Auth: tyk9-9uFO3L-BEvZcouhjrdc8w0
Message-ID: <CAPig+cSxeOkT7fLuCQrGJNabPfx1855+1-5pqcq0==22mzJk9w@mail.gmail.com>
Subject: Re: [PATCH 10/15] sequencer: lib'ify save_head()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 12:07 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -844,18 +844,22 @@ static int create_seq_dir(void)
> -static void save_head(const char *head)
> +static int save_head(const char *head)
>  {
>         static struct lock_file head_lock;
>         struct strbuf buf = STRBUF_INIT;
>         int fd;
>
> -       fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), LOCK_DIE_ON_ERROR);
> +       fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
> +       if (fd < 0)
> +               return error_errno(_("Could not lock HEAD"));
>         strbuf_addf(&buf, "%s\n", head);
>         if (write_in_full(fd, buf.buf, buf.len) < 0)
> -               die_errno(_("Could not write to %s"), git_path_head_file());
> +               return error_errno(_("Could not write to %s"),
> +                                  git_path_head_file());

Does this need to rollback the lockfile before returning?

>         if (commit_lock_file(&head_lock) < 0)
> -               die(_("Error wrapping up %s."), git_path_head_file());
> +               return error(_("Error wrapping up %s."), git_path_head_file());
> +       return 0;
>  }

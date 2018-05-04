Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E4B200B9
	for <e@80x24.org>; Fri,  4 May 2018 02:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeEDCfv (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 22:35:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46579 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEDCfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 22:35:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id m16-v6so25594823qtg.13
        for <git@vger.kernel.org>; Thu, 03 May 2018 19:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qCYwGyugU92Jqtx4IPxCQzpTsqhLU4U7Ik/okcGFl9A=;
        b=dsxvT5LKEakbGFD6Dg9/pk9lGziYB37WZyijuxc8vw18G+CycjHfb8YcXE/kbOg31i
         poJxrwQiBPYidclBuJu9WCSuuZL/DAi6oCZUUtmNURwEHAgIC8o+Ww7vhRlCrPYMAzcZ
         CsznlsY90Eh5oOf8+Zhr1e5HvoD7hvL6bZBZ6JHpleviJhfS9buZzh5YvDOfn5RKToWt
         iVFvFh80/0uxyRb6x6eFKnVrhuvA8SAP1bnHCTeshXX8WyfDpMxDVoeIG6c1P7lBil1T
         341iFThLI/RtjVGcBr26cUP2hbeIgapwyioL1/MxDN1ijF3Fzvd3laNFfr5v4dGrIt+C
         5aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qCYwGyugU92Jqtx4IPxCQzpTsqhLU4U7Ik/okcGFl9A=;
        b=KqCg6zYLhX18gL/nH0DzKIkyda7z+1U4fSloKN6K5MiXvp6jL4Eb5ZPEdAuV68jLPN
         u5z4a4cDyIpaUBufr5vECtdSIZ3biYkgJ7ojpqztJS8z52cgmvSBafwUPEiuJxOUnuYa
         8qRYwkSYA+HOS6nmKSTW98XUEx6PXlWrnOIduTMi+i3sYGcLes3Bqp1YCXn6OuVmpEJw
         bysQsdH87Jl3ma2m8t6IyDM9S5q5pqjtjvf/PQZAtw0HMWg2LaLJ2KLleASRKWNiJ4of
         t+CzLOFFLsE4jhb9N3Xt+BnG/zyqHjGGZx/FF8OjZ2GhOUwCCdvJCTLpV6fMJ8/vDYkS
         cWfA==
X-Gm-Message-State: ALQs6tAMRPpPKcuO9FHDqMfYeMVzz29kRy0ema4D3pdmjieh5SdB5ZK0
        4EpEs6TnjyIjJD31d1FEEP85jaGLIj8EE8LjwUQ=
X-Google-Smtp-Source: AB8JxZpoKNrEX2If+BXyZc1PDrayQAG5Jb/YVXcP8lNgr+Mbhyu+TuPg+lOWyh/72NTH027SMgSMMYxqPDHuoFaAQRs=
X-Received: by 2002:ac8:3267:: with SMTP id y36-v6mr22314200qta.25.1525401350197;
 Thu, 03 May 2018 19:35:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 3 May 2018 19:35:49 -0700 (PDT)
In-Reply-To: <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 May 2018 22:35:49 -0400
X-Google-Sender-Auth: HRuXu7XFfDi3oyz_nw7M7dBAMco
Message-ID: <CAPig+cSvHWvb0dsGkjL69yzbBvgaT7oJm6nFuGWeA6Jw0NpYUw@mail.gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 11:30 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> At this stage, `git branch-diff` can determine corresponding commits of
> two related commit ranges. This makes use of the recently introduced
> implementation of the Hungarian algorithm.
>
> The core of this patch is a straight port of the ideas of tbdiff, the
> seemingly dormant project at https://github.com/trast/tbdiff.
>
> The output does not at all match `tbdiff`'s output yet, as this patch
> really concentrates on getting the patch matching part right.
>
> Note: due to differences in the diff algorithm (`tbdiff` uses the
> Pythong module `difflib`, Git uses its xdiff fork), the cost matrix

s/Pythong/Python/

> calculated by `branch-diff` is different (but very similar) to the one
> calculated by `tbdiff`. Therefore, it is possible that they find
> different matching commits in corner cases (e.g. when a patch was split
> into two patches of roughly equal length).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> @@ -19,6 +23,279 @@ static int parse_creation_weight(const struct option *opt, const char *arg,
> +static int read_patches(const char *range, struct string_list *list)
> +{
> +       [...]
> +       struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
> +       [...]
> +                       } else if (starts_with(line.buf, "    ")) {
> +                               strbuf_addbuf(&buf, &line);
> +                               strbuf_addch(&buf, '\n');
> +                       }
> +
> +                       continue;

Unnecessary blank line above 'continue'?

> +               } else if (starts_with(line.buf, "@@ "))
> +                       strbuf_addstr(&buf, "@@");
> +               [...]
> +       }
> +       fclose(in);
> +
> +       if (util)
> +               string_list_append(list, buf.buf)->util = util;
> +       strbuf_release(&buf);

strbuf_release(&line);

> +       if (finish_command(&cp))
> +               return -1;
> +
> +       return 0;
> +}
> @@ -32,9 +309,63 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
> +       if (argc == 2) {
> +               if (!strstr(argv[0], ".."))
> +                       warning(_("no .. in range: '%s'"), argv[0]);
> +               strbuf_addstr(&range1, argv[0]);
> +
> +               if (!strstr(argv[1], ".."))
> +                       warning(_("no .. in range: '%s'"), argv[1]);
> +               strbuf_addstr(&range2, argv[1]);
> +       } else if (argc == 1) {
> +               if (!b)
> +                       die(_("single arg format requires a symmetric range"));
> +       } else {
> +               error("Need two commit ranges");

Other warning/error messages emitted by this function are not
capitalized: s/Need/need/

> +               usage_with_options(builtin_branch_diff_usage, options);
> +       }
> +
> +       if (read_patches(range1.buf, &branch1))
> +               res = error(_("could not parse log for '%s'"), range1.buf);
> +       if (!res && read_patches(range2.buf, &branch2))
> +               res = error(_("could not parse log for '%s'"), range2.buf);

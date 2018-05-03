Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F502023F
	for <e@80x24.org>; Thu,  3 May 2018 16:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeECQnq (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:43:46 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:42770 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeECQno (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:43:44 -0400
Received: by mail-yb0-f179.google.com with SMTP id 140-v6so6723922ybc.9
        for <git@vger.kernel.org>; Thu, 03 May 2018 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qvnuwg1tp3SEEuiVPsXI0RlU6GIzPfX0JBLFrtj7rBQ=;
        b=Ow6vwxSr6xaZwNlcvyKvF4rCeIPnNL2hM49sGegW016Q735DVpHpURiS15VCIGK0yw
         nGq7qUSWQ/ZJQdtuyscgNSil8zKhY1S9UfOgOGjqO0GEDw1GlIuHqcbulAKJEcaR32Zk
         diDheuL413jYXrbiItDoBnQFnTsSxs0ggE4D8PQOrpp7RcIixpw3W8PRptt8OUl/RhXf
         vMSv887LYHdPSuvGeAGbPuNhdjXMj07WFOzzTM4zAjpxGrbPvkha+WLeu7WLqJW0qjeR
         uJUoUKC6+1AJ05yqbw7zHrL2q7UohKU7+E6HJe2ej8WfFF1X/u0C05Ymg6AywvfLHTLe
         kVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qvnuwg1tp3SEEuiVPsXI0RlU6GIzPfX0JBLFrtj7rBQ=;
        b=WLpqXcllxJM7PI8+rdjyMq3RM8deUGjFEvadcE7GJrHdVU2yVx68uN9FFVE3Dq0z3n
         2JT2kyfEttMr1Xk0JoVFII5ihMCm+glSj5wcNNQHi0zrLeFXecHzsUBJj1JrORt6X511
         ZMod7SzPUnvhBR7ZQX/xCLyeymcIZzTQXepuJcrQaCWx46dUqgpZb9sTrJS6gLCsdxj/
         9CQWuVq7gn/P13yoPZz/yRnO7/FZSVi5onB3IbfSlWiZJc6e90HX4JBoxHkf8xyuvKKc
         kor8Os9ksUUPXD8TRTvBkyBcvtGdn+a2qcb2S5wB6Zz24ml6MNDrOfZOoc8tUa9HmrAv
         1gZg==
X-Gm-Message-State: ALQs6tB8oKZtVIYvl8mqnVsuoG6aXWDWqjSoDPqXxzfrR6rJoPwtty4s
        bH1qz8Nu+QDl4wc+aOi2MDeAQMPRKwmBxpMIK+4ouA==
X-Google-Smtp-Source: AB8JxZrA9AR3kxEF10eIdslsifiG10LdIgAH8vlDL2rlUZt0F5bIMbzlZibisVktFi+UzmGO8uEl5gGsHjWqSaEPVK4=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr15822189ybc.307.1525365822989;
 Thu, 03 May 2018 09:43:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 09:43:42 -0700 (PDT)
In-Reply-To: <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 09:43:42 -0700
Message-ID: <CAGZ79kZAidPafdfu1NGwwpVo1Vy=vKOV+EREE2=-ct_sbo7Gkg@mail.gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Thu, May 3, 2018 at 8:30 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This builtin does not do a whole lot so far, apart from showing a usage
> that is oddly similar to that of `git tbdiff`. And for a good reason:
> the next commits will turn `branch-diff` into a full-blown replacement
> for `tbdiff`.

While I appreciate the 1:1 re-implementation, I'll comment as if this
was a newly invented tool, questioning design choices. They are probably
chosen pretty well, and fudge facotrs as below are at tweaked to a reasonable
factor, but I'll try to look with fresh eyes.

>
> At this point, we ignore tbdiff's color options, as they will all be
> implemented later and require some patches to the diff machinery.

Speaking of colors, for origin/sb/blame-color Junio hinted at re-using
cyan for "uninteresting" parts to deliver a consistent color scheme for
Git. Eventually he dreams of having 2 layers of indirection IIUC, with
    "uninteresting" -> cyan
    "repeated lines in blame" -> uninteresting

Maybe we can fit the coloring of this tool in this scheme, too?

> +       double creation_weight = 0.6;

I wondered if we use doubles in Gits code base at all,
and I found

khash.h:59:static const double __ac_HASH_UPPER = 0.77;
pack-bitmap-write.c:248:        static const double
REUSE_BITMAP_THRESHOLD = 0.2;
pack-bitmap.c:751:      static const double REUSE_PERCENT = 0.9;

all other occurrences of `git grep double` are mentioning it in other
contexts (e.g. "double linked list" or comments).

When implementing diff heuristics in 433860f3d0b (diff: improve
positioning of add/delete blocks in diffs, 2016-09-05), Michael broke
it down to fixed integers instead of floating point.

Do we need to dynamic of a floating point, or would a rather small range
suffice here? (Also see rename detection settings, that take percents as
integers)

Thanks,
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A671F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeGITe1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:34:27 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46213 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754520AbeGITe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:34:26 -0400
Received: by mail-yb0-f194.google.com with SMTP id s14-v6so7651889ybp.13
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 12:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RnY+F+4zX6aX1PzzP/I8NEEmX+daWN4KLgtcdg04kY=;
        b=H9n2uaqE8LzvoSnk2djUO2rqiPF0d4AZu5o8ZmTwOV06Fkv9v4G2puU9MfkEHQlMdu
         uJP6yAeoug0P9GIyM+cSgkTvA/t/7xdIPPtqIfzVdJ2ADPXYLMw2uDUDtDGyxzvSFR2c
         5pQM5i8DY0eT7tz8J5NO2srC/PNKjCTT5vEjb+OpunoNqckXSL+DQ2Vt2nV2FNMp3xWe
         OcT+s6XZOHVd2YVGNQZXCf354YWe7xw9wv4msmOjXK80ybwM8nmqLZjolM4xKgmbnG5j
         r+WucBfG5mAVetYhMDm5Rbpzba2oe2K1Sa2b/BFoQQoelZ9qbJAv53NrsoJSApp8t41s
         JADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RnY+F+4zX6aX1PzzP/I8NEEmX+daWN4KLgtcdg04kY=;
        b=YPDs6gEyod46EIM20Lh60nMAA5CBF/xHgNmX+Ym1lH+Pyw2UR5xRlazR9EChvz+FYJ
         NNpZYyDk2hDb54PGpe1sWVZVREZAefapZMR0lzHX3t3jSjRw2a3tUm2V51q+CyNug5aB
         kscIuV/YPRG2vYO+GXNRctzXR4hhPy9Q+0V4ZGFuYwT40mfRiv30XW1MFv97NMvfeUn4
         NHKaJeDree+v1Zb8/ACHrMIg/faX6CNuguSNxlWOXeFokOylcp4hThVipIVk8vNby10t
         DtVZUXrmpmpocFsTOQmh7910feRg6fRQY2WyxOmJiG0RcyYkNvgIjVr9ttGf3k5Z8sso
         WerQ==
X-Gm-Message-State: APt69E0NBjwZUDxn2B+Hdb4wGBewo2JdJxA7Kqwrfs7DVWLOGQhkJhG8
        ENGz2s0zntxpOT3gDlmZizMK69K3NUEM3d0mT5mlbA==
X-Google-Smtp-Source: AAOMgpc1C4N3M1tVSch9F0aOVJFMUlgcO0K9+Y7mwRcVa2uflxVPrY3bTTjIfyRsP6vIHk8R+QypgdxD58kZv34aRIA=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr11569119ybp.352.1531164865947;
 Mon, 09 Jul 2018 12:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <dfa7b1e71f7a39dfa608e1e205579d3b95d8a34f.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <dfa7b1e71f7a39dfa608e1e205579d3b95d8a34f.1530617166.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jul 2018 12:34:14 -0700
Message-ID: <CAGZ79kYQTTjipfBn3oAbpjZGnszWNiTKN3Ai4Pp-QA+i_xigbg@mail.gmail.com>
Subject: Re: [PATCH v3 16/20] range-diff --dual-color: work around bogus
 white-space warning
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 4:26 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When displaying a diff of diffs, it is possible that there is an outer
> `+` before a context line. That happens when the context changed between
> old and new commit. When that context line starts with a tab (after the
> space that marks it as context line), our diff machinery spits out a
> white-space error (space before tab), but in this case, that is
> incorrect.
>
> Work around this by detecting that situation and simply *not* printing
> the space in that case.

ok. If that is the workaround that you deem to be the right thing for now.
(I do not have an opinion if that is the right approach, or if we'd want
to s/<TAB>/<SPACE>/ for example.)

> This is slightly improper a fix because it is conceivable that an
> output_prefix might be configured with *just* the right length to let
> that tab jump to a different tab stop depending whether we emit that
> space or not.
>
> However, the proper fix would be relatively ugly and intrusive because
> it would have to *weaken* the WS_SPACE_BEFORE_TAB option in ws.c.
> Besides, we do not expose the --dual-color option in cases other than
> the `git range-diff` command, which only uses a hard-coded
> output_prefix of four spaces (which misses the problem by one
> column... ;-)).

That makes sense!

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 26445ffa1..325007167 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1093,6 +1093,12 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>                                 set = diff_get_color_opt(o, DIFF_FRAGINFO);
>                         else if (c != '+')
>                                 set = diff_get_color_opt(o, DIFF_CONTEXT);
> +                       /* Avoid space-before-tab warning */
> +                       if (c == ' ' && (len < 2 || line[1] == '\t' ||
> +                                        line[1] == '\r' || line[1] == '\n')) {
> +                               line++;
> +                               len--;
> +                       }
>                 }

And this is inside the check for 'o->flags.dual_color_diffed_diffs',
so that is protected against other diffs.

Thanks,
Stefan

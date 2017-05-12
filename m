Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8DB201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbdELW2O (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:28:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:32941 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbdELW2N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:28:13 -0400
Received: by mail-it0-f67.google.com with SMTP id l145so6335403ita.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zaqUvlbTTZq7uIokHyT6AAUVYtbCysgRjDeTq4V5z6U=;
        b=ECVLdn0I0PQEA+t3DmQd5y8roHifAehJcYM+kPQ7FjuPagcC6ulvN3uWsmpjZ4E3tU
         KTWZSIU/vBLoLX57JT83DodAz3srVfdutBxNRsgIXbVbqDnM0R1YDy+kHVXdSHqTZ6gw
         +fQdbE+FOwO/tHi9iM6W5W8kFrAwrmNfE30RovgUPUCYjSdN7fqfn9X+PMa63A8lneSy
         nlGBzGkhbGdN44Ll+MC3LyKhQDdb2AvmvtMKVZxD8SDnxgt7N728OWpEUjCZri2Se0Ms
         6xar0fOYTDiGh0qIEdKlrmR3gCgGSd5KwKFb7kgJCZaNsG4Dl1JvuBkRB4/PMGe81GQ/
         vJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zaqUvlbTTZq7uIokHyT6AAUVYtbCysgRjDeTq4V5z6U=;
        b=gcgdt5ArIQ7WZtz6byWD1AiqptyUDQPIqVGAhMcQS22cVhxWI3SDsXAMUttDLYC1xK
         JaPPT+wuvzjWI2ItmIp3PqCm11PBWmQKqetRHrCP/sFXkgC1sFb6NGe3fSEaIeaZibSD
         ZlOTIPImrHjkaTtzc7+paD9y2kPcd5KOJxc3eO39UsLNb5n4eMoGnRy0KjHouuobZsco
         1yypDInGcr2Ie8QF7ny+Xo92+tDGaJAk0y+JcwGRyrh1eWLgVzUjn9oopvQuPJzIOVXb
         ry8/DfxiX0FZN4x172nS4GGrO338suqt1fMgzQsAVxnhpizOCtySe4SOPqkn7nBfnmUi
         h2+A==
X-Gm-Message-State: AODbwcCa7tnmqu5Tr9aDRu5q6ja82yuzVQDNyIm0pjibmHNYbitc9SsA
        lQMJ34XUAD80QPl6C2YaKE97BAzDtg==
X-Received: by 10.36.138.131 with SMTP id v125mr5925309itd.66.1494628092370;
 Fri, 12 May 2017 15:28:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 12 May 2017 15:27:51 -0700 (PDT)
In-Reply-To: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 00:27:51 +0200
Message-ID: <CACBZZX4UUwzRQmyH8joYaqHnuVTjVtGBHp+iZKcnAnwoM_ZJhg@mail.gmail.com>
Subject: Re: [PATCH] compat/regex: fix compilation on Windows
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 3:50 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The real issue here is that GNU awk's regex implementation assumes a bit
> too much about the relative sizes of pointers and long integers. What they
> really want is to use intptr_t.
>
> This patch recapitulates what 56a1a3ab449 (Silence GCC's "cast of pointer
> to integer of a different size" warning, 2015-10-26) did to our previous
> copy of GNU awk's regex engine.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/compat-regex-fixes-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git compat-regex-fixes-v1
>
>  .../0003-Use-intptr_t-instead-of-long.patch        | 22 ++++++++++++++++++++++
>  compat/regex/regcomp.c                             |  4 ++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>  create mode 100644 compat/regex/patches/0003-Use-intptr_t-instead-of-long.patch
>
> diff --git a/compat/regex/patches/0003-Use-intptr_t-instead-of-long.patch b/compat/regex/patches/0003-Use-intptr_t-instead-of-long.patch
> new file mode 100644
> index 00000000000..246ff256fb8
> --- /dev/null
> +++ b/compat/regex/patches/0003-Use-intptr_t-instead-of-long.patch
> @@ -0,0 +1,22 @@
> +diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
> +index 5e9ea26cd46..e6469167a80 100644
> +--- a/compat/regex/regcomp.c
> ++++ b/compat/regex/regcomp.c
> +@@ -2641,7 +2641,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
> +     old_tree = NULL;
> +
> +   if (elem->token.type == SUBEXP)
> +-    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
> ++    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
> +
> +   tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
> +   if (BE (tree == NULL, 0))
> +@@ -3868,7 +3868,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
> + static reg_errcode_t
> + mark_opt_subexp (void *extra, bin_tree_t *node)
> + {
> +-  int idx = (int) (long) extra;
> ++  int idx = (int) (intptr_t) extra;
> +   if (node->token.type == SUBEXP && node->token.opr.idx == idx)
> +     node->token.opt_subexp = 1;
> +
> diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
> index 5e9ea26cd46..e6469167a80 100644
> --- a/compat/regex/regcomp.c
> +++ b/compat/regex/regcomp.c
> @@ -2641,7 +2641,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
>      old_tree = NULL;
>
>    if (elem->token.type == SUBEXP)
> -    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
> +    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
>
>    tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
>    if (BE (tree == NULL, 0))
> @@ -3868,7 +3868,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
>  static reg_errcode_t
>  mark_opt_subexp (void *extra, bin_tree_t *node)
>  {
> -  int idx = (int) (long) extra;
> +  int idx = (int) (intptr_t) extra;
>    if (node->token.type == SUBEXP && node->token.opr.idx == idx)
>      node->token.opt_subexp = 1;
>
>
> base-commit: 4e23cefb4da69a2d884c2d5a303825f40008ca42
> --
> 2.12.2.windows.2.800.gede8f145e06

Let's drop this current gawk import series.

After talking to the gawk author it turns out it's better to use the
version from gnulib, this includes the equivalent of your patch.

The following one-liner works for me on linux to import that library,
on the master branch:

$ git reset --hard; rm compat/regex/*.[ch]; rm -rfv /tmp/git.rx; test
-e /tmp/git-gnulib || git clone
https://git.savannah.gnu.org/git/gnulib.git /tmp/git-gnulib; mkdir
/tmp/git.rx; touch /tmp/git.rx/configure.ac;
/tmp/git-gnulib/gnulib-tool --lgpl --add-import --dir=/tmp/git.rx
regex; cp /tmp/git.rx/lib/{intprops.h,reg*} compat/regex/; perl -0666
-pi.bak -e 's[compat/regex/regex.o: EXTRA_CPPFLAGS =
\K[^\n]+\n[^\n]+][]s' Makefile; echo '#define _GNU_SOURCE'
>compat/regex/config.h

I.e. remove the existing engine, import new one from gnulib, then wipe
the extra -D flags that exist now, and define _GNU_SOURCE.

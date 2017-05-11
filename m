Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7CB20196
	for <e@80x24.org>; Thu, 11 May 2017 14:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbdEKOal (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 10:30:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36850 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933095AbdEKOak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 10:30:40 -0400
Received: by mail-it0-f65.google.com with SMTP id z15so1724656ite.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o4ZI9grO5MX9yZrAony+g5LeCdGmquQ1fvKI4A1TOwM=;
        b=FFA657rkn7Ysz0DBhibLhY2HXzV0VhF2oeQ7wAhLKiIPMmeOJwxfa8IfnxFe5bEe8p
         kptu6ofuGstwovElon0rvp6ewO13NdrHE4gVne+VL9114dKIew1Y1mWZ+Ez4EES9aOdi
         PCSDrBZe7KFOdb47HNaAK8PeyqaY0T7fC/6ZmAl5bys9XFUD0aE3lGggfVvGYiUkkqwc
         3S+izgdRcuj803d1J5RG91cpXK0jvwjIS2nPaPTfXipguW+iOLeusKBtOywZoI8h0Dtk
         oRD1CZVZAoHfnyEhB2xEdaMqJA8ZQ23tv+UxhYDbzngysw8a16ba48Q7oKIy+huG1rV6
         GsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o4ZI9grO5MX9yZrAony+g5LeCdGmquQ1fvKI4A1TOwM=;
        b=I07St7FsDjl7qP4Qto1R7nmqrTBlR4Th3u6DU7J0mDqCnP+75TRGwFs9tIhFKy7zDs
         88kCH7i+ujo0V+UvVey02maCA64KtrFGyf+iC+GqvbWZm2a5xGst2LOLqhAq8wtdYLvn
         mAX1s+APH7vQgWzoy7i6cCn7e66kEtPQkBI8otH5BUsrMPqxQDcKiEhZ34wLmTh1VxLN
         /f/2u1KyVRVuUB+HGS754/htTqCMBzcOkY7JnKcFMRWErYG0/kTF3hNK3zuHSV6i8skR
         KW8M+0f98WwA1kNiA1Tvc+0pPsSpXEuLTc2ZJsRUgSGMW25VK+yDBMg+6/Ql/zIIsOI+
         U5mg==
X-Gm-Message-State: AODbwcD3OCZfR+/9wwMpGY5LmdHE1+KmwzDnCr+j0v22rnYzPUUbdaAN
        54igAfrCwRH+rd8ogef5TYG0qSUxdpXR1p0=
X-Received: by 10.36.166.4 with SMTP id q4mr1339705ite.66.1494513034445; Thu,
 11 May 2017 07:30:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 07:30:13 -0700 (PDT)
In-Reply-To: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 16:30:13 +0200
Message-ID: <CACBZZX7i4Sz2w1obCVEKKoq+a+SmzkJ6AYDvaVQgkGRGDU+rng@mail.gmail.com>
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

Thanks, looks good!

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

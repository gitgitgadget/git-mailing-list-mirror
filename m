Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E321F404
	for <e@80x24.org>; Tue,  6 Mar 2018 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeCFUmh (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 15:42:37 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40291 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753504AbeCFUmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 15:42:36 -0500
Received: by mail-qt0-f193.google.com with SMTP id y6so26185315qtm.7
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yPHlM+ShLXsDd3vUb41/I+wt4PgOr3uxipAbQg6Kjv4=;
        b=W3LVvke8nuMsxJB2N9hTz5RddzJuGC734kAZCJaiLIPFSZjoOPn1o13BiOd3rjUAM3
         p4Vy3soaE4YulcBQON5hp2rTcZwhaOQJ6yzdQ43AODOzFrCAa95kxKyq3L82xCHXeQ70
         Kf3sULspZLecBw4IJxldj58Y+dwv23spH8ZQ8DngTiUDVpp84NKznBaOT3EXFBoPu3lI
         9KqV7zd6LXP+rSKGX9+rZ0BvnEy/cZ1xflo4HG7XnuvbuiuGCGN9uDR9U+sebSu2sUfG
         9AzMc/NzJdSPkaJnJB5u91msCguRolCztBRjjkk9j0osplKtccVVPfLC7EFBlXp6S018
         ALHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yPHlM+ShLXsDd3vUb41/I+wt4PgOr3uxipAbQg6Kjv4=;
        b=ls7khXr/lEYTDdGrX5oOdnBeXmuVmXIXB/rVVYsDnPrp9YJkJI74n1UMWTwiWHmXp2
         oHoWwWsRAYPsJuoBz4nSZxwths8HmUwTzLtYUloMAZFvnw2svSjnCDzUoWnPmfNa0b/M
         RjHguJY4ICWHPpPvzrZ5xlGo3KxNNz2XjXG8yX6bIhoR1csXYE7OPbc40+J8HP1CLjT4
         nun8h6nec6p81Y9fo3fzmBC5Z6gA9aey4+zPNtnaLjVYjANeHxqdAV0Lf0+94l7r1DiH
         H85VwF182iXMLyJ2Ziv1XrcNE8X8uswr+TLPpp0iM23TG+jRh+BcQUIafr+plFpVTZWH
         H2ow==
X-Gm-Message-State: AElRT7Gck+8vyUsQdMPo2W+U9bbvwL0g0OPWxudc6YpDr854Gok/rnTw
        Jg6RRr83Wg8rhpf0SMyXnlZC9nxPMnBnU0lhjlA=
X-Google-Smtp-Source: AG47ELuqgvaS5f/BEoqcTCoovvwZoNFWRSyzZlmb17l35iS5vMyfK/ncPTj9wnOElFHHUTtsDW+nXvl0/Ghx+8AM4ec=
X-Received: by 10.200.6.5 with SMTP id d5mr31218841qth.205.1520368955778; Tue,
 06 Mar 2018 12:42:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Tue, 6 Mar 2018 12:42:35 -0800 (PST)
In-Reply-To: <20180304201418.60958-6-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com> <20180304201418.60958-6-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Mar 2018 15:42:35 -0500
X-Google-Sender-Auth: yPgNS9YjLBPewtdNC6ch72eecVQ
Message-ID: <CAPig+cTOpBODeoHV=+4-4MEjKM=pUrZSa=BEmHh4mVP=xPpFCA@mail.gmail.com>
Subject: Re: [PATCH v9 5/8] convert: add 'working-tree-encoding' attribute
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 3:14 PM,  <lars.schneider@autodesk.com> wrote:
> Git recognizes files encoded with ASCII or one of its supersets (e.g.
> UTF-8 or ISO-8859-1) as text files. All other encodings are usually
> interpreted as binary and consequently built-in Git text processing
> tools (e.g. 'git diff') as well as most Git web front ends do not
> visualize the content.
> [...]
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/convert.c b/convert.c
> @@ -978,6 +1051,25 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
> +static const char *git_path_check_encoding(struct attr_check_item *check)
> +{
> +       [...]
> +       /*
> +        * Ensure encoding names are always upper case (e.g. UTF-8) to
> +        * simplify subsequent string comparisons.
> +        */
> +       return xstrdup_toupper(value);

xstrdup_toupper() allocates memory...

> +}
> @@ -1033,6 +1125,7 @@ struct conv_attrs {
>         enum crlf_action attr_action; /* What attr says */
>         enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
>         int ident;
> +       const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */

...which is assigned to 'const char *'...

>  };
> @@ -1064,6 +1158,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>                         else if (eol_attr == EOL_CRLF)
>                                 ca->crlf_action = CRLF_TEXT_CRLF;
>                 }
> +               ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);

...by this code, and eventually leaked.

It's too bad it isn't cleaned up (freed), but looking at the callers,
fixing this leak would be mildly noisy (though not particularly
invasive). How much do we care about this leak?

>         } else {
>                 ca->drv = NULL;
>                 ca->crlf_action = CRLF_UNDEFINED;
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
> @@ -0,0 +1,135 @@
> +test_expect_success 'check $GIT_DIR/info/attributes support' '
> +       test_when_finished "rm -f test.utf8.raw test.utf32.raw test.utf32.git" &&

It seems weird to be cleaning up files this test didn't create
(test.utf8.raw and test.utf32.raw).

> +       test_when_finished "git reset --hard HEAD" &&
> +
> +       echo "*.utf32 text working-tree-encoding=utf-32" >.git/info/attributes &&
> +       git add test.utf32 &&
> +
> +       git cat-file -p :test.utf32 >test.utf32.git &&
> +       test_cmp_bin test.utf8.raw test.utf32.git
> +'
> +
> +test_expect_success 'check unsupported encodings' '
> +       test_when_finished "rm -f err.out" &&
> +       test_when_finished "git reset --hard HEAD" &&

Resetting to HEAD here is an important cleanup action, but tests don't
usually clean up files such as 'err.out' since such detritus doesn't
usually impact subsequent tests negatively. (Just an observation; no
re-roll needed.)

> +       echo "*.nothing text working-tree-encoding=" >>.gitattributes &&
> +       printf "nothing" >t.nothing &&
> +       git add t.nothing &&
> +
> +       echo "*.garbage text working-tree-encoding=garbage" >>.gitattributes &&
> +       printf "garbage" >t.garbage &&
> +       test_must_fail git add t.garbage 2>err.out &&
> +       test_i18ngrep "fatal: failed to encode" err.out
> +'

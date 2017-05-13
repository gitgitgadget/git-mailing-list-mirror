Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980B320188
	for <e@80x24.org>; Sat, 13 May 2017 17:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756291AbdEMRlo (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 13:41:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34493 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756164AbdEMRlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 13:41:42 -0400
Received: by mail-it0-f67.google.com with SMTP id c26so8629718itd.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ui8zoyI15WNVj0xLk533jVqd0vdBkVhaOuqziOYoL70=;
        b=KwlBE91Rw/1dYbR55sHJX/SxrcC+13ufZgiHaS1Zxp7Zxm/ZmmiKjFnu8XYxIEmDvX
         IQa9RSlqpGsGnnsDEejHXV1uxTUhZdFyUtlkacp5SuBMeQbHOrXqQfrFKfGxg5Zgsqma
         HglxXGw44EB5L1JHaJ9x5T6lrUcDuvdkue4aRy9CX66P9Gvfxaf9WHyqBHcv18EfENbU
         6PvY+YWHKq0d6y5gusyyMvwbFU8Z3wIv9okKD3MZ2KP5HaO50fmb4psCHRr3t/Nwk0XA
         wU753TJaQ31l0pwX+gXUy/jmS4N+1GfUYa9V8EmjCaXcLe1OAZNwF6k82eTjRQrWHGTc
         01LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ui8zoyI15WNVj0xLk533jVqd0vdBkVhaOuqziOYoL70=;
        b=CD4+o+yuN6xb7ci21yfjJiaT+Odv7Ih0GM7waCS3+dnz9Y4AKySRDziGFfYnD12g86
         VP80Yvkt8T46RuzWQ7vM8RfN/IPrGsUSGbO6hr7tyVzkHG0bKZ3Md2k5PdAR3jOM80Pp
         DsQp46+9vYG+TH2wN1wEFMA6sOMn2Qc6RXuOKZL60pMhL04NRZND4NVduJf8JkFBJSvD
         8e7Uk05DHahQ8h74k9uX6TclWWQBIrvppKwmThUG55d8wNzUW2/bGAYfBiIZD8vseDCP
         KeFaT5fkiTFC4ru8vNq2twxc+HsifDpcI2I08UR0snN08tHDRQhIYcRKvI7M+NnAsrMx
         5uPg==
X-Gm-Message-State: AODbwcDh3+3S6rocEnNxK7CS3bBisqj+DpAhNIBdD3nsyhLiVpUxS8Ea
        WIZ4y5/CZ8XpaF0CES82hskRDIJsog==
X-Received: by 10.36.89.207 with SMTP id p198mr2371442itb.71.1494697301583;
 Sat, 13 May 2017 10:41:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 10:41:20 -0700 (PDT)
In-Reply-To: <1360664260-11803-4-git-send-email-drafnel@gmail.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com> <1360664260-11803-4-git-send-email-drafnel@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 19:41:20 +0200
Message-ID: <CACBZZX543mhEDEZ78KH=GU++u0Gq=YGt-WXye1nSC=EirRiO-g@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] t/test-lib-functions.sh: allow to specify the
 tag name to test_commit
To:     Brandon Casey <drafnel@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <bcasey@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2013 at 11:17 AM, Brandon Casey <drafnel@gmail.com> wrote:
> The <message> part of test_commit() may not be appropriate for a tag name.
> So let's allow test_commit to accept a fourth argument to specify the tag
> name.

[Kind of late to notice, I know]

I see nobody spotted in four rounds of reviews that this commit didn't
update the corresponding t/README docs for test_commit.

> Signed-off-by: Brandon Casey <bcasey@nvidia.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  t/test-lib-functions.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index fa62d01..61d0804 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -135,12 +135,12 @@ test_pause () {
>         fi
>  }
>
> -# Call test_commit with the arguments "<message> [<file> [<contents>]]"
> +# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
>  #
>  # This will commit a file with the given contents and the given commit
> -# message.  It will also add a tag with <message> as name.
> +# message, and tag the resulting commit with the given tag name.
>  #
> -# Both <file> and <contents> default to <message>.
> +# <file>, <contents>, and <tag> all default to <message>.
>
>  test_commit () {
>         notick= &&
> @@ -168,7 +168,7 @@ test_commit () {
>                 test_tick
>         fi &&
>         git commit $signoff -m "$1" &&
> -       git tag "$1"
> +       git tag "${4:-$1}"
>  }
>
>  # Call test_merge with the arguments "<message> <commit>", where <commit>
> --
> 1.8.1.3.579.gd9af3b6
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

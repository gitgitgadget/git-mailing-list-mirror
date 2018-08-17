Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15DA61F954
	for <e@80x24.org>; Fri, 17 Aug 2018 15:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeHQSeI (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 14:34:08 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33049 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeHQSeI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 14:34:08 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so1859498itj.0
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n6Jor3cYRGQlILzlpBlXQiP3A4xxgyjjxxEwESnuXNo=;
        b=MY4YPnLwQW58IJ9WCHnH7pS+yosWKepONgTZkdPR4wcdtlduWeCxik+wmp8+BqpI4s
         E/IUCd3M4zwHXUXwMC2+tZdppXLGeus0WjeBwwtjtVUM73QUfIJa51RqoMB6Md21uuJQ
         w+YHdGEwqZP5nTe0zgEB0ognnTeRzKEbcSx0n3FcI9ebbUTRjD+ituna4mlmxlYx4vVQ
         s+d2xG6t25DregkO/q8EySJWG+ndr8zzxrmxz7YGm40wUdyZ+zl1TeVK7KBD3jrsXExu
         P51mu9Gnpn56qBU5IwEKKRugTNGb2ILRW+wt1/Euw0TBcz3AfvzA7GcB5ETglp0ExlfG
         UCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n6Jor3cYRGQlILzlpBlXQiP3A4xxgyjjxxEwESnuXNo=;
        b=D2g+CHVyaq/UvaR5BZF9hRBaoDPNVjOtpE+HELQXrM4JnBGKVv+AnDATmUU3UbcVD6
         OspLGbm5vqZfveQreUPAuucCdDjDaK33Bc7glij4dFxjXLSvqoOl8EomAjYDDvX60O4y
         Pjx9nFuT6tW/ApyUfTNd8SDjBx+6jfPYwJdwCKCWRgFoFkl0+HFT5/xpnFVJO5MS3GIO
         knAmACF/zSmCaon1/xAYDoHUZNYcSbJ91a3Cl+xETTHTFjtxBZWn/Cl0ctCmVjnEd3Ch
         GoO0bPdUqNPY1EVtz3RkD7E02TIV91fZZb/pua4WzxwWUrGiL6tJeO4evKcC8EpZGIjd
         MZdw==
X-Gm-Message-State: AOUpUlGEgwo0vUnNSjjp4Zaj0joWlYZ1N5wPgMisIvuT1cXtcELvU7sd
        h/ZEbjZGjqMs8BEL5dwbsnr4JQnytIfiTUqkDFbbew==
X-Google-Smtp-Source: AA+uWPyBx7pRzTbjDLXHyJfReJE/nK2xZDu1JjmTHgsjPzTYv7rw35tLV8y3Dp1x0X9+OW9qEi9Mt9w4FB0kDJtyYYA=
X-Received: by 2002:a02:c99:: with SMTP id 25-v6mr1045946jan.97.1534519819867;
 Fri, 17 Aug 2018 08:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8AYQL3oDLyt14eJ1emynngqKQv9GXju56gU9u4mHrFHOg@mail.gmail.com>
 <20180816155647.10459-1-pclouds@gmail.com> <xmqqin4afdoj.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C2r5y0m88yrRQHQ-_QNXemy2pfcjxYK0zSd0J3fFy3rQ@mail.gmail.com> <xmqqefexc8vm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefexc8vm.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 17:29:53 +0200
Message-ID: <CACsJy8BmvT5JqckDqA8d_3EwZsav3QPDvHX2o4aWJNJNscQ9kg@mail.gmail.com>
Subject: Re: [PATCH] config.txt: clarify core.checkStat = minimal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 5:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> -- >8 --
> Subject: [PATCH] config.txt: clarify core.checkStat
>
> The description of this key does not really tell what the 'minimal'
> mode checks and does not check.  The description for the 'default'
> mode is not much better and just says 'all fields', which is unclear
> and is not even correct (e.g. we do not look at 'atime').
>
> Spell out what are and what are not checked under the 'minimal' mode
> relative to the 'default' mode to help those who want to decide if
> they want to use the 'minimal' mode, also taking information about
> this mode from the commit message of c08e4d5b5c (Enable minimal stat
> checking - 2013-01-22).

Looking good. This does make me want to adjust $GIT_DIR/index format
to optionally not store extra fields if we know we're not going to use
them. But that's a topic for another day.

> Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a9..933d719137 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -449,10 +449,20 @@ core.untrackedCache::
>         See linkgit:git-update-index[1]. `keep` by default.
>
>  core.checkStat::
> -       Determines which stat fields to match between the index
> -       and work tree. The user can set this to 'default' or
> -       'minimal'. Default (or explicitly 'default'), is to check
> -       all fields, including the sub-second part of mtime and ctime.
> +       When missing or is set to `default`, many fields in the stat
> +       structure are checked to detect if a file has been modified
> +       since Git looked at it.  When this configuration variable is
> +       set to `minimal`, sub-second part of mtime and ctime, the
> +       uid and gid of the owner of the file, the inode number (and
> +       the device number, if Git was compiled to use it), are
> +       excluded from the check among these fields, leaving only the
> +       whole-second part of mtime (and ctime, if `core.trustCtime`
> +       is set) and the filesize to be checked.
> ++
> +There are implementations of Git that do not leave usable values in
> +some fields (e.g. JGit); by excluding these fields from the
> +comparison, the `minimal` mode may help interoperability when the
> +same repository is used by these other systems at the same time.
>
>  core.quotePath::
>         Commands that output paths (e.g. 'ls-files', 'diff'), will
> --
> 2.18.0-666-g63749b2dea
>


--=20
Duy

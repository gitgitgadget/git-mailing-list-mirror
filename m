Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C5F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 15:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031195AbeBNPPs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 10:15:48 -0500
Received: from mail-ua0-f176.google.com ([209.85.217.176]:45010 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031183AbeBNPPq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 10:15:46 -0500
Received: by mail-ua0-f176.google.com with SMTP id x4so13842847uaj.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=upfHo752HxkmU0r+Uip+qIxKMK1wdO1bAO4tfxEcxmo=;
        b=r6R/hhOcQps0uLNnABYrL9sNcTBgI5NbK0BJKV2euQxPIaEN/vPohGPk7F/lkFuNb0
         Lr0AWpcAF6tqFr0CaOg8oH5kF5QjncGsTGXbYbTWVbg/TxayHFpuDpWecoUBD9iX3Rtm
         oW1+aD0s1LQvRjtWcGDn1k6neb6lzRkgFU51MRvZcS6TfmmBvF5oFi3VhPEIakitOuTH
         /P5d2EvpcgXj+HqjhytTQ5Njl4AA1L/Ca8gI5dx8YMfIUpZ7jY20L+NyM5SNJqQcwgNP
         L6a/7oa89eQGonCINZcCJ/7SZn85iZl4xDwCz6Xqb3kEVTNmBpDmTnNUsX+OuMSTj5WL
         uRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=upfHo752HxkmU0r+Uip+qIxKMK1wdO1bAO4tfxEcxmo=;
        b=c8JaWPP2IB+Nx8TyM6d0L3tHVAqNaPuNCh0KOrd1gCEFZo+FK15FEg52m1YBua7/OG
         /1zEsQKA2U7sZSPg8Te52HKbBUlXNVN8LZoZamNF2R/7BaMHDBTbEVbfvun3GnzDFt4M
         6vhE4V3UQsESdq0hKFk62ky3dYPg5qLODVxxqppgbDXewmhWPJsfEd0+vwEo9unRAvwo
         euYUQG5SCoqnF8V2UTyLg1iozpOBOVQsGauiXBFJh1XY3XExoMc7oVCSnWTnDQsgtd4q
         M4J0lDD9oyHeZEVUBL25JceZev58xRWpsWnOO72OrBJ3NBFUwGBTbAsRI4NYj3opF1pl
         VbBQ==
X-Gm-Message-State: APf1xPBjNr8+ikX1S7/FkVsZbYBUiXcPsP+IptLZuuvMQyGgbXvGYX3u
        KgODolUKgt0AU+2IdoovbysKZqu9tGqlsD6T3LkPFA==
X-Google-Smtp-Source: AH8x2270yNGVr/ndKfvpeTVNELgnxO/B8GaHxpjzktBMV+0oXB1MeKk2MWmUYyZUzgMCq2UOLFVeByhOSKJIz4ubbQ8=
X-Received: by 10.176.11.141 with SMTP id c13mr5177775uak.94.1518621345854;
 Wed, 14 Feb 2018 07:15:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 14 Feb 2018 07:15:45 -0800 (PST)
In-Reply-To: <20180209110221.27224-30-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-30-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 14 Feb 2018 16:15:45 +0100
Message-ID: <CAM0VKjkOpQ-bxQJ0FQtqOycKQEfEHywVEuwAQyKRZs9VsDtb1w@mail.gmail.com>
Subject: Re: [PATCH v3 29/42] completion: use __gitcomp_builtin in _git_notes
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 12:02 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index c7b8b37f19..60127daebf 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1835,7 +1835,7 @@ _git_notes ()
>
>         case "$subcommand,$cur" in
>         ,--*)
> -               __gitcomp '--ref'
> +               __gitcomp_builtin notes
>                 ;;
>         ,*)
>                 case "$prev" in

Hmm, after this patch is applied, this part of _git_notes() looks like
this:

        case "$subcommand,$cur" in
        <skip>
        ,*)
                case "$prev" in
                --ref)
                        __git_complete_refs
                        ;;
                *)
                        __gitcomp "$subcommands --ref"
                        ;;
                esac
                ;;

Note that '--ref' option passed to __gitcomp() along with the
subcommands.

It would be great if that option could come from parse options as well,
but we can't rely on $__gitcomp_builtin_notes being already initialized
at this point and the current __gitcomp_builtin function tightly couples
initializing that variable and completing options.

It would be even greater, if all the subcommands could come from parse
options as well, but not sure how that would fit into parse options,
because subcommands are, well, not --options.

There are only a few commands with subcommands whose main command
accepts an --option, too; I could only find 'notes', 'remote', 'stash'
and 'submodule'.  The latter two are scripts, and for 'remote' we don't
offer its '--verbose' option along with its subcommands, but perhaps we
should.  Anyway, considering that there are only two such cases at the
moment, I think we could live with that two hard-coded options.

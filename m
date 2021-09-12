Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28953C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 04:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1881610CE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 04:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhILErQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 12 Sep 2021 00:47:16 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:33365 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhILErQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 00:47:16 -0400
Received: by mail-ej1-f43.google.com with SMTP id x11so13211131ejv.0
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 21:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pOlP8mVt277hqGcFjS+/Imhn0DppMYpNF1+ZVXMOxJg=;
        b=TfvQQvFhTNHIaFWuth3noU9n4qUL2qMy02MXBa3z1Ns3Cz8EjheCRD6NcvuD31kcQD
         Mg9tAmgmj4qvPwKE++ZaXeHhBsRBJXmnz9zh4HZx8AnVMcaxo/oIjd3d5WERzLlvLjy6
         uYyPXYdDvCa64qtViRoLE25jwi3DZeES3VMhHKY5og3kbcdw/P8XgObzaNGSByh9Eghr
         02Kz6Z08tEeq4T4eNWykvnoXcQSztwXbIlnK4rU0p9W469ewfCpyGOyppfNfXngxrUmd
         vgH3GO076CXlxjdra8NCp16vZNurVsnWnNAjk90q3wGenAuCXFNkHC5zM8pKpL0sZ3Ls
         c7fA==
X-Gm-Message-State: AOAM533LpRetHE5jMQdh/fxwudTFZMZ4zTraZ9LLGjfQUVDtd6KNZJho
        9ae0hgV4ZmDxDUWxjpqd/20i252gcbWLWBlB5H0=
X-Google-Smtp-Source: ABdhPJzaQjGnLdjpEzv8TKIjMkn/Z+qTfaQdaMRR01Bx6GZuVrFcK0Kawddpf7KIXYSDXIehnwtnYTctPlawrlPTRTg=
X-Received: by 2002:a17:906:4691:: with SMTP id a17mr5679826ejr.36.1631421961708;
 Sat, 11 Sep 2021 21:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com> <patch-v3-2.6-036eb0efb5b-20210911T190239Z-avarab@gmail.com>
In-Reply-To: <patch-v3-2.6-036eb0efb5b-20210911T190239Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Sep 2021 00:45:50 -0400
Message-ID: <CAPig+cRzzMEFKMEW1dMB=Y++kuoFUnLgRatV7_hFZ5BnSbpD+A@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] blame: replace usage end blurb with better option spec
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 3:10 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change the "git blame -h" output to be consistent with "git bundle
> -h"'s, i.e. before this we'd emit:

Just a couple tiny, tiny nits (which may or may not be worth a re-roll)...

>     $ git blame -h
>     usage: git blame [<options>] [<rev-opts>] [<rev>] [--] <file>
>
>         <rev-opts> are documented in git-rev-list(1)
>     [...]
>
> Now instead of that we'll emit:
>
>     $ git blame -h
>     usage: git blame [<options>] [<git rev-list args>] [<rev>] [--] <file>

This is lacking a hyphen between `git` and `rev-list`...

> This makes it consistent with the usage spec used for "git bundle":
>
>     $ git bundle -h
>     usage: git bundle create [<options>] <file> <git-rev-list args>

...whereas this has a hyphen between the two.

> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -29,12 +29,8 @@
> -       N_("<rev-opts> are documented in git-rev-list(1)"),
> +       N_("git blame [<options>] [<git rev-list args>] [<rev>] [--] <file>"),

Ditto regarding missing hyphen.

> @@ -1107,7 +1103,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>                                     nth_line_cb, &sb, lno, anchor,
>                                     &bottom, &top, sb.path,
>                                     the_repository->index))
> -                       usage(blame_usage);
> +                       usage_msg_opt(_("Invalid -L <range> parameter"),
> +                                     blame_opt_usage, options);

builltin/blame.c seems to be pretty consistent about starting error
and warning messages with a lowercase letter, so this perhaps should
follow suit. Also, I think you can drop "parameter" without losing
clarity:

    invalid -L range

would likely be good enough.

>                 if ((!lno && (top || bottom)) || lno < bottom)
>                         die(Q_("file %s has only %lu line",
>                                "file %s has only %lu lines",

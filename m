Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC7D1F404
	for <e@80x24.org>; Tue, 24 Apr 2018 10:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756745AbeDXKDh (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 06:03:37 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35189 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754574AbeDXKDg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 06:03:36 -0400
Received: by mail-pg0-f66.google.com with SMTP id j11so10497169pgf.2
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QjqHKCziEGkARcup/hLmT+UrZZP/hkmDd3CyBqh0U98=;
        b=X7a6hgGYcqbWCKDzoak1/QH1r3uZGsgNqM/JORQxAoWJyOckLNT1CIEynszT29LbRZ
         vq64h1J6ChMaKo+/E6+0K9+CJWU2Nb9ARZGrFq0K//kpg5+pkfeG7R1Y6GqGJdzcGDwt
         lxWk9GJHHSnKZjPFylqloRZyxw580XVNvxkjCkgZG+zKQsoQRzenaJCSLqoGposlxKHH
         gGSRXtTX3VDw0A+0DqI5D9g+6uGVfS7xPESTsX66+As9YuJlNmlZowVYLk/uAjW4JM7t
         C/wiTJ5jiluFQUDcHnPZ1R1rUqe4AjNTnH2pNu02GZ8j84zyAxagabqYgJTcQhNvmMl9
         ObrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QjqHKCziEGkARcup/hLmT+UrZZP/hkmDd3CyBqh0U98=;
        b=SGXnqxAUJpHLSWowvO4L074oWPK/5/cwb2uO5HLtEyujA1oiGPOLTNDVpdUboZ8QYW
         jjAcjomfUKldYgvwnmWYz4j9BgRLVSIHUMXCnwJFWuQzX4bP0NU8w/i4TP0LxBtRBaHc
         Wpjr2wt8MdKbH39UFTPSVi5RAbRXeAO2LRILStsHdMuF2h1lSpQdgVFDsk5QTm+r+Knp
         PndOtHbrluE2HsBP+GK8tvxdE76uRXELVpgyN+LfXN/aS5+ZoClqm+JuoJXqq9QrmoVI
         emCZhSLUjZwtHi+ok746sDCYNFN8oy/rZaDoa2PmW4W1x4Xs/Leb2ltt6Ex4gGDZ3+ST
         82jg==
X-Gm-Message-State: ALQs6tCGSlD5zQXXd8p88VvD9Af401E4B23r8EiYFVWqa0NjnY1ZZJov
        EFb39IOtsr0qXrnsO3PlIcP2Xd8o4NAfeuuDpTL1cor864s=
X-Google-Smtp-Source: AIpwx492lm02ZOUyO/xeFfJjlpdVQZgL8IiidwyjhMEsB+saq1tisEEqbWVcoBlHQqno/3V8wn4D+uAyjlc7iI/sqho=
X-Received: by 10.98.237.17 with SMTP id u17mr23262557pfh.78.1524564215726;
 Tue, 24 Apr 2018 03:03:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Tue, 24 Apr 2018 03:03:35 -0700 (PDT)
In-Reply-To: <20180423233951.276447-32-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net> <20180423233951.276447-32-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Apr 2018 12:03:35 +0200
Message-ID: <CAN0heSpoe7SgNZnYDHXS7ByMmh3TH+exaS40btK7pq21MZ3cEA@mail.gmail.com>
Subject: Re: [PATCH 31/41] wt-status: convert two uses of EMPTY_TREE_SHA1_HEX
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 April 2018 at 01:39, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Convert two uses of EMPTY_TREE_SHA1_HEX to use oid_to_hex_r and
> the_hash_algo to avoid a dependency on a given hash algorithm.  Use
> oid_to_hex_r in preference to oid_to_hex because the buffer needs to
> last through several function calls which might exhaust the limit of
> four static buffers.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  wt-status.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 50815e5faf..857724bd60 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -600,10 +600,11 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>  {
>         struct rev_info rev;
>         struct setup_revision_opt opt;
> +       char hex[GIT_MAX_HEXSZ + 1];
>
>         init_revisions(&rev, NULL);
>         memset(&opt, 0, sizeof(opt));
> -       opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
> +       opt.def = s->is_initial ? oid_to_hex_r(hex, the_hash_algo->empty_tree) : s->reference;
>         setup_revisions(0, NULL, &rev, &opt);
>
>         rev.diffopt.flags.override_submodule_config = 1;
> @@ -975,13 +976,14 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>         struct setup_revision_opt opt;
>         int dirty_submodules;
>         const char *c = color(WT_STATUS_HEADER, s);
> +       char hex[GIT_MAX_HEXSZ + 1];
>
>         init_revisions(&rev, NULL);
>         rev.diffopt.flags.allow_textconv = 1;
>         rev.diffopt.ita_invisible_in_index = 1;
>
>         memset(&opt, 0, sizeof(opt));
> -       opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
> +       opt.def = s->is_initial ? oid_to_hex_r(hex, the_hash_algo->empty_tree) : s->reference;
>         setup_revisions(0, NULL, &rev, &opt);

Just a thought: Maybe it would make sense to have a function
`oid_hex_empty_tree()` or similar to replace the
oid_to_hex[_r](the_hash_algo->empty_tree) idiom. It would help avoid the
buffer here, but also get rid of a few instances of code peeking into
the_hash_algo. I dunno.

I've been scanning this series semi-sloppily up to here, and left some
comments along the way.

Thank you for working on this.

Martin

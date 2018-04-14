Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6721F404
	for <e@80x24.org>; Sat, 14 Apr 2018 18:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbeDNSdv (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 14:33:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38554 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeDNSdu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 14:33:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id h3so3063134wrh.5
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ogFmiDoUYD24DGYXn/qbBNDTUJnBShSzmUS0XdBoy+o=;
        b=h17bUM53ngtSRCd5d6rDRKIPjg/bvGT19vEriDnPI2hrpE1JPieTMVk6qnxcn54tpj
         p2f3jrAgr8HSFQ1ftqEXkZmIIIxVLGmILaZCsg2UiUa8oA7XZDzYBfpS2/Cez5EGVEFX
         TaGb/HXNM4qTmcKGNGqelCSYJzVVS8y1AJKG05mba2xwM1F5IviepWf342Bcqvthzr0O
         NTYhoNdbdo6dCx2bpMNxn+ApIbLUUA7mGfIQKysjlzUlWothsLRPJj5fWdbFVpMUndvc
         kG9HwciOXF+yoQCPvcgtMvLUWHCCfuvjes2bp/tMRuip71+EDreTm8SbnvUyL5p+yS+b
         h1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ogFmiDoUYD24DGYXn/qbBNDTUJnBShSzmUS0XdBoy+o=;
        b=tOpSrfM5sH/wqEX4j1HAhTx6wrgJom5NVpzcSzOgcQhzEQeaFc+eggyfp3EdHPP+ri
         QzZXxXi3c9EQUYk1o/v/+2xUtznPoUhcwdDXPqm5tEbsiYGS7d6pdF92j71XGChU7lTu
         SB9aj0m7DpTD2da9SnL3p8206SwsTZCkIF5XGAxivuBBSHS8kutxmEa0yBS+6obO3BgB
         FD8NAv63FC0xvia/qkgiwjca0+bpDO8p1pKZCX0UlpUpCiuBZv/vyeYIt8kk05/5Fiv9
         XlUlVWefocdDbi5PWr89C/z+53em1OCsLBRrBCbOaENlgpUY+EpfYXxWC6rttdPoq5EC
         7cuQ==
X-Gm-Message-State: ALQs6tCvZeECYTcy2t/t5+uZwpGoGcOlEPN9GxNI3BQynf005TALMLco
        CoyL1L/WJVw8k5f3XutVJXU=
X-Google-Smtp-Source: AIpwx4+1vh24v/yddbzVVJa1CLt7bJYwMvQGTXI91CRgO0qQYfpSYV0pK7OioDELkMMjQh6Odsk1jA==
X-Received: by 10.223.225.76 with SMTP id f12mr6550419wri.128.1523730829129;
        Sat, 14 Apr 2018 11:33:49 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egm16.neoplus.adsl.tpnet.pl. [83.21.76.16])
        by smtp.gmail.com with ESMTPSA id 185sm6609772wmj.46.2018.04.14.11.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Apr 2018 11:33:47 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v8 09/14] commit-graph: add core.commitGraph setting
References: <20180402203427.170177-1-dstolee@microsoft.com>
        <20180410125608.39443-1-dstolee@microsoft.com>
        <20180410125608.39443-10-dstolee@microsoft.com>
Date:   Sat, 14 Apr 2018 20:33:43 +0200
In-Reply-To: <20180410125608.39443-10-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 10 Apr 2018 08:56:03 -0400")
Message-ID: <86h8odljso.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit graph feature is controlled by the new core.commitGraph config
> setting. This defaults to 0, so the feature is opt-in.
>
> The intention of core.commitGraph is that a user can always stop checking
> for or parsing commit graph files if core.commitGraph=3D0.

This is bool-valued setting, so the commit message should talk about
'true' and 'false', not '1' or '0'.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config.txt | 4 ++++
>  cache.h                  | 1 +
>  config.c                 | 5 +++++
>  environment.c            | 1 +
>  4 files changed, 11 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4e0cff87f6..e5c7013fb0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -898,6 +898,10 @@ core.notesRef::
>  This setting defaults to "refs/notes/commits", and it can be overridden =
by
>  the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>=20=20
> +core.commitGraph::
> +	Enable git commit graph feature. Allows reading from the
> +	commit-graph file.
> +

This is a very minimal description of this config variable.  In my
opionion it lack two things:

1. The reference to the documentation where one can read more, for
   example linkgit:git-commit-graph[1] manpage, like in the description
   of core.sparseCheckout feature described below.

2. The information about restrictions, for example something like the
   following:

  "The feature does not work for shallow clones, neither when
  `git-replace` or grafts file are used."

   Perhaps even with references to each commit-graph disabling feature.

When the feature matures, and it will be on by default (well, the
reading part at least), it would probably acquire wording similar to the
one for `pack.useBitmaps` config option[1], isn't it?

[1]: https://git-scm.com/docs/git-config#git-config-packuseBitmaps

>  core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>  	linkgit:git-read-tree[1] for more information.
> diff --git a/cache.h b/cache.h
> index a61b2d3f0d..8bdbcbbbf7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -805,6 +805,7 @@ extern char *git_replace_ref_base;
>=20=20
>  extern int fsync_object_files;
>  extern int core_preload_index;
> +extern int core_commit_graph;
>  extern int core_apply_sparse_checkout;
>  extern int precomposed_unicode;
>  extern int protect_hfs;
> diff --git a/config.c b/config.c
> index b0c20e6cb8..25ee4a676c 100644
> --- a/config.c
> +++ b/config.c
> @@ -1226,6 +1226,11 @@ static int git_default_core_config(const char *var=
, const char *value)
>  		return 0;
>  	}
>=20=20
> +	if (!strcmp(var, "core.commitgraph")) {
> +		core_commit_graph =3D git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "core.sparsecheckout")) {
>  		core_apply_sparse_checkout =3D git_config_bool(var, value);
>  		return 0;
> diff --git a/environment.c b/environment.c
> index d6dd64662c..8853e2f0dd 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -62,6 +62,7 @@ enum push_default_type push_default =3D PUSH_DEFAULT_UN=
SPECIFIED;
>  enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MODE;
>  char *notes_ref_name;
>  int grafts_replace_parents =3D 1;
> +int core_commit_graph;
>  int core_apply_sparse_checkout;
>  int merge_log_config =3D -1;
>  int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition()=
 */

So this is just a config variable handling.  Nicely short patch to
review; the code part looks good to me.

--=20
Jakub Nar=C4=99bski

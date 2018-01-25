Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E001FADF
	for <e@80x24.org>; Thu, 25 Jan 2018 20:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeAYURH (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 15:17:07 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36597 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeAYURG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 15:17:06 -0500
Received: by mail-yb0-f194.google.com with SMTP id v12so3508496ybl.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 12:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=16vv9wrIbPPyyOOW5uF8bS/LgkVXzNPg52wLQ7o13LA=;
        b=Ku52UkdEZXUgptgQTUo8aqCYYHuffsXl8l8jjv++dZavO3QS11UvkdLBMmEL4E0loO
         YTPRB10/k2OIpa/fUDJBf/dW9kqmp+T+It5BPJ2HP98PTGT+cJVBCGPOvpoMpL10h6lR
         TfCppdFXzdnPBXItGMZ1sahI9kPk8TZIKkPGH3lEFmS6e3yK3G4hmd+lT0qqamKufQZH
         5quE1Y8MDGbw3tCZ/o13wGExeK7sAO/pSMiOUJ2x2twqDslBcYW3DieBrw+/TI1ySFlb
         ogdQVNuA23KnoMNKOL8/9/q0IYJ4n6bxpGYpyOu35sIIjqtcbiwrwxF/PuLIbdpHn2FA
         a1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=16vv9wrIbPPyyOOW5uF8bS/LgkVXzNPg52wLQ7o13LA=;
        b=un001z1EUopO3IpiR+UHUFTtBNl7HDfH12FeELKzEFqygiPxLdbZqjsUDduLMLGpRr
         GH04w3E3B39SISHkh5tWjNbc+3dqMHoRvhqB3cBAPDhP4P/1QbyjJGDw7fs+JSvqWIns
         zJZbWMV7hyclsLXjda1Z+K5VhP8NBq8BXbtJBcWlaUKKBt9Pgsu3TRkjFHE471UMCSoD
         UeUTQ4YAhHY6b0VeKYmS9KK4+wJax77EmfMB86+llHI59EJNQ6EEr13idRcvtFHaLEPN
         eWyX+GkxN9CzVEu8mx4c8I9PG2nglJu2ijsoQrYs+8wgHNtQiWrppcjcK0WVwiNwC68J
         vaNg==
X-Gm-Message-State: AKwxytcUefOiyt0ZjD0iK/uT5nFyQ6wHbM/fcxVKRSmsbk9L/foV63L2
        H5vSaIlPJp1R+cXYk3V/4jbJ5KtztGFkZemu/EMKmp0O
X-Google-Smtp-Source: AH8x227EH5uyiH/Bhx6puxRG4s4Ld5nExm4qCaTola+GwAoYXvPUL340k+pSJQg7GbnHjAORcsSv6isrejoQj/oMjL0=
X-Received: by 10.37.163.198 with SMTP id e64mr9550069ybi.438.1516911425372;
 Thu, 25 Jan 2018 12:17:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Thu, 25 Jan 2018 12:17:04 -0800 (PST)
In-Reply-To: <20180125140231.65604-3-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-3-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Jan 2018 12:17:04 -0800
Message-ID: <CAGZ79kbUr-iQghL8qXxCq7noiYR9-MrxmTB4_v3D7WyXLPwUjA@mail.gmail.com>
Subject: Re: [PATCH 02/14] packed-graph: add core.graph setting
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
> The packed graph feature is controlled by the new core.graph config
> setting. This defaults to 0, so the feature is opt-in.
>
> The intention of core.graph is that a user can always stop checking
> for or parsing packed graph files if core.graph=0.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config.txt | 3 +++
>  cache.h                  | 1 +
>  config.c                 | 5 +++++
>  environment.c            | 1 +
>  4 files changed, 10 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0e25b2c92b..e7b98fa14f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -898,6 +898,9 @@ core.notesRef::
>  This setting defaults to "refs/notes/commits", and it can be overridden by
>  the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>
> +core.graph::
> +       Enable git commit graph feature. Allows writing and reading from .graph files.
> +
>  core.sparseCheckout::
>         Enable "sparse checkout" feature. See section "Sparse checkout" in
>         linkgit:git-read-tree[1] for more information.
> diff --git a/cache.h b/cache.h
> index d8b975a571..655a81ac90 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -825,6 +825,7 @@ extern char *git_replace_ref_base;
>  extern int fsync_object_files;
>  extern int core_preload_index;
>  extern int core_apply_sparse_checkout;
> +extern int core_graph;

Putting it here instead of say the_repository makes sense as you'd want
to use this feature globally. However you can still have the config
different per repository  (e.g. version number of the graph setting,
as one might be optimized for speed and the other for file size of
the .graph file or such).

So not sure if we'd rather want to put this into the repository struct.
But then again the other core settings aren't there either and this
feature sounds like it is repository specific only in the experimental
phase; later it is expected to be on everywhere?

>  extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;
> diff --git a/config.c b/config.c
> index e617c2018d..fee90912d8 100644
> --- a/config.c
> +++ b/config.c
> @@ -1223,6 +1223,11 @@ static int git_default_core_config(const char *var, const char *value)
>                 return 0;
>         }
>
> +       if (!strcmp(var, "core.graph")) {
> +               core_graph = git_config_bool(var, value);
> +               return 0;
> +       }
> +
>         if (!strcmp(var, "core.sparsecheckout")) {
>                 core_apply_sparse_checkout = git_config_bool(var, value);
>                 return 0;
> diff --git a/environment.c b/environment.c
> index 63ac38a46f..0c56a3d869 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -61,6 +61,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
>  char *notes_ref_name;
>  int grafts_replace_parents = 1;
>  int core_apply_sparse_checkout;
> +int core_graph;
>  int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
> --
> 2.16.0
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670661F403
	for <e@80x24.org>; Sat,  9 Jun 2018 18:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeFISOO (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 14:14:14 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34690 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753392AbeFISON (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 14:14:13 -0400
Received: by mail-ot0-f195.google.com with SMTP id r18-v6so4910262otk.1
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWYDdiq1CFHEXEZpa2Fif/5D6P/F0gOvMRYpTLWofFg=;
        b=Tuz3IzlUfsTjt6MZfItdP42w5nC5iI2LcY+UP7uZu2VdgJPRjZxDM4cB64SwgVw5aK
         jkZmZ7aGSBmR+5p4fXjb0BcGkw5d0TA19Eyd91mGqTr3qh9kaQu72ekjfw69TomNwqFz
         M0PmMgEnOcOyBTu4w2jsGFDLV9BJlxp2sM/qOQwzrz6Ka9ChOp+w2eoQrdNJIfo+35rj
         ChaVr619CQ4a2bUybxCtP2iufIRPAE6hTfeSYTclzV8GB65Qt4+V/iNP+U9bCDfnPHtU
         FCBI3nO8E4At9fRQJ4Bm4XfbKcRv0pTiTPywJ96Mae57a2XBMUzOty/S/T/klMy0UAEW
         6WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWYDdiq1CFHEXEZpa2Fif/5D6P/F0gOvMRYpTLWofFg=;
        b=e9uE1aMdqYKW+MB+5PGaaaH6DaDL9sjm96CipUnRtMpEfaSTFjlNDg2ggfhQMQ1ko1
         EJo6EOOnL+7xSVs+NRyUG2z/WFItCub92TkPIIDHWr7S17F/pmGvCIdZw1NEKbXI70QM
         D9QAkuw5lpmf3f3aotXwhZA9xJ4fMfHJVR+d6C8gBIhO4TgkOtyJbv78AHG6lQ/oLfj3
         H7ZQ+c8+QGP3uuFLbPu7AynFNk2rduS7AM6SK7InsiyYmmc+0IEM380WFP9RuyvbfaCu
         P/39PuUUXIHwCYki2x2dNHg4ZXY+QZzqOv4YQcqHlVtBKM6BAj6ODoIG9cstJn/7IXRd
         HJsg==
X-Gm-Message-State: APt69E0rnt+Yt0vShYkcjVp7hSGkay+W4jyag1ezv2DDhgs21jr1UgUM
        6z3Hry6HbEYw67jj2jwx0leEpRqNm6il2Zib5zk=
X-Google-Smtp-Source: ADUXVKKqG1Hsbm357UqOM+HvvHoPUxd4IeRXyGbtRTrkqGy6yCMoJ9UlSrLDmevuudPr2IkhMqpdvNLXVKi3XiYez0s=
X-Received: by 2002:a9d:32e1:: with SMTP id u88-v6mr1161355otb.173.1528568053122;
 Sat, 09 Jun 2018 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-24-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-24-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 20:13:47 +0200
Message-ID: <CACsJy8BHgqqrDNvU_oy0+_QmDW-wt-jBvWT9oJ9H1pA_tmuVFg@mail.gmail.com>
Subject: Re: [PATCH 23/23] midx: clear midx on repack
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:07 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> If a 'git repack' command replaces existing packfiles, then we must
> clear the existing multi-pack-index before moving the packfiles it
> references.

I think there are other places where we add or remove pack files and
need to reprepare_packed_git(). Any midx invalidation should be part
of that as well.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/repack.c | 8 ++++++++
>  midx.c           | 8 ++++++++
>  midx.h           | 1 +
>  3 files changed, 17 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 6c636e159e..66a7d8e8ea 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -8,6 +8,7 @@
>  #include "strbuf.h"
>  #include "string-list.h"
>  #include "argv-array.h"
> +#include "midx.h"
>
>  static int delta_base_offset = 1;
>  static int pack_kept_objects = -1;
> @@ -174,6 +175,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>         int no_update_server_info = 0;
>         int quiet = 0;
>         int local = 0;
> +       int midx_cleared = 0;
>
>         struct option builtin_repack_options[] = {
>                 OPT_BIT('a', NULL, &pack_everything,
> @@ -340,6 +342,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>                                 continue;
>                         }
>
> +                       if (!midx_cleared) {
> +                               /* if we move a packfile, it will invalidated the midx */

What about removing packs, which also happens in repack? If the
removed pack is part of midx, then midx becomes invalid as well.

> +                               clear_midx_file(get_object_directory());
> +                               midx_cleared = 1;
> +                       }
> +
>                         fname_old = mkpathdup("%s/old-%s%s", packdir,
>                                                 item->string, exts[ext].name);
>                         if (file_exists(fname_old))
> diff --git a/midx.c b/midx.c
> index e46f392fa4..1043c01fa7 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -913,3 +913,11 @@ int write_midx_file(const char *object_dir)
>         FREE_AND_NULL(pack_names);
>         return 0;
>  }
> +
> +void clear_midx_file(const char *object_dir)

delete_ may be more obvious than clear_

> +{
> +       char *midx = get_midx_filename(object_dir);
> +
> +       if (remove_path(midx))
> +               die(_("failed to clear multi-pack-index at %s"), midx);

die_errno()

> +}
> diff --git a/midx.h b/midx.h
> index 6996b5ff6b..46f9f44c94 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -18,5 +18,6 @@ int midx_contains_pack(struct midxed_git *m, const char *idx_name);
>  int prepare_midxed_git_one(struct repository *r, const char *object_dir);
>
>  int write_midx_file(const char *object_dir);
> +void clear_midx_file(const char *object_dir);
>
>  #endif
> --
> 2.18.0.rc1
>


-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE101F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933424AbeFGRVM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:21:12 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37366 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932804AbeFGRVL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 13:21:11 -0400
Received: by mail-ot0-f195.google.com with SMTP id 101-v6so12445944oth.4
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EDg4XpScZG3C/aptuX6631pEDSq/bDFkhm0Eg2CL1T0=;
        b=cMcxJRxnMe68qeswzTh2WPv4Kqumrj54Q9Bscfu2FYoWVWz+08JsyFvotbNT6U1RLt
         ZYOlAOovZk8pjy/4u8+nIo9chsivwR1xZ4yZGZbqz4nDMGyDazsEv3LE6nefrC8aq72f
         eejCsXdy8O96at4n1TErx2eP/4RFrt+x5xTiPFjbwqM5PNz2v8witvd474IlWPocAr8F
         fByiOPzqra0yhei/umaKA5Zw69Sgk6KJ2eswlu9pBqkWaeMtaz24xzLxrW4xThZMyxNi
         7dhlFsN5oXEAr3JKap0NhV6PUvyzjhcWCBUY++v36L28X49ziwSO1dL01WB9AnPwdhkI
         3c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EDg4XpScZG3C/aptuX6631pEDSq/bDFkhm0Eg2CL1T0=;
        b=YoB+srZtMXakj6OF2aau5cPO52m4m9RKmkCdbe2XlO6h0G1o6aH+SrD6OijmulCHUd
         uQNwl/4V5WKcmTQbi0S8TnAFWQDlwKQzSgT/6Z3CRzltlEbG5SqU5W5E8IoGFJIL3yPd
         PYVNsKpCQQkhXIzFiAR3HTkhBYWSLmieGnzAZVHNrZk4vsPwg+SAE4ZZ9MJk1iexE7Ng
         GRVADS1H2jSXNA8+bbIydIRkeoyOyM+oJVCk1zDF8R6sv9WBH4RDI/uR73zp6zj7iaie
         /Sg4dtgKpWq8d2+5v58VkK24WqyvIhyedUCbTeCVvONR08wj6lcShvoPu95V2GzYeHXb
         o4Sw==
X-Gm-Message-State: APt69E3QNNS13b+rcjri0mikgQBfb/0nS0Ur65YBoIFWv0ptHjk7Qwxl
        tKSv1XD2rrrx8TOBXFhph6tyeQvow5PtThUp4XI=
X-Google-Smtp-Source: ADUXVKJGOyWoMywiY++Sjg/wcgBTdhC7WMW+ahgtLMIkocwNXlRqaA93dUhk3PeE/AK74McU1JcpBvo3hN+ynOUH7dU=
X-Received: by 2002:a9d:2f91:: with SMTP id r17-v6mr1669197otb.356.1528392070652;
 Thu, 07 Jun 2018 10:21:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:20:40 -0700 (PDT)
In-Reply-To: <20180607140338.32440-4-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-4-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 19:20:40 +0200
Message-ID: <CACsJy8Ca4B_xjpuTU=sFS+fOEin5fFiSmH+Z7JKjoUA6ZMnv4A@mail.gmail.com>
Subject: Re: [PATCH 03/23] midx: add midx builtin
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

On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
> diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
> new file mode 100644
> index 0000000000..2bd886f1a2
> --- /dev/null
> +++ b/Documentation/git-midx.txt
> @@ -0,0 +1,29 @@
> +git-midx(1)
> +============
> +
> +NAME
> +----
> +git-midx - Write and verify multi-pack-indexes (MIDX files).

No full stop. This head line is collected automatically with others
and its having a full stop while the rest does not looks strange/

> diff --git a/builtin/midx.c b/builtin/midx.c
> new file mode 100644
> index 0000000000..59ea92178f
> --- /dev/null
> +++ b/builtin/midx.c
> @@ -0,0 +1,38 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "config.h"
> +#include "git-compat-util.h"

You only need either cache.h or git-compat-util.h. If cache.h is here,
git-compat-util can be removed.

> +#include "parse-options.h"
> +
> +static char const * const builtin_midx_usage[] ={
> +       N_("git midx [--object-dir <dir>]"),
> +       NULL
> +};
> +
> +static struct opts_midx {
> +       const char *object_dir;
> +} opts;
> +
> +int cmd_midx(int argc, const char **argv, const char *prefix)
> +{
> +       static struct option builtin_midx_options[] = {
> +               { OPTION_STRING, 0, "object-dir", &opts.object_dir,

For paths (including dir), OPTION_FILENAME may be a better option to
handle correctly when the command is run in a subdir. See df217ed643
(parse-opts: add OPT_FILENAME and transition builtins - 2009-05-23)
for more info.

> +                 N_("dir"),
> +                 N_("The object directory containing set of packfile and pack-index pairs.") },

Other help strings do not have full stop either (I only checked a
couple commands though)

Also, doesn't OPT_STRING() work here too (if you avoid OPTION_FILENAME
for some reason)?

> +               OPT_END(),
> +       };
> +
> +       if (argc == 2 && !strcmp(argv[1], "-h"))
> +               usage_with_options(builtin_midx_usage, builtin_midx_options);
> +
> +       git_config(git_default_config, NULL);
> +
> +       argc = parse_options(argc, argv, prefix,
> +                            builtin_midx_options,
> +                            builtin_midx_usage, 0);
> +
> +       if (!opts.object_dir)
> +               opts.object_dir = get_object_directory();
> +
> +       return 0;
> +}

> diff --git a/git.c b/git.c
> index c2f48d53dd..400fadd677 100644
> --- a/git.c
> +++ b/git.c
> @@ -503,6 +503,7 @@ static struct cmd_struct commands[] = {
>         { "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>         { "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>         { "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
> +       { "midx", cmd_midx, RUN_SETUP },

If it's a plumbing and can take an --object-dir, then I don't think
you should require it to run in a repo (with RUN_SETUP).
RUN_SETUP_GENTLY may be better. You could even leave it empty here and
only call setup_git_directory() only when --object-dir is not set.

>         { "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
>         { "mktree", cmd_mktree, RUN_SETUP },
>         { "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
-- 
Duy

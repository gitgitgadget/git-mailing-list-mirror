Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5FD1F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeEaTjF (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:39:05 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46792 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754081AbeEaTjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:39:04 -0400
Received: by mail-yb0-f194.google.com with SMTP id p22-v6so7969998yba.13
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=laUHgg2Z2kkjUjTtk8v4yepWkcE0rXLhIC0Fn9KLBiE=;
        b=WDJFedcqGbCPGFB69SSBRJ5XmgZOh3MFk/CiYPbjZQn70uFEcf7kSFiE7w5+Tz0NYc
         jltnxqLwlrzPlR7698BbMmdW0tzhpqyr10H6BHmLVo5HZ9YOWou5ti9R6ATXt6EHyKVf
         LVkN+VTjDAx8esA7JDqzs0/mbQKLSJrfHfM5uSaRUDaqmSaBzLwHDYUiVnJuD3buiDpH
         5bwNNLvjW5GS5PpR/hwHglR5eHxyX4GPahkew+Oppsk0sZR5eYGTlwlhZDhYvdg46zyp
         9j3Dpml3tWZPsMUpjloVTgHvpJcA1P8b1Ms5jGW8GkMAGM9HLGKgNDWMgetTj8TBlc9J
         8eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=laUHgg2Z2kkjUjTtk8v4yepWkcE0rXLhIC0Fn9KLBiE=;
        b=MRWN43wR5FQ8OzqFejdRMWo6zaQrE9CbpV5ibXFB9xvJxg7xwkH0cI7WmjVxH0q3uw
         AKtPExQ36oKsHZpBwfVhkWihzgCaEXKN4LSATZEyhgsDVDfzmDoVc76Qdf6Kw8a2lHie
         kPqH4Uo0E+7f1Cdmb/MeFy43cnVhq9mRSIgD/iuwoqjT6D6oyQZgjyNJ+UdGxx72xhVW
         OF6Iq6RsE38xR5+3rL4mgXdYCg+OyGdGwr0QZkRsKrYawIEOUtVDnyUTLFkYpLrxK6MS
         lGAZS2uxTZgAsmADfCkLhxbMnJ3LUiUeULHWSStgBKZCbWhIzpuKI/ixyVEa3YqZeiTj
         diPg==
X-Gm-Message-State: ALKqPwc5l4ULlN1Darije3Y/ygdLm7v+IBccXTOZr0wxKKmk5TmGCDDz
        K/rwVgcZt30UMwSNJVCdVffb9qSx1PBEnF7HK5Ti8w==
X-Google-Smtp-Source: ADUXVKLTY0HX246qAWL4yRhYbPacRd2mBccaH0pyKBtt0mkhO3Be2QjsJFWC4QhmvuMNsPODR+mA9Giodbd4HIVrsN0=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr4710630ybc.307.1527795543224;
 Thu, 31 May 2018 12:39:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 12:39:02 -0700 (PDT)
In-Reply-To: <20180531174024.124488-2-dstolee@microsoft.com>
References: <20180531174024.124488-1-dstolee@microsoft.com> <20180531174024.124488-2-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 12:39:02 -0700
Message-ID: <CAGZ79kZ=Zmd8i9Z565MU=QCQGXixwkRYPY5RKekua67Lq+b2=g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] DO NOT MERGE: compute commit-graph on every commit
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 10:41 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> Also enable core.commitGraph and gc.commitGraph. Helps to test the
> commit-graph feature with the rest of the test infrastructure.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/commit.c | 5 +++++
>  builtin/gc.c     | 2 +-
>  environment.c    | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e8e8d13be4..8751b816c1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -32,6 +32,7 @@
>  #include "column.h"
>  #include "sequencer.h"
>  #include "mailmap.h"
> +#include "commit-graph.h"
>
>  static const char * const builtin_commit_usage[] = {
>         N_("git commit [<options>] [--] <pathspec>..."),
> @@ -1623,5 +1624,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>
>         UNLEAK(err);
>         UNLEAK(sb);
> +
> +       if (core_commit_graph)
> +               write_commit_graph_reachable(get_object_directory(), 1);
> +

I'd personally put it before the UNLEAKS, as then
we have the cleanup at the end of the function and
not scattered somewhere in the middle.

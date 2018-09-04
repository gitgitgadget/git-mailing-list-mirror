Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB001F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIEAci (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:32:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38132 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeIEAci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:32:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so4253959edb.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TQhQ5bDR5TcIt6bLSh+jxqRAxMiuZxparvUWhoSzsEQ=;
        b=tcKTdD3FKIhBdN21N7d08PnqVmStAlkw+fix52PnVyAFPybXJqP0L5J2VmHI1ll/NB
         3FNqLAGUq+z6RlAfj7x6Tod7LN/y+K+lLLrNoKODWUysRc1d5zaDSYMd1O40VTR5EVAx
         gP/p+d7VNWqwOw5PwbwrJk7F1vSScG2kJ2HF7rEkMEtBC8wu0lBzloS32qWj9LnxFMZ1
         bH4YBxQ/jsyQogjGYd/iO0ZjARveRXsAYyJUqqOg4NCSIvF3JroHdTI8NGAq22Q2q2rw
         j3qRQgGkWAz0d8BA57tusDEACKxtqnlqAItthTBuU2XbCkRyMVxNfVN9irY7aNHnB3Lx
         7EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TQhQ5bDR5TcIt6bLSh+jxqRAxMiuZxparvUWhoSzsEQ=;
        b=ALENSxqL6epG4yIpnvP9BKDSWco5A0EfsTTDlV5JlBNFQmd5PIBC913aiYhpfXNPN7
         nwMPbJ2lRyrfmlcdV5fgvfs6AKr8z5Q3wqLv3QAfW73Jo5osKHK51V8lIkeolZI6UuqO
         Et1fjanYK92Cl5APkui53afYdsIgxaHxSAOYjSKgGxNkuXM9ab8Bsg7NXqxCos7/QmkB
         JKTatmj/Xbs1TbP51PgQMZY6U82o9r+1qpB34rsRJpG/xSmltElZYjLRP3Un2sS8wJbS
         NHtw6Mlw/7HrSelQfmm5iC+U4NXNDyBaYtcUrGaPGDswXmBWNh0KqJ/ZsAiSJBBVgdxQ
         vRtw==
X-Gm-Message-State: APzg51A1wZiLHMVgQhAMu1/rHnbYzVF8M/w5LCZhcplDvTxplPKHweO8
        ljJe8VNCXSEUY5U3hzMMCYLT9NDSczL5FA2VlZ4pfo9tKrk=
X-Google-Smtp-Source: ANB0VdYVO9wvkKjNeDWSC3TEgC5REn94+fZAwRobWBsSEqoloD04jyLFEDI7L1ySeCR2fdEzBs8j5XyMsMyHd9g1WF8=
X-Received: by 2002:aa7:ca51:: with SMTP id j17-v6mr37214471edt.45.1536091556841;
 Tue, 04 Sep 2018 13:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-23-pclouds@gmail.com>
In-Reply-To: <20180903180932.32260-23-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 13:05:45 -0700
Message-ID: <CAGZ79kZi=qt4LyeA4U8nSGKx3_sOEF2m8=K_YNE2JpesF5ybTA@mail.gmail.com>
Subject: Re: [PATCH v2 22/24] revision.c: remove implicit dependency on the_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 11:10 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> "remove" is probably a strong word because the dependency is still
> there, hidden behind the_repository. This patch is almost mechanical,
> all call sites are updated to take the_repository, no exception.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  bisect.c                         |  4 ++--
>  builtin/add.c                    |  4 ++--
>  builtin/am.c                     |  6 +++---
>  builtin/blame.c                  |  2 +-
>  builtin/checkout.c               |  4 ++--
>  builtin/commit.c                 |  2 +-
>  builtin/describe.c               |  4 ++--
>  builtin/diff-files.c             |  2 +-
>  builtin/diff-index.c             |  2 +-
>  builtin/diff-tree.c              |  2 +-
>  builtin/diff.c                   |  2 +-
>  builtin/fast-export.c            |  2 +-
>  builtin/fmt-merge-msg.c          |  2 +-
>  builtin/log.c                    | 16 ++++++++--------
>  builtin/merge.c                  |  4 ++--
>  builtin/pack-objects.c           |  2 +-
>  builtin/prune.c                  |  2 +-
>  builtin/reflog.c                 |  2 +-
>  builtin/rev-list.c               |  2 +-
>  builtin/revert.c                 |  2 +-
>  builtin/shortlog.c               |  2 +-
>  builtin/submodule--helper.c      |  2 +-
>  bundle.c                         |  4 ++--
>  diff-lib.c                       |  4 ++--
>  http-push.c                      |  2 +-
>  merge-recursive.c                |  2 +-
>  pack-bitmap-write.c              |  2 +-
>  ref-filter.c                     |  2 +-
>  remote.c                         |  2 +-
>  revision.c                       | 32 ++++++++++++++++++--------------
>  revision.h                       | 10 +++++++---
>  sequencer.c                      |  8 ++++----
>  shallow.c                        |  2 +-
>  submodule.c                      |  6 +++---
>  t/helper/test-revision-walking.c |  2 +-
>  wt-status.c                      | 10 +++++-----
>  36 files changed, 84 insertions(+), 76 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index e1275ba79e..e19c60829c 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -632,7 +632,7 @@ static void bisect_rev_setup(struct rev_info *revs, c=
onst char *prefix,
>         struct argv_array rev_argv =3D ARGV_ARRAY_INIT;
>         int i;
>
> -       init_revisions(revs, prefix);
> +       init_revisions(revs, the_repository, prefix);

Thanks for this patch!

At first I wondered why we put the repository as the second argument,
but that comes down to personal preference, so I wanted to keep it silent.
(FWIW: Thinking about it, I'd either go with this order or with (repo,
prefix, revs)
as it puts the target struct to initialize either first or last, and
then the repo
struct first in the number of parameters. I think the order is fine
after thinking
about it.)

However we have Documentation/technical/api-revision-walking.txt
which would break with this change:

    `init_revisions`::
        Initialize a rev_info structure with default values. The second
        parameter may be NULL or can be prefix path, [...]

The second parameter changes, so we'd want to update the docs
eventually, too. for now I'd think a cheap s/second/prefix/ would do
in that part of the doc.

That said, we can do that on top depending on quickly this merges down
(it touches a lot of code, so keeping the churn down would be nice).

Thanks,
Stefan

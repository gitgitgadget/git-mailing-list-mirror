Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD93A208CD
	for <e@80x24.org>; Wed, 23 Aug 2017 19:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbdHWTZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:25:24 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36140 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbdHWTZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:25:23 -0400
Received: by mail-yw0-f169.google.com with SMTP id y64so6506167ywf.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fuhml/HfjjL9bPfTbAOnxxSHWTmf4bDI2DJ4/K9DK3A=;
        b=TJILIGiU2G+88H0IqI8sWT6rpOYnFJKN7LlMkP/RI5O21AwciPzmdSDxy6hMbhuqpO
         yXy+4DNtyaSHPnkrADsmyOZVv+iN1KLraqXrsHT6VE3usFTvv5zCnUDc556UlgCsC+OW
         FdPjdTJLtosOwoTyy9qQURxDkcHX0J9EFtdOZiMs3LLOccMgjusfUXX9oJJDOaMJTrTo
         lbgTw48YKg8wV/h9PU2L4x7ubZRZywriYNxIm//dq+TAI+h+fPNczkO16VdH3LeqPtba
         GJZXdVvgN07pSwpXn9qKNcGMvtb7MCWHG8zdCF4N1ntjfePK3F4E+DQ4sWAt7NuAOnqD
         3Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fuhml/HfjjL9bPfTbAOnxxSHWTmf4bDI2DJ4/K9DK3A=;
        b=pQioLa2RBGOyLrotfUMGAswqEO9sAoyTzigHKiy1kfW09w1rSeUY4fmn8T5t27JzJU
         ezy73I89rvF2bm5A667yi99BW1N5nEut7Gxq3nUgQEX3QGu7a8z8+aztso3IEGnOveOa
         AwgrCfFMWBimwA4ESh4xnXwLSPIyS9Xs6xkdYW3cQsCklPatbH30M2D5MfM5arpYLW50
         ax77yar+/MI6bzHIOGkVewt3SQhVg2EzsNLWqDp9ATXO95XKvfQxKv0cVe5PFxQBFMcS
         3hDsXe1sRDOulJNsS6gp/w3efbd1wkfwcZDaI0YETfxqBjZgTO0/lsO9WjckNLkbvDWZ
         z6tQ==
X-Gm-Message-State: AHYfb5hHyqmgn2Q/zm41nARqZOi7uD12RcjZI7jRyYb9MowXXm1x2eV0
        obxRAMlWdaWm0CwPMLKfSerfsIToXDDr9CJSjw==
X-Google-Smtp-Source: ADKCNb6J58J78teygoVZqlaelO3QqstjnwHiQbhYS8xuynfZ23OD/UV5ZUKer67iYXzhUyaTSYYPfb1T+6iNkyym2yU=
X-Received: by 10.37.208.146 with SMTP id h140mr3031382ybg.151.1503516322639;
 Wed, 23 Aug 2017 12:25:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.214.133 with HTTP; Wed, 23 Aug 2017 12:25:22 -0700 (PDT)
In-Reply-To: <20170823123704.16518-5-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-5-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 23 Aug 2017 12:25:22 -0700
Message-ID: <CAGZ79kbPTr+DgcXcMmOax6SzLad4q8VByCiO=FH5hcmN7icc3g@mail.gmail.com>
Subject: Re: [PATCH v4 04/16] revision.c: --indexed-objects add objects from
 all worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 5:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This is the result of single_worktree flag never being set (no way to up
> until now). To get objects from current index only, set single_worktree.
>
> The other add_index_objects_to_pending's caller is mark_reachable_objects=
()
> (e.g. "git prune") which also mark objects from all indexes.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  revision.c       | 21 +++++++++++++++++++++
>  t/t5304-prune.sh |  9 +++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 6c46ad6c8a..f35cb49af5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -19,6 +19,7 @@
>  #include "dir.h"
>  #include "cache-tree.h"
>  #include "bisect.h"
> +#include "worktree.h"
>
>  volatile show_early_output_fn_t show_early_output;
>
> @@ -1290,8 +1291,28 @@ static void do_add_index_objects_to_pending(struct=
 rev_info *revs,
>
>  void add_index_objects_to_pending(struct rev_info *revs, unsigned int fl=
ags)
>  {
> +       struct worktree **worktrees, **p;
> +
>         read_cache();
>         do_add_index_objects_to_pending(revs, &the_index);
> +
> +       if (revs->single_worktree)
> +               return;
> +
> +       worktrees =3D get_worktrees(0);
> +       for (p =3D worktrees; *p; p++) {
> +               struct worktree *wt =3D *p;
> +               struct index_state istate =3D { NULL };
> +
> +               if (wt->is_current)
> +                       continue; /* current index already taken care of =
*/
> +
> +               if (read_index_from(&istate,
> +                                   worktree_git_path(wt, "index")) > 0)
> +                       do_add_index_objects_to_pending(revs, &istate);
> +               discard_index(&istate);
> +       }
> +       free_worktrees(worktrees);
>  }

The commit (message and code) looks acceptable and easy to read.
I wonder though if another approach would be more feasible:

* factor out anything after the early return into a new function
  "add_wt_index_objects_to_pending", maybe?
* introduce a new function
    for_each_wt_except_current(function, callback_cookie)
  such that this code could use this predefined iterator.
  (I have the impression I have seen this code pattern before,
  hence it may be useful to have such a foreach function; we
  have foreach functions already for various ref things, string
  list items, reflogs, and soon submodule lists)

>
>  static int add_parents_only(struct rev_info *revs, const char *arg_, int=
 flags,
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index 133b5842b1..cba45c7be9 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -283,4 +283,13 @@ test_expect_success 'prune: handle alternate object =
database' '
>         git -C B prune
>  '
>
> +test_expect_success 'prune: handle index in multiple worktrees' '
> +       git worktree add second-worktree &&
> +       echo "new blob for second-worktree" >second-worktree/blob &&
> +       git -C second-worktree add blob &&
> +       git prune --expire=3Dnow &&
> +       git -C second-worktree show :blob >actual &&
> +       test_cmp second-worktree/blob actual
> +'
> +
>  test_done
> --
> 2.11.0.157.gd943d85
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8231F609
	for <e@80x24.org>; Tue,  4 Jun 2019 08:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfFDIdb (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 04:33:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38073 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfFDIda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 04:33:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id l3so12771859qtj.5
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=oC9G3G1boVhmhU6bwplO3LPVWmr+dMsAx6pcXY+i4jY=;
        b=Mmdr/4c2n42Y8e+6DVcYzqwl4yDve3RT0bMwMVqJN/MrsQJmDUuVe0lZ/1AO9i/Mc0
         xgYgJDEE+/E7h7cyrRWELe67O4d36g876KjjTFNqVctPJwDfJP9QTb+FtxqvUEj4eQQr
         ZFBtsgGl1CVgXUYf+8394yEMSuCjD+6yb4NCsjh2PGRk19WxL1y8pqHtcLVxtm6mnmoZ
         Jfiu1QbHBmsDLEdUrO0qcQBuJ+ykJO/zpC+rtFmqAdqkyDHA2SvWwyrfVE60QvLw8mWJ
         ubkztoIT0muZsDTaWlHgitOcaLuHigKxYFm5R5KpelooecDmZVWxQlVjc/Jz1XIBVKWC
         7kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=oC9G3G1boVhmhU6bwplO3LPVWmr+dMsAx6pcXY+i4jY=;
        b=ES0EEBZrhQeKM6T4cu+sY+dwSn7hiVs8d9cyaMi+M5o1gBQF66m/jGvvg+oUO0zRVl
         tu9f558sMw+DLzLucVpXXkyyq8NMo9XjOggzRbp70tkBAGfeR5cPLhtZMj5d4xwVZf8E
         bqa0nvOK+5O93r0k2e/SGYCbAIKk+H02dDkkFWjnHlFqGzNPM2PV1We3vxKykpela0rI
         k427JfRSKUUH9hI0UbWL0rzDlcyo4R3Bzj55XADAAueyfHQ5CLdxQ3syru+RvKT/duvB
         2dOzuZ99kZbUaPkJcj2NkufAGSpF03iim0qnmktseb4txsStB3edQ2d5VP+FRZOphZu3
         3jMA==
X-Gm-Message-State: APjAAAUVxexeyBHjTup3MT/2Jy/O74MWf62M3R3Scv2IieuJrPKXVHGh
        NwdwOKD36wkHkslwP+EVKuRuLeN+hgIm0dvWpaHjqA==
X-Google-Smtp-Source: APXvYqzdyMMYMTOk4l4sqAFzxHS/Pz9evJBOGGOUK69m1/SXHL/kFHqAo3S4zCgPGXK3W3Gzw+o6PneeB3wNOKD+mDo=
X-Received: by 2002:ac8:3861:: with SMTP id r30mr7290328qtb.341.1559637209270;
 Tue, 04 Jun 2019 01:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190604023039.GR951@szeder.dev> <20190604072614.26885-1-newren@gmail.com>
In-Reply-To: <20190604072614.26885-1-newren@gmail.com>
Reply-To: ben.humphreys@atlassian.com
From:   Ben Humphreys <behumphreys@atlassian.com>
Date:   Tue, 4 Jun 2019 18:33:18 +1000
Message-ID: <CAFkS+yLVG2bBOHeZjZ6LoBy7thTHA4c4ZEff25TisXZyHckw-g@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: restore accidentally dropped setting of path
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Humphreys <ben.humphreys@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ben: Could you rerun all your special testcases to make sure things
> are good with this patch too?  It'd be much appreciated.

Many thanks for the super fast turnaround Elijah and Szeder!

I can confirm with 2.22.0-rc3 plus your patch this failing testcase
now passes, and indeed our entire Git test suite passes.

Best Regards,
Ben Humphreys

On Tue, Jun 4, 2019 at 5:26 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jun 3, 2019 at 7:30 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> >
> > On Tue, Jun 04, 2019 at 11:32:24AM +1000, Ben Humphreys wrote:
> > > Hi folks,
> > >
> > > I=E2=80=99m one of the Bitbucket Server developers and I just wanted =
to let
> > > you know of one of our test cases that is now failing on the 2.22.0
> > > release candidates (tested rc2 and rc3). I=E2=80=99m still looking in=
to it,
> > > but figure the release is probably imminent so worth reporting sooner
> > > than later.
> > >
> > > The problem seems to be related to some recent changes in
> > > merge-recursive.c. I=E2=80=99ve made available our test dataset and t=
he
> > > following steps will reproduce the problem:
> > >
> > > $ git --version
> > > git version 2.22.0.rc3
> > >
> > > $ git clone https://bitbucket.org/ben_humphreys/merge-dataset.git
> > > $ cd merge-dataset
> > > $ git checkout branch_that_has_rename_add_triggering_content_conflict=
_trgt
> > > $ git merge origin/branch_that_has_rename_add_triggering_content_conf=
lict_src
> > > Assertion failed: (a->path && b->path), function merge_3way, file
> > > merge-recursive.c, line 1044.
> > > Abort trap: 6
> > >
> > > The assertion is failing because b->path is null:
> > >
> > > (lldb) print a->path
> > > (char *const) $2 =3D 0x00007f8e177025f8 "count.txt"
> > > (lldb) print b->path
> > > (char *const) $3 =3D 0x0000000000000000 <no value available>
> >
> > merge_3way() is called from merge_mode_and_contents(), which in turn
> > is called from handle_rename_add(), which was modified in 8daec1df03
> > (merge-recursive: switch from (oid,mode) pairs to a diff_filespec,
> > 2019-04-05) like this:
> >
> > > diff --git a/merge-recursive.c b/merge-recursive.c
> > > index ada1c19ed2..1d2c9e1772 100644
> > > --- a/merge-recursive.c
> > > +++ b/merge-recursive.c
> > >
> > > @@ -1654,7 +1625,6 @@ static int handle_rename_add(struct merge_optio=
ns *opt,
> > >       /* a was renamed to c, and a separate c was added. */
> > >       struct diff_filespec *a =3D ci->ren1->pair->one;
> > >       struct diff_filespec *c =3D ci->ren1->pair->two;
> > > -     struct diff_filespec tmp;
> > >       char *path =3D c->path;
> > >       char *prev_path_desc;
> > >       struct merge_file_info mfi;
> > > @@ -1669,23 +1639,21 @@ static int handle_rename_add(struct merge_opt=
ions *opt,
> > >              a->path, c->path, rename_branch,
> > >              c->path, add_branch);
> > >
> > > -     filespec_from_entry(&tmp, ci->ren1->src_entry, other_stage);
> > > -     tmp.path =3D a->path;
> >
> > Note that 'tmp.path' used to be set ...
> >
> > > -
> > >       prev_path_desc =3D xstrfmt("version of %s from %s", path, a->pa=
th);
> > > -     if (merge_mode_and_contents(opt, a, c, &tmp,
> >
> > ... and that this 'tmp' used to become 'b' in
> > merge_mode_and_contents() and then in merge_3way().
> >
> > > +     if (merge_mode_and_contents(opt, a, c,
> > > +                                 &ci->ren1->src_entry->stages[other_=
stage],
> > >                                   prev_path_desc,
> > >                                   opt->branch1, opt->branch2,
> > >                                   1 + opt->call_depth * 2, &mfi))
> > >               return -1;
> > >       free(prev_path_desc);
> >
> >
> > This one-liner patch below the issue, the merge fails with conflicts
> > as expected, but, honestly, I have no idea what I am doing :)  At
> > least the test suite still passes, but that might not mean all that
> > much since it missed this issue in the first place...
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index a7bcfcbeb4..d2e380b7ed 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -1660,6 +1660,7 @@ static int handle_rename_add(struct merge_options=
 *opt,
> >                c->path, add_branch);
> >
> >         prev_path_desc =3D xstrfmt("version of %s from %s", path, a->pa=
th);
> > +       ci->ren1->src_entry->stages[other_stage].path =3D a->path;
> >         if (merge_mode_and_contents(opt, a, c,
> >                                     &ci->ren1->src_entry->stages[other_=
stage],
> >                                     prev_path_desc,
> >
> >
>
> This analysis and patch are correct; I somehow deleted the setting of the
> path here in what should have been a straightforward conversion.
>
> I've tried to look through every other callsite to merge_3way to see
> if any others fail to set the paths; there's a dozen or two of them.
> I think this was the only one that was missed, but honestly I'm
> exhausted right now and not sure I'm thinking straight.  So I'll
> recheck tomorrow and do a bunch more testing.
>
> Of course, this wasn't the only bug; it also showed we had a glaring
> whole in our test coverage -- there's a dearth of tests for rename/add
> conflicts, and in particular none involving content merges for the
> rename side.  So, I created a patch which adds some tests for that
> (which triggered the assertion error).  I pulled SZEDER's fix into the
> same patch and added a commit message explaining the issue, using a
> Based-on-patch-by tag for the fix.  SZEDER: if you'd like to see this
> in a different format (maybe I add tests which show the error and then
> in a separate patch authored by you we introduce your fix?), just let
> me know.
>
> Since we're at -rc3 already, even if it is a trivial patch, I'm going to
> try to re-analyze it all tomorrow to make sure I didn't miss anything and
> see if I can find more tests to throw at it.
>
> Ben: Could you rerun all your special testcases to make sure things
> are good with this patch too?  It'd be much appreciated.
>
> Thanks Ben for reporting and SZEDER for jumping on and analyzing and
> cc'ing me.
>
> Sorry for the headache folks,
> Elijah
>
>
> -- 8< --
> Subject: [PATCH] merge-recursive: restore accidentally dropped setting of=
 path
>
> In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
> to a diff_filespec", 2019-04-05), we actually switched from
> (oid,mode,path) triplets to a diff_filespec -- but most callsites in the
> patch only needed to worry about oid and mode so the commit message
> focused on that.  The oversight in the commit message apparently spilled
> over to the code as will; one of the dozen or so callsites accidentally
> dropped the setting of the path in the conversion.  Restore the path
> setting in that location.
>
> Also, this pointed out that our testsuite was lacking a good rename/add
> test, at least one that involved the need for merge content with the
> rename.  Add such a test, and since rename/add vs. add/rename could
> possibly be important, redo the merge the opposite direction to make
> sure we don't have issues with the direction of the merge.  These
> testcases failed before restoring the setting of path, but with the
> paths appropriately set the testcases both pass.
>
> Reported-by: Ben Humphreys <behumphreys@atlassian.com>
> Based-on-patch-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                    |   1 +
>  t/t6042-merge-rename-corner-cases.sh | 118 +++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index a7bcfcbeb4..d2e380b7ed 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1660,6 +1660,7 @@ static int handle_rename_add(struct merge_options *=
opt,
>                c->path, add_branch);
>
>         prev_path_desc =3D xstrfmt("version of %s from %s", path, a->path=
);
> +       ci->ren1->src_entry->stages[other_stage].path =3D a->path;
>         if (merge_mode_and_contents(opt, a, c,
>                                     &ci->ren1->src_entry->stages[other_st=
age],
>                                     prev_path_desc,
> diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-=
corner-cases.sh
> index 09dfa8bd92..0793f64099 100755
> --- a/t/t6042-merge-rename-corner-cases.sh
> +++ b/t/t6042-merge-rename-corner-cases.sh
> @@ -411,6 +411,124 @@ test_expect_success 'disappearing dir in rename/dir=
ectory conflict handled' '
>         )
>  '
>
> +# Test for basic rename/add-dest conflict, with rename needing content m=
erge:
> +#   Commit O: a
> +#   Commit A: rename a->b, modifying b too
> +#   Commit B: modify a, add different b
> +
> +test_expect_success 'setup rename-with-content-merge vs. add' '
> +       test_create_repo rename-with-content-merge-and-add &&
> +       (
> +               cd rename-with-content-merge-and-add &&
> +
> +               test_seq 1 5 >a &&
> +               git add a &&
> +               git commit -m O &&
> +               git tag O &&
> +
> +               git checkout -b A O &&
> +               git mv a b &&
> +               test_seq 0 5 >b &&
> +               git add b &&
> +               git commit -m A &&
> +
> +               git checkout -b B O &&
> +               echo 6 >>a &&
> +               echo hello world >b &&
> +               git add a b &&
> +               git commit -m B
> +       )
> +'
> +
> +test_expect_success 'handle rename-with-content-merge vs. add' '
> +       (
> +               cd rename-with-content-merge-and-add &&
> +
> +               git checkout A^0 &&
> +
> +               test_must_fail git merge -s recursive B^0 >out &&
> +               test_i18ngrep "CONFLICT (rename/add)" out &&
> +
> +               git ls-files -s >out &&
> +               test_line_count =3D 2 out &&
> +               git ls-files -u >out &&
> +               test_line_count =3D 2 out &&
> +               git ls-files -u b >out &&
> +               test_line_count =3D 2 out &&
> +               git ls-files -o >out &&
> +               test_line_count =3D 1 out &&
> +
> +               test_path_is_missing a &&
> +               test_path_is_file b &&
> +
> +               test_seq 0 6 >tmp &&
> +               git hash-object tmp >expect &&
> +               git rev-parse B:b >>expect &&
> +               git rev-parse >actual  \
> +                       :2:b    :3:b   &&
> +               test_cmp expect actual &&
> +
> +               # Test that the two-way merge in b is as expected
> +               git cat-file -p :2:b >>ours &&
> +               git cat-file -p :3:b >>theirs &&
> +               >empty &&
> +               test_must_fail git merge-file \
> +                       -L "HEAD" \
> +                       -L "" \
> +                       -L "B^0" \
> +                       ours empty theirs &&
> +               git hash-object b >actual &&
> +               git hash-object ours >expect &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'handle rename-with-content-merge vs. add, merge oth=
er way' '
> +       (
> +               cd rename-with-content-merge-and-add &&
> +
> +               git reset --hard &&
> +               git clean -fdx &&
> +
> +               git checkout B^0 &&
> +
> +               test_must_fail git merge -s recursive A^0 >out &&
> +               test_i18ngrep "CONFLICT (rename/add)" out &&
> +
> +               git ls-files -s >out &&
> +               test_line_count =3D 2 out &&
> +               git ls-files -u >out &&
> +               test_line_count =3D 2 out &&
> +               git ls-files -u b >out &&
> +               test_line_count =3D 2 out &&
> +               git ls-files -o >out &&
> +               test_line_count =3D 1 out &&
> +
> +               test_path_is_missing a &&
> +               test_path_is_file b &&
> +
> +               test_seq 0 6 >tmp &&
> +               git rev-parse B:b >expect &&
> +               git hash-object tmp >>expect &&
> +               git rev-parse >actual  \
> +                       :2:b    :3:b   &&
> +               test_cmp expect actual &&
> +
> +               # Test that the two-way merge in b is as expected
> +               git cat-file -p :2:b >>ours &&
> +               git cat-file -p :3:b >>theirs &&
> +               >empty &&
> +               test_must_fail git merge-file \
> +                       -L "HEAD" \
> +                       -L "" \
> +                       -L "A^0" \
> +                       ours empty theirs &&
> +               git hash-object b >actual &&
> +               git hash-object ours >expect &&
> +               test_cmp expect actual
> +       )
> +'
> +
>  # Test for all kinds of things that can go wrong with rename/rename (2to=
1):
>  #   Commit A: new files: a & b
>  #   Commit B: rename a->c, modify b
> --
> 2.22.0.rc3.1.g617c1f72bf
>

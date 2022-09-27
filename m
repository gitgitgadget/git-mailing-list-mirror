Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8F3C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 15:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiI0PEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiI0PEe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 11:04:34 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8662628
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 08:04:32 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id c23so3664122uan.5
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pcLRB70IRYQT8ryXY8VISKhfzkC4DHEzNx/nSCbVpJg=;
        b=MGiZm1bA/9QcWKDey8TfS15SsN4XuvC1iA7sfSLhVgI1DLjP7aOW75br+LWDkVVcFc
         J5opM6kHkdOJbeFEL9Vqk9xefs/7o+b0dXs/ZzD8srnVV5YhoSTcYlp3L9zu+wMCqT/M
         LyghbNdKbTYj7y785ThvO7+eeABNzEzGB95EH7aqp2qYwwtHu0V0oY0VEsy4/+zZktcp
         o8nEPNA2KoC/Mmzou5GNoY1QNQ76LN/uqtBKHr+EgmGGTn+A7GR//YEuF9wdWEzdstS6
         HBkH7KVa8qrCuCOzw2uV29mJJubOx+wdKRYh7YMIpF1XjR1JZcHYSMGsVysNmKgsCfih
         whxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pcLRB70IRYQT8ryXY8VISKhfzkC4DHEzNx/nSCbVpJg=;
        b=bckM4QGK5Qa4rGBIFspkeEsW+Xb0+o+giRpxoax3ZnHwLYACfww6l0G0m4dw6xf4EA
         RHUHINtRP89KL7qK0hfflfXUp5hFuixYUph5M/UXB3Rxww1O4JvUHtA0aQ2mAbts5Kso
         tRVcFgYkDgk/sA92HGcnxEm3QQAwnXwM29XZBoH+W5wp33a3ssq4VMo4y83N9NRSEQXY
         rKb21Hok9hmVzzTFw12DoRJR/BFu4vLFK/YZLxkK6X8EgUp7FWQh9A+LkU5vo+qvmN5o
         n3aunqiUTVZ1V5BjC3Kx3JZZ+BbSg0HNtf05jsegJH0r0dpHvaflms6r5dMP9cUpf+zL
         BaIQ==
X-Gm-Message-State: ACrzQf3J8nDlBf0g2vTDIlTiqWkKSPuzer4sK87L42nBjn0vVblLyk/H
        hWQeg9vK3Oj16uC83POMQKYyIugwqX3q1TRHf+8=
X-Google-Smtp-Source: AMsMyM4bbX0OuvV/b7CncKPGlaoIB69og/aAonwM03V3PWVgg0NHwN0kKu/meWy5BFlCvIytJgSrKUjPxpGqhmO1348=
X-Received: by 2002:ab0:7083:0:b0:3d1:8663:cb9c with SMTP id
 m3-20020ab07083000000b003d18663cb9cmr1189040ual.75.1664291069810; Tue, 27 Sep
 2022 08:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1368.git.1664036052741.gitgitgadget@gmail.com> <CABPp-BE_VUd=kjMb=T0WDvj=kn8fgN92-DtS3HdX+cZPjmhS_w@mail.gmail.com>
In-Reply-To: <CABPp-BE_VUd=kjMb=T0WDvj=kn8fgN92-DtS3HdX+cZPjmhS_w@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 27 Sep 2022 23:04:18 +0800
Message-ID: <CAOLTT8RU1uGLOEZR5h4FyZc3jGAFQ5i62zhrXVqn7qZCMu2wxw@mail.gmail.com>
Subject: Re: [PATCH] diff: introduce --restrict option
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8825=E6=97=
=A5=E5=91=A8=E6=97=A5 05:32=E5=86=99=E9=81=93=EF=BC=9A

>
> Hi ZheNing,
>
> Thanks for working on this!  I've long wanted these options for a few
> commands, but just hadn't gotten back to it, in part because of
> several lingering questions we never resolved.
>
> I'm adding Matheus and Shaoxuan to cc, who both have had similar
> patches (for grep) derailed because we never agreed on option names
> and flags and defaults and whatnot.  (I'll post a big RFC I've been
> working on this week later today so we can discuss that, but thought
> Matheus and Shaoxuan should see this patch too.)
>

I'd love to see some improvements of monorepo on git, So I'm happy to
help (or helped by others) in this area. :-)

> On Sat, Sep 24, 2022 at 9:14 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When we use sparse-checkout, we often want the set of files
> > that some commands operate on to be restricted to the
> > sparse-checkout cone(s).
>
> There are also non-cone users of sparse-checkout, so perhaps "cone(s)"
> =3D> "specification"?
>

Yeah, "specification", "filterspec"... They might be better words.

> > So introduce the `--restrict` option to git diff, which can
> > restrict diff filespec to the sparse-checkout cone(s).
>
> "can"?  Is there times when it doesn't?
>
> "diff filespec" might be okay, but I'd personally prefer talking about
> the "diff output".
>
> And again, there are `--no-cone` users of sparse checkouts so we need
> to avoid "cone(s)" here.
>
> Perhaps something like:
>
>     To allow this, introduce a `--restrict` option to git diff, which
> restricts the diff output to those files matching the sparsity
> specification.
>
> ?
>

Yes, that's good.

> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     diff: introduce --restrict option
> >
> >     In [1], we discovered that users working on different sparse-checko=
ut
> >     cone(s) may download unnecessary blobs from each other's cone(s) in
> >     collaboration. And in [2] Junio suggested that maybe we can restric=
t
> >     some git command's filespec in sparse-checkout cone(s) to elegantly
> >     solve this problem above.
>
> But this doesn't solve that problem, because there's no way to get
> pull to notify merge to pass this extra option to diff...right?  I
> mean it's a step in that direction because you've added the new
> capability, but you'd also need to add a config option which would
> turn this option on by default, and suggest to partial clone +
> sparse-checkout users that they set that config option.  Of course, if
> we do that, we'd also need a `--no-restrict` option to git-diff to
> override such a config option.
>

Make sense. The patch should add an RFC header, because I think
there are a lot of other git command that might need to use this diff --res=
trict
option, e.g. git log... and want you mentioned is git pull.

Do we make it work by git config "diff.restrict=3Dtrue|false" , or do we
just use this
diff option to other git commands, like git log --restrict (like git
log --diff-filter)?

> And if we add a config option, we may want to start the output with a
> warning about the output being restricted.
>

Good advice.

> >     So this patch is attempt to do this thing on git diff:
> >
> >     v1:
> >
> >      1. add --restrict option to git diff, which restrict diff filespec=
 in
> >         sparse-checkout cone(s).
> >
> >     [1]:
> >     https://lore.kernel.org/git/CAOLTT8SHo66kGbvWr=3D+LQ9UVd1NHgqGGEYK2=
qq6=3D=3DQgRCgLZqQ@mail.gmail.com/
> >     [2]: https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1368%=
2Fadlternative%2Fzh%2Fdiff-restrict-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1368/adl=
ternative/zh/diff-restrict-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1368
> >
> >  Documentation/diff-options.txt           |  4 ++
> >  diff.c                                   | 57 ++++++++++++++++++++++++
> >  diff.h                                   |  1 +
> >  t/t1092-sparse-checkout-compatibility.sh | 30 +++++++++++++
> >  4 files changed, 92 insertions(+)
> >
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> > index 3674ac48e92..8ee5b6b4603 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
>
> Note that diff-options.txt is included by not only git-diff.txt, but
> also git-log.txt, git-show.txt, git-format-patch.txt, and a few
> others.  It appears your changes are specific to git-diff, though.  I
> think it'd be nice if they more generally applied to git-log.txt and
> git-show.txt, but we'd have to be careful since they definitely should
> not apply to git-format-patch.txt.
>

I'm a little confused here: git log/git show/git format-patch already
naturally inherits the --restrict option from git diff. If we don't really =
want
the --restrict option in the documentation of git format-patch, does that
mean we should let git format-patch disable --restrict?

> > @@ -631,6 +631,10 @@ Also, these upper-case letters can be downcased to=
 exclude.  E.g.
> >  Note that not all diffs can feature all types. For instance, copied an=
d
> >  renamed entries cannot appear if detection for those types is disabled=
.
> >
> > +--restrict::
> > +       Restrict the diff filespec in the sparse-checkout cone(s).
> > +       See linkgit:git-sparse-checkout[1] for more details.
> > +
>
> It would be nice to also provide a --no-restrict at the same time,
> especially if we even think we might want to make --restrict the
> default in the future[1] or if we want to add config option now or
> soon to treat --restrict as the default when that config option is
> set[2].
>
> We need to get the name nailed down too.  I'm slightly leaning towards
> the name you have used here, but we should note that we currently have
> other commands using --sparse (which confusingly maps to
> --no-restrict), some using --ignore-skip-worktree-bits (also as an
> equivalent for --no-restrict), we have had people propose patches
> using --ignore-sparsity (again as an equivalent for --no-restrict),
> and we've seen a few other suggestions for names like
> --full-tree/--sparse-tree, --dense, and maybe others.
>

Yes, it does get a little cluttered. =E2=80=9Csparse=E2=80=9D was probably =
the most appropriate
name, but some other command like =E2=80=9Cgit rev-list --sparse=E2=80=9D o=
r
"git pack-objects --sparse" has taken precedence and conveyed another
level of meaning. So "restrict" may be an appropriate word in this case.

> There's another question surrounding the option name too -- whether
> these options should be global for git (like --work-tree), or command
> specific.  That is a bit muddled by the fact that different
> subcommands should have different defaults (checkout definitely should
> default to `--restrict` or else sparse checkouts would be essentially
> worthless, but stash and apply need to default to `--no-restrict` or
> we'll drop some of the user's changes.  And it gets worse because we
> also have two variants of not-quite-restrict-but-close for different
> command classes, and not by accident.).  It may also be affected by
> the fact that we'd only want to control a subset of commands with a
> config option (namely, the querying commands (log, diff against
> history, grep against history, etc.) and perhaps the path-modifying
> commands (add/rm/mv)), whereas the rest (like checkout or apply) we
> would only want to allow control with an explicit command line flag
> added by the user.
>

Well, here you answered my question above, I also understood the points
that plagued us in moving forward on this feature:

"Which git commands should we use this -[no]-restrict on?"

> I'm slightly leaning towards command-specific, using --[no-]restrict,
> and defaulting diff for now to --no-restrict...but we really should
> get buy-in on all of this.  I've been working on a big RFC patch
> creating a Documentation/technical/sparse-checkout.txt file so we can
> hammer down these questions.
>

command-specific can make some common git command (i.e.
git format-patch, git stash) have consistent behavior, then use it if
we really need to work on sparse-checkout specification, e.g.
git log, git pull.

I will check your RFC patch later.

> Sorry if that feels like it's derailing you.  It also derailed
> Matheus' changes to grep that he worked on for nearly a year from
> 2020-2021[3], and derailed Shaoxuan's similar changes to grep just
> recently[4], so I'm aware it's a big problem.  Hopefully the RFC will
> let us resolve the questions and unblock these kinds of patches.
>

Ah, the long patch set, I wonder how many collisions happened :)

> [1] https://lore.kernel.org/git/xmqqh719pcoo.fsf@gitster.g/
> [2] https://lore.kernel.org/git/a86af661-cf58-a4e5-0214-a67d3a794d7e@gith=
ub.com/
> [3] https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.=
1612901326.git.matheus.bernardino@usp.br/
> -- see his comment section in particular
> [4] https://lore.kernel.org/git/20220923041842.27817-1-shaoxuan.yuan02@gm=
ail.com/
>
> >  -S<string>::
> >         Look for differences that change the number of occurrences of
> >         the specified string (i.e. addition/deletion) in a file.
> > diff --git a/diff.c b/diff.c
> > index 648f6717a55..95e13607041 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4923,6 +4923,19 @@ static int diff_opt_diff_filter(const struct opt=
ion *option,
> >         return 0;
> >  }
> >
> > +static int diff_opt_diff_restrict(const struct option *option,
> > +                               const char *optarg, int unset)
> > +{
> > +       struct diff_options *opt =3D option->value;
> > +
> > +       BUG_ON_OPT_NEG(unset);
> > +       CALLOC_ARRAY(opt->sparse_checkout_patterns, 1);
> > +
> > +       if (get_sparse_checkout_patterns(opt->sparse_checkout_patterns)=
 < 0)
> > +               FREE_AND_NULL(opt->sparse_checkout_patterns);
> > +       return 0;
>
> Should this be protected by "if (core_apply_sparse_checkout)"?
> Digging into get_sparse_checkout_patterns(), it appears it will throw
> a warning if ${GIT_DIR}/info/sparse-checkout doesn't exist, which
> would be annoying for non-sparse-checkout users.
>

Agree.

> > +}
> > +
> >  static void enable_patch_output(int *fmt)
> >  {
> >         *fmt &=3D ~DIFF_FORMAT_NO_OUTPUT;
> > @@ -5660,6 +5673,9 @@ static void prep_parse_options(struct diff_option=
s *options)
> >                 OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M=
|R|T|U|X|B)...[*]]"),
> >                                N_("select files by diff type"),
> >                                PARSE_OPT_NONEG, diff_opt_diff_filter),
> > +               OPT_CALLBACK_F(0, "restrict", options, NULL,
> > +                              N_("restrict files in sparse-checkout pa=
tterns"),
>
> I'd suggest at least replacing "in" with "to".  I'd also like to avoid
> the word "patterns" since it hints at non-cone mode (in cone mode,
> users specify directories, not patterns, even if patterns exist behind
> the scenes).  Maybe we could change the phrase to something like
> "restrict paths to those matching sparse-checkout specification" would
> be better?
>

Agree.

> > +                              PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff=
_opt_diff_restrict),
> >                 { OPTION_CALLBACK, 0, "output", options, N_("<file>"),
> >                   N_("output to a specific file"),
> >                   PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
> > @@ -6601,6 +6617,24 @@ free_queue:
> >         }
> >  }
> >
> > +
> > +static int match_sparse_checkout_patterns_by_spec(const struct diff_op=
tions *options, struct diff_filespec *spec) {
> > +       int dtype =3D DT_REG;
> > +
> > +       if (!spec)
> > +               return 0;
> > +
> > +       return path_matches_pattern_list(spec->path, strlen(spec->path)=
,
> > +                                        "", &dtype, options->sparse_ch=
eckout_patterns,
> > +                                        the_repository->index) > 0;
> > +}
> > +
> > +static int match_sparse_checkout_patterns(const struct diff_options *o=
ptions, const struct diff_filepair *p)
> > +{
> > +       return match_sparse_checkout_patterns_by_spec(options, p->one) =
||
> > +              match_sparse_checkout_patterns_by_spec(options, p->two);
>
> Most of the time, p->one will match p->two.  Do we want to optimize
> that case to not make both of these calls but just one?
>

Yes, it is true that simplification can be done here.

> > +}
> > +
> >  static int match_filter(const struct diff_options *options, const stru=
ct diff_filepair *p)
> >  {
> >         return (((p->status =3D=3D DIFF_STATUS_MODIFIED) &&
> > @@ -6612,6 +6646,28 @@ static int match_filter(const struct diff_option=
s *options, const struct diff_fi
> >                  filter_bit_tst(p->status, options)));
> >  }
> >
> > +static void diffcore_apply_restrict(struct diff_options *options)
> > +{
> > +       int i;
> > +       struct diff_queue_struct *q =3D &diff_queued_diff;
> > +       struct diff_queue_struct outq;
> > +
> > +       DIFF_QUEUE_CLEAR(&outq);
> > +
> > +       if (!options->sparse_checkout_patterns)
> > +               return;
> > +
> > +       for (i =3D 0; i < q->nr; i++) {
> > +               struct diff_filepair *p =3D q->queue[i];
> > +               if (match_sparse_checkout_patterns(options, p))
> > +                       diff_q(&outq, p);
> > +               else
> > +                       diff_free_filepair(p);
> > +       }
> > +       free(q->queue);
> > +       *q =3D outq;
> > +}
>
> So you're post-processing the results.  I think it'd be better to
> avoid even walking into the trees outside the sparsity paths, much
> like paths listed on the command line do.  That'd also be more
> reusable for log when we add a similar option for it.
>

Yes, the temporary implementation was made by learning from the
-diff-filter implementation. I may have to look at the code elsewhere
if it needs to be filtered at the beginning of the traversal of the file.

> > +
> >  static void diffcore_apply_filter(struct diff_options *options)
> >  {
> >         int i;
> > @@ -6827,6 +6883,7 @@ void diffcore_std(struct diff_options *options)
> >                 /* See try_to_follow_renames() in tree-diff.c */
> >                 diff_resolve_rename_copy();
> >         diffcore_apply_filter(options);
> > +       diffcore_apply_restrict(options);
> >
> >         if (diff_queued_diff.nr && !options->flags.diff_from_contents)
> >                 options->flags.has_changes =3D 1;
> > diff --git a/diff.h b/diff.h
> > index 8ae18e5ab1e..f651216da13 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -396,6 +396,7 @@ struct diff_options {
> >         struct repository *repo;
> >         struct option *parseopts;
> >         struct strmap *additional_path_headers;
> > +       struct pattern_list *sparse_checkout_patterns;
> >
> >         int no_free;
> >  };
> > diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-=
checkout-compatibility.sh
> > index b9350c075c2..4c416ef8e82 100755
> > --- a/t/t1092-sparse-checkout-compatibility.sh
> > +++ b/t/t1092-sparse-checkout-compatibility.sh
>
> The description of this file is
>     test_description=3D'compare full workdir to sparse workdir'
> which seems like a misfit for the tests you are adding.  I'd suggest
> placing them somewhere else.  t1090 might be a good candidate.
>

Agree.

> > @@ -504,6 +504,36 @@ test_expect_success 'diff --cached' '
> >         test_all_match git diff --cached
> >  '
> >
> > +test_expect_success 'diff --restrict' '
> > +       init_repos &&
> > +
> > +       test_all_match mkdir modules &&
> > +       test_all_match touch modules/a &&
> > +       test_all_match touch deep/b &&
> > +       test_all_match git rm deep/a &&
> > +       test_all_match git add --sparse modules deep &&
> > +       run_on_all git diff --restrict --staged --stat &&
> > +       cat >expect <<-EOF &&
> > +        deep/a | 1 -
> > +        deep/b | 0
> > +        2 files changed, 1 deletion(-)
> > +       EOF
> > +       test_cmp expect sparse-checkout-out &&
> > +       cat >expect <<-EOF &&
> > +        deep/a | 1 -
> > +        deep/b | 0
> > +        2 files changed, 1 deletion(-)
> > +       EOF
> > +       test_cmp expect sparse-index-out &&
> > +       cat >expect <<-EOF &&
> > +        deep/a    | 1 -
> > +        deep/b    | 0
> > +        modules/a | 0
> > +        3 files changed, 1 deletion(-)
> > +       EOF
> > +       test_cmp expect full-checkout-out
> > +'
> > +
> >  # NEEDSWORK: sparse-checkout behaves differently from full-checkout wh=
en
> >  # running this test with 'df-conflict-2' after 'df-conflict-1'.
>
> Just a guess, but is this NEEDSWORK perhaps reflecting the fact that
> the test is in the wrong file?
>
> The whole point of --restrict is to make the output you'd get within a
> sparse-checkout NOT match what you'd get in a full checkout, because
> you are restricting the output to a subset.  If you want to compare to
> a full-checkout and make sure the output matches, you'd want to use
> --no-restrict, right?

Yes, a test compare between --restrict and --no-restrict will be better.

Thanks for review~~~
--
ZheNing Hu

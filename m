Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9D81FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754905AbeARV33 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:29:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:58684 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932379AbeARV1q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:27:46 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54fe-1f2KzT3b5i-00zJu3; Thu, 18
 Jan 2018 22:27:41 +0100
Date:   Thu, 18 Jan 2018 22:27:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] sequencer: handle autosquash and post-rewrite for
 merge commands
In-Reply-To: <CA+P7+xr0FpgTUa9SgkXM1U86i8f0cParNqGkP=KNPOR_EqNHYg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801182226160.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <219dbf95a8069190abe0986ca66b65a8ae3e670d.1516225925.git.johannes.schindelin@gmx.de> <CA+P7+xr0FpgTUa9SgkXM1U86i8f0cParNqGkP=KNPOR_EqNHYg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cL0tOex4QJsn+wHReLgk2aiSRCoCnnpZUHYcp1xJCqZMZCDQxzx
 eu+EbOkXTQDv3pDJTPbQWV9i3v9rCtGxfhbEWMIRr9M/ybQIdvxqkxD3Vdqs+suIF1Oumi+
 2k3HFDh4vRdxWXucUfOW332/Suzb2AR/UWMWLc10y04YTeC2jSVKUnAnk9Q8ahevIe0T29v
 Tjm6rPuotgszdPOmJciaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EHrulbxKkEY=:nZ6OER67Mmzu08Fj2u237+
 VYPPN2grlfRa9Qv3sPz3i1fnlfC0VPVfvrS9Kwxpq3K53TP9RYiJBEH4DS085Z1jM5Tr07JcM
 GsuT7OmLl17Rmq5ol2hrGK3mfBqmcsp6YcXuma8Xg2k5aHbMLV0e3CbCqrea+gGsTfVQVqDph
 B4tsGSkcqEUdTjCGK8KtgdeQc3XRpdCKQGBAUdVJszhn+tPiq5F07h/gNtQbU7qpmo5YVlwuV
 x6cpwRgdz8AncEMMBArS23oZ4oY2V9th3dcRhuEn9tRKP6lIpmG+XXail0e1DZbnbrTPt1N12
 RPCNeV2IgWlllYLPy6a2e6KeFXzVFsl6FR6IJgwFvV3zV3N8ayuLl9PXLjQfQ2z/JKE62ZRW9
 spevdgne9FfCp3Td/921KbiPQC5fHwJkCmi4r5Q5evAEoHZKrHRHz7i3oY4p3kP8ScPuij2iy
 1lAXdpeXD98EXLeHFahBlHxPz94a3CR8MSiot1AZy620hksRqEDeocuReOVFbYNNWnzoKeaeD
 AA3oI+F8X82fyntTvFuJlCVwODoemFYu+xhvcbCEMp+w9azLD+CP2+CsTZyi/CsXXREiSBH+8
 DM1HvUEuV/4qefZUoFNsMR1OD2BqZOqSBnGNmAk1BTe6Wvi0osDpcnBYOD1tmPzenlHtEUh0v
 KMqwNHjKpFJpGlf71h81C+4seJzh64Q1+bS7Stp+tAjy4a11MOOvkpaEXL12d4DwU8yUNl0sc
 7gVo77fRiziZ5AfesfMdW/+R4P9xU/qz9nKHJbP8FmWk93P3mIxYIsed3cJEwzhJ0GFEoYWb3
 v+WS7wEswN8CH0/Lk6+Enk+oFWXi97eV+80zQcIyY1IW67oxmQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Thu, 18 Jan 2018, Jacob Keller wrote:

> On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > In the previous patches, we implemented the basic functionality of the
> > `git rebase -i --recreate-merges` command, in particular the `merge`
> > command to create merge commits in the sequencer.
> >
> > The interactive rebase is a lot more these days, though, than a simple
> > cherry-pick in a loop. For example, it calls the post-rewrite hook (if
> > any) after rebasing with a mapping of the old->new commits. And the
> > interactive rebase also supports the autosquash mode, where commits
> > whose oneline is of the form `fixup! <oneline>` or `squash! <oneline>`
> > are rearranged to amend commits whose oneline they match.
> >
> > This patch implements the post-rewrite and autosquash handling for the
> > `merge` command we just introduced. The other commands that were added
> > recently (`label`, `reset` and `bud`) do not create new commits,
> > therefore post-rewrite & autosquash do not need to handle them.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  refs.c                            |  3 ++-
> >  sequencer.c                       | 10 +++++++---
> >  t/t3430-rebase-recreate-merges.sh | 39 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 48 insertions(+), 4 deletions(-)
> >
> > diff --git a/refs.c b/refs.c
> > index 20ba82b4343..e8b84c189ff 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -600,7 +600,8 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
> >  static int is_per_worktree_ref(const char *refname)
> >  {
> >         return !strcmp(refname, "HEAD") ||
> > -               starts_with(refname, "refs/bisect/");
> > +               starts_with(refname, "refs/bisect/") ||
> > +               starts_with(refname, "refs/rewritten/");
> >  }
> 
> Would this part make more sense to move into the commit that
> introduces writing these refs, or does it only matter once you start
> this step here?
> 
> >
> >  static int is_pseudoref_syntax(const char *refname)
> > diff --git a/sequencer.c b/sequencer.c
> > index 1bef16647b4..b63bfb9a141 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2413,10 +2413,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >                         res = do_reset(item->arg, item->arg_len);
> >                 else if (item->command == TODO_BUD)
> >                         res = do_reset("onto", 4);
> > -               else if (item->command == TODO_MERGE)
> > +               else if (item->command == TODO_MERGE) {
> >                         res = do_merge(item->commit,
> >                                        item->arg, item->arg_len, opts);
> > -               else if (!is_noop(item->command))
> > +                       if (item->commit)
> > +                               record_in_rewritten(&item->commit->object.oid,
> > +                                                   peek_command(todo_list, 1));
> > +               } else if (!is_noop(item->command))
> >                         return error(_("unknown command %d"), item->command);
> >
> >                 todo_list->current++;
> > @@ -3556,7 +3559,8 @@ int rearrange_squash(void)
> >                 struct subject2item_entry *entry;
> >
> >                 next[i] = tail[i] = -1;
> > -               if (item->command >= TODO_EXEC) {
> > +               if (item->command >= TODO_EXEC &&
> > +                   (item->command != TODO_MERGE || !item->commit)) {
> >                         subjects[i] = NULL;
> >                         continue;
> >                 }
> > diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
> > index 46ae52f88b3..76e615bd7c1 100755
> > --- a/t/t3430-rebase-recreate-merges.sh
> > +++ b/t/t3430-rebase-recreate-merges.sh
> > @@ -143,4 +143,43 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
> >         EOF
> >  '
> >
> > +test_expect_success 'refs/rewritten/* is worktree-local' '
> > +       git worktree add wt &&
> > +       cat >wt/script-from-scratch <<-\EOF &&
> > +       label xyz
> > +       exec GIT_DIR=../.git git rev-parse --verify refs/rewritten/xyz >a || :
> > +       exec git rev-parse --verify refs/rewritten/xyz >b
> > +       EOF
> > +
> > +       test_config -C wt sequence.editor \""$PWD"/replace-editor.sh\" &&
> > +       git -C wt rebase -i HEAD &&
> > +       test_must_be_empty wt/a &&
> > +       test_cmp_rev HEAD "$(cat wt/b)"
> > +'
> > +
> 
> Same for the test here, I can't figure out why this is necessary in
> this patch as opposed to the patch which first introduced the
> refs/rewritten/<label> refs.

Woops. This was its own commit, and must have been accidentally squashed
during one of my rebases. Will re-introduce it; this is roughly what it
will look like:

-- snipsnap --
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: sequencer: make refs generated by the `label` command worktree-local

This allows for rebases to be run in parallel in separate worktrees
(think: interrupted in the middle of one rebase, being asked to perform
a different rebase, adding a separate worktree just for that job).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/refs.c b/refs.c
index 20ba82b4343..e8b84c189ff 100644
--- a/refs.c
+++ b/refs.c
@@ -600,7 +600,8 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 static int is_per_worktree_ref(const char *refname)
 {
 	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/bisect/");
+		starts_with(refname, "refs/bisect/") ||
+		starts_with(refname, "refs/rewritten/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
index f5e476d948b..50a8eefc81e 100755
--- a/t/t3430-rebase-recreate-merges.sh
+++ b/t/t3430-rebase-recreate-merges.sh
@@ -115,4 +115,18 @@ test_expect_success 'generate correct todo list' '
 	test_cmp expect output
 '
 
+test_expect_success 'refs/rewritten/* is worktree-local' '
+	git worktree add wt &&
+	cat >wt/script-from-scratch <<-\EOF &&
+	label xyz
+	exec GIT_DIR=../.git git rev-parse --verify refs/rewritten/xyz >a || :
+	exec git rev-parse --verify refs/rewritten/xyz >b
+	EOF
+
+	test_config -C wt sequence.editor \""$PWD"/replace-editor.sh\" &&
+	git -C wt rebase -i HEAD &&
+	test_must_be_empty wt/a &&
+	test_cmp_rev HEAD "$(cat wt/b)"
+'
+
 test_done

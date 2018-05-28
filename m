Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6DE11F42D
	for <e@80x24.org>; Mon, 28 May 2018 22:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934927AbeE1WHJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 18:07:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51923 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934924AbeE1WHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 18:07:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so7695713wmc.1
        for <git@vger.kernel.org>; Mon, 28 May 2018 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hesxVYYPisLjs56D+vjhuLh5iHIwjOBfAV/w3iOfk0Y=;
        b=JldsrACSuIddTV1ma0Gn38m82gDXagFQhYmnJxxzKrenJXp0s5AKeReBjJeY1recig
         4zUnrs6ufAZiYILSi32+j2myDf3xfztWlp22fKz6cKfbAJI+aQXLJxNvzksulsnaxBsD
         asqqcWA/31YayKcBbdbfiLy2SSVJ5dil1lXov6C2OxK0JV/I2+5hufY+bWJMmhz8iLDV
         aZFiIfDBYFNjQmjEQpwSx39xo6MqpfXjcoJgaNIIN+mFFQORjT+V5St9blYBgxYhPDfR
         oNYbwRLTeB0QzWeIbDH7HZUYBfR7AGyTrjHql0zxPD7gWm7vwT4V9iVzodLpf3TeDCKT
         auJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hesxVYYPisLjs56D+vjhuLh5iHIwjOBfAV/w3iOfk0Y=;
        b=anQGX7K1hP2bHIT+/euMg4SUCxEDrLfXXrRnw3dNsmCuiaFgAhKjr/48HWzwwDwfdB
         JcQ/9xjUt+djbdqOddB/OHFv/tvgzdKAPmo1mGkbj9CKOQisTDNemVJ+ZysO7F3LMZwH
         sEE+UQciG7ZTlkm/hpnUgpk09Y/OhjGjTniQlx43nHotoP2iSwKURePtZBwBpm8bkFoU
         A+R7JR5MtBy/pH1T/9TICb721j37dG+hxHQWoU1TlznU0mIgfh0X5dBiB5Ad5/uSXqiH
         l5wfwRuD+mf1PmGPA9zSCT/6P5Jag6oh82QA3QpaAfAxUPTEkjwZKy45/qY88qx6fqlO
         JoNQ==
X-Gm-Message-State: ALKqPwdoEU1r17W+0hlX0w1cvzT791fbq8ujHrt9qtijHbYStiwxj8lg
        GcOz3XXQPx6wzOBr57nyoyc=
X-Google-Smtp-Source: AB8JxZqIQLKKkK7gE0Whd+Lc2IOXzRAoroswF3ixt2NzxnYnT2zS0e3ZfpWquzbkmVmHvMr+ZbBWzQ==
X-Received: by 2002:a1c:9383:: with SMTP id v125-v6mr10629877wmd.58.1527545226842;
        Mon, 28 May 2018 15:07:06 -0700 (PDT)
Received: from localhost.localdomain (x4db29f3d.dyn.telefonica.de. [77.178.159.61])
        by smtp.gmail.com with ESMTPSA id 60-v6sm22162197wrc.42.2018.05.28.15.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 May 2018 15:07:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Kevin Bracey <kevin@bracey.fi>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Weird revision walk behaviour
Date:   Tue, 29 May 2018 00:06:51 +0200
Message-Id: <20180528220651.20287-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.993.g55a0f0c723
In-Reply-To: <cb1d7c86-a989-300a-01d2-923e9c29e834@bracey.fi>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com> <20180523173246.GA10299@sigill.intra.peff.net> <20180523173523.GB10299@sigill.intra.peff.net> <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi> <cb1d7c86-a989-300a-01d2-923e9c29e834@bracey.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24/05/2018 23:26, Kevin Bracey wrote:
> >
> >>> On Wed, May 23, 2018 at 07:10:58PM +0200, SZEDER Gábor wrote:
> >>>
> >>>>    $ git log --oneline master..ba95710a3b -- ci/
> >>>>    ea44c0a594 Merge branch 'bw/protocol-v2' into 
> >>>> jt/partial-clone-proto-v2
> >>>>
> > In this case, we're hitting a merge commit which is not on master, but 
> > it has two parents which both are.

Indeed, I didn't notice this important detail amidst the complexity of
the git history.  Thanks, with this info I could come up with a small
test case to demonstrate the issue, see below.

> Which, IIRC, means the merge commit 
> > is INTERESTING with two UNINTERESTING parents; and we are TREESAME to 
> > only one of them.
> >
> > The commit changing the logic of TREESAME you identified believes that 
> > those TREESAME changes for merges which were intended to improve 
> > fuller history modes shouldn't affect the simple history "because 
> > partially TREESAME merges are turned into normal commits". Clearly 
> > that didn't happen here.
> >
> Haven't currently got a development environment set up here, but I've 
> been looking at the code.Here's a proposal, untested, as a potential 
> starting point if anyone wants to consider a proper patch.
> 
> The simplify_history first-scan logic never actually turned merges into 
> simple commits unless they were TREESAME to a relevant/interesting 
> parent.  Anything where the TREESAME parent was UNINTERESTING was 
> retained as a merge, but had its TREESAME flag set, and that permitted 
> later simplification.
> 
> With the redefinition of the TREESAME flag, this merge commit is no 
> longer TREESAME, and as the decoration logic to refine TREESAME isn't 
> active for simplify_history, it doesn't get cleaned up (even if it would 
> be in full history?)
> 
> I think the answer may be to add an extra post-process step on the 
> initial loop to handle this special case. Something like:
> 
>          case REV_TREE_SAME:
>              if (!revs->simplify_history || !relevant_commit(p)) {
>                  /* Even if a merge with an uninteresting
>                   * side branch brought the entire change
>                   * we are interested in, we do not want
>                   * to lose the other branches of this
>                   * merge, so we just keep going.
>                   */
>                  if (ts)
>                      ts->treesame[nth_parent] = 1;
> +               /* But we note it for potential later simplification */
> +               if (!treesame_parent)
> +                    treesame_parent = p;
>                  continue;
>               }
> 
> ...
> 
> After loop:
> 
> +     if (relevant_parents == 0 && revs->simplify_history && 
> treesame_parent) {
> +           treesame_parent->next = NULL;// Repeats code from loop - 
> share somehow?
> +           commit->parents = treesame_parent;
> +           commit->object.flags |= TREESAME;
> +           return;
> +    }
> 
>       /*
>        * TREESAME is straightforward for single-parent commits. For merge

So, without investing nearly enough time to understand what is going
on, I massaged the above diffs into this:

  ---  >8 ---

diff --git a/revision.c b/revision.c
index 4e0e193e57..0ddd2c1e8a 100644
--- a/revision.c
+++ b/revision.c
@@ -605,7 +605,7 @@ static inline int limiting_can_increase_treesame(const struct rev_info *revs)
 
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
-	struct commit_list **pp, *parent;
+	struct commit_list **pp, *parent, *treesame_parents = NULL;
 	struct treesame_state *ts = NULL;
 	int relevant_change = 0, irrelevant_change = 0;
 	int relevant_parents, nth_parent;
@@ -672,6 +672,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		switch (rev_compare_tree(revs, p, commit)) {
 		case REV_TREE_SAME:
 			if (!revs->simplify_history || !relevant_commit(p)) {
+				struct commit_list *tp;
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
 				 * we are interested in, we do not want
@@ -680,6 +681,13 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				 */
 				if (ts)
 					ts->treesame[nth_parent] = 1;
+				/* But we note it for potential later
+				 * simplification
+				 */
+				tp = treesame_parents;
+				treesame_parents = xmalloc(sizeof(*treesame_parents));
+				treesame_parents->item = p;
+				treesame_parents->next = tp;
 				continue;
 			}
 			parent->next = NULL;
@@ -716,6 +724,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		die("bad tree compare for commit %s", oid_to_hex(&commit->object.oid));
 	}
 
+	if (relevant_parents == 0 && revs->simplify_history &&
+	    treesame_parents) {
+		commit->parents = treesame_parents;
+		commit->object.flags |= TREESAME;
+		return;
+	} else
+		free_commit_list(treesame_parents);
+
 	/*
 	 * TREESAME is straightforward for single-parent commits. For merge
 	 * commits, it is most useful to define it so that "irrelevant"

  ---  >8 ---

FWIW, the test suite passes with the above patch applied.

And here is the small PoC test case to illustrate the issue, which
fails without but succeeds with the above patch.  Eventually it should
be part of 't6012-rev-list-simplify.sh', of course, but I haven't
looked into that yet.


  ---  >8 ---

diff --git a/t/t9999-weird-revision-walk-behaviour.sh b/t/t9999-weird-revision-walk-behaviour.sh
new file mode 100755
index 0000000000..22820f845b
--- /dev/null
+++ b/t/t9999-weird-revision-walk-behaviour.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='PoC weird revision walk behaviour test'
+
+. ./test-lib.sh
+
+# Create the following history, i.e. where both parents of merge 'M1'
+# are in 'master':
+#
+#   B---M2   master
+#  / \ /
+# A   X
+#  \ / \
+#   C---M1   b2
+#
+# and modify 'file' in commits 'A' and 'B', so one of 'M1's parents
+# ('B') is TREESAME wrt. 'file'.
+test_expect_success 'setup' '
+	test_commit initial file &&	# A
+	test_commit modified file &&	# B
+	git checkout -b b1 master^ &&
+	test_commit other-file &&	# C
+	git checkout -b b2 master &&
+	git merge --no-ff b1 &&		# M1
+	git checkout master &&
+	git merge --no-ff b1		# M2
+'
+
+test_expect_success 'debug' '
+	git log --oneline --graph --all
+'
+
+test_expect_success "\"Merge branch 'b1' into b2\" should not be shown" '
+	git log master..b2 -- file >actual &&
+	test_must_be_empty actual
+'
+
+test_done



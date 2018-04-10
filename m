Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE731F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeDJMaW (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:30:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:36247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752585AbeDJMaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:30:19 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MHoWj-1f2q8v10Cj-003fl2; Tue, 10 Apr 2018 14:30:12 +0200
Date:   Tue, 10 Apr 2018 14:30:11 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 11/15] sequencer: handle post-rewrite for merge commands
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <3316ce1ee802d0bded8c47e3ad2abd00ea63956c.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NLmjMpyyyizeUG5+NUArDm6XvEYVZXCI+h2z9iww72iMKkX6oOa
 /TI0cAHHSUysF0ekTalTEEmqHQkT88dSNeyQPHXm9/R0C6i1tsq/Q6pxMqb+QUES07Qsmc4
 oHnFb0Hd2eNd7w+ZdQWLOmVGyQhC9Br8LmKhfUKXYcvpaLjJzG4sxCbjlqSo+bSeI0fX7Kj
 UE4T0a5wPpI06QgnQQsgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rfj0bGzWFYA=:uM2C/QfFJCxOhG9fHiC7hV
 hYG7pNEWTOxmN5m2TTA4cabrLY+x6b+z6Jq9SgzHmbsmxm8XTf9q5+TFD7cuH+uwjRtI0roY3
 dK8HswZnFt3u5ufmX0ntk2EgpRTiq45W5jHHxNMvJcbR4WEb9vVzmHsXtGY3IXL8R3QlPCrWR
 SgIHht0TMxSRYTY4hfal6ODQxSyxxTdBHu2XzeH1jnYk9pgNvZJjpklwJU10jeFEByy1v4mPc
 Xk9OWHoFR8+wSGMdXun9uO2hNP+guZeYfYSDMkOdQAacl+7vDMY+PAHz+/Grj950HuTnQAEmz
 0Snd1VCh0kYok7tXd/y8FGbhg89/Pmssfjo97vF0ReF8LblH5WpXjK6fz9W4zwm2R9Scn6stZ
 KC/V17c1BAplNoGKtjYZY4OTeUQKbzyA0pFKIcdQ1C9PZEkCirdRosY2zXhDEoWb8zsuluyhF
 6BSeLwBUwIIHs8IpaTpCKJ6njjyLrJzMcm3jg+90WyYIOH4bot7bsUav3WEho5PYVUVhQP0ql
 j40Vc8HP5YhUZIGdiXn6fOE7a7016EAyrSjSwDkBKgy94VqucZf7tuW49w8EUDDVMqkUNBeiX
 oBkUrEv1lNy8uvj6Kxk79G8Z7NxZd/cih9xlBzyF9PGDvd3Z5jDI/lgfK90K34Ur/n33+7OEL
 qHt78vu2UN83QN6o027LqSFik3xIgtAXQ7Ud8J6PBMYKm8W3G2aaYoGagG7SKTOp/mdcjWGPN
 kcva1CIHu+BLyz40jZaXCP/szmjY+yHmpS/DB9E+vtENfLFQxor2w6rlByHzXZBPvkTc+Z9ON
 FE30+42Nc101xaL2rSDz9pI5ir32sIlmiN60g2DRNj3yQs8qqE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patches, we implemented the basic functionality of the
`git rebase -i --rebase-merges` command, in particular the `merge`
command to create merge commits in the sequencer.

The interactive rebase is a lot more these days, though, than a simple
cherry-pick in a loop. For example, it calls the post-rewrite hook (if
any) after rebasing with a mapping of the old->new commits.

This patch implements the post-rewrite handling for the `merge` command
we just introduced. The other commands that were added recently (`label`
and `reset`) do not create new commits, therefore post-rewrite hooks do
not need to handle them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              |  7 +++++--
 t/t3430-rebase-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 422c71db975..878ff449fe8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3012,10 +3012,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_label(item->arg, item->arg_len);
 		else if (item->command == TODO_RESET)
 			res = do_reset(item->arg, item->arg_len, opts);
-		else if (item->command == TODO_MERGE)
+		else if (item->command == TODO_MERGE) {
 			res = do_merge(item->commit, item->arg, item->arg_len,
 				       item->flags, opts);
-		else if (!is_noop(item->command))
+			if (item->commit)
+				record_in_rewritten(&item->commit->object.oid,
+						    peek_command(todo_list, 1));
+		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 95f99d965c1..392c1136973 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -157,4 +157,29 @@ test_expect_success 'refs/rewritten/* is worktree-local' '
 	test_cmp_rev HEAD "$(cat wt/b)"
 '
 
+test_expect_success 'post-rewrite hook and fixups work for merges' '
+	git checkout -b post-rewrite &&
+	test_commit same1 &&
+	git reset --hard HEAD^ &&
+	test_commit same2 &&
+	git merge -m "to fix up" same1 &&
+	echo same old same old >same2.t &&
+	test_tick &&
+	git commit --fixup HEAD same2.t &&
+	fixup="$(git rev-parse HEAD)" &&
+
+	mkdir -p .git/hooks &&
+	test_when_finished "rm .git/hooks/post-rewrite" &&
+	echo "cat >actual" | write_script .git/hooks/post-rewrite &&
+
+	test_tick &&
+	git rebase -i --autosquash -r HEAD^^^ &&
+	printf "%s %s\n%s %s\n%s %s\n%s %s\n" >expect $(git rev-parse \
+		$fixup^^2 HEAD^2 \
+		$fixup^^ HEAD^ \
+		$fixup^ HEAD \
+		$fixup HEAD) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.17.0.windows.1.4.g7e4058d72e3



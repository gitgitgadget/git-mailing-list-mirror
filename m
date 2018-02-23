Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4A41F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeBWMjb (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:39:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:45713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeBWMja (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:39:30 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0PdN-1ebNbj333V-00udux; Fri, 23
 Feb 2018 13:39:22 +0100
Date:   Fri, 23 Feb 2018 13:39:07 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 10/12] sequencer: handle post-rewrite for merge commands
In-Reply-To: <cover.1519389319.git.johannes.schindelin@gmx.de>
Message-ID: <8ecddf181eeaa9c6bfc9ff573562f9bd9d3d32a5.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U0ivv25LKKKymv73zfsV8zw74b3sUvA3UrRqPRuy3B13lvbB8Th
 E8uFI4nO8iJ0Ub/LNhLBEQ8B+hLc33wL32/rVF68l2iED/rus6IQNEOp1eQX0lo5MYVY66E
 rkSkeMNsHFn2Aa2PbgETBOiOKLQnF9jA41PcReynXthBRnnSIzlnXTbmLQu/9GUmTdoS1I8
 vbIdx80IQh14wdlVm1KHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FK/Ub/2NPTY=:z0dOTNCnlpWOp85gA7cuHa
 8Ay5CckZX9UyLLyxH7rmkkp/29MounGOFDtF+D6H7+2M6Gn8OdwSH1hEq+N5AvZCdzvJa9Qzj
 iDlI+5SQkaN4ExgCgA+qWiikQ+M2FxR8pXdcpPQf6P4J3OOIuwsuuKc6P/t5ERkTF3wKSalXS
 rcFgrVRA4gl4nWlFPUEDr0e0Fqd/DpduNO6/gOnXgDhAmCo0595+WNxPwgvccu9BQGsrgQR6Z
 2TTyWsAtTGbqWsA9T/WsY+elHNbZo55Tt1rlFbfDB3xBUEQxMtL/5+nzzKQKaVy1Fmem9eMLV
 U7Xm77fd//RIqL/zqjDAfHh/Z9Oyq42zMXv189my2IzImbv1GpBDH8uJ71GELU1lskdVmelKv
 h41dRJp+fGDyMnT5r+lNFzPD7G0kf2A5mra9eixutrduc7ER0gA3mdykaYcMx2sEz2BdCHVMh
 s3Jb2Sgjk5m+qXNXV1cetksEW3/8yDlQPRd3ygznHEBuExY3mYXwJK1vOBMLiz9jjIXLWQkOk
 UufzNv38hm2EfzqpcBsGpNIkqd8FwhJ32B3l7nEq5EtZzIjPGCKnzMwAqqj77HgpbRx+lWnzk
 xNKPU9oOUGXCIBWRIdF9aqVw5swCmRE2Hqte7CKHUlyGbOSanGKKkVgYnVGUJ3GcCxJTc6PWx
 FiZHSDPnWmTylm2TGWbsJFIiwa9LH8+5i8yGSA8GQFy2m6e1a/zrUZrtIz7GM05/8Oo9JnXG5
 QcnrR/b5S0XYDL9joEioVhwEgp7/ToKYyIlNYLNL6rBUqD/SMoxA7mTW9nwhMKyScdEePbJqd
 ddhvR8iuwmHeJMOTwwdSl3VZJeOJEoFastjK25yzotRmnchhgw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patches, we implemented the basic functionality of the
`git rebase -i --recreate-merges` command, in particular the `merge`
command to create merge commits in the sequencer.

The interactive rebase is a lot more these days, though, than a simple
cherry-pick in a loop. For example, it calls the post-rewrite hook (if
any) after rebasing with a mapping of the old->new commits.

This patch implements the post-rewrite handling for the `merge` command
we just introduced. The other commands that were added recently (`label`
and `reset`) do not create new commits, therefore post-rewrite do not
need to handle them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                       |  7 +++++--
 t/t3430-rebase-recreate-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 01bafe2fe47..85ce37cb99f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2980,11 +2980,14 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		else if (item->command == TODO_RESET)
 			res = do_reset(item->arg, item->arg_len, opts);
 		else if (item->command == TODO_MERGE ||
-			 item->command == TODO_MERGE_AND_EDIT)
+			 item->command == TODO_MERGE_AND_EDIT) {
 			res = do_merge(item->commit, item->arg, item->arg_len,
 				       item->command == TODO_MERGE_AND_EDIT ?
 				       EDIT_MSG | VERIFY_MSG : 0, opts);
-		else if (!is_noop(item->command))
+			if (item->commit)
+				record_in_rewritten(&item->commit->object.oid,
+						    peek_command(todo_list, 1));
+		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
index 1a3e43d66ff..35a61ce90bb 100755
--- a/t/t3430-rebase-recreate-merges.sh
+++ b/t/t3430-rebase-recreate-merges.sh
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
+	git rebase -i --autosquash --recreate-merges HEAD^^^ &&
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
2.16.1.windows.4



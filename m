Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A6DCCA47F
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbiF1N2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbiF1N1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02083336D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k129so5948857wme.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ytd2ggdFgQN3ECqt4DEJXXwxUL5kTtrxYj01UpRwi5A=;
        b=e99c9I+aIrx/qPiPn2NizIFMGhkvNgy//hP6yufEl/PxIQhtCi2iel4sAwsfhRQyYm
         MmSBj6l9Jfc7W64a/dXQ9U8G5E0PHkQfmud2pb9SpRC6wF7BiyHBfviYJqMiPW6KnYbv
         MVhxcccE5Z94v+yZ3K4KtlJfj7UEDGhGwOt7LaKYSzo/NRDt0kNXlHd0RDlWdD0qf24v
         Ojryqwjfy0MfX/PKWuHCkCxASV6D/iqGUoBJQRWudNZ6yQX5weSP2L8FtEwpl589Soeh
         2WxSrIF9xyevdV6KkSLNrOsVVvqKbIeBA2m0lFYBRXUn7Maixdl+wqFivDpsu4t14LDt
         b5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ytd2ggdFgQN3ECqt4DEJXXwxUL5kTtrxYj01UpRwi5A=;
        b=6hDUY2odDWU0SCSIMiYMAYJBeICbcXEiZb0tu3HCTx3dMokYFhOfUWma0cKNFmuPRH
         V5ptmWqNTivqTtEgVq9owIGkvDIIRLMA4ll1xTgBs/NnVCRsSu7pc3opQAahigzpgh8l
         8f0930Vh7FokOK8H57JZE4azFcmrpboSZ8vHMuafeBqvUHsxK3xBZQBd1kBOPCNp9psM
         8POEBMXrFr5pb2aSqQjfcJ78EioHD0r/RQK+r2dtHXfMqW0oIbwhFLD1s0mXOOK7Fk/3
         BxWruXB7JK8Yafbu3uHqn1mG3LMNbIgsQbLpXope9RZqw5KpEaqU7x4YswbNZkdCdrh0
         JK0Q==
X-Gm-Message-State: AJIora8vaJfJ2ogGP01G8KCqDah9ahJ+MM/NrBrIWfOEG+LcZDT6NBE1
        QiL8G6SGnL634ezJ3fgiXB1TKtzFD3990w==
X-Google-Smtp-Source: AGRyM1uUWTuQotep8K8Er9o1uNXcDZ+cje86c2N7YsiSLfCjUzV+c8i/qXdrUIfp99Ar9fjSKGsJ+A==
X-Received: by 2002:a05:600c:198f:b0:39c:8417:5daf with SMTP id t15-20020a05600c198f00b0039c84175dafmr27317973wmq.110.1656422766127;
        Tue, 28 Jun 2022 06:26:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c00cf00b0039ee51fda45sm17156149wmm.2.2022.06.28.06.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:26:05 -0700 (PDT)
Message-Id: <e95ad41d3551244ea98c43145a089ecfd2536e54.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:25:56 +0000
Subject: [PATCH v3 5/8] sequencer: add update-ref command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Add the boilerplate for an "update-ref" command in the sequencer. This
connects to the current no-op do_update_ref() which will be filled in
after more connections are created.

The syntax in the todo list will be "update-ref <ref-name>" to signal
that we should store the current commit as the value for updating
<ref-name> at the end of the rebase.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 rebase-interactive.c |  3 +++
 sequencer.c          | 14 +++++++++++++-
 sequencer.h          |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 22394224faa..1ff07647af3 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -57,6 +57,9 @@ void append_todo_help(int command_count,
 "        create a merge commit using the original merge commit's\n"
 "        message (or the oneline, if no original merge commit was\n"
 "        specified); use -c <commit> to reword the commit message\n"
+"u, update-ref <ref> = track a placeholder for the <ref> to be updated\n"
+"                      to this position in the new commits. The <ref> is\n"
+"                      updated at the end of the rebase\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
diff --git a/sequencer.c b/sequencer.c
index 2ffee79619c..0b61835d441 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1696,6 +1696,7 @@ static struct {
 	[TODO_LABEL] = { 'l', "label" },
 	[TODO_RESET] = { 't', "reset" },
 	[TODO_MERGE] = { 'm', "merge" },
+	[TODO_UPDATE_REF] = { 'u', "update-ref" },
 	[TODO_NOOP] = { 0,   "noop" },
 	[TODO_DROP] = { 'd', "drop" },
 	[TODO_COMMENT] = { 0,   NULL },
@@ -2457,7 +2458,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 			     command_to_string(item->command));
 
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
-	    item->command == TODO_RESET) {
+	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
@@ -4056,6 +4057,11 @@ leave_merge:
 	return ret;
 }
 
+static int do_update_ref(struct repository *r, const char *ref_name)
+{
+	return 0;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -4431,6 +4437,12 @@ static int pick_commits(struct repository *r,
 				return error_with_patch(r, item->commit,
 							arg, item->arg_len,
 							opts, res, 0);
+		} else if (item->command == TODO_UPDATE_REF) {
+			struct strbuf ref = STRBUF_INIT;
+			strbuf_add(&ref, arg, item->arg_len);
+			if ((res = do_update_ref(r, ref.buf)))
+				reschedule = 1;
+			strbuf_release(&ref);
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
diff --git a/sequencer.h b/sequencer.h
index 3ae541bb145..2cf5c1b9a38 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -95,6 +95,7 @@ enum todo_command {
 	TODO_LABEL,
 	TODO_RESET,
 	TODO_MERGE,
+	TODO_UPDATE_REF,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
-- 
gitgitgadget


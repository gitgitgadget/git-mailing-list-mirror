Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06603C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiGLNHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGLNH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20519B523A
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l68so4688508wml.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=stRNxZ4AfG44vt1jEARC9vbPev/VMKbCYW2oFy5pmQM=;
        b=G38D/Yq8WDnWe+w+qVRL7umZXT+qdqYy4xKzy8ytYZmK7rVbdzcHywRGP4LoWwNeFW
         mMy1VIygkss7A6qnibW2fcV5popeBSsENeHd8QbVO1XnsbJQ54pOEns6pZ2HfMayHN3T
         503Qez1fdVIVBlTAjkToFtk119NW/J/ycfarDo54bHyZ9XJDGYg4Z8SD7ibCE6fZaxCC
         pMr8D0aN1IGymZjY48oyyAtg9CVQenAKfUeZKNHf45mKf6w7KY7r0DG87JGjzqo8F+dL
         mIrTkrK30MiimsJB1fK2VT8TrElh63o3c9AK0ftmdfDuSO7vht8c6JgthdueIBoK82hi
         /sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=stRNxZ4AfG44vt1jEARC9vbPev/VMKbCYW2oFy5pmQM=;
        b=CxjobZQe7+p4H1nLsm5CNc28p4mwPAQq1184V20QpXfVgFhITDKpqRwmMI0M2zTeIp
         EjjRnS1I31gB+tpRQvdHsMlMBTyLOgtXf5cE+5rgU7Fro3Eu4Jsnv4E2CjrTRWISLDY/
         Eze+N0eqiwQF1DqBwLSn3WdH3+IydvpwFKMZRITL8UESXOtFTO0zc55hIXkNKnJVjVH5
         C86ictmv60EmCNNIgYDXLPaDC0Lysbixhax0rbQQROgxoMN81sF4spl+01bRgKKGZTMb
         hFe0k1rAejPfB/DOs59mOwwr99AY7x3xy68A20FpIFVm8CblT1qPhBbEtw5fSXtGWOoe
         icLg==
X-Gm-Message-State: AJIora+8RUI2vi76NfSmXtX5JZGFIQBa3iHsFjGEjwG9j7Vihq/MgclB
        p3noaeC3y+nef+2qQ+BQT5ApZqP7ams=
X-Google-Smtp-Source: AGRyM1vN+0rLDO0/LLxeYkn1nRthihLOa9MB+vpS5R6ALT1N7glFto9zC1MH2P7az7JuwGAhT5lqzA==
X-Received: by 2002:a05:600c:3641:b0:3a2:df38:7ec8 with SMTP id y1-20020a05600c364100b003a2df387ec8mr3812707wmq.34.1657631238246;
        Tue, 12 Jul 2022 06:07:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020adfd841000000b0021d73772c87sm8013988wrl.91.2022.07.12.06.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:17 -0700 (PDT)
Message-Id: <fa7ecb718cfb404c791d6d107799aa2756ca7ee2.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:06:59 +0000
Subject: [PATCH v4 06/12] sequencer: add update-ref command
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
index 575f9be5ea0..1d6442c9639 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1719,6 +1719,7 @@ static struct {
 	[TODO_LABEL] = { 'l', "label" },
 	[TODO_RESET] = { 't', "reset" },
 	[TODO_MERGE] = { 'm', "merge" },
+	[TODO_UPDATE_REF] = { 'u', "update-ref" },
 	[TODO_NOOP] = { 0,   "noop" },
 	[TODO_DROP] = { 'd', "drop" },
 	[TODO_COMMENT] = { 0,   NULL },
@@ -2480,7 +2481,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 			     command_to_string(item->command));
 
 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
-	    item->command == TODO_RESET) {
+	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
 		item->commit = NULL;
 		item->arg_offset = bol - buf;
 		item->arg_len = (int)(eol - bol);
@@ -4079,6 +4080,11 @@ leave_merge:
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
@@ -4454,6 +4460,12 @@ static int pick_commits(struct repository *r,
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


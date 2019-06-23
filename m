Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D291F1F461
	for <e@80x24.org>; Sun, 23 Jun 2019 20:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFWUGV (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 16:06:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47099 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFWUGV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 16:06:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so6227225pfy.13
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXlgn2RLQiB+pwvjujW1AIFhXcPY2wIhLojiaXmaZ0o=;
        b=IFT69nztQan4FvXo8GmED1MtAtF5svKNcAZ/6AtEvzMcogUQ4tWHcGEwo5HBhYEeF8
         hcz7Dtc35/L05fmIg9gybGJorEAaMDKU4pQnpX0pLS+/mimK7NHA02BAxl/XWAPWOYB9
         dfVz4k6UDqdkkzHC5+2kEqqUVCkttLBxS1788J7FmkzkakS+kWUwuI72rx/U8pVmqWiH
         IThyWGsxs8SQyUkag8TqtG2FEhbECvZI99S33q4dTso4++Wr59QHh3go2zHNK2w8LnQf
         xoJgoPtSIRYM3jzgKH8HH+jS6byGSzfwwAYFw1VLV1g4H3HUlxMI1/Ldgp+CjGKg/wSz
         jk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXlgn2RLQiB+pwvjujW1AIFhXcPY2wIhLojiaXmaZ0o=;
        b=AwWApTty15ROwDtB8WT4Fz4lmqYjNlef1jVdBCC9kRPlIOKBODq7sSZpxwbFA+ihfS
         d/S+Q/3CDBQSkOeu9M/rjVNdZRQtL1pK/cMh2XIKvUBOAj/KyeHJ5DqYxa62/hxKSuA+
         rdiK3Hlq7cUq8NAGEUWKtKkIMl9/ONXtaCTboVClZ6hncnRsAwePTzYUAoV5e5JBJSwG
         WnlJcDiV9Al5wN638VMtel0wfSkLPl5bcMbwUz1+4TasktnRVzCQV7YttLt0FPlIIwFj
         A9iYP8d0jyuovJRbVqSy/2aHkYpE55QeLj9dMT0QPIGA5sf6OaI1v0QZlojnXCEePPjq
         m++A==
X-Gm-Message-State: APjAAAW74optLnqdgeAbePeLY9OSJwoCczxTe3lvp6CtyIAMrlKRvRQA
        mN8tFKn7tXhk/WRqbENfWWM=
X-Google-Smtp-Source: APXvYqx7ybRSSKb92VIC0WMiI2Dz/2VL+5N0TFnddO5H/87NQTqJ+Xx4Lq1Sryh//JUFAM1DTd//hQ==
X-Received: by 2002:a63:2249:: with SMTP id t9mr29704341pgm.149.1561320379893;
        Sun, 23 Jun 2019 13:06:19 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.213])
        by smtp.gmail.com with ESMTPSA id 27sm8621882pgt.6.2019.06.23.13.06.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 13:06:19 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v7 6/6] cherry-pick/revert: advise using --skip
Date:   Mon, 24 Jun 2019 01:33:38 +0530
Message-Id: <20190623200338.17144-7-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit introduced a --skip flag for cherry-pick and
revert. Update the advice messages, to tell users about this less
cumbersome way of skipping commits. Also add tests to ensure
everything is working fine.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 builtin/commit.c                | 13 ++++++++-----
 sequencer.c                     |  9 ++++++---
 t/t3510-cherry-pick-sequence.sh | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1c9e8e2228..1f47c51bdc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -60,15 +60,18 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
 "\n");
 
 static const char empty_cherry_pick_advice_single[] =
-N_("Otherwise, please use 'git reset'\n");
+N_("Otherwise, please use 'git cherry-pick --skip'\n");
 
 static const char empty_cherry_pick_advice_multi[] =
-N_("If you wish to skip this commit, use:\n"
+N_("and then use:\n"
 "\n"
-"    git reset\n"
+"    git cherry-pick --continue\n"
 "\n"
-"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
-"the remaining commits.\n");
+"to resume cherry-picking the remaining commits.\n"
+"If you wish to skip this commit, use:\n"
+"\n"
+"    git cherry-pick --skip\n"
+"\n");
 
 static const char *color_status_slots[] = {
 	[WT_STATUS_HEADER]	  = "header",
diff --git a/sequencer.c b/sequencer.c
index f5e3d60878..2e7b16b75f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2655,18 +2655,20 @@ static int create_seq_dir(struct repository *r)
 	enum replay_action action;
 	const char *in_progress_error = NULL;
 	const char *in_progress_advice = NULL;
+	unsigned int advise_skip = file_exists(git_path_revert_head(r)) ||
+				file_exists(git_path_cherry_pick_head(r));
 
 	if (!sequencer_get_last_command(r, &action)) {
 		switch (action) {
 		case REPLAY_REVERT:
 			in_progress_error = _("revert is already in progress");
 			in_progress_advice =
-			_("try \"git revert (--continue | --abort | --quit)\"");
+			_("try \"git revert (--continue | %s--abort | --quit)\"");
 			break;
 		case REPLAY_PICK:
 			in_progress_error = _("cherry-pick is already in progress");
 			in_progress_advice =
-			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
+			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
 			break;
 		default:
 			BUG("unexpected action in create_seq_dir");
@@ -2675,7 +2677,8 @@ static int create_seq_dir(struct repository *r)
 	if (in_progress_error) {
 		error("%s", in_progress_error);
 		if (advice_sequencer_in_use)
-			advise("%s", in_progress_advice);
+			advise(in_progress_advice,
+				advise_skip ? "--skip | " : "");
 		return -1;
 	}
 	if (mkdir(git_path_seq_dir(), 0777) < 0)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 20515ea37b..793bcc7fe3 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -172,6 +172,26 @@ test_expect_success 'check advice when we move HEAD by committing' '
 	test_i18ncmp expect advice
 '
 
+test_expect_success 'selectively advise --skip while launching another sequence' '
+	pristine_detach initial &&
+	cat >expect <<-EOF &&
+	error: cherry-pick is already in progress
+	hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
+	fatal: cherry-pick failed
+	EOF
+	test_must_fail git cherry-pick picked..yetanotherpick &&
+	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_i18ncmp expect advice &&
+	cat >expect <<-EOF &&
+	error: cherry-pick is already in progress
+	hint: try "git cherry-pick (--continue | --abort | --quit)"
+	fatal: cherry-pick failed
+	EOF
+	git reset --merge &&
+	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_i18ncmp expect advice
+'
+
 test_expect_success 'allow skipping commit but not abort for a new history' '
 	pristine_detach initial &&
 	cat >expect <<-EOF &&
-- 
2.21.0


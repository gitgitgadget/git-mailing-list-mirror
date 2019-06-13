Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76E31F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404343AbfFMQuF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:50:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45579 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMEHn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 00:07:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so10913734pfm.12
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 21:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwL8yViKW9OLERyRCQ/aUXLFvTpWyWU21Ur0R3kBaJU=;
        b=uan4dMWkQFhAu0DRnJuct9svvslytXeIe7kSXGF7ZsTS89x1QTYyeasT6m9qBlj4Av
         tPLbmlWvxQrkydxK9g3km6HkjHk8poyjocUAQJ564IXtPqoqtzk4ETLjjHSMCWlW91aR
         psakBFfzBcwA9EZm47fWDpdHYY/P8sTyNOePuX1KD6a4VArE1UKoYE7ljtyD/SZwzmqV
         1owbq4Ss6KzLuByjna528uDWUTpZEilvOuggkljP2bx1lU1AOC/HH3ZdSP0m+0fZovTw
         FeXfFb3ThWzjPB4c7t3SfDTpo+EEqGhri0swik2sGa5awrYJPU0AfWwhTqrfp1g6T+1R
         fdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwL8yViKW9OLERyRCQ/aUXLFvTpWyWU21Ur0R3kBaJU=;
        b=TTUq45ooBqEDs5dPYq9YGJKPuhyHXzCbeeM1UUYvX9qgVuHTxQgv52HFQ9UOP1iDex
         NCy/WhN3rTYAPwtHDMyfzIHRy9LbnVTV0raFxbqGvvgnF6jKeIXRUipal1C5Mp2OmFl+
         JBuwYJIMIyHmF47zSucm/VluPk/oqi0CGs+hEycU86n8+4Umw+LZ6lzeavUyLHviy6gT
         M02U9R0cnYfIzQaI6z3zrVdv1mc5VoaUtrzEdSVLSzBh0CHllLgdZB7nwAYdFBjPstRU
         HXnCIQk6BQWwWwCmyELBUSKseJgZeLdF6Rxc+GYB5EUzZMMnhybvdE8flNMG+aWeSbXg
         5fMA==
X-Gm-Message-State: APjAAAVx/neYC2wdX7FKAw/2Go5qFsHQNnSY7mXM59qKMDxZO2Z6FLlA
        py1NV9swcXRRWOiqrMCUVTI=
X-Google-Smtp-Source: APXvYqyN2QRbF1dVeR6BQGE04tGQnx2ogCrj3NZyy+1uknULvompwiZq8iZxCIFpr5sW0OqdVnJfiQ==
X-Received: by 2002:a17:90a:b908:: with SMTP id p8mr2776851pjr.94.1560398862610;
        Wed, 12 Jun 2019 21:07:42 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:2894:35ed:6485:6224:95ac])
        by smtp.gmail.com with ESMTPSA id k197sm1073288pgc.22.2019.06.12.21.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 21:07:41 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v3 3/3] cherry-pick/revert: advise using --skip
Date:   Thu, 13 Jun 2019 09:35:04 +0530
Message-Id: <20190613040504.32317-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
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
changes:
    - No major changes, change slightly according to the previous commits

 builtin/commit.c                | 13 ++++++++-----
 sequencer.c                     | 11 ++++++++---
 t/t3510-cherry-pick-sequence.sh | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

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
index 6b78a26920..5d189791ee 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2655,18 +2655,20 @@ static int create_seq_dir(struct repository *r)
 	enum replay_action action;
 	const char *in_progress_advice;
 	const char *in_progress_error = NULL;
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
 			BUG(_("the control must not reach here"));
@@ -2674,7 +2676,10 @@ static int create_seq_dir(struct repository *r)
 	}
 	if (in_progress_error) {
 		error("%s", in_progress_error);
-		advise("%s", in_progress_advice);
+		if (advise_skip)
+			advise(in_progress_advice, "--skip | ");
+		else
+			advise(in_progress_advice, "");
 		return -1;
 	}
 	if (mkdir(git_path_seq_dir(), 0777) < 0)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index f85ef51cac..8672f0b2cd 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -172,6 +172,26 @@ test_expect_success 'check advice when we move HEAD by committing' '
 	test_cmp expect advice
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
+	test_cmp expect advice &&
+	cat >expect <<-EOF &&
+	error: cherry-pick is already in progress
+	hint: try "git cherry-pick (--continue | --abort | --quit)"
+	fatal: cherry-pick failed
+	EOF
+	git reset --merge &&
+	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_cmp expect advice
+'
+
 test_expect_success 'allow skipping commit but not abort for a new history' '
 	pristine_detach initial &&
 	cat >expect <<-EOF &&
-- 
2.21.0


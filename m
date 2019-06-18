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
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E521F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfFRRJ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:09:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33091 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRRJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:09:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so8040207pga.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msXHt0g7o1vKKQfwTgbj/YQsf0pFh7Xtnp3g+gdIvyk=;
        b=BQDOhfHlfMI2VtKlfWhAuhOgke0N+PYgI4ClMUKw5aRxxBflNcndAklYC6I6fsPbM2
         PAQTL+L4D7y7umx8R6HVgRlp68plRKAjFxylKH65gsx+BYfPqzZ+Fw1vsLj+9wBiUg7L
         PRzr84UaALuZou62XeTd8h0iP8WPVkGPXp0bS1yAn8NkX2MlF1RFYCMCYASM0qD1EsIM
         P6wiD51D22tDbiR5IgrYBWaVxOziN1FbteivicW8+eAroQWMjUbI23AWr+5xDmqG3Y6l
         l7c/+wjWLb0YVVGNdyy6X8THmGImhvvLqLku04D6t1oyGclpLS4lvF4wSTPeCJsMVRdf
         btOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msXHt0g7o1vKKQfwTgbj/YQsf0pFh7Xtnp3g+gdIvyk=;
        b=SfxZRdbMJNbXRNOV7SgUeGcdX1IFQPVPhA4QLE/kyntd37s+8ZlO2CmIQ1JLAFl8c+
         VYRKHWbcHA4pQPtLn4nQOrzxti5FjNgJQAVl5eCoTaBplHL7GTc+sqcVziOnu+sHCItR
         HOFcPb487PRtZLDLrP2uPoOPGxsH1ABQJ6AvXmoD8kHErZT5QFjTd1OwRrwI00/QSIHq
         UElA9KhfqaO94jSSsCtY748ok/oIbbHPBnZGdeTW6zKD6fvVsxupEHbx7QogX7YXqi59
         op5jdpILvVyQulJRhYJVMDcy2XYshd5jJfHgH68+zZwS0eJBkG/O1BncR2Krkbn00Eys
         xhEA==
X-Gm-Message-State: APjAAAXDQHce1Yf2H/vPtz9NeVCX2gborbcFqmx63QCOPUoa9YUFW1qc
        eDV/jGNUVjKLazaF+ZkHgStfsX0SaJM=
X-Google-Smtp-Source: APXvYqydmVOQgROkGVizfG2mtFfWeFabXQzp/tp38JU2vtZyjiKwf1iPaEus9MMj7HHL8Eto7XIzQw==
X-Received: by 2002:a17:90a:b294:: with SMTP id c20mr6390355pjr.16.1560877768005;
        Tue, 18 Jun 2019 10:09:28 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id d6sm14251093pgf.55.2019.06.18.10.09.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 10:09:27 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v5 5/5] cherry-pick/revert: advise using --skip
Date:   Tue, 18 Jun 2019 22:36:50 +0530
Message-Id: <20190618170650.22721-6-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
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
index 5720cd1c85..cc7f6219e7 100644
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
index dc0ac8343c..0e8adc95fc 100755
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


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
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4891F461
	for <e@80x24.org>; Fri, 21 Jun 2019 09:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfFUJUo (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 05:20:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44472 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJUo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 05:20:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so2690076plr.11
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wi/5p1dB0D0dQabo92pB0NPIwpQWRxmKRG8cIupQ1B8=;
        b=mGFqfGXL0vs61MQ88hSFXOo2Cg0UlPqp8ML09GANkyAN/hePi6/FtiKfE/HNm+nBfU
         QsTZGBnXHQjOucJlrxM8FZb8EcaZaaxZv1dD26ChtJVa/pmxjSJgUyAcj2Pd5yhP6kdb
         PpaYg2rNBYo/tCEKqNNQ3DG3jb3vQmIadyVgKAeTHYVOwSPh2RTQ5dwv58hpjLs8P4TG
         lqpDz5POVAQ9yG9XvjvM6hO9u3Thk2q82rgRKhzPuOit6w2eiszZE7zKxtHQflXE5Agg
         3zZ0THSb2sgLVqx3E6pm/97+oilvods3hy0eSxQ2ueo/STFOQPmh6ZPdBvxJOi03DPJX
         fI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wi/5p1dB0D0dQabo92pB0NPIwpQWRxmKRG8cIupQ1B8=;
        b=KsZOwbMgUuWmwTDExlqPGZLGPtSmq6s4/nvOEJXstP+HW7wrUkQP82aDo29KI14ZMH
         sX5n5CV5zgO4P37iGP1An1NkPmJ4cLFLdqEoRmsTgz7XQhpxiMnkNYg9/W70dhoUx5/C
         iOO+J/7sU5FjwlHW4dQwwQOoyfdWbxRmM49pEU8hsGOdjksSkmQkc62UIi9D63yJO7oE
         Q+8E1EU+G4MYbPvl8KfPzpF5f8Scc3W2bvV7I0cIHfAVOH2ZomOdtJHg/79ccJBEeJuH
         eDtX/arq0fRkdfoH1Xc9OPSy4zj3kXyGXmKr0VAwgTXhva+6ndeTLK9O7xxDS+VYbRm/
         PzMw==
X-Gm-Message-State: APjAAAXXjeolxpPG8LwmC2oedXmO892USj3HE6FOhYsYrmPIUAphybrn
        3smd8YTw8vI2vevbV6WkUnY=
X-Google-Smtp-Source: APXvYqws/3dEsPNXGBPI0zNN8Shnk8rxLzPs23Ya+/xBeISDcqBM2uVtWmfjCQtXLecxV1TG5ILR8g==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr70765746pls.72.1561108842965;
        Fri, 21 Jun 2019 02:20:42 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.216])
        by smtp.gmail.com with ESMTPSA id i133sm4380220pfe.75.2019.06.21.02.20.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:20:42 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v6 5/5] cherry-pick/revert: advise using --skip
Date:   Fri, 21 Jun 2019 14:48:00 +0530
Message-Id: <20190621091800.17686-6-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
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
index c62f7a33aa..98f3537dfc 100644
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


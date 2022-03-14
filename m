Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12129C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbiCNQMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242908AbiCNQLs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:11:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60BC40E5F
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r6so24374883wrr.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1dTmO/MGB8TCNOeHVIRw46EdZM4DrmZ5m+UHTUZgB4c=;
        b=ZrCj98LzgZdj4ZZq6oTAvACrHbsC73n0YSE9C+MlXA+/yIOYhUcDl8WHWyyEbb3Xyy
         xI22/oqFACJPfkMhHuG+WO8GgW8qQUwHs9IcaKlqyBCyQ7V2jD9gEpzDIsg7dLw47Bbx
         HLBUusMn+FXTNdQbayFmVK4RekIaZp+oA7gelcNMXbBM+4jB+MDFw/562zy8hPJ6RcMj
         dqieQzQkPtbhH02BoM5eB7ikOI2YJ38CzzTW7iO1DJlbyCrHx3f9GGDxkLDZHqTl61Fe
         Marb1bDNKDZMRTH2+MIho9rEFBztRLs3Gacx2z6VhoZtZDBXfE4PeaqhCMgpINUB1ohP
         uwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1dTmO/MGB8TCNOeHVIRw46EdZM4DrmZ5m+UHTUZgB4c=;
        b=lwhP+wsprctO9XIpOlbQioCxiI9Sr8jHQutjtgaBwwLwDjs1P4RCXKg3kCq+VPty0C
         EXoJ7GiK4sw98K6CL+hf/LIgbJlsoblq+HaCDAjT6vgiIn72LYNvyt9XrVBzETrI8agI
         okzR4qbSgcJDiwpcNlu29sJjLcKfnMYQP1tKke/XaTC13vPEvocn3gZShCC7NP36kZpE
         u7SVVDeuBGUt78I7mEKaQPPGZbpYcxwRMuICUJG0zauuUZeSuFiIXIlDVtSROF8hqIcK
         PJGazRaCptEFYPz+mza6qzzHdpSIxMlFOai4un4Z/awP9qbPNp2WgcRCsWHHFfZ2xqd4
         cz9Q==
X-Gm-Message-State: AOAM530ibN0oNMzjnYOiFnn/i7i0k368cbE2FNfo51N2EzacTmTFQaww
        iwi8GEuG5I1s3goXehv9+elLYGjCFkw=
X-Google-Smtp-Source: ABdhPJwRLyoQrDEzXBE632x9f9fW8PkbAo0hUj3EUrp3YcQBkfkdghSU4Jj0lh9Vj0D/Oo5DsnnNNg==
X-Received: by 2002:a05:6000:1446:b0:203:c402:fbfe with SMTP id v6-20020a056000144600b00203c402fbfemr2570635wrx.316.1647274236098;
        Mon, 14 Mar 2022 09:10:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020adffc44000000b001f1dba38a65sm13702822wrs.105.2022.03.14.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:10:35 -0700 (PDT)
Message-Id: <3334d4cb6f302a35986d94ea8ffcd1ee9c6aae5d.1647274230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 16:10:30 +0000
Subject: [PATCH v2 5/5] stash: make internal resets quiet and refresh index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add the options '-q' and '--refresh' to the 'git reset' executed in
'reset_head()', and '--refresh' to the 'git reset -q' executed in
'do_push_stash(...)'.

'stash' is implemented such that git commands invoked  as part of it (e.g.,
'clean', 'read-tree', 'reset', etc.) have their informational output
silenced. However, the 'reset' in 'reset_head()' is *not* called with '-q',
leading to the potential for a misleading printout from 'git stash apply
--index' if the stash included a removed file:

Unstaged changes after reset: D      <deleted file>

Not only is this confusing in its own right (since, after the reset, 'git
stash' execution would stage the deletion in the index), it would be printed
even when the stash was applied with the '-q' option. As a result, the
messaging is removed entirely by calling 'git status' with '-q'.

Additionally, because the default behavior of 'git reset -q' is to skip
refreshing the index, but later operations in 'git stash' subcommands expect
a non-stale index, enable '--refresh' as well.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/stash.c  |  5 +++--
 t/t3903-stash.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3e8af210fde..91407d9bbe0 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -310,7 +310,7 @@ static int reset_head(void)
 	 * API for resetting.
 	 */
 	cp.git_cmd = 1;
-	strvec_push(&cp.args, "reset");
+	strvec_pushl(&cp.args, "reset", "--quiet", "--refresh", NULL);
 
 	return run_command(&cp);
 }
@@ -1633,7 +1633,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
-			strvec_pushl(&cp.args, "reset", "-q", "--", NULL);
+			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
+				     NULL);
 			add_pathspecs(&cp.args, ps);
 			if (run_command(&cp)) {
 				ret = -1;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f36e121210e..17f2ad2344c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -261,6 +261,18 @@ test_expect_success 'apply -q is quiet' '
 	test_must_be_empty output.out
 '
 
+test_expect_success 'apply --index -q is quiet' '
+	# Added file, deleted file, modified file all staged for commit
+	echo foo >new-file &&
+	echo test >file &&
+	git add new-file file &&
+	git rm other-file &&
+
+	git stash &&
+	git stash apply --index -q >output.out 2>&1 &&
+	test_must_be_empty output.out
+'
+
 test_expect_success 'save -q is quiet' '
 	git stash save --quiet >output.out 2>&1 &&
 	test_must_be_empty output.out
-- 
gitgitgadget

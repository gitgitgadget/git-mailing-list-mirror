Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722B51F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfFXSNa (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:13:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33505 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbfFXSN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:13:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so14973021wru.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAj1UyL6S9MtquN4j4m9IdZ4FBisgTrZBixRsl0N33c=;
        b=BhWd84+TfVQslyqtnnrl9rFl1rpJ0KxmBIHz/gVPn0XsMdcawA+N3X5IcNTZuBOiYB
         rbd6Hcp824EIJcJq9PDSanHB/4yITxzTc+RRtZjdcBTJw5e6hJFu/IA6MPeFA2Eeb3tk
         lWkDeAO+ZCDNyNEILfK2fWqm+ArXhaSBU3hyENXNN4clITKKysODro3Q4Z45YNwo/wJy
         PRwjKfxEcwt2eLYeCLbUJ1VfW3orgwDB3Cg76k0b5wNV+IimL3OerNqIyDd94QDfNF11
         4di/Ngx6XK7H54GSIOqH028CCpNUmSadSjKYjDvQX3+O7mdwEQuDBsYdMIO1O1fWZhEB
         Bckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAj1UyL6S9MtquN4j4m9IdZ4FBisgTrZBixRsl0N33c=;
        b=hQCyIvfaMfJnxFhoTe5lkETc4LQQESoT9Lahgfc8pVjZqLfCWXSI2QAU1QK4YVYyhT
         /qx22dPgjSKjmV97MSrI9Of0H1N629HEDUEf4icwL1WVKIIQ73hOmoRb6H1AF/l7NA0E
         kulYXXNukxa8a6pp1LbKDfvBQF38dR/MsEUKQiWcbWGI2vUfwn+np5iRCJ7lguyLlZQC
         4/hyYDibNFhlz18oMq47WLLIDDMzbPN6bfK1/hwIuhSS7Lc2r+qCaVgnjk04xBnDsVvG
         yhuUmLv/+SzBG8jl5SmyMr3adsCfbVQeSYtq/nzysSand1u/Dp7OinJG7atfTkyuBuuh
         lpRw==
X-Gm-Message-State: APjAAAX3tHY/NbmA/qXGw1B8UChe8hyvvghiVIUzTxL8r77/+EezwFP9
        hpP3xyfzn5WhCvGi+kUzD/w=
X-Google-Smtp-Source: APXvYqyO9oYtUqMtzmjwwdG7Jgj0KhLxYPXos6kyx8FlEp1CVQVWQBOlnJFyUXfmcsceTi8EZGEAog==
X-Received: by 2002:adf:f050:: with SMTP id t16mr91114266wro.99.1561400006101;
        Mon, 24 Jun 2019 11:13:26 -0700 (PDT)
Received: from localhost.localdomain (x4db9a89d.dyn.telefonica.de. [77.185.168.157])
        by smtp.gmail.com with ESMTPSA id v65sm401349wme.31.2019.06.24.11.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 11:13:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/5] t3404: modernize here doc style
Date:   Mon, 24 Jun 2019 20:13:14 +0200
Message-Id: <20190624181318.17388-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190624181318.17388-1-szeder.dev@gmail.com>
References: <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190624181318.17388-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 't3404-rebase-interactive.sh' the expected output of several tests
is prepared from here documents, which are outside of
'test_expect_success' blocks and have spaces around redirection
operators.

Move these here documents into the corresponding 'test_expect_success'
block and avoid spaces between filename and redition operators.
Furthermore, quote the here docs' delimiter word to prevent parameter
expansions and what not, where applicable.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3404-rebase-interactive.sh | 123 ++++++++++++++++------------------
 1 file changed, 58 insertions(+), 65 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1723e1a858..9146f9d47b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,11 +75,10 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
-cat > expect <<EOF
-error: nothing to do
-EOF
-
 test_expect_success 'rebase -i with empty HEAD' '
+	cat >expect <<-\EOF &&
+	error: nothing to do
+	EOF
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 exec_true" git rebase -i HEAD^ >actual 2>&1 &&
 	test_i18ncmp expect actual
@@ -237,25 +236,23 @@ test_expect_success 'exchange two commits' '
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-cat > expect << EOF
-diff --git a/file1 b/file1
-index f70f10e..fd79235 100644
---- a/file1
-+++ b/file1
-@@ -1 +1 @@
--A
-+G
-EOF
-
-cat > expect2 << EOF
-<<<<<<< HEAD
-D
-=======
-G
->>>>>>> 5d18e54... G
-EOF
-
 test_expect_success 'stop on conflicting pick' '
+	cat >expect <<-\EOF &&
+	diff --git a/file1 b/file1
+	index f70f10e..fd79235 100644
+	--- a/file1
+	+++ b/file1
+	@@ -1 +1 @@
+	-A
+	+G
+	EOF
+	cat >expect2 <<-\EOF &&
+	<<<<<<< HEAD
+	D
+	=======
+	G
+	>>>>>>> 5d18e54... G
+	EOF
 	git tag new-branch1 &&
 	set_fake_editor &&
 	test_must_fail git rebase -i master &&
@@ -495,15 +492,14 @@ test_expect_success 'commit message retained after conflict' '
 	git branch -D conflict-squash
 '
 
-cat > expect-squash-fixup << EOF
-B
-
-D
+test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messages' '
+	cat >expect-squash-fixup <<-\EOF &&
+	B
 
-ONCE
-EOF
+	D
 
-test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messages' '
+	ONCE
+	EOF
 	git checkout -b squash-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
 	set_fake_editor &&
@@ -799,13 +795,12 @@ test_expect_success 'rebase -i can copy notes' '
 	test "a note" = "$(git notes show HEAD)"
 '
 
-cat >expect <<EOF
-an earlier note
-
-a note
-EOF
-
 test_expect_success 'rebase -i can copy notes over a fixup' '
+	cat >expect <<-\EOF &&
+	an earlier note
+
+	a note
+	EOF
 	git reset --hard n3 &&
 	git notes add -m"an earlier note" n2 &&
 	set_fake_editor &&
@@ -1304,27 +1299,26 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 		actual
 '
 
-cat >expect <<EOF
-Warning: some commits may have been dropped accidentally.
-Dropped commits (newer to older):
- - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
-To avoid this message, use "drop" to explicitly remove a commit.
-
-Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
-The possible behaviours are: ignore, warn, error.
-
-Rebasing (1/4)
-Rebasing (2/4)
-Rebasing (3/4)
-Rebasing (4/4)
-Successfully rebased and updated refs/heads/missing-commit.
-EOF
-
 cr_to_nl () {
 	tr '\015' '\012'
 }
 
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
+	cat >expect <<-EOF &&
+	Warning: some commits may have been dropped accidentally.
+	Dropped commits (newer to older):
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+	To avoid this message, use "drop" to explicitly remove a commit.
+
+	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
+	The possible behaviours are: ignore, warn, error.
+
+	Rebasing (1/4)
+	Rebasing (2/4)
+	Rebasing (3/4)
+	Rebasing (4/4)
+	Successfully rebased and updated refs/heads/missing-commit.
+	EOF
 	test_config rebase.missingCommitsCheck warn &&
 	rebase_setup_and_clean missing-commit &&
 	set_fake_editor &&
@@ -1335,21 +1329,20 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	test D = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: some commits may have been dropped accidentally.
-Dropped commits (newer to older):
- - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
- - $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
-To avoid this message, use "drop" to explicitly remove a commit.
-
-Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
-The possible behaviours are: ignore, warn, error.
-
-You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
-Or you can abort the rebase with 'git rebase --abort'.
-EOF
-
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
+	cat >expect <<-EOF &&
+	Warning: some commits may have been dropped accidentally.
+	Dropped commits (newer to older):
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
+	To avoid this message, use "drop" to explicitly remove a commit.
+
+	Use '\''git config rebase.missingCommitsCheck'\'' to change the level of warnings.
+	The possible behaviours are: ignore, warn, error.
+
+	You can fix this with '\''git rebase --edit-todo'\'' and then run '\''git rebase --continue'\''.
+	Or you can abort the rebase with '\''git rebase --abort'\''.
+	EOF
 	test_config rebase.missingCommitsCheck error &&
 	rebase_setup_and_clean missing-commit &&
 	set_fake_editor &&
-- 
2.22.0.589.g5bd7971b91


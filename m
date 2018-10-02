Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3123A1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 16:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeJBWvS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 18:51:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36043 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbeJBWvS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 18:51:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id d4-v6so1852638lfa.3
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNqv1K6uM8g8hZQNhSbMmsWhJvYJXDyK1+cID3NZEwY=;
        b=qrt4pIjZMgEl9O/wHHMOjF8ce0Vg4zERf/QsQKvReSQmSSjJb876mqlxoA6rah8yuV
         1oauM4krDQg0zhGaMWDAlCMp8C9c+3NLdSfrFMd2BTStqBKaflaRNierzmWecC60acXa
         eTbqxIMJn5851rXyAlKtww13Bsl3/DTWe2/+5+s/V0Asf4ybiW/yivl8WiB1e1KlDvBh
         pcO9grG+JeQN5W6HKhZFwE/2zQeaIZmG515RRO/1eEfek9ZXtcNhxHeK1QEc1HNmUwVU
         wQY+qzdltMpcK3EPVmA7+Alx46AtVJjbf9JLNwWTNV3rzQ3ktvl8OpHFkTWVcyCaz+AV
         bbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNqv1K6uM8g8hZQNhSbMmsWhJvYJXDyK1+cID3NZEwY=;
        b=TSxlvD4CtM+S3UTg4+EHtUuF2YB4XZU8UpspRoJlYbxeMPW5N5ilBUdwOp4bUQ5123
         NGfEjSjCMiFHZIhuU648PcJ1OXxxzEVZAB1dxdPnzdBkVl1AZ2da2L+EHMUS9w4mM94J
         4ReZuMFNhzDbLcFQc851zXifdBccxjFGqtXELo6GtDd1MFpbpS+MlALfemENfhsz1nDN
         tB0je3O/r5qaqmZl6JyZ0vsqxLM13WL+QwPcoDorRX8nscyTBEU6zMg5WU7mAvYtapfm
         y7Z6WIQFCLLfAv/ZKeF51vAp9pt6Xyk7JBZS1SMrQALBJIcJe7/EbV4wexV3TV66i572
         dKLQ==
X-Gm-Message-State: ABuFfoix0UeiadslmWbGm7IroXb5ZBCvf9XsqnFJr6jyWsn12Js9fIb4
        pwd/BbebIJ0doU73ewdKHco=
X-Google-Smtp-Source: ACcGV63wZ8kBf1R/rnhAGYZTai1ly/olTYz5AsGzgXsGnx/QM0CjDHRSmHHCjf+n4/TtvbRN4aPwMg==
X-Received: by 2002:a19:4ed3:: with SMTP id u80-v6mr8421295lfk.55.1538496429897;
        Tue, 02 Oct 2018 09:07:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1771194lji.87.2018.10.02.09.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 09:07:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/2] Per-worktree config files
Date:   Tue,  2 Oct 2018 18:06:56 +0200
Message-Id: <20181002160658.15891-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.342.gc057aaf40a.dirty
In-Reply-To: <20180929153005.10599-1-pclouds@gmail.com>
References: <20180929153005.10599-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 changes are minor (besides test_cmp_config), mostly document
cleanup. Diff

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 44407e69db..e036ff7b86 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -4,7 +4,7 @@ CONFIGURATION FILE
 The Git configuration file contains a number of variables that affect
 the Git commands' behavior. The files `.git/config` and optionally
 `config.worktree` (see `extensions.worktreeConfig` below) in each
-repository is used to store the configuration for that repository, and
+repository are used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index aa88278dde..408c87c9ef 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -221,7 +221,7 @@ $ git config extensions.worktreeConfig true
 In this mode, specific configuration stays in the path pointed by `git
 rev-parse --git-path config.worktree`. You can add or update
 configuration in this file with `git config --worktree`. Older Git
-versions may will refuse to access repositories with this extension.
+versions will refuse to access repositories with this extension.
 
 Note that in this file, the exception for `core.bare` and `core.worktree`
 is gone. If you have them in $GIT_DIR/config before, you must move
@@ -283,6 +283,9 @@ to `/path/main/.git/worktrees/test-next` then a file named
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
 
+When extensions.worktreeConfig is enabled, the config file
+`.git/worktrees/<id>/config.worktree` is read after `.git/config` is.
+
 LIST OUTPUT FORMAT
 ------------------
 The worktree list command has two output formats.  The default format shows the
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4cd7fb8fdf..2149b88392 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -747,28 +747,27 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
 
-# similar to test_cmp but $2 is a config key instead of actual value
-# it can also accept -C to read from a different repo, e.g.
+# Check that the given config key has the expected value.
 #
-#     test_cmp_config -C xyz foo core.bar
+#    test_cmp_config [-C <dir>] <expected-value>
+#                    [<git-config-options>...] <config-key>
 #
-# is sort of equivalent of
+# for example to check that the value of core.bar is foo
+#
+#    test_cmp_config foo core.bar
 #
-#     test "foo" = "$(git -C xyz core.bar)"
-
 test_cmp_config() {
-	if [ "$1" = "-C" ]
+	local GD
+	if test "$1" = "-C"
 	then
 		shift &&
 		GD="-C $1" &&
 		shift
-	else
-		GD=
 	fi &&
-	echo "$1" >expected &&
+	printf "%s\n" "$1" >expect.config &&
 	shift &&
-	git $GD config "$@" >actual &&
-	test_cmp expected actual
+	git $GD config "$@" >actual.config &&
+	test_cmp expect.config actual.config
 }
 
 # test_cmp_bin - helper to compare binary files

Nguyễn Thái Ngọc Duy (2):
  t1300: extract and use test_cmp_config()
  worktree: add per-worktree config files

 Documentation/config.txt               | 12 +++-
 Documentation/git-config.txt           | 26 ++++++---
 Documentation/git-worktree.txt         | 33 +++++++++++
 Documentation/gitrepository-layout.txt |  8 +++
 builtin/config.c                       | 19 ++++++-
 cache.h                                |  2 +
 config.c                               | 11 ++++
 environment.c                          |  1 +
 setup.c                                | 40 ++++++++++---
 t/t1300-config.sh                      | 79 +++++++-------------------
 t/t2029-worktree-config.sh             | 79 ++++++++++++++++++++++++++
 t/test-lib-functions.sh                | 23 ++++++++
 12 files changed, 255 insertions(+), 78 deletions(-)
 create mode 100755 t/t2029-worktree-config.sh

-- 
2.19.0.342.gc057aaf40a.dirty


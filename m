Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735901F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeCPUIF (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:08:05 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42307 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeCPUIC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:08:02 -0400
Received: by mail-lf0-f67.google.com with SMTP id a22-v6so17075270lfg.9
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEbvGig8tLLfoy9tKEiPaCgzzcZK1ZjAc0oTapn5Qoc=;
        b=oZruYY0AJqKzh6xn+M/u+vGkt2kFdsXszLgA5UpcbJTEiny/8HZuYsA/MESnbWPDn6
         GGsC83WaNztUzkoPpSXC/1vu4Rz7nz9O3WLfMuQwBtpBnxeCItD4/6HwhNT20qZCHq2A
         s6V302pGg+fFwiU5P6tP2bcV6zXEgL8ppq6IX9s/8a1hvt6NTuIB7Tn3/tvf+tZQJbO2
         Gy1X3Uxbrel4Zv2FrgDTtaLc9wScW4QiUUKZilhGQp6HWrJC+vFV9d8UwXAmQ0WoXz5T
         kJVwHCCPY5QlE8eUEkymrUI7el/Jb036r+I3+JDx9YWwcnRLAT0b0tuUw8Gh9ALRDYet
         UKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEbvGig8tLLfoy9tKEiPaCgzzcZK1ZjAc0oTapn5Qoc=;
        b=NUZcGHz6bb6O5/YEtEe6peumQ301Vkh9jr+bTgrJfY38HvT37HXW3LmEPJpX5RWoDo
         udnctYA2vemCT/TM1ctaRfjz+Ab9wqWuKmd0RmmeaaSWyjMZGD8j42rG9exfOr+ClpjM
         EbqoIuH50wV5xgCVSMesRvSz4H528dWA/JJ91SfpA7ODsUDBetGFWX1h9XKIc5foQFXE
         bFHxWvksQuMgiJ8TKiiLWHelKpvhreOb3pnT1kd+RzJQtBMfH1i02OdCyTAMEndmLGCu
         fKAua4+h7M+8i5CRwkKkC1o4Hcq2UpDVSZzH87gZcgJ1wMoZ8jRyp0IdvwAirqzRSi2Z
         PhsQ==
X-Gm-Message-State: AElRT7ETMhZMj5hOyvMwp4Bl1ImLhN+TAkfhdNFsJ2sAagk04X56rYiI
        ARdiC2G0VBuUJrbrUCvKuO9TrQ==
X-Google-Smtp-Source: AG47ELvMylcPwp3rOGy3heQfnPpM2l/LlSNK2/HdoVG1WEDx60meUVb6jAdZp1APGYFoVYC35NAcEg==
X-Received: by 10.46.23.70 with SMTP id l67mr2181019lje.132.1521230879570;
        Fri, 16 Mar 2018 13:07:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i89-v6sm1065407lfk.12.2018.03.16.13.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 13:07:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] format-patch: use --compact-summary instead of --summary
Date:   Fri, 16 Mar 2018 21:06:48 +0100
Message-Id: <20180316200648.18256-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For reviewers, a couple fewer lines from diffstat (either cover letter
or patches) is a good thing because there's less to read.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I realize that rename percentage is lost with this change. I just
 hope that nobody cares about that, or I'll have to implement rename
 percentage in --compact-summary too in order to move this patch
 forward.

 builtin/log.c                                 |  9 +++++---
 ...tach_--stdout_--suffix=.diff_initial..side |  7 +++---
 ...at-patch_--attach_--stdout_initial..master | 19 +++++++---------
 ...t-patch_--attach_--stdout_initial..master^ | 12 +++++-----
 ...rmat-patch_--attach_--stdout_initial..side |  7 +++---
 ..._--stdout_--numbered-files_initial..master | 19 +++++++---------
 ..._--subject-prefix=TESTCASE_initial..master | 19 +++++++---------
 ...at-patch_--inline_--stdout_initial..master | 19 +++++++---------
 ...t-patch_--inline_--stdout_initial..master^ | 12 +++++-----
 ...-patch_--inline_--stdout_initial..master^^ |  7 +++---
 ...rmat-patch_--inline_--stdout_initial..side |  7 +++---
 ...-stdout_--cover-letter_-n_initial..master^ | 22 ++++++++-----------
 ...tch_--stdout_--no-numbered_initial..master | 19 +++++++---------
 ...-patch_--stdout_--numbered_initial..master | 19 +++++++---------
 ...diff.format-patch_--stdout_initial..master | 19 +++++++---------
 ...iff.format-patch_--stdout_initial..master^ | 12 +++++-----
 .../diff.format-patch_--stdout_initial..side  |  7 +++---
 t/t4052-stat-output.sh                        |  4 ++--
 18 files changed, 103 insertions(+), 136 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 94ee177d56..c8e3be5de7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1062,7 +1062,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		return;
 
 	memcpy(&opts, &rev->diffopt, sizeof(opts));
-	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+	opts.output_format = DIFF_FORMAT_DIFFSTAT;
+	opts.flags.stat_with_summary = 1;
 	opts.stat_width = MAIL_DEFAULT_WRAP;
 
 	diff_setup_done(&opts);
@@ -1615,8 +1616,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (!use_patch_format &&
 		(!rev.diffopt.output_format ||
-		 rev.diffopt.output_format == DIFF_FORMAT_PATCH))
-		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY;
+		 rev.diffopt.output_format == DIFF_FORMAT_PATCH)) {
+		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
+		rev.diffopt.flags.stat_with_summary = 1;
+	}
 	if (!rev.diffopt.stat_width)
 		rev.diffopt.stat_width = MAIL_DEFAULT_WRAP;
 
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
index 547ca065a5..89ab87fb4e 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_--suffix=.diff_initial..side
@@ -12,11 +12,10 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index 52fedc179e..48f284f1d9 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -14,11 +14,10 @@ Content-Transfer-Encoding: 8bit
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -73,10 +72,9 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -121,11 +119,10 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index 1c3cde251b..be6de1290a 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -14,11 +14,10 @@ Content-Transfer-Encoding: 8bit
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -73,10 +72,9 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 4717bd8313..c14f4c9011 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -12,11 +12,10 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
index 02c4db7ec5..d763a0b437 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initial..master
@@ -14,11 +14,10 @@ Content-Transfer-Encoding: 8bit
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -73,10 +72,9 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -121,11 +119,10 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
index c7677c5951..441a7d8a9d 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
@@ -14,11 +14,10 @@ Content-Transfer-Encoding: 8bit
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -73,10 +72,9 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -121,11 +119,10 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
index 5b3e34e2c0..0eb5b3aa3b 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master
@@ -14,11 +14,10 @@ Content-Transfer-Encoding: 8bit
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -73,10 +72,9 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -121,11 +119,10 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
index d13f8a8128..2d019707e2 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
@@ -14,11 +14,10 @@ Content-Transfer-Encoding: 8bit
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 
 --------------g-i-t--v-e-r-s-i-o-n
@@ -73,10 +72,9 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
index caec5537de..1aa57f21d6 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
@@ -14,11 +14,10 @@ Content-Transfer-Encoding: 8bit
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..side b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
index d3a6762130..844b348eee 100644
--- a/t/t4013/diff.format-patch_--inline_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..side
@@ -12,11 +12,10 @@ Content-Type: text/plain; charset=UTF-8; format=fixed
 Content-Transfer-Encoding: 8bit
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 
 --------------g-i-t--v-e-r-s-i-o-n
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
index 244d964fc6..9f4525a60d 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
@@ -10,13 +10,11 @@ A U Thor (2):
   Second
   Third
 
- dir/sub | 4 ++++
- file0   | 3 +++
- file1   | 3 +++
- file2   | 3 ---
+ dir/sub      | 4 ++++
+ file0        | 3 +++
+ file1 (new)  | 3 +++
+ file2 (gone) | 3 ---
  4 files changed, 10 insertions(+), 3 deletions(-)
- create mode 100644 file1
- delete mode 100644 file2
 
 -- 
 g-i-t--v-e-r-s-i-o-n
@@ -28,11 +26,10 @@ Subject: [DIFFERENT_PREFIX 1/2] Second
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -73,10 +70,9 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [DIFFERENT_PREFIX 2/2] Third
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
index bfc287a147..c102104f70 100644
--- a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
@@ -6,11 +6,10 @@ Subject: [PATCH] Second
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -51,10 +50,9 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH] Third
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -85,11 +83,10 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
index 568f6f584e..f29efe555e 100644
--- a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
@@ -6,11 +6,10 @@ Subject: [PATCH 1/3] Second
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -51,10 +50,9 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/3] Third
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -85,11 +83,10 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH 3/3] Side
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t4013/diff.format-patch_--stdout_initial..master
index 5f0352f9f7..febe8c4390 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_initial..master
@@ -6,11 +6,10 @@ Subject: [PATCH 1/3] Second
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -51,10 +50,9 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/3] Third
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -85,11 +83,10 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH 3/3] Side
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t4013/diff.format-patch_--stdout_initial..master^
index 2ae454d807..ade0790a44 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_initial..master^
@@ -6,11 +6,10 @@ Subject: [PATCH 1/2] Second
 
 This is the second commit.
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file2   | 3 ---
+ dir/sub      | 2 ++
+ file0        | 3 +++
+ file2 (gone) | 3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
- delete mode 100644 file2
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -51,10 +50,9 @@ Date: Mon, 26 Jun 2006 00:02:00 +0000
 Subject: [PATCH 2/2] Third
 
 ---
- dir/sub | 2 ++
- file1   | 3 +++
+ dir/sub     | 2 ++
+ file1 (new) | 3 +++
  2 files changed, 5 insertions(+)
- create mode 100644 file1
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--stdout_initial..side b/t/t4013/diff.format-patch_--stdout_initial..side
index a7d52fbeea..59db45454b 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--stdout_initial..side
@@ -5,11 +5,10 @@ Date: Mon, 26 Jun 2006 00:03:00 +0000
 Subject: [PATCH] Side
 
 ---
- dir/sub | 2 ++
- file0   | 3 +++
- file3   | 4 ++++
+ dir/sub     | 2 ++
+ file0       | 3 +++
+ file3 (new) | 4 ++++
  3 files changed, 9 insertions(+)
- create mode 100644 file3
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 6e2cf933f7..acea4c0b76 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -267,10 +267,10 @@ log -1 --stat
 EOF
 
 cat >expect72 <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 +++++++++++++++++
 EOF
 cat >expect72-graph <<'EOF'
-|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++
+|  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (new) | 1000 +++++++++++++++++
 EOF
 cat >expect200 <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 
2.16.2.903.gd04caf5039


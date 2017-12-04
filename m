Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2E720954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdLDX7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:15 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44593 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdLDX7M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:12 -0500
Received: by mail-pg0-f67.google.com with SMTP id j9so9382914pgc.11
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f8W7XSWDdDCBuYhBW2fnh0f/orYiZxeQirPu7CwOxF8=;
        b=MHCZi2HfbFGzvcSnMZBKOqI0bZUpiCuCX8TAqibvBLBKqAcLyYYCSrIZBYEwGB3mGV
         9Cs0nqsat8gQ8Sg7xenqv4yBaQeaE4cCxW48/7MjPqyLTkyG17kF1OccH/E0fasxh8uG
         LLTWpfQ547UpPVCDNknpzdFD4zbM2mhwhDrJWI6GbS6gL6Y7Ts6w0uryYYBmK2wZBIml
         BbRnLXtSici9MXDMdTqkBZXQbQpgInrC2SG/HlrYubZeHGBo2d473/lAS92VRqH6g0hi
         ilVlO+0yvveA4DbKu8ONAzLswmC5pvNlP20ZCUJVrFCGtmGC5aN2TM3fn89RoT9cCrgw
         3aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f8W7XSWDdDCBuYhBW2fnh0f/orYiZxeQirPu7CwOxF8=;
        b=JMELsFAr8RuAQU/3Gl1UmeMBgA8SuQjKoegiQn6mho9wAhHYMX39nKzHQ8rSezgz9f
         fO8mDKnVUsJab1oa7OaLvPsjC4O2upaYJhinqpgcF4vruI6ESc0XniQULA1x9U6RoICp
         nriYH4bNE7ktdP1P5OXt7kFewQuu9ISQ4W/YVejbR8pWn71+I2sbYPB8bFUxfRFZhGV4
         PjoSPAL/8IzthY6eDBS3fYmZu4XErfL1nJKh563xX9x5KavaL2xkmeVs+rc3rlIxlOkh
         TJ0cuC1FayKY8/37FliEkRVLeFh/1a1y/0fUBwhsxvpRsTX/gX1YAHqb9EG1moaP5CEF
         TLIg==
X-Gm-Message-State: AJaThX5788fjP6A1s1eeUtW6AJFQNX/oXbNjMSUnvCN3zspu3YYjBbqt
        e4gYx9muSUTBA7oDWsWexCDAGWhhTEw=
X-Google-Smtp-Source: AGs4zMZsjN1neDCoDJPb5ssin2ScyrsglmLlq+e43YSJ4al0RmxXM4/F9hY/OSe/S3ttQwn0PNPiIw==
X-Received: by 10.99.160.26 with SMTP id r26mr15670440pge.408.1512431950924;
        Mon, 04 Dec 2017 15:59:10 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:09 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 04/15] upload-pack: convert to a builtin
Date:   Mon,  4 Dec 2017 15:58:12 -0800
Message-Id: <20171204235823.63299-5-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to allow for code sharing with the server-side of fetch in
protocol-v2 convert upload-pack to be a builtin.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile      | 3 ++-
 builtin.h     | 1 +
 git.c         | 1 +
 upload-pack.c | 2 +-
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9ce68cded..86394b69d 100644
--- a/Makefile
+++ b/Makefile
@@ -630,7 +630,6 @@ PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
-PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
@@ -692,6 +691,7 @@ BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
+BUILT_INS += git-upload-pack$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build and 'install' will install in gitexecdir,
@@ -890,6 +890,7 @@ LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += unpack-trees.o
+LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
 LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa..f332a1257 100644
--- a/builtin.h
+++ b/builtin.h
@@ -231,6 +231,7 @@ extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
+extern int cmd_upload_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_var(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index f31dca696..e32e16f2d 100644
--- a/git.c
+++ b/git.c
@@ -474,6 +474,7 @@ static struct cmd_struct commands[] = {
 	{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 	{ "upload-archive", cmd_upload_archive },
 	{ "upload-archive--writer", cmd_upload_archive_writer },
+	{ "upload-pack", cmd_upload_pack },
 	{ "var", cmd_var, RUN_SETUP_GENTLY },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
diff --git a/upload-pack.c b/upload-pack.c
index ef99a029c..2d16952a3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1033,7 +1033,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 {
 	const char *dir;
 	int strict = 0;
-- 
2.15.1.424.g9478a66081-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589991F404
	for <e@80x24.org>; Mon, 26 Mar 2018 16:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeCZQ42 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 12:56:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40406 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCZQ4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 12:56:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id e5-v6so29212479lfb.7
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxUP9Z6hGVR8hTPGF538XqN1HK53UISwsirrBbTBZp8=;
        b=gWcg6KWvBRPmCHlS4nzHW1aDJw++0UM6kGJ3pQ8b7wbY5oBC5K9jS+e6VM2GuLR2E5
         OMLJDqvV0dBK0WTKXmS535GisPq79GUFswSAzw/RkLfVznXF63CR53mUTHVvN4eXfO86
         OO8AOfS+dsjf0nOIUNYmj1086SfPV6vPWWqmExjvBdJkgWBMp8J/0W9quXzqRHMCmAol
         IvFSNUqsR7zfJBeLMdyuybIJNdLjqdI5nRrmS2p/MY5IZQ+U0NFPe9JOcVS+3wNbxxAC
         /+ScOk+a59cvi8h5b1dIT+FSFtITqd8c4qP9kg8elYvApn9gFAqMkfMUtLRw5Rh4lvsP
         YNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxUP9Z6hGVR8hTPGF538XqN1HK53UISwsirrBbTBZp8=;
        b=heFE9B0OcDuiFjiGcD8R8RMs+4sayDStwTAXPIGxJ3Q20Tq4119KvBoDJpuVRWetaX
         meECR3N0MIX/apUzeTFJEx95QCbCbpWfnI8Ep0k0/8rSEFrJ3HJmw6Ktw6a571X3t5lH
         +8H+u5HrWvqJuf3FsLyLyITVKrnqsQbvwIgSRSR0pg4hk6LCwIPf4PXfuw291XpTPcRg
         0gh+eHNzNzMe95xjgdhblYk1Ms1Vhl5Zv/3GzK1IunzLZBtVB6ez+ucS+V0x9QE1Xum+
         DDdTVpRalUxUNFpirlxzjC+EYr8HyA7VIB7a3nredYFabvA9G5ZHcjlZaBWdLIFjoUMu
         t+qA==
X-Gm-Message-State: AElRT7ElMegzZiT6EC5bz/JwdDsMDsQNU4CTl7oCCKNxDBALOGVAIzhQ
        DnGlz2TTUVLpH+iJa2ZkgQCLLQ==
X-Google-Smtp-Source: AIpwx4/7cTn4UNy46ff3Xqt6+As8e3c9y0WiIDxjZ3fnHOqcjg1snwtWza7fPYJlGGzBTBeyN2RiyA==
X-Received: by 10.46.158.19 with SMTP id e19mr6759205ljk.47.1522083370328;
        Mon, 26 Mar 2018 09:56:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j8sm814451lje.83.2018.03.26.09.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 09:56:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 4/5] git.c: implement --list-cmds=porcelain
Date:   Mon, 26 Mar 2018 18:55:19 +0200
Message-Id: <20180326165520.802-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180326165520.802-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is useful for git-completion.bash because it needs this set of
commands. Right now we have to maintain a separate command category in
there.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 94 ++------------------------
 git.c                                  |  2 +
 help.c                                 | 12 ++++
 help.h                                 |  1 +
 t/t9902-completion.sh                  |  4 +-
 5 files changed, 20 insertions(+), 93 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e0f545819d..d711a9b53a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -833,14 +833,15 @@ __git_commands () {
 	then
 		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
 	else
-		git --list-cmds=all
+		git --list-cmds=$1
 	fi
 }
 
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(__git_commands)
+	local category=${1-all}
+	for i in $(__git_commands $category)
 	do
 		case $i in
 		*--*)             : helper pattern;;
@@ -856,98 +857,11 @@ __git_compute_all_commands ()
 	__git_all_commands=$(__git_list_all_commands)
 }
 
-__git_list_porcelain_commands ()
-{
-	local i IFS=" "$'\n'
-	__git_compute_all_commands
-	for i in $__git_all_commands
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		applymbox)        : ask gittus;;
-		applypatch)       : ask gittus;;
-		archimport)       : import;;
-		cat-file)         : plumbing;;
-		check-attr)       : plumbing;;
-		check-ignore)     : plumbing;;
-		check-mailmap)    : plumbing;;
-		check-ref-format) : plumbing;;
-		checkout-index)   : plumbing;;
-		column)           : internal helper;;
-		commit-tree)      : plumbing;;
-		count-objects)    : infrequent;;
-		credential)       : credentials;;
-		credential-*)     : credentials helper;;
-		cvsexportcommit)  : export;;
-		cvsimport)        : import;;
-		cvsserver)        : daemon;;
-		daemon)           : daemon;;
-		diff-files)       : plumbing;;
-		diff-index)       : plumbing;;
-		diff-tree)        : plumbing;;
-		fast-import)      : import;;
-		fast-export)      : export;;
-		fsck-objects)     : plumbing;;
-		fetch-pack)       : plumbing;;
-		fmt-merge-msg)    : plumbing;;
-		for-each-ref)     : plumbing;;
-		hash-object)      : plumbing;;
-		http-*)           : transport;;
-		index-pack)       : plumbing;;
-		init-db)          : deprecated;;
-		local-fetch)      : plumbing;;
-		ls-files)         : plumbing;;
-		ls-remote)        : plumbing;;
-		ls-tree)          : plumbing;;
-		mailinfo)         : plumbing;;
-		mailsplit)        : plumbing;;
-		merge-*)          : plumbing;;
-		mktree)           : plumbing;;
-		mktag)            : plumbing;;
-		pack-objects)     : plumbing;;
-		pack-redundant)   : plumbing;;
-		pack-refs)        : plumbing;;
-		parse-remote)     : plumbing;;
-		patch-id)         : plumbing;;
-		prune)            : plumbing;;
-		prune-packed)     : plumbing;;
-		quiltimport)      : import;;
-		read-tree)        : plumbing;;
-		receive-pack)     : plumbing;;
-		remote-*)         : transport;;
-		rerere)           : plumbing;;
-		rev-list)         : plumbing;;
-		rev-parse)        : plumbing;;
-		runstatus)        : plumbing;;
-		sh-setup)         : internal;;
-		shell)            : daemon;;
-		show-ref)         : plumbing;;
-		send-pack)        : plumbing;;
-		show-index)       : plumbing;;
-		ssh-*)            : transport;;
-		stripspace)       : plumbing;;
-		symbolic-ref)     : plumbing;;
-		unpack-file)      : plumbing;;
-		unpack-objects)   : plumbing;;
-		update-index)     : plumbing;;
-		update-ref)       : plumbing;;
-		update-server-info) : daemon;;
-		upload-archive)   : plumbing;;
-		upload-pack)      : plumbing;;
-		write-tree)       : plumbing;;
-		var)              : infrequent;;
-		verify-pack)      : infrequent;;
-		verify-tag)       : plumbing;;
-		*) echo $i;;
-		esac
-	done
-}
-
 __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
 	test -n "$__git_porcelain_commands" ||
-	__git_porcelain_commands=$(__git_list_porcelain_commands)
+	__git_porcelain_commands=$(__git_list_all_commands porcelain)
 }
 
 # Lists all set config variables starting with the given section prefix,
diff --git a/git.c b/git.c
index 2e0c5e17e2..5b09f77792 100644
--- a/git.c
+++ b/git.c
@@ -210,6 +210,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				list_builtins();
 			else if (!strcmp(cmd, "all"))
 				list_all_cmds();
+			else if (!strcmp(cmd, "porcelain"))
+				list_porcelain_cmds();
 			else
 				die("unsupported command listing type '%s'", cmd);
 			exit(0);
diff --git a/help.c b/help.c
index 4d07ea3913..cacd8249bb 100644
--- a/help.c
+++ b/help.c
@@ -270,6 +270,18 @@ void list_all_cmds(void)
 		puts(other_cmds.names[i]->name);
 }
 
+void list_porcelain_cmds(void)
+{
+	int i, nr = ARRAY_SIZE(command_list);
+	struct cmdname_help *cmds = command_list;
+
+	for (i = 0; i < nr; i++) {
+		if (cmds[i].category != CAT_mainporcelain)
+			continue;
+		puts(cmds[i].name);
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 0bf29f8dc5..33e2210ebd 100644
--- a/help.h
+++ b/help.h
@@ -18,6 +18,7 @@ static inline void mput_char(char c, unsigned int num)
 
 extern void list_common_cmds_help(void);
 extern void list_all_cmds(void);
+extern void list_porcelain_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e6485feb0a..79a2c6d67d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1208,8 +1208,6 @@ test_expect_success 'basic' '
 	grep -q "^add \$" out &&
 	# script
 	grep -q "^filter-branch \$" out &&
-	# plumbing
-	! grep -q "^ls-files \$" out &&
 
 	run_completion "git f" &&
 	! grep -q -v "^f" out
@@ -1272,7 +1270,7 @@ test_expect_success 'general options' '
 	test_completion "git --no-r" "--no-replace-objects "
 '
 
-test_expect_success 'general options plus command' '
+test_expect_failure 'general options plus command' '
 	test_completion "git --version check" "checkout " &&
 	test_completion "git --paginate check" "checkout " &&
 	test_completion "git --git-dir=foo check" "checkout " &&
-- 
2.17.0.rc0.348.gd5a49e0b6f


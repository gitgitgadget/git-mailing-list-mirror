Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349641F461
	for <e@80x24.org>; Fri, 17 May 2019 00:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfEQA1m (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 20:27:42 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39410 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfEQA1m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 20:27:42 -0400
Received: by mail-it1-f193.google.com with SMTP id 9so9246085itf.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SOkjU0xy9igfPMoIOMfOcjw51+D20FupzGxAb7ZGprk=;
        b=t+iZKZZ0Z53i8ASctlH+TnuEOEQKAAdgyrL6QvoeoFsGI6vouUKS24Sxnwlr7rJpnX
         fvn6rHFitmRJqwJBOZYEV77cj7MyEAWm22zr+5degz4V03g5gxhZmYNBAFbtk49Biw7D
         QO9RqlAUongv2qYi30OUqD5BOdiBHzehF7thC/CCmXSxg2tJFljUHLxoG7SAVHQx5DoA
         dASnm0M4CXKLEf/uHEYNQSYOV/Chg5m6I/047UCuzm7mq6mvbFYmKlW/+X+8OZgUAiXe
         JVcUqAVem/3ZKOaZnb20cK2P04Ea5pxteICpngsl8sNWfANyuwNCvmaOrUSOioQa+OhG
         kI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SOkjU0xy9igfPMoIOMfOcjw51+D20FupzGxAb7ZGprk=;
        b=locPHP9MR6jKXGVN0leMm/hqqAAhDB1Mhfc3Cca34I2ih/flssU3gi9u8CuDczPhPE
         4B0QOYdX/E8TyPXxSiUmiGuC5X0Ks7zVIq1gibkbYOhXihUpX2sOWadIuOXM2SJbWvsk
         6yncy8tAEM8ab4cwbFxOt5q+AqYemMAnnf2LjqWHB+7uGWuZDBQ+l2HL8c5dQJmc+XpS
         xhDJmEVXlqCteFNgewxqTyioJSyl5GIQqNA1Et/voVi8FXjLnq64VYLb3tyWOMNUm8sM
         HI7uoaboa/iLVEKEA79RJ2pehy4g2rqJGhzwrTDel7FqcW7t4FyyxUOcqZE7xyoPoQO1
         iuXQ==
X-Gm-Message-State: APjAAAXZWHfzvy0WJq94BKs7s0bdp3+XO7nx2Ie7aQt6m95L3YmfULy2
        q1xXHb2catjEV2S/hdBPgXYIF6yt
X-Google-Smtp-Source: APXvYqzFhFKnd6IGl2FsKcFo8zN0cOMNEqDkCgvaeiI51OGboOYfo0MxUBJH6FxOFFmFEhwxKJsDfA==
X-Received: by 2002:a02:1146:: with SMTP id 67mr35477575jaf.10.1558052860744;
        Thu, 16 May 2019 17:27:40 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id c128sm2271234itc.19.2019.05.16.17.27.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 17:27:40 -0700 (PDT)
Date:   Thu, 16 May 2019 20:27:38 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] teach branch-specific options for format-patch
Message-ID: <cover.1558052674.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1557072929.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I thought a lot about building the branch-specific include option but I
opted against this because `format.<name>.coverSubject` is a
branch-exclusive config option, whereas it doesn't make sense to have a
`format.coverSubject` option.

Thus, if we pursue this, we *need* to have a `format.<name>.*` section
so let's not deal with the complexity of buliding a generic include
system for now.

Also, I might consider adding a `format.<name>.outputDirectory` option
in the future but let's see what kind of comments this patchset gets.

Changes since v1:

* Used format.<branch-name>.* variables instead of branch.<branch-name>.*


Denton Liu (6):
  t4014: clean up style
  Doc: add more detail for git-format-patch
  format-patch: make cover letter subject configurable
  format-patch: move extra_headers logic later
  string-list: create string_list_append_all
  format-patch: read branch-specific To: and Cc: headers

 Documentation/config/format.txt    |  12 +-
 Documentation/git-format-patch.txt |  33 +-
 builtin/branch.c                   |  16 +-
 builtin/log.c                      | 162 +++++--
 string-list.c                      |   9 +
 string-list.h                      |   7 +
 t/t3200-branch.sh                  |   8 +-
 t/t4014-format-patch.sh            | 708 +++++++++++++++++------------
 t/t9902-completion.sh              |   5 +-
 9 files changed, 608 insertions(+), 352 deletions(-)

Interdiff against v1:
diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index d292210cf6..8f4b3faadd 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -100,13 +100,3 @@ branch.<name>.description::
 	`git branch --edit-description`. Branch description is
 	automatically added in the format-patch cover letter or
 	request-pull summary.
-
-branch.<name>.coverSubject::
-	When format-patch generates a cover letter, use the specified
-	subject for the cover letter instead of the generic template.
-
-branch.<name>.to::
-branch.<name>.cc::
-	Additional recipients to include in a patch to be submitted
-	by mail.  See the --to and --cc options in
-	linkgit:git-format-patch[1].
diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index dc77941c48..d387451573 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -28,14 +28,22 @@ format.headers::
 
 format.to::
 format.cc::
+format.<branch-name>.to::
+format.<branch-name>.cc::
 	Additional recipients to include in a patch to be submitted
-	by mail.  See the --to and --cc options in
-	linkgit:git-format-patch[1].
+	by mail.  For the <branch-name> options, the recipients are only
+	included if patches are generated for the given <branch-name>.
+	See the --to and --cc options in linkgit:git-format-patch[1].
 
 format.subjectPrefix::
 	The default for format-patch is to output files with the '[PATCH]'
 	subject prefix. Use this variable to change that prefix.
 
+format.<branch-name>.coverSubject::
+	When format-patch generates a cover letter for the given
+	<branch-name>, use the specified subject for the cover letter
+	instead of the generic template.
+
 format.signature::
 	The default for format-patch is to output a signature containing
 	the Git version number. Use this variable to change that default.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1c972f683a..4e826010f6 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -199,7 +199,7 @@ will want to ensure that threading is disabled for `git send-email`.
 	Add a `To:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times. The
 	emails given will be used along with any emails given by
-	`format.to` and `branch.<name>.to` configurations.
+	`format.to` and `format.<branch-name>.to` configurations.
 	The negated form `--no-to` discards all `To:` headers added so
 	far (from config or command line).
 
@@ -207,7 +207,7 @@ will want to ensure that threading is disabled for `git send-email`.
 	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times. The
 	emails given will be used along with any emails given by
-	`format.cc` and `branch.<name>.cc` configurations.
+	`format.cc` and `format.<branch-name>.cc` configurations.
 	The negated form `--no-cc` discards all `Cc:` headers added so
 	far (from config or command line).
 
@@ -355,7 +355,7 @@ In addition, for a specific branch, you can specify a custom cover
 letter subject, and add additional "To:" or "Cc:" headers.
 
 ------------
-[branch "branch-name"]
+[format "branch-name"]
 	coverSubject = "subject for branch-name only"
 	to = <email>
 	cc = <email>
diff --git a/branch.c b/branch.c
index 83cd441790..643694542a 100644
--- a/branch.c
+++ b/branch.c
@@ -163,11 +163,11 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	free(tracking.src);
 }
 
-static int read_branch_config(struct strbuf *buf, const char *branch_name, const char *key)
+int read_branch_desc(struct strbuf *buf, const char *branch_name)
 {
 	char *v = NULL;
 	struct strbuf name = STRBUF_INIT;
-	strbuf_addf(&name, "branch.%s.%s", branch_name, key);
+	strbuf_addf(&name, "branch.%s.description", branch_name);
 	if (git_config_get_string(name.buf, &v)) {
 		strbuf_release(&name);
 		return -1;
@@ -178,16 +178,6 @@ static int read_branch_config(struct strbuf *buf, const char *branch_name, const
 	return 0;
 }
 
-int read_branch_desc(struct strbuf *buf, const char *branch_name)
-{
-	return read_branch_config(buf, branch_name, "description");
-}
-
-int read_branch_subject(struct strbuf *buf, const char *branch_name)
-{
-	return read_branch_config(buf, branch_name, "coversubject");
-}
-
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/branch.h b/branch.h
index 363a4fae9d..6f38db14e9 100644
--- a/branch.h
+++ b/branch.h
@@ -79,11 +79,6 @@ int install_branch_config(int flag, const char *local, const char *origin, const
  */
 int read_branch_desc(struct strbuf *, const char *branch_name);
 
-/*
- * Read branch subject
- */
-extern int read_branch_subject(struct strbuf *, const char *branch_name);
-
 /*
  * Check if a branch is checked out in the main worktree or any linked
  * worktree and die (with a message describing its checkout location) if
diff --git a/builtin/branch.c b/builtin/branch.c
index d4359b33ac..367e1fc9bc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -178,12 +178,22 @@ static int check_branch_commit(const char *branchname, const char *refname,
 	return 0;
 }
 
+static const char *branch_specific_config[] = {
+	"branch",
+	"format",
+	NULL
+};
+
 static void delete_branch_config(const char *branchname)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addf(&buf, "branch.%s", branchname);
-	if (git_config_rename_section(buf.buf, NULL) < 0)
-		warning(_("Update of config-file failed"));
+	int i;
+	for (i = 0; branch_specific_config[i]; i++) {
+		strbuf_addf(&buf, "%s.%s", branch_specific_config[i], branchname);
+		if (git_config_rename_section(buf.buf, NULL) < 0)
+			warning(_("Update of config-file failed"));
+		strbuf_reset(&buf);
+	}
 	strbuf_release(&buf);
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 3adc942b8c..e1d793577d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1032,6 +1032,21 @@ static void show_diffstat(struct rev_info *rev,
 	fprintf(rev->diffopt.file, "\n");
 }
 
+static int read_branch_subject(struct strbuf *buf, const char *branch_name)
+{
+	char *v = NULL;
+	struct strbuf name = STRBUF_INIT;
+	strbuf_addf(&name, "format.%s.coverSubject", branch_name);
+	if (git_config_get_string(name.buf, &v)) {
+		strbuf_release(&name);
+		return -1;
+	}
+	strbuf_addstr(buf, v);
+	free(v);
+	strbuf_release(&name);
+	return 0;
+}
+
 static void add_branch_headers(struct rev_info *rev, const char *branch_name)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -1064,7 +1079,7 @@ static void add_branch_headers(struct rev_info *rev, const char *branch_name)
 	 */
 
 	if (!to_cleared) {
-		strbuf_addf(&buf, "branch.%s.to", branch_name);
+		strbuf_addf(&buf, "format.%s.to", branch_name);
 		values = git_config_get_value_multi(buf.buf);
 		if (values)
 			string_list_append_all(&extra_to, values);
@@ -1072,7 +1087,7 @@ static void add_branch_headers(struct rev_info *rev, const char *branch_name)
 
 	if (!cc_cleared) {
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "branch.%s.cc", branch_name);
+		strbuf_addf(&buf, "format.%s.cc", branch_name);
 		values = git_config_get_value_multi(buf.buf);
 		if (values)
 			string_list_append_all(&extra_cc, values);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e9ad50b66d..9ae3da888e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -782,9 +782,15 @@ test_expect_success 'test tracking setup via --track but deeper' '
 '
 
 test_expect_success 'test deleting branch deletes branch config' '
+	git config format.my7.coverSubject "cover subject" &&
+	git config format.my7.to "To Me <to@example.com>" &&
+	git config format.my7.cc "Cc Me <cc@example.com>" &&
 	git branch -d my7 &&
 	test -z "$(git config branch.my7.remote)" &&
-	test -z "$(git config branch.my7.merge)"
+	test -z "$(git config branch.my7.merge)" &&
+	test -z "$(git config format.my7.coverSubject)"
+	test -z "$(git config format.my7.to)" &&
+	test -z "$(git config format.my7.cc)"
 '
 
 test_expect_success 'test deleting branch without config' '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 5d6c85489e..9c527510c3 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -237,7 +237,7 @@ test_expect_failure 'configuration To: header (rfc2047)' '
 test_expect_success 'branch-specific configuration To: header (ascii)' '
 
 	test_unconfig format.to &&
-	git config branch.side.to "R E Cipient <rcipient@example.com>" &&
+	git config format.side.to "R E Cipient <rcipient@example.com>" &&
 	git format-patch --stdout master..side >patch10 &&
 	sed -e "/^\$/q" patch10 >hdrs10 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
@@ -245,7 +245,7 @@ test_expect_success 'branch-specific configuration To: header (ascii)' '
 
 test_expect_failure 'branch-specific configuration To: header (rfc822)' '
 
-	git config branch.side.to "R. E. Cipient <rcipient@example.com>" &&
+	git config format.side.to "R. E. Cipient <rcipient@example.com>" &&
 	git format-patch --stdout master..side >patch10 &&
 	sed -e "/^\$/q" patch10 >hdrs10 &&
 	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs10
@@ -253,7 +253,7 @@ test_expect_failure 'branch-specific configuration To: header (rfc822)' '
 
 test_expect_failure 'branch-specific configuration To: header (rfc2047)' '
 
-	git config branch.side.to "R Ä Cipient <rcipient@example.com>" &&
+	git config format.side.to "R Ä Cipient <rcipient@example.com>" &&
 	git format-patch --stdout master..side >patch10 &&
 	sed -e "/^\$/q" patch10 >hdrs10 &&
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs10
@@ -265,10 +265,10 @@ test_expect_success 'all recipients included from all sources' '
 	git config --add format.to "Format To2 <formatto2@example.com>" &&
 	git config format.cc "Format Cc1 <formatcc1@example.com>" &&
 	git config --add format.cc "Format Cc2 <formatcc2@example.com>" &&
-	git config branch.side.to "Branch To1 <branchto1@example.com>" &&
-	git config --add branch.side.to "Branch To2 <branchto2@example.com>" &&
-	git config branch.side.cc "Branch Cc1 <branchcc1@example.com>" &&
-	git config --add branch.side.cc "Branch Cc2 <branchcc2@example.com>" &&
+	git config format.side.to "Branch To1 <branchto1@example.com>" &&
+	git config --add format.side.to "Branch To2 <branchto2@example.com>" &&
+	git config format.side.cc "Branch Cc1 <branchcc1@example.com>" &&
+	git config --add format.side.cc "Branch Cc2 <branchcc2@example.com>" &&
 	cat <<-\EOF >expect &&
 	To: Format To1 <formatto1@example.com>,
 	    Format To2 <formatto2@example.com>,
@@ -345,7 +345,7 @@ test_expect_success '--no-to overrides config.to' '
 
 	git config --replace-all format.to \
 		"R E Cipient <rcipient@example.com>" &&
-	git config --replace-all branch.side.to \
+	git config --replace-all format.side.to \
 		"B R Anch <branch@example.com>" &&
 	git format-patch --no-to --stdout master..side >patch11 &&
 	sed -e "/^\$/q" patch11 >hdrs11 &&
@@ -358,7 +358,7 @@ test_expect_success '--no-to and --to replaces config.to' '
 
 	git config --replace-all format.to \
 		"Someone <someone@out.there>" &&
-	git config --replace-all branch.side.to \
+	git config --replace-all format.side.to \
 		"B R Anch2 <branch2@example.com>" &&
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
 		--stdout master..side >patch12 &&
@@ -373,7 +373,7 @@ test_expect_success '--no-cc overrides config.cc' '
 
 	git config --replace-all format.cc \
 		"C E Cipient <rcipient@example.com>" &&
-	git config --replace-all branch.side.cc \
+	git config --replace-all format.side.cc \
 		"B R Anch3 <branch3@example.com>" &&
 	git format-patch --no-cc --stdout master..side >patch13 &&
 	sed -e "/^\$/q" patch13 >hdrs13 &&
@@ -1538,7 +1538,7 @@ test_expect_success 'format patch ignores color.ui' '
 '
 
 test_expect_success 'cover letter with config subject' '
-	test_config branch.rebuild-1.coverSubject "config subject" &&
+	test_config format.rebuild-1.coverSubject "config subject" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter master >actual &&
 	grep "Subject: \[PATCH 0/2\] config subject" actual
@@ -1551,7 +1551,7 @@ test_expect_success 'cover letter with command-line subject' '
 '
 
 test_expect_success 'cover letter with command-line subject overrides config' '
-	test_config branch.rebuild-1.coverSubject "config subject" &&
+	test_config format.rebuild-1.coverSubject "config subject" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-subject "command-line subject" master >actual &&
 	grep "Subject: \[PATCH 0/2\] command-line subject" actual
-- 
2.21.0.1049.geb646f7864


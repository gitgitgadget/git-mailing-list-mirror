Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3111F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfHTHTU (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:19:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44634 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfHTHTU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:20 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so10035992iop.11
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5HwAeLALKorIq6zNnyvMDBVWHRNx/lHaAcG/qH0MPuE=;
        b=EXqXauH7lzK+w3Fn2DI7zv4qqb9RonjQlJAkPwiIHIE8OQqiMPuZRqjJONsrp7TcJw
         gUx7lQr8aXyI6EfMBdU2icdg1r5BbKa17ovFtE4aNCozTz6znQhPm0WD5VeJbX2skVI0
         miBSXsAzd92eJdQkjmEtEFFVAhsO+p1swFlzZmyWRVLgsNjl38jlfLS/t/llhPxC19oh
         SeouOqgtFENY9xzqKvEZaGpJmeOj99P26o/TCE7qPCgxuns3CVKDaSkSIXBzEjoCzkK1
         s9bTrlMDPS2w2GsVM7xmmbCWp2c9GZz0ofkOK2Yvi4WuQnXxv3pMpPaNXIGejv6YvYV3
         uzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5HwAeLALKorIq6zNnyvMDBVWHRNx/lHaAcG/qH0MPuE=;
        b=rKb8jhSRo4r9QixzFjdC2Crp8hqPmCjDRoqK6W/j0rm3QfbJHUGeokzDqh9qQetCwl
         PW3M6qzdnB9SBdvaEewTxRig06Vbp0RulxTByzyyTqPW56c8rQnzS1+0d/VJYn2bU4VZ
         MDd6obXjAkQfkPI4//xwTDR3sP0eCVsGNiRtbZ98lwWAhiy/y2xARaucXJDxHBsS4YQK
         NBuG8mwDi2FhgP+qok/vwHgwDKHNvhRCsQbph6T51IgNBPzdoZUSXckUvQUCkFRle6hz
         0cBQvHY6i6WEFVVR4/0jkFpTieNRzIcYtH+THyTwejz1jNrDeKR20SBc4ckRNUlDbHVy
         u6vQ==
X-Gm-Message-State: APjAAAUqBTQTOz9Yf+vSPALRptyW63thhanc4gHojGj66ybvcsEQUsT6
        LbPAuJL2+uDk2ywCban/td0Bk/+X
X-Google-Smtp-Source: APXvYqy9PUeHT1ImZIJ3eXQIdivj8b+H8eEGtn9TaxQ0c9TZ6nztrAxDO6yh3lhcxYuazdM9r5DrKw==
X-Received: by 2002:a05:6638:a09:: with SMTP id 9mr2194367jan.95.1566285558385;
        Tue, 20 Aug 2019 00:19:18 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id o3sm16230673ioo.74.2019.08.20.00.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:19:17 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:19:16 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
Message-ID: <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach format-patch to use the first line of the branch description as
the Subject: of the generated cover letter, rather than "*** SUBJECT
HERE ***" if `--infer-cover-subject` is specified or the corresponding
`format.inferCoverSubject` option is enabled. This complements the
existing inclusion of the branch description in the cover letter body.

The reason why this behaviour is not made default is because this change
is not backwards compatible and may break existing tooling that may rely
on the default template subject.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    |  6 ++++
 Documentation/git-format-patch.txt |  7 ++++
 builtin/log.c                      | 56 +++++++++++++++++++-----------
 t/t4014-format-patch.sh            | 35 ++++++++++++++++++-
 4 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index cb629fa769..2723566289 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -36,6 +36,12 @@ format.subjectPrefix::
 	The default for format-patch is to output files with the '[PATCH]'
 	subject prefix. Use this variable to change that prefix.
 
+format.inferCoverSubject::
+	A boolean that controls whether or not to take the first line of
+	the branch description as the subject for the cover letter. See the
+	`--infer-cover-subject` option in linkgit:git-format-patch[1].
+	Default is false.
+
 format.signature::
 	The default for format-patch is to output a signature containing
 	the Git version number. Use this variable to change that default.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 95bc4d53ca..c5bc0bf5c6 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<Message-Id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
+		   [--[no-]infer-cover-subject]
 		   [--rfc] [--subject-prefix=<Subject-Prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
@@ -171,6 +172,11 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--[no-]infer-cover-subject::
+	Use the beginning of the branch description (up to the first
+	blank line) as the cover letter subject instead of the default
+	"*** SUBJECT HERE ***".
+
 --subject-prefix=<Subject-Prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
 	line, instead use '[<Subject-Prefix>]'. This
@@ -347,6 +353,7 @@ with configuration variables.
 	signOff = true
 	outputDirectory = <directory>
 	coverLetter = auto
+	inferCoverSubject = true
 ------------
 
 
diff --git a/builtin/log.c b/builtin/log.c
index 44b10b3415..a19b746495 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -774,6 +774,7 @@ static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
 static const char *config_output_directory;
+static int infer_cover_subject;
 
 enum {
 	COVER_UNSET,
@@ -887,6 +888,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "format.infercoversubject")) {
+		infer_cover_subject = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -993,20 +998,6 @@ static void print_signature(FILE *file)
 	putc('\n', file);
 }
 
-static void add_branch_description(struct strbuf *buf, const char *branch_name)
-{
-	struct strbuf desc = STRBUF_INIT;
-	if (!branch_name || !*branch_name)
-		return;
-	read_branch_desc(&desc, branch_name);
-	if (desc.len) {
-		strbuf_addch(buf, '\n');
-		strbuf_addbuf(buf, &desc);
-		strbuf_addch(buf, '\n');
-	}
-	strbuf_release(&desc);
-}
-
 static char *find_branch_name(struct rev_info *rev)
 {
 	int i, positive = -1;
@@ -1057,13 +1048,17 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
+			      int infer_subject,
 			      int quiet)
 {
 	const char *committer;
-	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
-	const char *msg;
+	const char *subject = "*** SUBJECT HERE ***";
+	const char *body = "*** BLURB HERE ***";
+	const char *description = NULL;
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf description_sb = STRBUF_INIT;
+	struct strbuf subject_sb = STRBUF_INIT;
 	int i;
 	const char *encoding = "UTF-8";
 	int need_8bit_cte = 0;
@@ -1091,17 +1086,34 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!branch_name)
 		branch_name = find_branch_name(rev);
 
-	msg = body;
+	if (branch_name && *branch_name)
+		read_branch_desc(&description_sb, branch_name);
+
+	if (description_sb.len) {
+		if (infer_subject) {
+			description = format_subject(&subject_sb, description_sb.buf, " ");
+			subject = subject_sb.buf;
+		} else {
+			description = description_sb.buf;
+		}
+	}
+
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;
 	pp.print_email_subject = 1;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
-	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
-	pp_remainder(&pp, &msg, &sb, 0);
-	add_branch_description(&sb, branch_name);
+	pp_title_line(&pp, &subject, &sb, encoding, need_8bit_cte);
+	pp_remainder(&pp, &body, &sb, 0);
+	if (description) {
+		strbuf_addch(&sb, '\n');
+		strbuf_addstr(&sb, description);
+		strbuf_addch(&sb, '\n');
+	}
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
+	strbuf_release(&description_sb);
+	strbuf_release(&subject_sb);
 	strbuf_release(&sb);
 
 	shortlog_init(&log);
@@ -1577,6 +1589,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "rfc", &rev, NULL,
 			    N_("Use [RFC PATCH] instead of [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback },
+		OPT_BOOL(0, "infer-cover-subject", &infer_cover_subject,
+			    N_("infer a cover letter subject from branch description")),
 		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
 			    N_("Use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback },
@@ -1916,7 +1930,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name, infer_cover_subject, quiet);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7b8c8fe136..94a3191aca 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -822,7 +822,7 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 '
 
 test_expect_success 'get git version' '
-	git_version="$(git --version | sed "s/.* //")"
+	git_version="$(git --version >version && sed "s/.* //" <version)"
 '
 
 signature() {
@@ -1516,6 +1516,39 @@ test_expect_success 'format patch ignores color.ui' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cover letter with config subject' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.inferCoverSubject true &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	grep "^body" actual
+'
+
+test_expect_success 'cover letter with command-line subject' '
+	test_config branch.rebuild-1.description "command-line subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --infer-cover-subject master >actual &&
+	grep "^Subject: \[PATCH 0/2\] command-line subject$" actual &&
+	grep "^body" actual
+'
+
+test_expect_success 'cover letter with command-line --no-infer-cover-subject overrides config' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.inferCoverSubject true &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --no-infer-cover-subject master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	grep "^config subject" actual &&
+	grep "^body" actual
+'
+
 test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
-- 
2.23.0.248.g3a9dd8fb08


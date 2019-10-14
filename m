Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF8C1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 20:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfJNUrI (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:47:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43422 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfJNUrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:47:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id f21so8496146plj.10
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iII+H9c8Lu+bzOTXm20oOZW/Oh2JydL5XSy0HlJcZB0=;
        b=ugB3VqTncQvYEyqkp5sHeDLCkarqLq/OVzZMsAMHy9Tn7SEf1ewKv/sIpggFMjH/ae
         fe3tI2Vdfx9DqjxoncF6CSYJj6LDNXAMPNA9dzOcUYxWuQQpTe45wYu6EYX/6mXIPO+q
         n96eMQq86S8eukQioBiVqiCCRz3DZ5MbAVG2K1bna8XmcTJMNSf2GkVxaPv3QXib14ZZ
         bZ/2y8Ywis1uYhKNyywlK2Pnez9itNpS81Zsz57IzbISLZDBAAzfxZc58L2QMcuPyYnf
         osKhcxOI2p4SoAJp0SZbugXk0820DJVW+KLwidWuaGvNy7H/w4YhNrkuEMuY34F+d0UE
         3N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iII+H9c8Lu+bzOTXm20oOZW/Oh2JydL5XSy0HlJcZB0=;
        b=Lkbp5Z2DXFJcN97QIbv8ejRw3X6dSZEkbnpFipDmR5J2IpnrGmD51ASQCfGS8dAvxR
         L3YF3/tNr8kj707Eso+KJZZc1tzkJp1W3PM8NpfAnjTZtFtOBKzRLyuS+JKefCdsgFgC
         OMjOi7RGNY/hCksm9L4GfM7HEmK24JVl7czSbE10owFd11Ao0Blh18UEfB2P+j04koeW
         PsPzptnPKQNV+/NNxI07kzRQng/C8I267rmIvn5KQFrpv2icNREa0kfc37pgrva8qGgJ
         DqLZSkaZ6HKIQAQwxbStu1ZyWcJqFO3FBbvfbDkJJA86iYnDmithIrHkdbZodgPYyr2B
         k8jg==
X-Gm-Message-State: APjAAAWq0dXicroDOktqZjFmSgUCEgD0eGB4T/svdPhpi5CqVHH3zop2
        11jiUDUI4jiEzhuiw4ws59zNWpgK
X-Google-Smtp-Source: APXvYqy1uhCmCxk8u7TYiKDej0IAzG5OOvuH/MkflgIXyo96s2SPv+XdqoUeVQLX0YKapo4Smo4ceA==
X-Received: by 2002:a17:902:7c8a:: with SMTP id y10mr15595487pll.115.1571086026698;
        Mon, 14 Oct 2019 13:47:06 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id r18sm25614187pfc.3.2019.10.14.13.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 13:47:06 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:47:04 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 3/3] format-patch: teach --cover-from-description option
Message-ID: <315c308950270968293c92c94fdadd3be3340c33.1571085952.git.liu.denton@gmail.com>
References: <cover.1570821015.git.liu.denton@gmail.com>
 <cover.1571085952.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571085952.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when format-patch generated a cover letter, only the body would
be populated with a branch's description while the subject would be
populated with placeholder text. However, users may want to have the
subject of their cover letter automatically populated in the same way.

Teach format-patch to accept the `--cover-from-description` option and
corresponding `format.coverFromDescription` config, allowing users to
populate different parts of the cover letter (including the subject
now).

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    |   6 +
 Documentation/git-format-patch.txt |  22 ++++
 builtin/log.c                      |  95 ++++++++++++----
 t/t4014-format-patch.sh            | 172 +++++++++++++++++++++++++++++
 t/t9902-completion.sh              |   5 +-
 5 files changed, 279 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index cb629fa769..735dfcf827 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -36,6 +36,12 @@ format.subjectPrefix::
 	The default for format-patch is to output files with the '[PATCH]'
 	subject prefix. Use this variable to change that prefix.
 
+format.coverFromDescription::
+	The default mode for format-patch to determine which parts of
+	the cover letter will be populated using the branch's
+	description. See the `--cover-from-description` option in
+	linkgit:git-format-patch[1].
+
 format.signature::
 	The default for format-patch is to output a signature containing
 	the Git version number. Use this variable to change that default.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0ac56f4b70..6800e1ab9a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
+		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
@@ -171,6 +172,26 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--cover-from-description=<mode>::
+	Controls which parts of the cover letter will be automatically
+	populated using the branch's description.
++
+If `<mode>` is `message` or `default`, the cover letter subject will be
+populated with placeholder text. The body of the cover letter will be
+populated with the branch's description. This is the default mode when
+no configuration nor command line option is specified.
++
+If `<mode>` is `subject`, the first paragraph of the branch description will
+populate the cover letter subject. The remainder of the description will
+populate the body of the cover letter.
++
+If `<mode>` is `auto`, if the first paragraph of the branch description
+is greater than 100 bytes, then the mode will be `message`, otherwise
+`subject` will be used.
++
+If `<mode>` is `none`, both the cover letter subject and body will be
+populated with placeholder text.
+
 --subject-prefix=<subject prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
 	line, instead use '[<subject prefix>]'. This
@@ -347,6 +368,7 @@ with configuration variables.
 	signOff = true
 	outputDirectory = <directory>
 	coverLetter = auto
+	coverFromDescription = auto
 ------------
 
 
diff --git a/builtin/log.c b/builtin/log.c
index d212a8305d..af33fe9ffb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -37,6 +37,7 @@
 #include "range-diff.h"
 
 #define MAIL_DEFAULT_WRAP 72
+#define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -777,6 +778,13 @@ enum thread_level {
 	THREAD_DEEP
 };
 
+enum cover_from_description {
+	COVER_FROM_NONE,
+	COVER_FROM_MESSAGE,
+	COVER_FROM_SUBJECT,
+	COVER_FROM_AUTO
+};
+
 static enum thread_level thread;
 static int do_signoff;
 static int base_auto;
@@ -785,6 +793,23 @@ static const char *signature = git_version_string;
 static const char *signature_file;
 static enum cover_setting config_cover_letter;
 static const char *config_output_directory;
+static enum cover_from_description cover_from_description_mode = COVER_FROM_MESSAGE;
+
+static enum cover_from_description parse_cover_from_description(const char *arg)
+{
+	if (!arg || !strcmp(arg, "default"))
+		return COVER_FROM_MESSAGE;
+	else if (!strcmp(arg, "none"))
+		return COVER_FROM_NONE;
+	else if (!strcmp(arg, "message"))
+		return COVER_FROM_MESSAGE;
+	else if (!strcmp(arg, "subject"))
+		return COVER_FROM_SUBJECT;
+	else if (!strcmp(arg, "auto"))
+		return COVER_FROM_AUTO;
+	else
+		die(_("%s: invalid cover from description mode"), arg);
+}
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
@@ -891,6 +916,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "format.coverfromdescription")) {
+		cover_from_description_mode = parse_cover_from_description(value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -997,20 +1026,6 @@ static void print_signature(FILE *file)
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
@@ -1057,6 +1072,44 @@ static void show_diffstat(struct rev_info *rev,
 	fprintf(rev->diffopt.file, "\n");
 }
 
+static void pp_from_desc(struct pretty_print_context *pp,
+			 const char *branch_name,
+			 struct strbuf *sb,
+			 const char *encoding,
+			 int need_8bit_cte)
+{
+	const char *subject = "*** SUBJECT HERE ***";
+	const char *body = "*** BLURB HERE ***";
+	struct strbuf description_sb = STRBUF_INIT;
+	struct strbuf subject_sb = STRBUF_INIT;
+
+	if (cover_from_description_mode == COVER_FROM_NONE)
+		goto do_pp;
+
+	if (branch_name && *branch_name)
+		read_branch_desc(&description_sb, branch_name);
+	if (!description_sb.len)
+		goto do_pp;
+
+	if (cover_from_description_mode == COVER_FROM_SUBJECT ||
+			cover_from_description_mode == COVER_FROM_AUTO)
+		body = format_subject(&subject_sb, description_sb.buf, " ");
+
+	if (cover_from_description_mode == COVER_FROM_MESSAGE ||
+			(cover_from_description_mode == COVER_FROM_AUTO &&
+			 subject_sb.len > COVER_FROM_AUTO_MAX_SUBJECT_LEN))
+		body = description_sb.buf;
+	else
+		subject = subject_sb.buf;
+
+do_pp:
+	pp_title_line(pp, &subject, sb, encoding, need_8bit_cte);
+	pp_remainder(pp, &body, sb, 0);
+
+	strbuf_release(&description_sb);
+	strbuf_release(&subject_sb);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1064,8 +1117,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int quiet)
 {
 	const char *committer;
-	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
-	const char *msg;
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -1095,15 +1146,12 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!branch_name)
 		branch_name = find_branch_name(rev);
 
-	msg = body;
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;
 	pp.print_email_subject = 1;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
-	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
-	pp_remainder(&pp, &msg, &sb, 0);
-	add_branch_description(&sb, branch_name);
+	pp_from_desc(&pp, branch_name, &sb, encoding, need_8bit_cte);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
 	strbuf_release(&sb);
@@ -1545,6 +1593,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int use_patch_format = 0;
 	int quiet = 0;
 	int reroll_count = -1;
+	char *cover_from_description_arg = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
@@ -1581,6 +1630,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "rfc", &rev, NULL,
 			    N_("Use [RFC PATCH] instead of [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback },
+		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
+			    N_("cover-from-description-mode"),
+			    N_("generate parts of a cover letter based on a branch's description")),
 		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
 			    N_("Use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback },
@@ -1672,6 +1724,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (cover_from_description_arg)
+		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
+
 	if (0 < reroll_count) {
 		struct strbuf sprefix = STRBUF_INIT;
 		strbuf_addf(&sprefix, "%s v%d",
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 72b09896cf..88db01308a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1517,6 +1517,178 @@ test_expect_success 'format patch ignores color.ui' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cover letter with invalid --cover-from-description and config' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_must_fail git format-patch --cover-letter --cover-from-description garbage master &&
+	test_config format.coverFromDescription garbage &&
+	test_must_fail git format-patch --cover-letter master
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = default' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription default &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description default' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description default master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = none' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription none &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	! grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description none' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description none master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	! grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = message' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription message &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description message' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description message master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = subject' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription subject &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description subject' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description subject master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = auto (short subject line)' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription auto &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description auto (short subject line)' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description auto master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = auto (long subject line)' '
+	test_config branch.rebuild-1.description "this is a really long first line and it is over 100 characters long which is the threshold for long subjects
+
+body" &&
+	test_config format.coverFromDescription auto &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description auto (long subject line)' '
+	test_config branch.rebuild-1.description "this is a really long first line and it is over 100 characters long which is the threshold for long subjects
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description auto master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with command-line --cover-from-description overrides config' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription none &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description subject master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
 test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 75512c3403..5187e2ede5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1548,7 +1548,10 @@ test_expect_success 'complete tree filename with metacharacters' '
 '
 
 test_expect_success PERL 'send-email' '
-	test_completion "git send-email --cov" "--cover-letter " &&
+	test_completion "git send-email --cov" <<-\EOF &&
+	--cover-from-description=Z
+	--cover-letter Z
+	EOF
 	test_completion "git send-email ma" "master "
 '
 
-- 
2.23.0.17.g315c308950


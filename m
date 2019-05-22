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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8261F462
	for <e@80x24.org>; Wed, 22 May 2019 02:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfEVCol (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 22:44:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39245 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfEVCok (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 22:44:40 -0400
Received: by mail-it1-f195.google.com with SMTP id 9so726581itf.4
        for <git@vger.kernel.org>; Tue, 21 May 2019 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gP6yJEP96bWMqMhYT9S5Hyd/tVmPk1rs9wq2IDxpcTo=;
        b=RvZPh2ndVWH+hHhu3Qp1cFt0VpTC7Q+gMl4vc7nf9LSAQ4NA/1fKKBeASuK7nWrAef
         7TKbSF4KVLS+lCbM2y44qMfkXOFG7pv14BP6L+OoHdt5Ow/wMy3y7BJOo4Zp/f2RrOkW
         gXbTk8R9HhqDizEnGHfFxAvgIIsk0teB6zUpAQjJN19XYYf0mZGyw/ZX6rYOxJChoApx
         ELhjf7PFJcsoJtJ3BQ3vgv6iHbHTd8emLPetAHBC2X2UADZ94DrXvBQRImoKQ2te1v2i
         HGRs1egL996M5V3AQoBwrE15EE7wIvPi7X//3ba7V8k95UvKM5t2zOitV6bV2FZJs8lo
         E6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gP6yJEP96bWMqMhYT9S5Hyd/tVmPk1rs9wq2IDxpcTo=;
        b=VYaDrAh/D//yD1jCPb1y58r9foOXbPUzkipuv8zOt/MN/lMaTCLpPuF7EZ2e5OUyV8
         vXH68AEdwYmGI5Ul3SmTfEOrGF8Qk3lyEjS+sAHaf6tnOZFKES09j9ZfMs5r/4c8HL8H
         Dc5B2caYgh4IZ1gUjUd7D76HOEL+/VeEwiraZ0CTyFi+f35TXYgTpNYmJht1zldp3nYj
         hNP+s6CwYsU+cYTnhFjVjuEkfnzPQGmGr/Ac1Kvaiw+4qjA513r5QGxrMdlW3JlwqCQ5
         +2hHiTCvXjLE0634Ext1f1ZUDoSGlPEW9NWw8p3ESJWu9+6EZ6y2YhbKjXyneFZchYe5
         yvNQ==
X-Gm-Message-State: APjAAAU3CD/Pqzj2IrF1lLso7YxgxWmmT+LqdqRxH/Na5JyOIez+zWHe
        wvFwHUEDagMQBNqj9Juu+rd/+SKr
X-Google-Smtp-Source: APXvYqy9ICf+bePJsjJ2B+23iMKPjW8bT28BBl7Haw1/482S8cRW2b+tw766NDxBXusXrpznW3kUIw==
X-Received: by 2002:a24:5c4a:: with SMTP id q71mr6366229itb.45.1558493079027;
        Tue, 21 May 2019 19:44:39 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id f24sm7381449ioj.50.2019.05.21.19.44.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 19:44:38 -0700 (PDT)
Date:   Tue, 21 May 2019 22:44:37 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/8] format-patch: read branch-specific To: and Cc: headers
Message-ID: <f2a1546b2d43ee66d2bfa1834f9a81fb9f453281.1558492582.git.liu.denton@gmail.com>
References: <cover.1558052674.git.liu.denton@gmail.com>
 <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user wishes to keep track of whom to Cc: on individual patchsets,
they must manually keep track of each recipient and fill it in with the
`--cc` option on git-format-patch each time. However, on the Git mailing
list, Cc:'s are typically never dropped. As a result, it would be nice
to have a method to keep track of recipients on a per-branch basis.

Currently, git-format-patch gets its To: headers from the `--to` options
and the `format.to` config variable. The Cc: header is derived
similarly.

In addition to the above, read To: and Cc: headers from
`format.<branch-name>.to` and `format.<branch-name>.cc` so that users
can have branch-specific configuration options.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    |   7 +-
 Documentation/git-format-patch.txt |  12 +++-
 builtin/log.c                      |  63 +++++++++++++++--
 t/t4014-format-patch.sh            | 108 +++++++++++++++++++++++------
 4 files changed, 162 insertions(+), 28 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index c8b28fe47f..95e255347a 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -28,9 +28,12 @@ format.headers::
 
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
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index f54aecf4bf..76e61b746a 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -203,7 +203,7 @@ the description up to and excluding the first blank line.
 	Add a `To:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times. The
 	emails given will be used along with any emails given by
-	`format.to` configurations.
+	`format.to` and `format.<branch-name>.to` configurations.
 	The negated form `--no-to` discards all `To:` headers added so
 	far (from config or command line).
 
@@ -211,7 +211,7 @@ the description up to and excluding the first blank line.
 	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times. The
 	emails given will be used along with any emails given by
-	`format.cc` configurations.
+	`format.cc` and `format.<branch-name>.cc` configurations.
 	The negated form `--no-cc` discards all `Cc:` headers added so
 	far (from config or command line).
 
@@ -358,6 +358,14 @@ with configuration variables.
 	inferCoverSubject = true
 ------------
 
+In addition, for a specific branch, you can specify a custom cover
+letter subject, and add additional "To:" or "Cc:" headers.
+
+------------
+[format "branch-name"]
+	to = <email>
+	cc = <email>
+------------
 
 DISCUSSION
 ----------
diff --git a/builtin/log.c b/builtin/log.c
index 3f97f344df..cb9ccdc59c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -738,6 +738,8 @@ static char *default_attach = NULL;
 static struct string_list extra_hdr = STRING_LIST_INIT_NODUP;
 static struct string_list extra_to = STRING_LIST_INIT_NODUP;
 static struct string_list extra_cc = STRING_LIST_INIT_NODUP;
+int to_cleared;
+int cc_cleared;
 
 static void add_header(const char *value)
 {
@@ -1021,6 +1023,55 @@ static void show_diffstat(struct rev_info *rev,
 	fprintf(rev->diffopt.file, "\n");
 }
 
+static void add_branch_headers(struct rev_info *rev, const char *branch_name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const struct string_list *values;
+
+	if (!branch_name)
+		branch_name = find_branch_name(rev);
+
+	if (!branch_name || !*branch_name)
+		return;
+
+	/*
+	 * HACK: We only use branch-specific recipients iff the list has not
+	 * been cleared by an earlier --no-{to,cc} option on the command-line.
+	 *
+	 * When we get format.{to,cc} options, they can be cleared by
+	 * --no-{to,cc} options since the `git_config` call comes before the
+	 *  `parse_options` call.
+	 *
+	 *  However, in the case of branch.<name>.{to,cc}, this function needs
+	 *  to be called after `setup_revisions`, which must be called after
+	 *  `parse_options`. However, in order for the --no-{to,cc} logic to
+	 *  clear the extra_{to,cc} string_list, this function should actually
+	 *  be called _before_ `parse_options`. As a result, we have a circular
+	 *  dependency.
+	 *
+	 *  The {to,cc}_cleared flag lets us workaround this by just no
+	 *  including branch-specific recipients iff --no-{to,cc} has been
+	 *  specified on the command-line.
+	 */
+
+	if (!to_cleared) {
+		strbuf_addf(&buf, "format.%s.to", branch_name);
+		values = git_config_get_value_multi(buf.buf);
+		if (values)
+			string_list_append_all(&extra_to, values);
+	}
+
+	if (!cc_cleared) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "format.%s.cc", branch_name);
+		values = git_config_get_value_multi(buf.buf);
+		if (values)
+			string_list_append_all(&extra_cc, values);
+	}
+
+	strbuf_release(&buf);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1293,18 +1344,20 @@ static int header_callback(const struct option *opt, const char *arg, int unset)
 
 static int to_callback(const struct option *opt, const char *arg, int unset)
 {
-	if (unset)
+	if (unset) {
+		to_cleared = 1;
 		string_list_clear(&extra_to, 0);
-	else
+	} else
 		string_list_append(&extra_to, arg);
 	return 0;
 }
 
 static int cc_callback(const struct option *opt, const char *arg, int unset)
 {
-	if (unset)
+	if (unset) {
+		cc_cleared = 1;
 		string_list_clear(&extra_cc, 0);
-	else
+	} else
 		string_list_append(&extra_cc, arg);
 	return 0;
 }
@@ -1769,6 +1822,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	add_branch_headers(&rev, branch_name);
+
 	for (i = 0; i < extra_hdr.nr; i++) {
 		strbuf_addstr(&buf, extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 4cb6b9edfa..23c467e95b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -234,6 +234,65 @@ test_expect_failure 'configuration To: header (rfc2047)' '
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
+test_expect_success 'branch-specific configuration To: header (ascii)' '
+
+	test_unconfig format.to &&
+	git config format.side.to "R E Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
+'
+
+test_expect_failure 'branch-specific configuration To: header (rfc822)' '
+
+	git config format.side.to "R. E. Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs10
+'
+
+test_expect_failure 'branch-specific configuration To: header (rfc2047)' '
+
+	git config format.side.to "R Ä Cipient <rcipient@example.com>" &&
+	git format-patch --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs10
+'
+
+test_expect_success 'all recipients included from all sources' '
+
+	git config format.to "Format To1 <formatto1@example.com>" &&
+	git config --add format.to "Format To2 <formatto2@example.com>" &&
+	git config format.cc "Format Cc1 <formatcc1@example.com>" &&
+	git config --add format.cc "Format Cc2 <formatcc2@example.com>" &&
+	git config format.side.to "Branch To1 <branchto1@example.com>" &&
+	git config --add format.side.to "Branch To2 <branchto2@example.com>" &&
+	git config format.side.cc "Branch Cc1 <branchcc1@example.com>" &&
+	git config --add format.side.cc "Branch Cc2 <branchcc2@example.com>" &&
+	cat <<-\EOF >expect &&
+	To: Format To1 <formatto1@example.com>,
+	    Format To2 <formatto2@example.com>,
+	    Command-line To1 <commandlineto1@example.com>,
+	    Command-line To2 <commandlineto2@example.com>,
+	    Branch To1 <branchto1@example.com>,
+	    Branch To2 <branchto2@example.com>
+	Cc: Format Cc1 <formatcc1@example.com>,
+	    Format Cc2 <formatcc2@example.com>,
+	    Command-line Cc1 <commandlinecc1@example.com>,
+	    Command-line Cc2 <commandlinecc2@example.com>,
+	    Branch Cc1 <branchcc1@example.com>,
+	    Branch Cc2 <branchcc2@example.com>
+
+	EOF
+	git format-patch --stdout \
+		--to="Command-line To1 <commandlineto1@example.com>" \
+		--to="Command-line To2 <commandlineto2@example.com>" \
+		--cc="Command-line Cc1 <commandlinecc1@example.com>" \
+		--cc="Command-line Cc2 <commandlinecc2@example.com>" \
+		master..side | sed -ne "/^To:/,/^$/p;/^$/q" >patch10 &&
+	test_cmp expect patch10
+'
+
 # check_patch <patch>: Verify that <patch> looks like a half-sane
 # patch email to avoid a false positive with !grep
 check_patch () {
@@ -286,42 +345,51 @@ test_expect_success '--no-to overrides config.to' '
 
 	git config --replace-all format.to \
 		"R E Cipient <rcipient@example.com>" &&
-	git format-patch --no-to --stdout master..side >patch10 &&
-	sed -e "/^\$/q" patch10 >hdrs10 &&
-	check_patch hdrs10 &&
-	! grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
+	git config --replace-all format.side.to \
+		"B R Anch <branch@example.com>" &&
+	git format-patch --no-to --stdout master..side >patch11 &&
+	sed -e "/^\$/q" patch11 >hdrs11 &&
+	check_patch hdrs11 &&
+	! grep "R E Cipient <rcipient@example.com>" hdrs11 &&
+	! grep "B R Anch <branch@example.com>" hdrs11
 '
 
 test_expect_success '--no-to and --to replaces config.to' '
 
 	git config --replace-all format.to \
 		"Someone <someone@out.there>" &&
+	git config --replace-all format.side.to \
+		"B R Anch2 <branch2@example.com>" &&
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
-		--stdout master..side >patch11 &&
-	sed -e "/^\$/q" patch11 >hdrs11 &&
-	check_patch hdrs11 &&
-	! grep "^To: Someone <someone@out.there>\$" hdrs11 &&
-	grep "^To: Someone Else <else@out.there>\$" hdrs11
+		--stdout master..side >patch12 &&
+	sed -e "/^\$/q" patch12 >hdrs12 &&
+	check_patch hdrs12 &&
+	! grep "Someone <someone@out.there>" hdrs12 &&
+	! grep "B R Anch2 <branch2@example.com>" hdrs12 &&
+	grep "^To: Someone Else <else@out.there>\$" hdrs12
 '
 
 test_expect_success '--no-cc overrides config.cc' '
 
 	git config --replace-all format.cc \
 		"C E Cipient <rcipient@example.com>" &&
-	git format-patch --no-cc --stdout master..side >patch12 &&
-	sed -e "/^\$/q" patch12 >hdrs12 &&
-	check_patch hdrs12 &&
-	! grep "^Cc: C E Cipient <rcipient@example.com>\$" hdrs12
+	git config --replace-all format.side.cc \
+		"B R Anch3 <branch3@example.com>" &&
+	git format-patch --no-cc --stdout master..side >patch13 &&
+	sed -e "/^\$/q" patch13 >hdrs13 &&
+	check_patch hdrs13 &&
+	! grep "C E Cipient <rcipient@example.com>" hdrs13 &&
+	! grep "B R Anch3 <branch3@example.com>" hdrs13
 '
 
 test_expect_success '--no-add-header overrides config.headers' '
 
 	git config --replace-all format.headers \
 		"Header1: B E Cipient <rcipient@example.com>" &&
-	git format-patch --no-add-header --stdout master..side >patch13 &&
-	sed -e "/^\$/q" patch13 >hdrs13 &&
-	check_patch hdrs13 &&
-	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs13
+	git format-patch --no-add-header --stdout master..side >patch14 &&
+	sed -e "/^\$/q" patch14 >hdrs14 &&
+	check_patch hdrs14 &&
+	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs14
 '
 
 test_expect_success 'multiple files' '
@@ -963,7 +1031,7 @@ test_expect_success 'format-patch wraps extremely long subject (ascii)' '
 	git add file &&
 	git commit -m "$M512" &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^Subject/p; /^ /p; /^$/q" <patch >subject &&
+	sed -n "/^Subject/p; /^ /p; /^Header1:/q" <patch >subject &&
 	test_cmp expect subject
 '
 
@@ -1002,7 +1070,7 @@ test_expect_success 'format-patch wraps extremely long subject (rfc2047)' '
 	git add file &&
 	git commit -m "$M512" &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^Subject/p; /^ /p; /^$/q" <patch >subject &&
+	sed -n "/^Subject/p; /^ /p; /^Header1:/q" <patch >subject &&
 	test_cmp expect subject
 '
 
@@ -1011,7 +1079,7 @@ check_author() {
 	git add file &&
 	GIT_AUTHOR_NAME=$1 git commit -m author-check &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^From: /p; /^ /p; /^$/q" <patch >actual &&
+	sed -n "/^From: /p; /^ /p; /^Date:/q" <patch >actual &&
 	test_cmp expect actual
 }
 
-- 
2.22.0.rc1.169.g49223abbf8


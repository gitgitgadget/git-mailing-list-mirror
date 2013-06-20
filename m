From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v5 5/5] pretty: user format ignores i18n.logOutputEncoding setting
Date: Thu, 20 Jun 2013 13:26:21 +0400
Message-ID: <ed75c8cbcfbbac336e2384e2f566e42264154918.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 11:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upb94-0003JW-Fo
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 11:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261Ab3FTJ1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 05:27:06 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:35761 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965226Ab3FTJ1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 05:27:01 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so5464546lab.39
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=V0EI4qokFN0ohRKslf3cFkM6DL3NJklRxQ5L3KH6404=;
        b=Wbxx8ePYDQyWDLwcnICU8mafrBUKsBHpv0kn7qCL2PeTFgZRo23YNwOl5NA+T51c6+
         KORD53EQBLJdWG+udvGIaJx4WLd+3C4Is40OuNojSC3WCI4R1a8QVn8+O2JNle0PzuBl
         FPAjy5zisSOR7VgXP90CyVeSuV5F83JePsWyg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=V0EI4qokFN0ohRKslf3cFkM6DL3NJklRxQ5L3KH6404=;
        b=oAI9nnU3/4P2jZXw1oIfpsNMQ6BnuLcLYp3w8lbfg5XxZrV0GXzihhgsfJrG0wWgt+
         sHpBXQ7Z243RI5y4qpdSAtv+JHMM2vLmwEKTeT7Ku4ftTGwxou2rAbNanCgoRkhPwyFK
         dy2xaVcFAse52QJJMqPKbeXwwjKlW6t+AOIGBJXH2z42pjYmYy3Wwci6rjxg3NOfxAuR
         EjGDmyXMJ1poUEwGG1pGasczQ+xP2ZFLpshMMZWRW04y4rOaml1BYpt3vExmNPdr5Bp2
         vcecZRRNm7NrbBt1TN5+OY/vAPK4fPieXJs7HxwVFeowEghwX/K5l1PpNfE87lpS1RDR
         WV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=V0EI4qokFN0ohRKslf3cFkM6DL3NJklRxQ5L3KH6404=;
        b=WFfiwGpel9ymO8SEhEYAm10w7ujWiSxks0Kzq0H0m5dRnYGdwd25waVPhOQD9io3aQ
         WQZ7ApPzzjn3oZ1R5tLGog6hgbCe840Y2AYlXTl69Rgx6c7nAhxXCXnMAb/NdvSLyBwv
         FFszsxdQEUhlRnXvFsBw1VJKBytzhEH6QQ6LTpESxN3fooo5N1CJEucFSraYPF5aMA2i
         ckWg35D5LYLmz8HFUo++dtjeLDWQi4nOgq0VM8cV4utdTi75LaXV9/uvrOIA3FLAZ21S
         7vUNh/lmZ3uMjNsZtgSMhwmWsfIyxf+nWIe3jgpO/5lS6D7Xbfy7VDGH8CnW/jINgz12
         B68g==
X-Received: by 10.152.22.130 with SMTP id d2mr3279209laf.33.1371720419717;
        Thu, 20 Jun 2013 02:26:59 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id f8sm1096lbr.10.2013.06.20.02.26.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 02:26:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com> <cover.1371720245.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQk7OlrgDa+aRj16weBERFq3hn8wNDCFvAy+COCm+MqfGpmjk9ntEILstwnPwNLAjL/wb/sM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228473>

The following two commands are expected to give the same output to a terminal:

	$ git log --oneline --no-color
	$ git log --pretty=format:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it format "%s".
Log messages written in an encoding i18n.commitEncoding which differs
from terminal encoding are shown corrupted with the latter even
when i18n.logOutputEncoding and terminal encoding are the same.

The same corruption is true for
	$ git diff --submodule=log
and
	$ git rev-list --pretty=format:%s HEAD
and
	$ git reset --hard

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 builtin/reset.c                  |  8 ++++++--
 builtin/rev-list.c               |  1 +
 builtin/shortlog.c               |  1 +
 log-tree.c                       |  1 +
 submodule.c                      |  3 +++
 t/t4041-diff-submodule-option.sh | 10 +++++-----
 t/t4205-log-pretty-formats.sh    | 34 +++++++++++++++++-----------------
 t/t6006-rev-list-format.sh       |  8 ++++----
 t/t7102-reset.sh                 |  2 +-
 9 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 6032131..b23ed63 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -92,11 +92,15 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
 
 static void print_new_head_line(struct commit *commit)
 {
-	const char *hex, *body;
+	const char *hex, *body, *encoding;
 
 	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	printf(_("HEAD is now at %s"), hex);
-	body = strstr(commit->buffer, "\n\n");
+	encoding = get_log_output_encoding();
+	body = logmsg_reencode(commit, NULL, encoding);
+	if (!body)
+		body = commit->buffer;
+	body = strstr(body, "\n\n");
 	if (body) {
 		const char *eol;
 		size_t len;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 67701be..a5ec30d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -111,6 +111,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.date_mode = revs->date_mode;
 		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
+		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &buf);
 		if (revs->graph) {
 			if (buf.len) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1fd6f8a..1434f8f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -137,6 +137,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.subject = "";
 		ctx.after_subject = "";
 		ctx.date_mode = DATE_NORMAL;
+		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &ufbuf);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
diff --git a/log-tree.c b/log-tree.c
index 1946e9c..5277d3e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -616,6 +616,7 @@ void show_log(struct rev_info *opt)
 	ctx.fmt = opt->commit_format;
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
+	ctx.output_encoding = get_log_output_encoding();
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/submodule.c b/submodule.c
index 1821a5b..baa8669 100644
--- a/submodule.c
+++ b/submodule.c
@@ -222,10 +222,13 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
 	struct commit *commit;
+	const char *log_output_encoding;
 
+	log_output_encoding = get_log_output_encoding();
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
+		ctx.output_encoding = log_output_encoding;
 		strbuf_setlen(&sb, 0);
 		strbuf_addstr(&sb, line_prefix);
 		if (commit->object.flags & SYMMETRIC_LEFT) {
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 22bf4df..ce192b0 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -94,7 +94,7 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
-test_expect_failure 'modified submodule(forward)' '
+test_expect_success 'modified submodule(forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -103,7 +103,7 @@ test_expect_failure 'modified submodule(forward)' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'modified submodule(forward)' '
+test_expect_success 'modified submodule(forward)' '
 	git diff --submodule=log >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -112,7 +112,7 @@ test_expect_failure 'modified submodule(forward)' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'modified submodule(forward) --submodule' '
+test_expect_success 'modified submodule(forward) --submodule' '
 	git diff --submodule >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -143,7 +143,7 @@ head3=$(
 	git rev-parse --short --verify HEAD
 )
 
-test_expect_failure 'modified submodule(backward)' '
+test_expect_success 'modified submodule(backward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
@@ -154,7 +154,7 @@ test_expect_failure 'modified submodule(backward)' '
 '
 
 head4=$(add_file sm1 foo4 foo5)
-test_expect_failure 'modified submodule(backward and forward)' '
+test_expect_success 'modified submodule(backward and forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 6a56019..1739a86 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -69,7 +69,7 @@ test_expect_success 'alias user-defined tformat with %s (iso88595 encoding)' '
 	test_cmp expected-s actual-s
 '
 
-test_expect_failure 'alias user-defined tformat with %s (utf-8 encoding)' '
+test_expect_success 'alias user-defined tformat with %s (utf-8 encoding)' '
 	git log --oneline >expected-s &&
 	git log --pretty="tformat:%h %s" >actual-s &&
 	test_cmp expected-s actual-s
@@ -108,19 +108,19 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=test-foo
 '
 
-test_expect_failure 'NUL separation' '
+test_expect_success 'NUL separation' '
 	printf "add bar\0$(commit_msg)" >expected &&
 	git log -z --pretty="format:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_failure 'NUL termination' '
+test_expect_success 'NUL termination' '
 	printf "add bar\0$(commit_msg)\0" >expected &&
 	git log -z --pretty="tformat:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_failure 'NUL separation with --stat' '
+test_expect_success 'NUL separation with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expected &&
@@ -145,7 +145,7 @@ test_expect_success 'setup more commits' '
 	head4=$(git rev-list --max-count=1 --abbrev-commit HEAD~3)
 '
 
-test_expect_failure 'left alignment formatting' "
+test_expect_success 'left alignment formatting' "
 	git log --pretty='format:%<(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -158,7 +158,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting at the nth column' "
+test_expect_success 'left alignment formatting at the nth column' "
 	git log --pretty='format:%h %<|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -171,7 +171,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting with no padding' "
+test_expect_success 'left alignment formatting with no padding' "
 	git log --pretty='format:%<(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -184,7 +184,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting with trunc' "
+test_expect_success 'left alignment formatting with trunc' "
 	git log --pretty='format:%<(10,trunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -197,7 +197,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting with ltrunc' "
+test_expect_success 'left alignment formatting with ltrunc' "
 	git log --pretty='format:%<(10,ltrunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -210,7 +210,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting with mtrunc' "
+test_expect_success 'left alignment formatting with mtrunc' "
 	git log --pretty='format:%<(10,mtrunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -223,7 +223,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'right alignment formatting' "
+test_expect_success 'right alignment formatting' "
 	git log --pretty='format:%>(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -236,7 +236,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'right alignment formatting at the nth column' "
+test_expect_success 'right alignment formatting at the nth column' "
 	git log --pretty='format:%h %>|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -249,7 +249,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'right alignment formatting with no padding' "
+test_expect_success 'right alignment formatting with no padding' "
 	git log --pretty='format:%>(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -262,7 +262,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'center alignment formatting' "
+test_expect_success 'center alignment formatting' "
 	git log --pretty='format:%><(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -275,7 +275,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'center alignment formatting at the nth column' "
+test_expect_success 'center alignment formatting at the nth column' "
 	git log --pretty='format:%h %><|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -288,7 +288,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'center alignment formatting with no padding' "
+test_expect_success 'center alignment formatting with no padding' "
 	git log --pretty='format:%><(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -301,7 +301,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left/right alignment formatting with stealing' "
+test_expect_success 'left/right alignment formatting with stealing' "
 	git commit --amend -m short --author 'long long long <long@me.com>' &&
 	git log --pretty='format:%<(10,trunc)%s%>>(10,ltrunc)% an' >actual &&
 	# complete the incomplete line at the end
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 36e4cc0..055655c 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -143,7 +143,7 @@ commit $head1
 iso88595
 EOF
 
-test_format failure subject %s <<EOF
+test_format subject %s <<EOF
 commit $head2
 $changed
 commit $head1
@@ -155,7 +155,7 @@ commit $head2
 commit $head1
 EOF
 
-test_format failure raw-body %B <<EOF
+test_format raw-body %B <<EOF
 commit $head2
 $changed
 
@@ -249,7 +249,7 @@ commit $head1
 iso88595
 EOF
 
-test_format failure complex-subject %s <<EOF
+test_format complex-subject %s <<EOF
 commit $head3
 Test printing of complex bodies
 commit $head2
@@ -258,7 +258,7 @@ commit $head1
 $added
 EOF
 
-test_format failure complex-body %b <<EOF
+test_format complex-body %b <<EOF
 commit $head3
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 48534f1..5a7b383 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -55,7 +55,7 @@ check_changes () {
 	done | test_cmp .cat_expect -
 }
 
-test_expect_failure 'reset --hard message' '
+test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
 	git reset --hard > .actual &&
 	echo HEAD is now at $hex $(commit_msg) > .expected &&
-- 
1.8.3.1.15.g5c23c1e

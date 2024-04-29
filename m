Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA8380
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365082; cv=none; b=LviY0sL1g46aqziVoAawBfjGFyMmdE/cgmrL0XUhV9buTEPbeEqNnY6HOcmUDSQdi/K2PMt/obTDZEwSodofKjfj4ERjVJ9fRL2u+nAWcKS9efHJOQrDjBkwE2dgbY+onUxglRQKFnz6qPhJJEGybAgH8AFfCBasO+c4LKdAJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365082; c=relaxed/simple;
	bh=zt102wZW8jd4qtpabwqIjNck/L4SZMmeHhX4ixRnqTk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=XaqVHF/MLyhZ/x5kpoiWBw3dm8/clJYv36kK/a7Vtrxgii8AcaFITYI4R4rh7aTvrKZZySiy2TGEkm5F6I85s+0CIcxHVut0nfaRHBg05XfUs2RYWFnsyVmDCTR1rV2qDoc7x1smvSYPfHe8+jj+g8oi6EfTiiH7cfErsLbQUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRv/0J8n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRv/0J8n"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41bd202f0b7so15022125e9.3
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714365078; x=1714969878; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8arrs0bjOXsBIQRsusrZDYjlQIRsripuaYwiybqtv34=;
        b=gRv/0J8nb81T2YaghC8xqGvWDBWLz/P4swwlo+Ez4afb9P0fcDeW4T3yZNlqvXhqyQ
         No5QxciQQ095JyAnU+SDnlYRmZWLqqKwMzglI5QnSDmwjzOjng51+NsPspRsdqzhvtHY
         mbJVEZrGH3QZ1JsXiagfcdmg5YZj1J09J+4jLxmTRsNgCCZNhCgre6gBrU8M5C49N6lV
         AYdOfnisDKd1SpY9fhwYyjWbI3B85Y7QiksDTb4cyNAWXIiqDT0zg4gl0+1MqwVK+pfI
         jw8k617tsdkC+yqv79OAd5yAOau6QulbX/zLwBWaA/kQK1kG7Oa8I2FfITeiiORTuhWU
         Mqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714365078; x=1714969878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8arrs0bjOXsBIQRsusrZDYjlQIRsripuaYwiybqtv34=;
        b=XC6CNxdN9EsynARoa36IPLr3mF5288+4rBfkrM/vP0mkuwpG+P9kWoyXJXq+zN4XHE
         KTeW9xZPNIa94x2CNTzIemijXCPzDamW6zLPBND8hGlOG6i9SMjMbGVq6ijwBVP9RFYg
         8cd/pvhhOwvYvG4Izu2XemzyhN1Xa+Wn6KQ9jzVteggKFovPLJaBtGu3qm5ENF+CvrMy
         ChmXIMRofSsXYbyzIDOWYbDMWlaVygasiG51BuNiVTHHKpytxd73m/6a/Pz+M2Q9rzby
         9EyjkcwXHQUQ6z3ppKRIB2zFmEaeKiMje2WVQXmIRDKTEPsNeSqkzU7UDZn3E/eOpqjf
         xY9A==
X-Gm-Message-State: AOJu0YxTkm0cF82ZYtLhklXyJeRo3IUwCqaOsksd82x5Zf7ht9x+pZrB
	m2JfVrKIZA+mWpUXvNDklr0YG6xv4BeVLHWTMRMcMgxAS+2ZOgAkv8RjAA==
X-Google-Smtp-Source: AGHT+IHlfED4te+Tfq2txCH8zPOjE+q+Go06PhIto+aZVMofRCXGPcSI4U/XZty65CquFe64LjQ5qw==
X-Received: by 2002:a05:600c:35c4:b0:418:df4:b24a with SMTP id r4-20020a05600c35c400b004180df4b24amr9837428wmq.37.1714365078065;
        Sun, 28 Apr 2024 21:31:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4e4600b0041c04022336sm5224614wmq.9.2024.04.28.21.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 21:31:17 -0700 (PDT)
Message-Id: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Apr 2024 04:31:15 +0000
Subject: [PATCH] builtin/tag.c: add --trailer arg
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

From: John Passaro <john.a.passaro@gmail.com>

Teach git-tag to accept --trailer option to add trailers to annotated
tag messages, like git-commit.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
    builtin/tag.c: add --trailer arg

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1723%2Fjpassaro%2Fjp%2Ftag-trailer-arg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1723/jpassaro/jp/tag-trailer-arg-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1723

 Documentation/git-tag.txt |  18 ++++++-
 builtin/tag.c             |  59 +++++++++++++++++----
 t/t7004-tag.sh            | 104 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 5fe519c31ec..79b0a7e9644 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]
+	[(--trailer <token>[(=|:)<value>])...]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
@@ -31,8 +32,8 @@ creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
 in the tag message.
 
-If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
-are absent, `-a` is implied.
+If `-m <msg>` or `-F <file>` or `--trailer <token>[=<value>]` is given
+and `-a`, `-s`, and `-u <key-id>` are absent, `-a` is implied.
 
 Otherwise, a tag reference that points directly at the given object
 (i.e., a lightweight tag) is created.
@@ -178,6 +179,19 @@ This option is only applicable when listing tags without annotation lines.
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
+--trailer <token>[(=|:)<value>]::
+	Specify a (<token>, <value>) pair that should be applied as a
+	trailer. (e.g. `git tag --trailer "Signed-off-by:T A Ger \
+	<tagger@example.com>" --trailer "Helped-by:C O Mitter \
+	<committer@example.com>"` will add the "Signed-off-by" trailer
+	and the "Helped-by" trailer to the tag message.)
+	The `trailer.*` configuration variables
+	(linkgit:git-interpret-trailers[1]) can be used to define if
+	a duplicated trailer is omitted, where in the run of trailers
+	each trailer would appear, and other details.
+	The trailers can be seen in `git tag --list` using
+	`--format="%(trailers)"` placeholder.
+
 -e::
 --edit::
 	The message taken from file with `-F` and command line with
diff --git a/builtin/tag.c b/builtin/tag.c
index 9a33cb50b45..0334a5d15ec 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -28,9 +28,11 @@
 #include "date.h"
 #include "write-or-die.h"
 #include "object-file-convert.h"
+#include "run-command.h"
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+	   "        [(--trailer <token>[(=|:)<value>])...]\n"
 	   "        <tagname> [<commit> | <object>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]\n"
@@ -290,10 +292,11 @@ static const char message_advice_nested_tag[] =
 static void create_tag(const struct object_id *object, const char *object_ref,
 		       const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
-		       struct object_id *prev, struct object_id *result, char *path)
+		       struct object_id *prev, struct object_id *result, struct strvec *trailer_args, char *path)
 {
 	enum object_type type;
 	struct strbuf header = STRBUF_INIT;
+	int should_edit;
 
 	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
@@ -313,14 +316,18 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		    tag,
 		    git_committer_info(IDENT_STRICT));
 
-	if (!opt->message_given || opt->use_editor) {
+	should_edit = opt->use_editor || !opt->message_given;
+	if (should_edit || trailer_args->nr) {
 		int fd;
 
 		/* write the template message before editing: */
 		fd = xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 
-		if (opt->message_given) {
+		if (opt->message_given && buf->len) {
 			write_or_die(fd, buf->buf, buf->len);
+			if (trailer_args->nr && buf->buf[buf->len-1] != '\n') {
+				write_or_die(fd, "\n", 1);
+			}
 			strbuf_reset(buf);
 		} else if (!is_null_oid(prev)) {
 			write_tag_body(fd, prev);
@@ -338,10 +345,31 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		}
 		close(fd);
 
-		if (launch_editor(path, buf, NULL)) {
-			fprintf(stderr,
-			_("Please supply the message using either -m or -F option.\n"));
-			exit(1);
+		if (trailer_args->nr) {
+			struct child_process run_trailer = CHILD_PROCESS_INIT;
+
+			strvec_pushl(&run_trailer.args, "interpret-trailers",
+				     "--in-place", "--no-divider",
+				     path, NULL);
+			strvec_pushv(&run_trailer.args, trailer_args->v);
+			run_trailer.git_cmd = 1;
+			if (run_command(&run_trailer))
+				die(_("unable to pass trailers to --trailers"));
+		}
+
+		if (should_edit) {
+			if (launch_editor(path, buf, NULL)) {
+				fprintf(stderr,
+				_("Please supply the message using either -m or -F option.\n"));
+				exit(1);
+			}
+		} else if (trailer_args->nr) {
+			strbuf_reset(buf);
+			if (strbuf_read_file(buf, path, 0) < 0) {
+				fprintf(stderr,
+						_("Please supply the message using either -m or -F option.\n"));
+				exit(1);
+			}
 		}
 	}
 
@@ -416,6 +444,14 @@ struct msg_arg {
 	struct strbuf buf;
 };
 
+static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+
+	strvec_pushl(opt->value, "--trailer", arg, NULL);
+	return 0;
+}
+
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct msg_arg *msg = opt->value;
@@ -463,6 +499,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
+	struct strvec trailer_args = STRVEC_INIT;
 	int icase = 0;
 	int edit_flag = 0;
 	struct option options[] = {
@@ -479,6 +516,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
 			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_CLEANUP(&cleanup_arg),
@@ -548,7 +586,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
-	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
+	create_tag_object = (opt.sign || annotate || msg.given || msgfile || edit_flag || trailer_args.nr);
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
@@ -635,7 +673,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
 
-	opt.message_given = msg.given || msgfile;
+	opt.message_given = msg.given || (msgfile != NULL);
 	opt.use_editor = edit_flag;
 
 	if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
@@ -653,7 +691,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
 		path = git_pathdup("TAG_EDITMSG");
-		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
+		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object, &trailer_args,
 			   path);
 	}
 
@@ -686,6 +724,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&msg.buf);
 	strbuf_release(&err);
+	strvec_clear(&trailer_args);
 	free(msgfile);
 	return ret;
 }
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 696866d7794..364db2b4685 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -668,6 +668,105 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+# trailers
+
+get_tag_header tag-with-inline-message-and-trailers $commit commit $time >expect
+cat >>expect <<EOF
+create tag with trailers
+
+my-trailer: here
+alt-trailer: there
+EOF
+test_expect_success 'create tag with -m and --trailer' '
+	git tag -m "create tag with trailers"  --trailer my-trailer=here --trailer alt-trailer=there tag-with-inline-message-and-trailers &&
+	get_tag_msg tag-with-inline-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'list tag extracting trailers' '
+	cat >expect <<-\EOF &&
+	my-trailer: here
+	alt-trailer: there
+
+	EOF
+	git tag --list --format="%(trailers)" tag-with-inline-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+echo 'create tag from message file using --trailer' >messagefilewithnotrailers
+get_tag_header tag-with-file-message-and-trailers $commit commit $time >expect
+cat >>expect <<EOF
+create tag from message file using --trailer
+
+my-trailer: here
+alt-trailer: there
+EOF
+test_expect_success 'create tag with -F and --trailer' '
+	git tag -F messagefilewithnotrailers  --trailer my-trailer=here --trailer alt-trailer=there tag-with-file-message-and-trailers &&
+	get_tag_msg tag-with-file-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'set up editor' '
+	write_script fakeeditor <<-\EOF
+	sed -e "1s/^/EDITED: /g" <"$1" >"$1-"
+	mv "$1-" "$1"
+	EOF
+'
+
+get_tag_header tag-with-edited-inline-message-and-trailers $commit commit $time >expect
+cat >>expect <<EOF
+EDITED: create tag with trailers
+
+my-trailer: here
+alt-trailer: there
+EOF
+test_expect_success 'create tag with -m and --trailer and --edit' '
+	GIT_EDITOR=./fakeeditor git tag --edit -m "create tag with trailers"  --trailer my-trailer=here --trailer alt-trailer=there tag-with-edited-inline-message-and-trailers &&
+	get_tag_msg tag-with-edited-inline-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+echo 'create tag from message file using --trailer' >messagefilewithnotrailers
+get_tag_header tag-with-edited-file-message-and-trailers $commit commit $time >expect
+cat >>expect <<EOF
+EDITED: create tag from message file using --trailer
+
+my-trailer: here
+alt-trailer: there
+EOF
+test_expect_success 'create tag with -F and --trailer and --edit' '
+	GIT_EDITOR=./fakeeditor git tag --edit -F messagefilewithnotrailers  --trailer my-trailer=here --trailer alt-trailer=there tag-with-edited-file-message-and-trailers &&
+	get_tag_msg tag-with-edited-file-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'set up editor' '
+	write_script fakeeditor <<-\EOF
+	echo "add a line" >"$1-"
+	echo >>"$1-"
+	cat <"$1" >>"$1-"
+	mv "$1-" "$1"
+	EOF
+'
+
+get_tag_header tag-with-trailers-and-no-message $commit commit $time >expect
+cat >>expect <<EOF
+add a line
+
+my-trailer: here
+alt-trailer: there
+EOF
+test_expect_success 'create annotated tag and force editor when only --trailer is given' '
+	GIT_EDITOR=./fakeeditor git tag --trailer my-trailer=here --trailer alt-trailer=there tag-with-trailers-and-no-message &&
+	get_tag_msg tag-with-trailers-and-no-message >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bad editor causes panic when only --trailer is given' '
+	test_must_fail env GIT_EDITOR=false git tag --trailer my-trailer=here tag-will-not-exist
+'
+
 # listing messages for annotated non-signed tags:
 
 test_expect_success \
@@ -810,6 +909,11 @@ test_expect_success 'git tag --format with ahead-behind' '
 	refs/tags/tag-lines 0 1 !
 	refs/tags/tag-one-line 0 1 !
 	refs/tags/tag-right 0 0 !
+	refs/tags/tag-with-edited-file-message-and-trailers 0 1 !
+	refs/tags/tag-with-edited-inline-message-and-trailers 0 1 !
+	refs/tags/tag-with-file-message-and-trailers 0 1 !
+	refs/tags/tag-with-inline-message-and-trailers 0 1 !
+	refs/tags/tag-with-trailers-and-no-message 0 1 !
 	refs/tags/tag-zero-lines 0 1 !
 	EOF
 	git tag -l --format="%(refname) %(ahead-behind:HEAD) !" >actual 2>err &&

base-commit: e326e520101dcf43a0499c3adc2df7eca30add2d
-- 
gitgitgadget

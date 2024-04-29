Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0B33C7
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409646; cv=none; b=hjOYVr0bvZ30JrHr7LtwRsglRMjZqCPyhXoTpjfft00u1jy2lXnqd5ERN6uw7vbIVRBk0qioI0N+syxsatsC6PcstvJOVr+tyH3EsfKzgSK61XYE/cY+yozj6zfwZhsJCLyoYKkW+9TUez8eSnZYsug5bHEadLgRLKtuab88N6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409646; c=relaxed/simple;
	bh=+Ve40wGCDjZCW7SkCn0Zmn/cLMCgcsRtc+GOtvOP61Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DLGbYJHnL8yHwA4Rugf0Yb9YV2QnIpvW3u+NQll2s6huy74oj3/QomzI7Vgl1VcF4wiR8yV0VzTXj10bTqCa29Q1SSyToInfqZFOdgd23i0AqBivLlIEXI5DC3mdsARXZ7udOZYmCb3Wg5h8aCb6xFdqzaeT4DFscAb324QwIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch5zCoUQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch5zCoUQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34d13789e2fso908066f8f.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714409640; x=1715014440; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DINkV3k1Mb/MhMWRbNU+ljwJqnokAOUuZrW0oqB6TMY=;
        b=Ch5zCoUQQgkH3/ZjiYsyJj6qTcek+wqaI7S+LnGNbtaRkxPBo9nIYy45B5ZOiT79lm
         2UA/2OrGugjelWFE8zDnJ6cid0WSC2kG42tQEnWBD5shoIq3aplUH/1wl5O0aMB7Pzo2
         tYQGJikU4Vl0n2FUzlVSCUg8FMqCQI6ZtdD8czO1ORB0z7MTQYv2NknSvoIS1mMTQrqb
         vy1TpqQ0QfzMiG3L6+0kREPYOiicbZOBM3WVc+sWgiAVOs8bfZYoO013oSEkmnFL6jOD
         ByNgCjkK80CBl63xstaXtSIUv2hQ6Ht9+ZueghSK81JN4F7qHYon/UQdan9vatpE73ay
         nefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714409640; x=1715014440;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DINkV3k1Mb/MhMWRbNU+ljwJqnokAOUuZrW0oqB6TMY=;
        b=N8rGYygbWvFZst9VkYExo4i90L/oJD7hSj780R68Noyf6+nZ9QclaMsfi8bOA38Q1s
         u+sIyrMBw6j7XasXl+iNkgmBoZiuK1HYAx/ZlYp+owb69/5UkBTJg6SkkohtzNwDJcv/
         t3enAFAhqptFK1yFsK9PHji6L0h9mIrT+KbzWHsSi77kTwbGZFVEPUpBpJEUWhNTYoeE
         5b3AJbN83MloFBqv9wfDc9tiWEarEsuZNY3/wmkQQp+DWvolisWY9/ZX8dlUucXHbp3h
         8IcMv/CNb/z1s9X2j+mmHkx0p783JXG7jslL86SplpU9enhH09MNuXu/fRGkiPM+CVWU
         1k+w==
X-Gm-Message-State: AOJu0YzKJRVUoMul+2hUAGk0YqhnZuwQ5lCDllKhY7Tzcu1vLySE2v+i
	MNVw8BTNDcm+KtQtfsnhHLu0aJ2Amms+c5WztyMtnpyMlLHr5EXOrDQ+Fg==
X-Google-Smtp-Source: AGHT+IG8Cu09t67TK7/+7ts1Xb7/C9qTfs0XXvckiZ6wbDBy74EFcMY2GtwVVTaVcZs4Kl8xHdnHXQ==
X-Received: by 2002:a5d:464c:0:b0:34d:1571:efbb with SMTP id j12-20020a5d464c000000b0034d1571efbbmr230796wrs.50.1714409640080;
        Mon, 29 Apr 2024 09:54:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b0034cf39c64bdsm4002248wrt.101.2024.04.29.09.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:53:59 -0700 (PDT)
Message-Id: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>
References: <pull.1723.git.1714365076246.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Apr 2024 16:53:57 +0000
Subject: [PATCH v2] builtin/tag.c: add --trailer arg
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
tag messages, like git-commit. Move the code that git-commit uses for
trailers to the trailer.h API, so it can be re-used for git-tag.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
    builtin/tag.c: add --trailer arg
    
    cc: Patrick Steinhardt ps@pks.im cc: John Passaro
    john.a.passaro@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1723%2Fjpassaro%2Fjp%2Ftag-trailer-arg-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1723/jpassaro/jp/tag-trailer-arg-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1723

Range-diff vs v1:

 1:  02d7a0f035e ! 1:  d4beb7cd67e builtin/tag.c: add --trailer arg
     @@ Commit message
          builtin/tag.c: add --trailer arg
      
          Teach git-tag to accept --trailer option to add trailers to annotated
     -    tag messages, like git-commit.
     +    tag messages, like git-commit. Move the code that git-commit uses for
     +    trailers to the trailer.h API, so it can be re-used for git-tag.
      
          Signed-off-by: John Passaro <john.a.passaro@gmail.com>
      
     @@ Documentation/git-tag.txt: This option is only applicable when listing tags with
       --edit::
       	The message taken from file with `-F` and command line with
      
     + ## builtin/commit.c ##
     +@@
     + #include "commit-reach.h"
     + #include "commit-graph.h"
     + #include "pretty.h"
     ++#include "trailer.h"
     + 
     + static const char * const builtin_commit_usage[] = {
     + 	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
     +@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     + 	fclose(s->fp);
     + 
     + 	if (trailer_args.nr) {
     +-		struct child_process run_trailer = CHILD_PROCESS_INIT;
     +-
     +-		strvec_pushl(&run_trailer.args, "interpret-trailers",
     +-			     "--in-place", "--no-divider",
     +-			     git_path_commit_editmsg(), NULL);
     +-		strvec_pushv(&run_trailer.args, trailer_args.v);
     +-		run_trailer.git_cmd = 1;
     +-		if (run_command(&run_trailer))
     ++		if (amend_file_with_trailers(git_path_commit_editmsg(), &trailer_args))
     + 			die(_("unable to pass trailers to --trailers"));
     + 		strvec_clear(&trailer_args);
     + 	}
     +
       ## builtin/tag.c ##
      @@
       #include "date.h"
       #include "write-or-die.h"
       #include "object-file-convert.h"
     -+#include "run-command.h"
     ++#include "trailer.h"
       
       static const char * const git_tag_usage[] = {
       	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
     @@ builtin/tag.c: static const char message_advice_nested_tag[] =
       		       const char *tag,
       		       struct strbuf *buf, struct create_tag_options *opt,
      -		       struct object_id *prev, struct object_id *result, char *path)
     -+		       struct object_id *prev, struct object_id *result, struct strvec *trailer_args, char *path)
     ++		       struct object_id *prev, struct object_id *result,
     ++		       struct strvec *trailer_args, char *path)
       {
       	enum object_type type;
       	struct strbuf header = STRBUF_INIT;
     @@ builtin/tag.c: static void create_tag(const struct object_id *object, const char
       
      -		if (opt->message_given) {
      +		if (opt->message_given && buf->len) {
     ++			strbuf_complete(buf, '\n');
       			write_or_die(fd, buf->buf, buf->len);
     -+			if (trailer_args->nr && buf->buf[buf->len-1] != '\n') {
     -+				write_or_die(fd, "\n", 1);
     -+			}
       			strbuf_reset(buf);
       		} else if (!is_null_oid(prev)) {
     - 			write_tag_body(fd, prev);
      @@ builtin/tag.c: static void create_tag(const struct object_id *object, const char *object_ref,
       		}
       		close(fd);
     @@ builtin/tag.c: static void create_tag(const struct object_id *object, const char
      -			fprintf(stderr,
      -			_("Please supply the message using either -m or -F option.\n"));
      -			exit(1);
     -+		if (trailer_args->nr) {
     -+			struct child_process run_trailer = CHILD_PROCESS_INIT;
     -+
     -+			strvec_pushl(&run_trailer.args, "interpret-trailers",
     -+				     "--in-place", "--no-divider",
     -+				     path, NULL);
     -+			strvec_pushv(&run_trailer.args, trailer_args->v);
     -+			run_trailer.git_cmd = 1;
     -+			if (run_command(&run_trailer))
     -+				die(_("unable to pass trailers to --trailers"));
     -+		}
     ++		if (trailer_args->nr && amend_file_with_trailers(path, trailer_args))
     ++			die(_("unable to pass trailers to --trailers"));
      +
      +		if (should_edit) {
      +			if (launch_editor(path, buf, NULL)) {
      +				fprintf(stderr,
     -+				_("Please supply the message using either -m or -F option.\n"));
     ++					_("Please supply the message using either -m or -F option.\n"));
      +				exit(1);
      +			}
      +		} else if (trailer_args->nr) {
      +			strbuf_reset(buf);
      +			if (strbuf_read_file(buf, path, 0) < 0) {
      +				fprintf(stderr,
     -+						_("Please supply the message using either -m or -F option.\n"));
     ++					_("Please supply the message using either -m or -F option.\n"));
      +				exit(1);
      +			}
       		}
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
       			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
       		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
     -+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
     ++		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"),
     ++				PARSE_OPT_NONEG, opt_pass_trailer),
       		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
       		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
       		OPT_CLEANUP(&cleanup_arg),
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       		set_signing_key(keyid);
       	}
      -	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
     -+	create_tag_object = (opt.sign || annotate || msg.given || msgfile || edit_flag || trailer_args.nr);
     ++	create_tag_object = (opt.sign || annotate || msg.given || msgfile ||
     ++			     edit_flag || trailer_args.nr);
       
       	if ((create_tag_object || force) && (cmdmode != 0))
       		usage_with_options(git_tag_usage, options);
      @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
     - 	else if (!force)
     - 		die(_("tag '%s' already exists"), tag);
     - 
     --	opt.message_given = msg.given || msgfile;
     -+	opt.message_given = msg.given || (msgfile != NULL);
     - 	opt.use_editor = edit_flag;
     - 
     - 	if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
     -@@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
     - 		if (force_sign_annotate && !annotate)
       			opt.sign = 1;
       		path = git_pathdup("TAG_EDITMSG");
     --		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
     -+		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object, &trailer_args,
     - 			   path);
     + 		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
     +-			   path);
     ++			   &trailer_args, path);
       	}
       
     + 	transaction = ref_transaction_begin(&err);
      @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       	strbuf_release(&reflog_msg);
       	strbuf_release(&msg.buf);
     @@ t/t7004-tag.sh: test_expect_success \
       
      +# trailers
      +
     -+get_tag_header tag-with-inline-message-and-trailers $commit commit $time >expect
     -+cat >>expect <<EOF
     -+create tag with trailers
     -+
     -+my-trailer: here
     -+alt-trailer: there
     -+EOF
      +test_expect_success 'create tag with -m and --trailer' '
     -+	git tag -m "create tag with trailers"  --trailer my-trailer=here --trailer alt-trailer=there tag-with-inline-message-and-trailers &&
     ++	get_tag_header tag-with-inline-message-and-trailers $commit commit $time >expect &&
     ++	cat >>expect <<-\EOF &&
     ++	create tag with trailers
     ++
     ++	my-trailer: here
     ++	alt-trailer: there
     ++	EOF
     ++	git tag -m "create tag with trailers" \
     ++		--trailer my-trailer=here \
     ++		--trailer alt-trailer=there \
     ++		tag-with-inline-message-and-trailers &&
      +	get_tag_msg tag-with-inline-message-and-trailers >actual &&
      +	test_cmp expect actual
      +'
     @@ t/t7004-tag.sh: test_expect_success \
      +	test_cmp expect actual
      +'
      +
     -+echo 'create tag from message file using --trailer' >messagefilewithnotrailers
     -+get_tag_header tag-with-file-message-and-trailers $commit commit $time >expect
     -+cat >>expect <<EOF
     -+create tag from message file using --trailer
     -+
     -+my-trailer: here
     -+alt-trailer: there
     -+EOF
      +test_expect_success 'create tag with -F and --trailer' '
     -+	git tag -F messagefilewithnotrailers  --trailer my-trailer=here --trailer alt-trailer=there tag-with-file-message-and-trailers &&
     ++	echo "create tag from message file using --trailer" >messagefilewithnotrailers &&
     ++	get_tag_header tag-with-file-message-and-trailers $commit commit $time >expect &&
     ++	cat >>expect <<-\EOF &&
     ++	create tag from message file using --trailer
     ++
     ++	my-trailer: here
     ++	alt-trailer: there
     ++	EOF
     ++	git tag -F messagefilewithnotrailers \
     ++		--trailer my-trailer=here \
     ++		--trailer alt-trailer=there \
     ++		tag-with-file-message-and-trailers &&
      +	get_tag_msg tag-with-file-message-and-trailers >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'set up editor' '
     -+	write_script fakeeditor <<-\EOF
     ++test_expect_success 'create tag with -m and --trailer and --edit' '
     ++	write_script fakeeditor <<-\EOF &&
      +	sed -e "1s/^/EDITED: /g" <"$1" >"$1-"
      +	mv "$1-" "$1"
      +	EOF
     -+'
     -+
     -+get_tag_header tag-with-edited-inline-message-and-trailers $commit commit $time >expect
     -+cat >>expect <<EOF
     -+EDITED: create tag with trailers
     ++	get_tag_header tag-with-edited-inline-message-and-trailers $commit commit $time >expect &&
     ++	cat >>expect <<-\EOF &&
     ++	EDITED: create tag with trailers
      +
     -+my-trailer: here
     -+alt-trailer: there
     -+EOF
     -+test_expect_success 'create tag with -m and --trailer and --edit' '
     -+	GIT_EDITOR=./fakeeditor git tag --edit -m "create tag with trailers"  --trailer my-trailer=here --trailer alt-trailer=there tag-with-edited-inline-message-and-trailers &&
     ++	my-trailer: here
     ++	alt-trailer: there
     ++	EOF
     ++	GIT_EDITOR=./fakeeditor git tag --edit \
     ++		-m "create tag with trailers" \
     ++		--trailer my-trailer=here \
     ++		--trailer alt-trailer=there \
     ++		tag-with-edited-inline-message-and-trailers &&
      +	get_tag_msg tag-with-edited-inline-message-and-trailers >actual &&
      +	test_cmp expect actual
      +'
      +
     -+echo 'create tag from message file using --trailer' >messagefilewithnotrailers
     -+get_tag_header tag-with-edited-file-message-and-trailers $commit commit $time >expect
     -+cat >>expect <<EOF
     -+EDITED: create tag from message file using --trailer
     -+
     -+my-trailer: here
     -+alt-trailer: there
     -+EOF
      +test_expect_success 'create tag with -F and --trailer and --edit' '
     -+	GIT_EDITOR=./fakeeditor git tag --edit -F messagefilewithnotrailers  --trailer my-trailer=here --trailer alt-trailer=there tag-with-edited-file-message-and-trailers &&
     ++	echo "create tag from message file using --trailer" >messagefilewithnotrailers &&
     ++	get_tag_header tag-with-edited-file-message-and-trailers $commit commit $time >expect &&
     ++	cat >>expect <<-\EOF &&
     ++	EDITED: create tag from message file using --trailer
     ++
     ++	my-trailer: here
     ++	alt-trailer: there
     ++	EOF
     ++	GIT_EDITOR=./fakeeditor git tag --edit \
     ++		-F messagefilewithnotrailers \
     ++		--trailer my-trailer=here \
     ++		--trailer alt-trailer=there \
     ++		tag-with-edited-file-message-and-trailers &&
      +	get_tag_msg tag-with-edited-file-message-and-trailers >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'set up editor' '
     -+	write_script fakeeditor <<-\EOF
     ++test_expect_success 'create annotated tag and force editor when only --trailer is given' '
     ++	write_script fakeeditor <<-\EOF &&
      +	echo "add a line" >"$1-"
     -+	echo >>"$1-"
      +	cat <"$1" >>"$1-"
      +	mv "$1-" "$1"
      +	EOF
     -+'
     -+
     -+get_tag_header tag-with-trailers-and-no-message $commit commit $time >expect
     -+cat >>expect <<EOF
     -+add a line
     ++	get_tag_header tag-with-trailers-and-no-message $commit commit $time >expect &&
     ++	cat >>expect <<-\EOF &&
     ++	add a line
      +
     -+my-trailer: here
     -+alt-trailer: there
     -+EOF
     -+test_expect_success 'create annotated tag and force editor when only --trailer is given' '
     -+	GIT_EDITOR=./fakeeditor git tag --trailer my-trailer=here --trailer alt-trailer=there tag-with-trailers-and-no-message &&
     ++	my-trailer: here
     ++	alt-trailer: there
     ++	EOF
     ++	GIT_EDITOR=./fakeeditor git tag \
     ++		--trailer my-trailer=here \
     ++		--trailer alt-trailer=there \
     ++		tag-with-trailers-and-no-message &&
      +	get_tag_msg tag-with-trailers-and-no-message >actual &&
      +	test_cmp expect actual
      +'
     @@ t/t7004-tag.sh: test_expect_success 'git tag --format with ahead-behind' '
       	refs/tags/tag-zero-lines 0 1 !
       	EOF
       	git tag -l --format="%(refname) %(ahead-behind:HEAD) !" >actual 2>err &&
     +
     + ## trailer.c ##
     +@@
     + #include "commit.h"
     + #include "trailer.h"
     + #include "list.h"
     ++#include "run-command.h"
     + /*
     +  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
     +  */
     +@@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
     + 	strbuf_release(&iter->val);
     + 	strbuf_release(&iter->key);
     + }
     ++
     ++int amend_file_with_trailers(const char *path, struct strvec const* trailer_args) {
     ++	struct child_process run_trailer = CHILD_PROCESS_INIT;
     ++
     ++	run_trailer.git_cmd = 1;
     ++	strvec_pushl(&run_trailer.args, "interpret-trailers",
     ++		     "--in-place", "--no-divider",
     ++		     path, NULL);
     ++	strvec_pushv(&run_trailer.args, trailer_args->v);
     ++	return run_command(&run_trailer);
     ++}
     +
     + ## trailer.h ##
     +@@
     + 
     + #include "list.h"
     + #include "strbuf.h"
     ++#include "strvec.h"
     + 
     + enum trailer_where {
     + 	WHERE_DEFAULT,
     +@@ trailer.h: int trailer_iterator_advance(struct trailer_iterator *iter);
     +  */
     + void trailer_iterator_release(struct trailer_iterator *iter);
     + 
     ++/*
     ++ * Augment a file to add trailers to it by running git-interpret-trailers.
     ++ * This calls run_command() and its return value is the same (i.e. 0 for
     ++ * success, various non-zero for other errors). See run-command.h.
     ++ */
     ++int amend_file_with_trailers(const char *path, struct strvec const* trailer_args);
     ++
     + #endif /* TRAILER_H */


 Documentation/git-tag.txt |  18 +++++-
 builtin/commit.c          |  10 +---
 builtin/tag.c             |  49 +++++++++++++---
 t/t7004-tag.sh            | 114 ++++++++++++++++++++++++++++++++++++++
 trailer.c                 |  12 ++++
 trailer.h                 |   8 +++
 6 files changed, 192 insertions(+), 19 deletions(-)

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
diff --git a/builtin/commit.c b/builtin/commit.c
index 6e1484446b0..a1cbc128429 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -38,6 +38,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "pretty.h"
+#include "trailer.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
@@ -1038,14 +1039,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	fclose(s->fp);
 
 	if (trailer_args.nr) {
-		struct child_process run_trailer = CHILD_PROCESS_INIT;
-
-		strvec_pushl(&run_trailer.args, "interpret-trailers",
-			     "--in-place", "--no-divider",
-			     git_path_commit_editmsg(), NULL);
-		strvec_pushv(&run_trailer.args, trailer_args.v);
-		run_trailer.git_cmd = 1;
-		if (run_command(&run_trailer))
+		if (amend_file_with_trailers(git_path_commit_editmsg(), &trailer_args))
 			die(_("unable to pass trailers to --trailers"));
 		strvec_clear(&trailer_args);
 	}
diff --git a/builtin/tag.c b/builtin/tag.c
index 9a33cb50b45..0a029fb8c30 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -28,9 +28,11 @@
 #include "date.h"
 #include "write-or-die.h"
 #include "object-file-convert.h"
+#include "trailer.h"
 
 static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+	   "        [(--trailer <token>[(=|:)<value>])...]\n"
 	   "        <tagname> [<commit> | <object>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]\n"
@@ -290,10 +292,12 @@ static const char message_advice_nested_tag[] =
 static void create_tag(const struct object_id *object, const char *object_ref,
 		       const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
-		       struct object_id *prev, struct object_id *result, char *path)
+		       struct object_id *prev, struct object_id *result,
+		       struct strvec *trailer_args, char *path)
 {
 	enum object_type type;
 	struct strbuf header = STRBUF_INIT;
+	int should_edit;
 
 	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
@@ -313,13 +317,15 @@ static void create_tag(const struct object_id *object, const char *object_ref,
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
+			strbuf_complete(buf, '\n');
 			write_or_die(fd, buf->buf, buf->len);
 			strbuf_reset(buf);
 		} else if (!is_null_oid(prev)) {
@@ -338,10 +344,22 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		}
 		close(fd);
 
-		if (launch_editor(path, buf, NULL)) {
-			fprintf(stderr,
-			_("Please supply the message using either -m or -F option.\n"));
-			exit(1);
+		if (trailer_args->nr && amend_file_with_trailers(path, trailer_args))
+			die(_("unable to pass trailers to --trailers"));
+
+		if (should_edit) {
+			if (launch_editor(path, buf, NULL)) {
+				fprintf(stderr,
+					_("Please supply the message using either -m or -F option.\n"));
+				exit(1);
+			}
+		} else if (trailer_args->nr) {
+			strbuf_reset(buf);
+			if (strbuf_read_file(buf, path, 0) < 0) {
+				fprintf(stderr,
+					_("Please supply the message using either -m or -F option.\n"));
+				exit(1);
+			}
 		}
 	}
 
@@ -416,6 +434,14 @@ struct msg_arg {
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
@@ -463,6 +489,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
+	struct strvec trailer_args = STRVEC_INIT;
 	int icase = 0;
 	int edit_flag = 0;
 	struct option options[] = {
@@ -479,6 +506,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
 			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"),
+				PARSE_OPT_NONEG, opt_pass_trailer),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_CLEANUP(&cleanup_arg),
@@ -548,7 +577,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
-	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
+	create_tag_object = (opt.sign || annotate || msg.given || msgfile ||
+			     edit_flag || trailer_args.nr);
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
@@ -654,7 +684,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			opt.sign = 1;
 		path = git_pathdup("TAG_EDITMSG");
 		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
-			   path);
+			   &trailer_args, path);
 	}
 
 	transaction = ref_transaction_begin(&err);
@@ -686,6 +716,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&msg.buf);
 	strbuf_release(&err);
+	strvec_clear(&trailer_args);
 	free(msgfile);
 	return ret;
 }
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 696866d7794..fa6336edf98 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -668,6 +668,115 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+# trailers
+
+test_expect_success 'create tag with -m and --trailer' '
+	get_tag_header tag-with-inline-message-and-trailers $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	create tag with trailers
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	git tag -m "create tag with trailers" \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-inline-message-and-trailers &&
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
+test_expect_success 'create tag with -F and --trailer' '
+	echo "create tag from message file using --trailer" >messagefilewithnotrailers &&
+	get_tag_header tag-with-file-message-and-trailers $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	create tag from message file using --trailer
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	git tag -F messagefilewithnotrailers \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-file-message-and-trailers &&
+	get_tag_msg tag-with-file-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create tag with -m and --trailer and --edit' '
+	write_script fakeeditor <<-\EOF &&
+	sed -e "1s/^/EDITED: /g" <"$1" >"$1-"
+	mv "$1-" "$1"
+	EOF
+	get_tag_header tag-with-edited-inline-message-and-trailers $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	EDITED: create tag with trailers
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	GIT_EDITOR=./fakeeditor git tag --edit \
+		-m "create tag with trailers" \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-edited-inline-message-and-trailers &&
+	get_tag_msg tag-with-edited-inline-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create tag with -F and --trailer and --edit' '
+	echo "create tag from message file using --trailer" >messagefilewithnotrailers &&
+	get_tag_header tag-with-edited-file-message-and-trailers $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	EDITED: create tag from message file using --trailer
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	GIT_EDITOR=./fakeeditor git tag --edit \
+		-F messagefilewithnotrailers \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-edited-file-message-and-trailers &&
+	get_tag_msg tag-with-edited-file-message-and-trailers >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create annotated tag and force editor when only --trailer is given' '
+	write_script fakeeditor <<-\EOF &&
+	echo "add a line" >"$1-"
+	cat <"$1" >>"$1-"
+	mv "$1-" "$1"
+	EOF
+	get_tag_header tag-with-trailers-and-no-message $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	add a line
+
+	my-trailer: here
+	alt-trailer: there
+	EOF
+	GIT_EDITOR=./fakeeditor git tag \
+		--trailer my-trailer=here \
+		--trailer alt-trailer=there \
+		tag-with-trailers-and-no-message &&
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
@@ -810,6 +919,11 @@ test_expect_success 'git tag --format with ahead-behind' '
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
diff --git a/trailer.c b/trailer.c
index c72ae687099..843c378199e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "trailer.h"
 #include "list.h"
+#include "run-command.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -1170,3 +1171,14 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
+
+int amend_file_with_trailers(const char *path, struct strvec const* trailer_args) {
+	struct child_process run_trailer = CHILD_PROCESS_INIT;
+
+	run_trailer.git_cmd = 1;
+	strvec_pushl(&run_trailer.args, "interpret-trailers",
+		     "--in-place", "--no-divider",
+		     path, NULL);
+	strvec_pushv(&run_trailer.args, trailer_args->v);
+	return run_command(&run_trailer);
+}
diff --git a/trailer.h b/trailer.h
index 9f42aa75994..55f85b008ee 100644
--- a/trailer.h
+++ b/trailer.h
@@ -3,6 +3,7 @@
 
 #include "list.h"
 #include "strbuf.h"
+#include "strvec.h"
 
 enum trailer_where {
 	WHERE_DEFAULT,
@@ -158,4 +159,11 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
  */
 void trailer_iterator_release(struct trailer_iterator *iter);
 
+/*
+ * Augment a file to add trailers to it by running git-interpret-trailers.
+ * This calls run_command() and its return value is the same (i.e. 0 for
+ * success, various non-zero for other errors). See run-command.h.
+ */
+int amend_file_with_trailers(const char *path, struct strvec const* trailer_args);
+
 #endif /* TRAILER_H */

base-commit: e326e520101dcf43a0499c3adc2df7eca30add2d
-- 
gitgitgadget

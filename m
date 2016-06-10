From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/27] nd/shallow-deepen updates
Date: Fri, 10 Jun 2016 19:26:47 +0700
Message-ID: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:30:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLXa-0000GQ-3D
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbcFJM1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 08:27:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33056 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbcFJM1x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:27:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id c74so5077394pfb.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HzOhEg+tJhxKdfidBelqc+TtP20ddqfqq0N/UugfsXU=;
        b=NTaLEiees174QzTO6qVELyLXEd2xTQMzKGVltQBtOnnQY9epbnXlbefdIEvRyLlxB0
         q5vFhBSbkupBx/igITTUxKh1v8xLDQBa2K0UflTfDav1frNfQ4ffgf9yXtsiV8kGbfCY
         jC4ukiDM5RaTkb6fDfdI2H9YNV1VOLSsAnDUNZB4m6DrzEfZT8l0MTCApr6HA6HmRu7/
         hG5KNUpLuN4pSKG4kJ3RnMysU7P1L22NA3dEPuMxOLWJJZubg65fOZY3fnVtXiOE/bEO
         35iin8ZptWrS1HcpUMLjDV3kEIFwqJN8DgpDr4Y8pVjgYFWz5F0FJiiJkOEOn8huKE6Z
         FfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HzOhEg+tJhxKdfidBelqc+TtP20ddqfqq0N/UugfsXU=;
        b=F497E3C2W8wo6LbEwCXugOz5Ir1acUjcvZW7rWsltjpnPsywDoyW7FIx8mmUvYVLKv
         qHGQ0rgFoWITyIUmV53EVxnjYSMsJHSTJMOtNaPqhfxu2+MhQOdEWBZ6Po017awiv2TY
         3VdyuDDKZ3Py2nvk2jkrIP0CvqrpGRcJnljW9UpDvnGWutCWwVXvUDwJ2NZx/FQ2hliE
         KzHLnAKcN5Dfd3LdCBTtv6U+vozYpJ+QI5JmIp76vx83SafR22g2nANRPyTmRWp+tOFE
         PvMFYD9BF8Fu7dvG006mqA6sevYYeUO43QZLyaaMqTv3lP3vgMzRU2i56bXZ3wZ3cg1b
         Ptug==
X-Gm-Message-State: ALyK8tKgfp6YoouFjKybT3YaYjbmFfIS9tDR6TNnt3wOExrxraji3SVzKaYe0XwX1ZO+WQ==
X-Received: by 10.98.5.196 with SMTP id 187mr2027956pff.133.1465561672028;
        Fri, 10 Jun 2016 05:27:52 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id v1sm17434469pfa.93.2016.06.10.05.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:27:51 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:27:47 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296985>

This contains cleanups after Eric's comments (all good points,
thanks!). Changed patches have Junio's s-o-b line removed, so it's
easy to see which is changed and which is not. 09/27 is a new one,
split out of 10/27.

Interdiff

diff --git a/builtin/clone.c b/builtin/clone.c
index 5ccf6b7..3849231 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -53,13 +53,6 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
 
-static int option_parse_deepen_not(const struct option *opt,
-				   const char *arg, int unset)
-{
-	string_list_append(&option_not, arg);
-	return 0;
-}
-
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
@@ -97,9 +90,8 @@ static struct option builtin_clone_options[] = {
 		    N_("create a shallow clone of that depth")),
 	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
 		    N_("create a shallow clone since a specific time")),
-	{ OPTION_CALLBACK, 0, "shallow-exclude", NULL, N_("revision"),
-		    N_("deepen history of shallow clone by excluding rev"),
-		    PARSE_OPT_NONEG, option_parse_deepen_not },
+	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
+			N_("deepen history of shallow clone by excluding rev")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 68b44ba..7b0ea1c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -51,13 +51,6 @@ static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
 
-static int option_parse_deepen_not(const struct option *opt,
-				   const char *arg, int unset)
-{
-	string_list_append(&deepen_not, arg);
-	return 0;
-}
-
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -126,9 +119,8 @@ static struct option builtin_fetch_options[] = {
 		   N_("deepen history of shallow clone")),
 	OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
 		   N_("deepen history of shallow repository based on time")),
-	{ OPTION_CALLBACK, 0, "shallow-exclude", NULL, N_("revision"),
-		    N_("deepen history of shallow clone by excluding rev"),
-		    PARSE_OPT_NONEG, option_parse_deepen_not },
+	OPT_STRING_LIST(0, "shallow-exclude", &deepen_not, N_("revision"),
+			N_("deepen history of shallow clone by excluding rev")),
 	OPT_INTEGER(0, "deepen", &deepen_relative,
 		    N_("deepen history of shallow clone")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
diff --git a/remote-curl.c b/remote-curl.c
index 3f1a8f5..d56412d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -745,7 +745,6 @@ static int fetch_git(struct discovery *heads,
 {
 	struct rpc_state rpc;
 	struct strbuf preamble = STRBUF_INIT;
-	char *depth_arg = NULL;
 	int i, err;
 	struct argv_array args = ARGV_ARRAY_INIT;
 
@@ -755,10 +754,8 @@ static int fetch_git(struct discovery *heads,
 		argv_array_push(&args, "--include-tag");
 	if (options.thin)
 		argv_array_push(&args, "--thin");
-	if (options.verbosity >= 3) {
-		argv_array_push(&args, "-v");
-		argv_array_push(&args, "-v");
-	}
+	if (options.verbosity >= 3)
+		argv_array_pushl(&args, "-v", "-v", NULL);
 	if (options.check_self_contained_and_connected)
 		argv_array_push(&args, "--check-self-contained-and-connected");
 	if (options.cloning)
@@ -798,7 +795,6 @@ static int fetch_git(struct discovery *heads,
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
-	free(depth_arg);
 	argv_array_clear(&args);
 	return err;
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f512098..a908036 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -678,8 +678,7 @@ test_expect_success 'shallow clone exclude tag two' '
 test_expect_success 'fetch exclude tag one' '
 	git -C shallow12 fetch --shallow-exclude one origin &&
 	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
-	echo three >expected &&
-	echo two  >>expected &&
+	test_write_lines three two >expected &&
 	test_cmp expected actual
 '
 
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 25f8968..5fbf67c 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -116,8 +116,7 @@ test_expect_success 'shallow clone exclude tag two' '
 test_expect_success 'fetch exclude tag one' '
 	git -C shallow12 fetch --shallow-exclude one origin &&
 	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
-	echo three >expected &&
-	echo two  >>expected &&
+	test_write_lines three two >expected &&
 	test_cmp expected actual
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index b894b60..a5cdd77 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -272,9 +272,9 @@ static int strbuf_set_helper_option(struct helper_data *data,
 
 	if (!strcmp(buf->buf, "ok"))
 		ret = 0;
-	else if (starts_with(buf->buf, "error")) {
+	else if (starts_with(buf->buf, "error"))
 		ret = -1;
-	} else if (!strcmp(buf->buf, "unsupported"))
+	else if (!strcmp(buf->buf, "unsupported"))
 		ret = 1;
 	else {
 		warning("%s unexpectedly said: '%s'", data->name, buf->buf);
diff --git a/upload-pack.c b/upload-pack.c
index 18b914a..ef693bd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -471,7 +471,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 	cmd->out = -1;
 
 	if (start_command(cmd))
-		return -1;
+		goto error;
 
 	/*
 	 * If rev-list --stdin encounters an unknown commit, it
@@ -491,8 +491,10 @@ static int do_reachable_revlist(struct child_process *cmd,
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd->in, namebuf, 42) < 0)
-			return -1;
+		if (write_in_full(cmd->in, namebuf, 42) < 0) {
+			sigchain_pop(SIGPIPE);
+			goto error;
+		}
 	}
 	namebuf[40] = '\n';
 	for (i = 0; i < src->nr; i++) {
@@ -505,13 +507,23 @@ static int do_reachable_revlist(struct child_process *cmd,
 		if (reachable && o->type == OBJ_COMMIT)
 			o->flags |= TMP_MARK;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd->in, namebuf, 41) < 0)
-			return -1;
+		if (write_in_full(cmd->in, namebuf, 41) < 0) {
+			sigchain_pop(SIGPIPE);
+			goto error;
+		}
 	}
 	close(cmd->in);
+	cmd->in = -1;
 
 	sigchain_pop(SIGPIPE);
 	return 0;
+
+error:
+	if (cmd->in >= 0)
+		close(cmd->in);
+	if (cmd->out >= 0)
+		close(cmd->out);
+	return -1;
 }
 
 static int get_reachable_list(struct object_array *src,
@@ -555,10 +567,10 @@ static int get_reachable_list(struct object_array *src,
 static int check_unreachable(struct object_array *src)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	int i, ret = do_reachable_revlist(&cmd, src, NULL);
 	char buf[1];
+	int i;
 
-	if (ret < 0)
+	if (do_reachable_revlist(&cmd, src, NULL) < 0)
 		return 0;
 
 	/*
@@ -567,8 +579,9 @@ static int check_unreachable(struct object_array *src)
 	 */
 	i = read_in_full(cmd.out, buf, 1);
 	if (i)
-		return 0;
+		goto error;
 	close(cmd.out);
+	cmd.out = -1;
 
 	/*
 	 * rev-list may have died by encountering a bad commit
@@ -576,10 +589,17 @@ static int check_unreachable(struct object_array *src)
 	 * even when it showed no commit.
 	 */
 	if (finish_command(&cmd))
-		return 0;
+		goto error;
 
 	/* All the non-tip ones are ancestors of what we advertised */
 	return 1;
+
+error:
+	if (cmd.in >= 0)
+		close(cmd.in);
+	if (cmd.out >= 0)
+		close(cmd.out);
+	return 0;
 }
 
 static void check_non_tip(void)
@@ -592,10 +612,12 @@ static void check_non_tip(void)
 	 * non-tip requests can never happen.
 	 */
 	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
-		;		/* error */
-	else if (check_unreachable(&want_obj))
+		goto error;
+	if (check_unreachable(&want_obj))
+		/* All the non-tip ones are ancestors of what we advertised */
 		return;
 
+error:
 	/* Pick one of them (we know there at least is one) */
 	for (i = 0; i < want_obj.nr; i++) {
 		struct object *o = want_obj.objects[i].item;
@@ -993,7 +1015,7 @@ int main(int argc, char **argv)
 	check_replace_refs = 0;
 
 	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
+		const char *arg = argv[i];
 
 		if (arg[0] != '-')
 			break;
@@ -1009,8 +1031,8 @@ int main(int argc, char **argv)
 			strict = 1;
 			continue;
 		}
-		if (starts_with(arg, "--timeout=")) {
-			timeout = atoi(arg+10);
+		if (skip_prefix(arg, "--timeout=", &arg)) {
+			timeout = atoi(arg);
 			daemon_mode = 1;
 			continue;
 		}
-- 
2.8.2.524.g6ff3d78

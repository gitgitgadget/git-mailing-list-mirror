Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEC21F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeFBEdg (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41662 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeFBEdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:16 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so17627493lfa.8
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DdMXiS7csyHGQ3SyfztsavVDt0ESItoAMpa2XK4wZvk=;
        b=pj+xdNqokNlmCj1yYQVBnj6+wDtb0pE5P1YGslu3pNV6EZIGI0X/OctUdpV94wx+Wg
         OTA8biWFA8vYgQgeBEVHYS7jLiKg9TL1t9DKN48BL74CV8APEEyjbg/3koFXUpVI6WmF
         PDtiEjCytsKqrdH3PorYPbLWd3Ou9ZBwqXMzUXNwY0Iph3RFX4g3isgw2Wpg4uxe4gT1
         7e/lI7GYbIoba0Po4lz7rQJwu6P4nww/byF/LP8MEW8cgTnXG0vTgl3de/cS3cpdOVbV
         SwfkMl5CS/jWdvM5Qx0o3uklqMXCrNd8P+SAk5Dg8PrKLTST+xpu59w0VXgnDd2my2OM
         09yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DdMXiS7csyHGQ3SyfztsavVDt0ESItoAMpa2XK4wZvk=;
        b=hhvE7c0gHT5SK3F3XG5Xj9TDY4nvZD+qRtNVNPPG+LwgPeFAakbRi+nhUq73cdSaJO
         p1O334iKgmxk5D9U3k6qGLEydlKJLw9j8CIsFy/Uc3rI0QnKg1pH1z5fElN/KjQ5RsJD
         ysoCfwdMegsj50ZZxtVvl5B1CR9QUS3a6q89Jt6FR5FWYAqS8Nqk3LVPhhDwuqZ5aAZt
         WlzviU9q+0G3EVu5uYgopVRZ8K+O7g9w0JunayqqiS8iN9TE9fn4XmQVQ5sUQ9ksgPco
         WK0WLLdMHFW8g8fTJAja/Txl6qZo6OvHgEb6tDL6KolPYVcaItKnd5EnO9b8j3rYf1r3
         61qQ==
X-Gm-Message-State: ALKqPwcPe+qCcIpm+6ucwPuWnFd26rfmIOJ/xn7GXJZx5q0cqsTYSFDq
        Ch+Sovn6EPm9s5w0d+PfpRpAIA==
X-Google-Smtp-Source: ADUXVKLZKXRwBIUYhiAvwn7dTwiaFyBMmO3mA/O8wdpxRftcFysihv7u2TaYsvOedwqq/6cYCFYQ9A==
X-Received: by 2002:a2e:1bcb:: with SMTP id c72-v6mr6806200ljf.99.1527913994552;
        Fri, 01 Jun 2018 21:33:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/22] transport-helper.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:41 +0200
Message-Id: <20180602043241.9941-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++--
 transport-helper.c        | 89 ++++++++++++++++++++-------------------
 2 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 362b1581e0..e3bc53b0c7 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -126,7 +126,7 @@ test_expect_success 'forced push' '
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 2>error &&
-	grep "This remote helper should implement refspec capability" error &&
+	test_i18ngrep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
@@ -134,7 +134,7 @@ test_expect_success 'pulling without refspecs' '
 	(cd local2 &&
 	git reset --hard &&
 	GIT_REMOTE_TESTGIT_REFSPEC="" git pull 2>../error) &&
-	grep "This remote helper should implement refspec capability" error &&
+	test_i18ngrep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
@@ -146,7 +146,7 @@ test_expect_success 'pushing without refspecs' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" &&
 	export GIT_REMOTE_TESTGIT_REFSPEC &&
 	test_must_fail git push 2>../error) &&
-	grep "remote-helper doesn.t support push; refspec needed" error
+	test_i18ngrep "remote-helper doesn.t support push; refspec needed" error
 '
 
 test_expect_success 'pulling without marks' '
@@ -246,7 +246,7 @@ test_expect_success 'proper failure checks for fetching' '
 	(cd local &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git fetch 2>error &&
 	cat error &&
-	grep -q "Error while running fast-import" error
+	test_i18ngrep -q "error while running fast-import" error
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 1f8ff7e942..442acec4f4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -48,7 +48,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", buffer->buf);
 	if (write_in_full(helper->helper->in, buffer->buf, buffer->len) < 0)
-		die_errno("Full write to remote helper failed");
+		die_errno(_("full write to remote helper failed"));
 }
 
 static int recvline_fh(FILE *helper, struct strbuf *buffer)
@@ -77,7 +77,7 @@ static void write_constant(int fd, const char *str)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", str);
 	if (write_in_full(fd, str, strlen(str)) < 0)
-		die_errno("Full write to remote helper failed");
+		die_errno(_("full write to remote helper failed"));
 }
 
 static const char *remove_ext_force(const char *url)
@@ -129,7 +129,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
-		die("Unable to find remote helper for '%s'", data->name);
+		die(_("unable to find remote helper for '%s'"), data->name);
 	else if (code != 0)
 		exit(code);
 
@@ -145,7 +145,7 @@ static struct child_process *get_helper(struct transport *transport)
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
-		die_errno("Can't dup helper output fd");
+		die_errno(_("can't dup helper output fd"));
 	data->out = xfdopen(duped, "r");
 
 	write_constant(helper->in, "capabilities\n");
@@ -196,13 +196,13 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
-			die("Unknown mandatory capability %s. This remote "
-			    "helper probably needs newer version of Git.",
+			die(_("Unknown mandatory capability %s. This remote "
+			      "helper probably needs newer version of Git."),
 			    capname);
 		}
 	}
 	if (!data->rs.nr && (data->import || data->bidi_import || data->export)) {
-		warning("This remote helper should implement refspec capability.");
+		warning(_("this remote helper should implement refspec capability"));
 	}
 	strbuf_release(&buf);
 	if (debug)
@@ -269,7 +269,7 @@ static int strbuf_set_helper_option(struct helper_data *data,
 	else if (!strcmp(buf->buf, "unsupported"))
 		ret = 1;
 	else {
-		warning("%s unexpectedly said: '%s'", data->name, buf->buf);
+		warning(_("%s unexpectedly said: '%s'"), data->name, buf->buf);
 		ret = 1;
 	}
 	return ret;
@@ -398,7 +398,7 @@ static int fetch_with_fetch(struct transport *transport,
 		if (starts_with(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
 			if (transport->pack_lockfile)
-				warning("%s also locked %s", data->name, name);
+				warning(_("%s also locked %s"), data->name, name);
 			else
 				transport->pack_lockfile = xstrdup(name);
 		}
@@ -409,7 +409,7 @@ static int fetch_with_fetch(struct transport *transport,
 		else if (!buf.len)
 			break;
 		else
-			warning("%s unexpectedly said: '%s'", data->name, buf.buf);
+			warning(_("%s unexpectedly said: '%s'"), data->name, buf.buf);
 	}
 	strbuf_release(&buf);
 	return 0;
@@ -476,7 +476,7 @@ static int fetch_with_import(struct transport *transport,
 	get_helper(transport);
 
 	if (get_importer(transport, &fastimport))
-		die("Couldn't run fast-import");
+		die(_("couldn't run fast-import"));
 
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
@@ -499,7 +499,7 @@ static int fetch_with_import(struct transport *transport,
 	 */
 
 	if (finish_command(&fastimport))
-		die("Error while running fast-import");
+		die(_("error while running fast-import"));
 
 	/*
 	 * The fast-import stream of a remote helper that advertises
@@ -528,7 +528,7 @@ static int fetch_with_import(struct transport *transport,
 			private = xstrdup(name);
 		if (private) {
 			if (read_ref(private, &posn->old_oid) < 0)
-				die("Could not read ref %s", private);
+				die(_("could not read ref %s"), private);
 			free(private);
 		}
 	}
@@ -554,7 +554,7 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
-		die_errno("Can't dup helper output fd");
+		die_errno(_("can't dup helper output fd"));
 	input = xfdopen(duped, "r");
 	setvbuf(input, NULL, _IONBF, 0);
 
@@ -573,8 +573,8 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 			fprintf(stderr, "Debug: Falling back to dumb "
 				"transport.\n");
 	} else {
-		die("Unknown response to connect: %s",
-			cmdbuf->buf);
+		die(_(_("unknown response to connect: %s")),
+		    cmdbuf->buf);
 	}
 
 	fclose(input);
@@ -595,9 +595,9 @@ static int process_connect_service(struct transport *transport,
 	if (strcmp(name, exec)) {
 		int r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
-			warning("Setting remote service path not supported by protocol.");
+			warning(_("setting remote service path not supported by protocol"));
 		else if (r < 0)
-			warning("Invalid remote service path.");
+			warning(_("invalid remote service path"));
 	}
 
 	if (data->connect) {
@@ -640,10 +640,10 @@ static int connect_helper(struct transport *transport, const char *name,
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
 	if (!data->connect)
-		die("Operation not supported by protocol.");
+		die(_("operation not supported by protocol"));
 
 	if (!process_connect_service(transport, name, exec))
-		die("Can't connect to subservice %s.", name);
+		die(_("can't connect to subservice %s"), name);
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
@@ -707,7 +707,7 @@ static int push_update_ref_status(struct strbuf *buf,
 		status = REF_STATUS_REMOTE_REJECT;
 		refname = buf->buf + 6;
 	} else
-		die("expected ok/error, helper said '%s'", buf->buf);
+		die(_("expected ok/error, helper said '%s'"), buf->buf);
 
 	msg = strchr(refname, ' ');
 	if (msg) {
@@ -760,7 +760,7 @@ static int push_update_ref_status(struct strbuf *buf,
 	if (!*ref)
 		*ref = find_ref_by_name(remote_refs, refname);
 	if (!*ref) {
-		warning("helper reported unexpected status of %s", refname);
+		warning(_("helper reported unexpected status of %s"), refname);
 		return 1;
 	}
 
@@ -821,20 +821,20 @@ static void set_common_push_options(struct transport *transport,
 {
 	if (flags & TRANSPORT_PUSH_DRY_RUN) {
 		if (set_helper_option(transport, "dry-run", "true") != 0)
-			die("helper %s does not support dry-run", name);
+			die(_("helper %s does not support dry-run"), name);
 	} else if (flags & TRANSPORT_PUSH_CERT_ALWAYS) {
 		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)
-			die("helper %s does not support --signed", name);
+			die(_("helper %s does not support --signed"), name);
 	} else if (flags & TRANSPORT_PUSH_CERT_IF_ASKED) {
 		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "if-asked") != 0)
-			die("helper %s does not support --signed=if-asked", name);
+			die(_("helper %s does not support --signed=if-asked"), name);
 	}
 
 	if (flags & TRANSPORT_PUSH_OPTIONS) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, transport->push_options)
 			if (set_helper_option(transport, "push-option", item->string) != 0)
-				die("helper %s does not support 'push-option'", name);
+				die(_("helper %s does not support 'push-option'"), name);
 	}
 }
 
@@ -926,12 +926,12 @@ static int push_refs_with_export(struct transport *transport,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->rs.nr)
-		die("remote-helper doesn't support push; refspec needed");
+		die(_("remote-helper doesn't support push; refspec needed"));
 
 	set_common_push_options(transport, data->name, flags);
 	if (flags & TRANSPORT_PUSH_FORCE) {
 		if (set_helper_option(transport, "force", "true") != 0)
-			warning("helper %s does not support 'force'", data->name);
+			warning(_("helper %s does not support 'force'"), data->name);
 	}
 
 	helper = get_helper(transport);
@@ -978,12 +978,12 @@ static int push_refs_with_export(struct transport *transport,
 	}
 
 	if (get_exporter(transport, &exporter, &revlist_args))
-		die("Couldn't run fast-export");
+		die(_("couldn't run fast-export"));
 
 	string_list_clear(&revlist_args, 1);
 
 	if (finish_command(&exporter))
-		die("Error while running fast-export");
+		die(_("error while running fast-export"));
 	if (push_update_refs_status(data, remote_refs, flags))
 		return 1;
 
@@ -1007,8 +1007,9 @@ static int push_refs(struct transport *transport,
 	}
 
 	if (!remote_refs) {
-		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
+		fprintf(stderr,
+			_("No refs in common and none specified; doing nothing.\n"
+			  "Perhaps you should specify a branch such as 'master'.\n"));
 		return 0;
 	}
 
@@ -1070,7 +1071,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 
 		eov = strchr(buf.buf, ' ');
 		if (!eov)
-			die("Malformed response in ref list: %s", buf.buf);
+			die(_("malformed response in ref list: %s"), buf.buf);
 		eon = strchr(eov + 1, ' ');
 		*eov = '\0';
 		if (eon)
@@ -1084,7 +1085,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 			if (has_attribute(eon + 1, "unchanged")) {
 				(*tail)->status |= REF_STATUS_UPTODATE;
 				if (read_ref((*tail)->name, &(*tail)->old_oid) < 0)
-					die(_("Could not read ref %s"),
+					die(_("could not read ref %s"),
 					    (*tail)->name);
 			}
 		}
@@ -1223,7 +1224,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
 	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
 	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
 		errno != EINTR) {
-		error_errno("read(%s) failed", t->src_name);
+		error_errno(_("read(%s) failed"), t->src_name);
 		return -1;
 	} else if (bytes == 0) {
 		transfer_debug("%s EOF (with %i bytes in buffer)",
@@ -1250,7 +1251,7 @@ static int udt_do_write(struct unidirectional_transfer *t)
 	transfer_debug("%s is writable", t->dest_name);
 	bytes = xwrite(t->dest, t->buf, t->bufuse);
 	if (bytes < 0 && errno != EWOULDBLOCK) {
-		error_errno("write(%s) failed", t->dest_name);
+		error_errno(_("write(%s) failed"), t->dest_name);
 		return -1;
 	} else if (bytes > 0) {
 		t->bufuse -= bytes;
@@ -1299,11 +1300,11 @@ static int tloop_join(pthread_t thread, const char *name)
 	void *tret;
 	err = pthread_join(thread, &tret);
 	if (!tret) {
-		error("%s thread failed", name);
+		error(_("%s thread failed"), name);
 		return 1;
 	}
 	if (err) {
-		error("%s thread failed to join: %s", name, strerror(err));
+		error(_("%s thread failed to join: %s"), name, strerror(err));
 		return 1;
 	}
 	return 0;
@@ -1322,11 +1323,11 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	err = pthread_create(&gtp_thread, NULL, udt_copy_task_routine,
 		&s->gtp);
 	if (err)
-		die("Can't start thread for copying data: %s", strerror(err));
+		die(_("can't start thread for copying data: %s"), strerror(err));
 	err = pthread_create(&ptg_thread, NULL, udt_copy_task_routine,
 		&s->ptg);
 	if (err)
-		die("Can't start thread for copying data: %s", strerror(err));
+		die(_("can't start thread for copying data: %s"), strerror(err));
 
 	ret |= tloop_join(gtp_thread, "Git to program copy");
 	ret |= tloop_join(ptg_thread, "Program to git copy");
@@ -1363,11 +1364,11 @@ static int tloop_join(pid_t pid, const char *name)
 {
 	int tret;
 	if (waitpid(pid, &tret, 0) < 0) {
-		error_errno("%s process failed to wait", name);
+		error_errno(_("%s process failed to wait"), name);
 		return 1;
 	}
 	if (!WIFEXITED(tret) || WEXITSTATUS(tret)) {
-		error("%s process failed", name);
+		error(_("%s process failed"), name);
 		return 1;
 	}
 	return 0;
@@ -1385,7 +1386,7 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	/* Fork thread #1: git to program. */
 	pid1 = fork();
 	if (pid1 < 0)
-		die_errno("Can't start thread for copying data");
+		die_errno(_("can't start thread for copying data"));
 	else if (pid1 == 0) {
 		udt_kill_transfer(&s->ptg);
 		exit(udt_copy_task_routine(&s->gtp) ? 0 : 1);
@@ -1394,7 +1395,7 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	/* Fork thread #2: program to git. */
 	pid2 = fork();
 	if (pid2 < 0)
-		die_errno("Can't start thread for copying data");
+		die_errno(_("can't start thread for copying data"));
 	else if (pid2 == 0) {
 		udt_kill_transfer(&s->gtp);
 		exit(udt_copy_task_routine(&s->ptg) ? 0 : 1);
-- 
2.18.0.rc0.309.g77c7720784


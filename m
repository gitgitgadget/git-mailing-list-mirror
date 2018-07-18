Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68661F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbeGRQvy (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33981 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbeGRQvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so4611253ljk.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Tjdb2jWDXkafY6Cf/HXRs480gX9UAW5hst6qrzvZNk=;
        b=Y74cPFWbFYekkhgrk00mRdCBX/KqBYg+VOTwfZskHoJK8KyOi1Ar5eEaXHaI8l4YMw
         78mGeTXdrSnt1JD0KrLRWikjae19QdL1tlILk/hT9Y0S9TWsU1vN6s1nQdVeGGeSN9wu
         Dn3ll3xFjpykzC0+AVgZM9y0cD8hRtF3qp8UZvcmeum/mBrfAzJOedfP7IR8dYu6jc8W
         3bFIcxGJUgTqwoJ/m/j+3PtIX7Ot5x32a2xbSlNmoSKlajJOv9DHp6+G2B4btrCqxt9R
         yRQ0f+NRwkQCKZUSU25r5Sptc32+9LTJayd0eUVB/2obIHaEJrDP0qj7NzQXo9nOnPWO
         nnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Tjdb2jWDXkafY6Cf/HXRs480gX9UAW5hst6qrzvZNk=;
        b=n+Xqmh6P4g5ezGzo1B4+XbEPHW+QOua9dde0Z9ku/daHMCZ42DVEqND+jnoLNTD7nj
         4p1YwoNlBBBLSXsR6+dVAPIBE+KuHYt+Rz4V/AX0CsBOgpyG0vvGi2vHSYLfJCiFo+fI
         7jyJlyXZO5sF58rrT53fMmroTR/yxHJoWQk4wHkySKz2bqMpAJ31PZFJ0lBsryxI/bQi
         8btfjkW2ZXHBifXi7eYPyZ5esI3+EwlKl8IP7YlNaFj8v1a9Xg2vo6BepiIus3M2DldR
         s0n2C1m43bdGYJcQKBFHiaUFarJOwBZHIZD0HHR+VOIue9e89pjb8R3veThVpXpdaF7w
         U9GA==
X-Gm-Message-State: AOUpUlGIcG562d0IGwQErM30Veg/W9JTB3yj4mJ6sCemXP6aeKMwL5z7
        wl1aDoT58xgjrt7JxftTTNdo2Q==
X-Google-Smtp-Source: AAOMgpeYhAo6Cir+tmMieiTBEsW7wdAjSA6azYZa6wtc8RfiWZytB3yF8oxraIFUyUryH/zvcrOdIQ==
X-Received: by 2002:a2e:3611:: with SMTP id d17-v6mr5368197lja.31.1531930394469;
        Wed, 18 Jul 2018 09:13:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:13:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 23/23] transport-helper.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:11:01 +0200
Message-Id: <20180718161101.19765-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
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
 transport-helper.c        | 87 ++++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 88c7f158ef..e3bc53b0c7 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -126,7 +126,7 @@ test_expect_success 'forced push' '
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 2>error &&
-	grep "this remote helper should implement refspec capability" error &&
+	test_i18ngrep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
@@ -134,7 +134,7 @@ test_expect_success 'pulling without refspecs' '
 	(cd local2 &&
 	git reset --hard &&
 	GIT_REMOTE_TESTGIT_REFSPEC="" git pull 2>../error) &&
-	grep "this remote helper should implement refspec capability" error &&
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
-	grep -q "error while running fast-import" error
+	test_i18ngrep -q "error while running fast-import" error
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 9f487cc905..84a10661cc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -48,7 +48,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", buffer->buf);
 	if (write_in_full(helper->helper->in, buffer->buf, buffer->len) < 0)
-		die_errno("full write to remote helper failed");
+		die_errno(_("full write to remote helper failed"));
 }
 
 static int recvline_fh(FILE *helper, struct strbuf *buffer)
@@ -77,7 +77,7 @@ static void write_constant(int fd, const char *str)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", str);
 	if (write_in_full(fd, str, strlen(str)) < 0)
-		die_errno("full write to remote helper failed");
+		die_errno(_("full write to remote helper failed"));
 }
 
 static const char *remove_ext_force(const char *url)
@@ -129,7 +129,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
-		die("unable to find remote helper for '%s'", data->name);
+		die(_("unable to find remote helper for '%s'"), data->name);
 	else if (code != 0)
 		exit(code);
 
@@ -145,7 +145,7 @@ static struct child_process *get_helper(struct transport *transport)
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
-		die_errno("can't dup helper output fd");
+		die_errno(_("can't dup helper output fd"));
 	data->out = xfdopen(duped, "r");
 
 	write_constant(helper->in, "capabilities\n");
@@ -196,13 +196,13 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
-			die("unknown mandatory capability %s; this remote "
-			    "helper probably needs newer version of Git",
+			die(_("unknown mandatory capability %s; this remote "
+			      "helper probably needs newer version of Git"),
 			    capname);
 		}
 	}
 	if (!data->rs.nr && (data->import || data->bidi_import || data->export)) {
-		warning("this remote helper should implement refspec capability");
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
-		die("couldn't run fast-import");
+		die(_("couldn't run fast-import"));
 
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
@@ -499,7 +499,7 @@ static int fetch_with_import(struct transport *transport,
 	 */
 
 	if (finish_command(&fastimport))
-		die("error while running fast-import");
+		die(_("error while running fast-import"));
 
 	/*
 	 * The fast-import stream of a remote helper that advertises
@@ -528,7 +528,7 @@ static int fetch_with_import(struct transport *transport,
 			private = xstrdup(name);
 		if (private) {
 			if (read_ref(private, &posn->old_oid) < 0)
-				die("could not read ref %s", private);
+				die(_("could not read ref %s"), private);
 			free(private);
 		}
 	}
@@ -554,7 +554,7 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
-		die_errno("can't dup helper output fd");
+		die_errno(_("can't dup helper output fd"));
 	input = xfdopen(duped, "r");
 	setvbuf(input, NULL, _IONBF, 0);
 
@@ -573,8 +573,8 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 			fprintf(stderr, "Debug: Falling back to dumb "
 				"transport.\n");
 	} else {
-		die("unknown response to connect: %s",
-			cmdbuf->buf);
+		die(_(_("unknown response to connect: %s")),
+		    cmdbuf->buf);
 	}
 
 	fclose(input);
@@ -595,9 +595,9 @@ static int process_connect_service(struct transport *transport,
 	if (strcmp(name, exec)) {
 		int r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
-			warning("setting remote service path not supported by protocol");
+			warning(_("setting remote service path not supported by protocol"));
 		else if (r < 0)
-			warning("invalid remote service path");
+			warning(_("invalid remote service path"));
 	}
 
 	if (data->connect) {
@@ -640,10 +640,10 @@ static int connect_helper(struct transport *transport, const char *name,
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
 	if (!data->connect)
-		die("operation not supported by protocol");
+		die(_("operation not supported by protocol"));
 
 	if (!process_connect_service(transport, name, exec))
-		die("can't connect to subservice %s", name);
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
-		die("couldn't run fast-export");
+		die(_("couldn't run fast-export"));
 
 	string_list_clear(&revlist_args, 1);
 
 	if (finish_command(&exporter))
-		die("error while running fast-export");
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
-			die("malformed response in ref list: %s", buf.buf);
+			die(_("malformed response in ref list: %s"), buf.buf);
 		eon = strchr(eov + 1, ' ');
 		*eov = '\0';
 		if (eon)
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
-		die("can't start thread for copying data: %s", strerror(err));
+		die(_("can't start thread for copying data: %s"), strerror(err));
 	err = pthread_create(&ptg_thread, NULL, udt_copy_task_routine,
 		&s->ptg);
 	if (err)
-		die("can't start thread for copying data: %s", strerror(err));
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
-		die_errno("can't start thread for copying data");
+		die_errno(_("can't start thread for copying data"));
 	else if (pid1 == 0) {
 		udt_kill_transfer(&s->ptg);
 		exit(udt_copy_task_routine(&s->gtp) ? 0 : 1);
@@ -1394,7 +1395,7 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	/* Fork thread #2: program to git. */
 	pid2 = fork();
 	if (pid2 < 0)
-		die_errno("can't start thread for copying data");
+		die_errno(_("can't start thread for copying data"));
 	else if (pid2 == 0) {
 		udt_kill_transfer(&s->gtp);
 		exit(udt_copy_task_routine(&s->ptg) ? 0 : 1);
-- 
2.18.0.rc2.476.g39500d3211


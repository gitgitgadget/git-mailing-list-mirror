From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/25] More flexibility in making shallow clones
Date: Tue, 23 Feb 2016 20:44:38 +0700
Message-ID: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDGm-0007t4-7p
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbcBWNot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:44:49 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33190 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbcBWNoq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:44:46 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so112546727pfb.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=U8ckKhlkj6bgFVJ/YT28QLLJ5qybueiU75FrWchwl8M=;
        b=G4oMF5bnFv5+S4zNXPJGQ9fGsG+4arG+ZKR/5X9lIvpFtFYozFjI0Su2wFLcZj8qyb
         2leZFJWWR5b1iDsIttqdcmu6q/gXSv6oKzZUfm+dQJT5yd9zTFqbFShWH8+XzIj91K/D
         b/OGNTh3JD+eNxp3CTjCHkSaclk2WUlY9uTj3HMPPT1iC9NYzTrOTR1V1yabjeCMuYzN
         WqpLFVLtr74SR/6fay6aTxCnkOV/OGQ1Alq4q0oi202dRMZEJq4I0kM2+WaOUILstx5u
         mBVe+sda+fKOnxIN668/uNDOwnmySIstZYHUrCozcocTdSo6aB2IRKUKQ4ZI2iUbGkXG
         231w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=U8ckKhlkj6bgFVJ/YT28QLLJ5qybueiU75FrWchwl8M=;
        b=ObNMzMkDc6Z7PIsXGXNRzdFyHU0DQ64SEI+wI5VCUqyPmHHnMLceJ7YoPxHl2dQVaG
         RUY5PiA+PyrrgbF1drUJ5xFEWNAqq8UNSees95cdZ1JD5j3hArm0NmdpQotXAUIOE8dc
         9vfV6rRL8s0/XY3aHdu6fzSIhmX4Q0tl9qVb0Lf+YmpwV9qxTNHyc617P1BxTIz6vU7K
         mwwW3RowP17ATmD8wh+igwjH+MewbqoP6OOfImcw5ysUfEt37jIici471c85ybylFhcC
         /AM2P+frjPlSuh6oa3dUTDSspry8Af9BFeH8KQVlzXgXnkNU7wv/kWXlpdAGVkcoYrbV
         WUkw==
X-Gm-Message-State: AG10YOSAX73nFCbSBiuBJRn0UKEd/Kk3TOsoPUzbTmvUKs/vrJdwjqlNRY1as7zUJW/cZw==
X-Received: by 10.98.33.70 with SMTP id h67mr45829262pfh.54.1456235086286;
        Tue, 23 Feb 2016 05:44:46 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id y68sm44534728pfi.6.2016.02.23.05.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:44:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:45:14 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287053>

Changes since v2 [1]

 - PATCH v2 03/25, transport-helper.c: do not send null option to
   remote, is dropped. It's just a hack. Even if we want to set NULL
   to a transport option to say "reset to defaults", we need to tell
   remote helper about it, not silently ignore it. 15/25 solves it
   without the old patch.

 - get_shallow_commits_by_rev_list() avoids going through all in-core
   objects in 13/25

 - split check_unreachable()'s double usage, 23/25 (new) and
   24/25. 23/25 actually makes interdiff a bit messy to read.

 - move --not arguments before revs in 19/25

 - some more small changes for other comments, see interdiff.

[1] http://thread.gmane.org/gmane.comp.version-control.git/285414

Interdiff

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 67a13af..8265348 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -50,6 +50,7 @@ int cmd_fetch_pack(int argc, const char **argv, const=
 char *prefix)
 	struct child_process *conn;
 	struct fetch_pack_args args;
 	struct sha1_array shallow =3D SHA1_ARRAY_INIT;
+	struct string_list deepen_not =3D STRING_LIST_INIT_DUP;
=20
 	packet_trace_identity("fetch-pack");
=20
@@ -58,14 +59,13 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
=20
 	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
 		const char *arg =3D argv[i];
-		const char *value;
=20
-		if (skip_prefix(arg, "--upload-pack=3D", &value)) {
-			args.uploadpack =3D value;
+		if (skip_prefix(arg, "--upload-pack=3D", &arg)) {
+			args.uploadpack =3D arg;
 			continue;
 		}
-		if (skip_prefix(arg, "--exec=3D", &value)) {
-			args.uploadpack =3D value;
+		if (skip_prefix(arg, "--exec=3D", &arg)) {
+			args.uploadpack =3D arg;
 			continue;
 		}
 		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
@@ -101,22 +101,16 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
 			args.verbose =3D 1;
 			continue;
 		}
-		if (skip_prefix(arg, "--depth=3D", &value)) {
-			args.depth =3D strtol(value, NULL, 0);
+		if (skip_prefix(arg, "--depth=3D", &arg)) {
+			args.depth =3D strtol(arg, NULL, 0);
 			continue;
 		}
-		if (skip_prefix(arg, "--shallow-since=3D", &value)) {
-			args.deepen_since =3D xstrdup(value);
+		if (skip_prefix(arg, "--shallow-since=3D", &arg)) {
+			args.deepen_since =3D xstrdup(arg);
 			continue;
 		}
-		if (skip_prefix(arg, "--shallow-exclude=3D", &value)) {
-			static struct string_list *deepen_not;
-			if (!deepen_not) {
-				deepen_not =3D xmalloc(sizeof(*deepen_not));
-				string_list_init(deepen_not, 1);
-				args.deepen_not =3D deepen_not;
-			}
-			string_list_append(deepen_not, value);
+		if (skip_prefix(arg, "--shallow-exclude=3D", &arg)) {
+			string_list_append(&deepen_not, arg);
 			continue;
 		}
 		if (!strcmp(arg, "--deepen-relative")) {
@@ -150,6 +144,8 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 		}
 		usage(fetch_pack_usage);
 	}
+	if (deepen_not.nr)
+		args.deepen_not =3D &deepen_not;
=20
 	if (i < argc)
 		dest =3D argv[i++];
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c5f0e9e..808c11b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -875,7 +875,7 @@ static void set_option(struct transport *transport,=
 const char *name, const char
 			name, transport->url);
 }
=20
-static struct transport *prepare_transport(struct remote *remote)
+static struct transport *prepare_transport(struct remote *remote, int =
deepen)
 {
 	struct transport *transport;
 	transport =3D transport_get(remote, NULL);
@@ -886,9 +886,9 @@ static struct transport *prepare_transport(struct r=
emote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
-	if (deepen_since)
+	if (deepen && deepen_since)
 		set_option(transport, TRANS_OPT_DEEPEN_SINCE, deepen_since);
-	if (deepen_not.nr)
+	if (deepen && deepen_not.nr)
 		set_option(transport, TRANS_OPT_DEEPEN_NOT,
 			   (const char *)&deepen_not);
 	if (deepen_relative)
@@ -900,15 +900,24 @@ static struct transport *prepare_transport(struct=
 remote *remote)
=20
 static void backfill_tags(struct transport *transport, struct ref *ref=
_map)
 {
-	if (transport->cannot_reuse) {
-		gsecondary =3D prepare_transport(transport->remote);
+	int cannot_reuse;
+
+	/*
+	 * Once we have set TRANS_OPT_DEEPEN_SINCE, we can't unset it
+	 * when remote helper is used (setting it to an empty string
+	 * is not unsetting). We could extend the remote helper
+	 * protocol for that, but for now, just force a new connection
+	 * without deepen-since. Similar story for deepen-not.
+	 */
+	cannot_reuse =3D transport->cannot_reuse ||
+		deepen_since || deepen_not.nr;
+	if (cannot_reuse) {
+		gsecondary =3D prepare_transport(transport->remote, 0);
 		transport =3D gsecondary;
 	}
=20
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
-	transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE, NULL);
-	transport_set_option(transport, TRANS_OPT_DEEPEN_NOT, NULL);
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
 	fetch_refs(transport, ref_map);
=20
@@ -1121,7 +1130,7 @@ static int fetch_one(struct remote *remote, int a=
rgc, const char **argv)
 		die(_("No remote repository specified.  Please, specify either a URL=
 or a\n"
 		    "remote name from which new revisions should be fetched."));
=20
-	gtransport =3D prepare_transport(remote);
+	gtransport =3D prepare_transport(remote, 1);
=20
 	if (prune < 0) {
 		/* no command line request */
diff --git a/fetch-pack.c b/fetch-pack.c
index 69a99e5..ace9217 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -857,7 +857,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 		allow_unadvertised_object_request |=3D ALLOW_TIP_SHA1;
 	}
 	if (server_supports("allow-reachable-sha1-in-want")) {
-		print_verbose(args, "Server supports allow-reachable-sha1-in-want\n"=
);
+		print_verbose(args, "Server supports allow-reachable-sha1-in-want");
 		allow_unadvertised_object_request |=3D ALLOW_REACHABLE_SHA1;
 	}
 	if (!server_supports("thin-pack"))
diff --git a/remote-curl.c b/remote-curl.c
index ea06c5d..3f1a8f5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -750,8 +750,7 @@ static int fetch_git(struct discovery *heads,
 	struct argv_array args =3D ARGV_ARRAY_INIT;
=20
 	argv_array_pushl(&args, "fetch-pack", "--stateless-rpc",
-			 "--stdin", "--lock-pack",
-			 NULL);
+			 "--stdin", "--lock-pack", NULL);
 	if (options.followtags)
 		argv_array_push(&args, "--include-tag");
 	if (options.thin)
diff --git a/shallow.c b/shallow.c
index f5d5c1d..5dca743 100644
--- a/shallow.c
+++ b/shallow.c
@@ -141,7 +141,7 @@ struct commit_list *get_shallow_commits(struct obje=
ct_array *heads, int depth,
=20
 static void show_commit(struct commit *commit, void *data)
 {
-	commit->object.flags |=3D *(int *)data;
+	commit_list_insert(commit, data);
 }
=20
 /*
@@ -155,20 +155,15 @@ struct commit_list *get_shallow_commits_by_rev_li=
st(int ac, const char **av,
 						    int not_shallow_flag)
 {
 	struct commit_list *result =3D NULL, *p;
+	struct commit_list *not_shallow_list =3D NULL;
 	struct rev_info revs;
-	unsigned int i, nr;
+	int both_flags =3D shallow_flag | not_shallow_flag;
=20
 	/*
 	 * SHALLOW (excluded) and NOT_SHALLOW (included) should not be
 	 * set at this point. But better be safe than sorry.
 	 */
-	nr =3D get_max_object_index();
-	for (i =3D 0; i < nr; i++) {
-		struct object *o =3D get_indexed_object(i);
-		if (!o || o->type !=3D OBJ_COMMIT)
-			continue;
-		o->flags &=3D ~(shallow_flag | not_shallow_flag);
-	}
+	clear_object_flags(both_flags);
=20
 	is_repository_shallow(); /* make sure shallows are read */
=20
@@ -176,10 +171,13 @@ struct commit_list *get_shallow_commits_by_rev_li=
st(int ac, const char **av,
 	save_commit_buffer =3D 0;
 	setup_revisions(ac, av, &revs, NULL);
=20
-	/* Mark all reachable commits as NOT_SHALLOW */
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
-	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_flag);
+	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_list);
+
+	/* Mark all reachable commits as NOT_SHALLOW */
+	for (p =3D not_shallow_list; p; p =3D p->next)
+		p->item->object.flags |=3D not_shallow_flag;
=20
 	/*
 	 * mark border commits SHALLOW + NOT_SHALLOW.
@@ -188,14 +186,8 @@ struct commit_list *get_shallow_commits_by_rev_lis=
t(int ac, const char **av,
 	 * A, later. If NOT_SHALLOW on A is cleared at step 1, B
 	 * itself is considered border at step 2, which is incorrect.
 	 */
-	nr =3D get_max_object_index();
-	for (i =3D 0; i < nr; i++) {
-		struct object *o =3D get_indexed_object(i);
-		struct commit *c =3D (struct commit *)o;
-
-		if (!o || o->type !=3D OBJ_COMMIT ||
-		    !(o->flags & not_shallow_flag))
-			continue;
+	for (p =3D not_shallow_list; p; p =3D p->next) {
+		struct commit *c =3D p->item;
=20
 		if (parse_commit(c))
 			die("unable to parse commit %s",
@@ -203,21 +195,21 @@ struct commit_list *get_shallow_commits_by_rev_li=
st(int ac, const char **av,
=20
 		for (p =3D c->parents; p; p =3D p->next)
 			if (!(p->item->object.flags & not_shallow_flag)) {
-				o->flags |=3D shallow_flag;
+				c->object.flags |=3D shallow_flag;
 				commit_list_insert(c, &result);
 				break;
 			}
 	}
+	free_commit_list(not_shallow_list);
=20
 	/*
 	 * Now we can clean up NOT_SHALLOW on border commits. Having
 	 * both flags set can confuse the caller.
 	 */
 	for (p =3D result; p; p =3D p->next) {
-		struct object *ro =3D &p->item->object;
-		if ((ro->flags & not_shallow_flag) &&
-		    (ro->flags & shallow_flag))
-			ro->flags &=3D ~not_shallow_flag;
+		struct object *o =3D &p->item->object;
+		if ((o->flags & both_flags) =3D=3D both_flags)
+			o->flags &=3D ~not_shallow_flag;
 	}
 	return result;
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index ed8d18c..f512098 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -654,8 +654,10 @@ test_expect_success 'clone shallow since ...' '
 test_expect_success 'fetch shallow since ...' '
 	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
 	git -C shallow11 log --pretty=3Dtformat:%s origin/master >actual &&
-	echo three >expected &&
-	echo two  >>expected &&
+	cat >expected <<-\EOF &&
+	three
+	two
+	EOF
 	test_cmp expected actual
 '
=20
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index 06389eb..25f8968 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -91,8 +91,10 @@ test_expect_success 'clone shallow since ...' '
 test_expect_success 'fetch shallow since ...' '
 	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
 	git -C shallow11 log --pretty=3Dtformat:%s origin/master >actual &&
-	echo three >expected &&
-	echo two  >>expected &&
+	cat >expected <<-\EOF &&
+	three
+	two
+	EOF
 	test_cmp expected actual
 '
=20
diff --git a/transport-helper.c b/transport-helper.c
index 3c1ae6f..b894b60 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -290,9 +290,6 @@ static int string_list_set_helper_option(struct hel=
per_data *data,
 	struct strbuf buf =3D STRBUF_INIT;
 	int i, ret =3D 0;
=20
-	if (!list)
-		return 0;
-
 	for (i =3D 0; i < list->nr; i++) {
 		strbuf_addf(&buf, "option %s ", name);
 		quote_c_style(list->items[i].string, &buf, NULL, 0);
@@ -337,12 +334,8 @@ static int set_helper_option(struct transport *tra=
nsport,
 	strbuf_addf(&buf, "option %s ", name);
 	if (is_bool)
 		strbuf_addstr(&buf, value ? "true" : "false");
-	else if (value)
+	else
 		quote_c_style(value, &buf, NULL, 0);
-	else {
-		strbuf_release(&buf);
-		return 0;
-	}
 	strbuf_addch(&buf, '\n');
=20
 	ret =3D strbuf_set_helper_option(data, &buf);
diff --git a/transport.c b/transport.c
index 2f3823a..f9c9e67 100644
--- a/transport.c
+++ b/transport.c
@@ -482,6 +482,7 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_NOT)) {
 		opts->deepen_not =3D (const struct string_list *)value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative =3D !!value;
 		return 0;
diff --git a/upload-pack.c b/upload-pack.c
index f05971e..18b914a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -452,33 +452,26 @@ static int is_our_ref(struct object *o)
 			(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
-/*
- * If reachable is NULL, return 1 if there is no unreachable object,
- * zero otherwise.
- *
- * If reachable is not NULL, it's filled with reachable objects.
- * Return value is irrelevant. The caller has to compare reachable and
- * src to find out if there's any unreachable object.
- */
-static int check_unreachable(struct object_array *reachable,
-			     struct object_array *src)
+
+static int do_reachable_revlist(struct child_process *cmd,
+				struct object_array *src,
+				struct object_array *reachable)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
 	};
-	static struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct object *o;
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
=20
-	cmd.argv =3D argv;
-	cmd.git_cmd =3D 1;
-	cmd.no_stderr =3D 1;
-	cmd.in =3D -1;
-	cmd.out =3D -1;
+	cmd->argv =3D argv;
+	cmd->git_cmd =3D 1;
+	cmd->no_stderr =3D 1;
+	cmd->in =3D -1;
+	cmd->out =3D -1;
=20
-	if (start_command(&cmd))
-		return 0;
+	if (start_command(cmd))
+		return -1;
=20
 	/*
 	 * If rev-list --stdin encounters an unknown commit, it
@@ -498,8 +491,8 @@ static int check_unreachable(struct object_array *r=
eachable,
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 42) < 0)
-			return 0;
+		if (write_in_full(cmd->in, namebuf, 42) < 0)
+			return -1;
 	}
 	namebuf[40] =3D '\n';
 	for (i =3D 0; i < src->nr; i++) {
@@ -512,22 +505,26 @@ static int check_unreachable(struct object_array =
*reachable,
 		if (reachable && o->type =3D=3D OBJ_COMMIT)
 			o->flags |=3D TMP_MARK;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 41) < 0)
-			return 0;
+		if (write_in_full(cmd->in, namebuf, 41) < 0)
+			return -1;
 	}
-	close(cmd.in);
+	close(cmd->in);
=20
 	sigchain_pop(SIGPIPE);
-
-	/*
-	 * The commits out of the rev-list are not ancestors of
-	 * our ref.
-	 */
-	if (!reachable) {
-		i =3D read_in_full(cmd.out, namebuf, 1);
-		if (i)
 	return 0;
-	} else {
+}
+
+static int get_reachable_list(struct object_array *src,
+			      struct object_array *reachable)
+{
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	int i, ret =3D do_reachable_revlist(&cmd, src, reachable);
+	struct object *o;
+	char namebuf[42]; /* ^ + SHA-1 + LF */
+
+	if (ret < 0)
+		return -1;
+
 	while ((i =3D read_in_full(cmd.out, namebuf, 41)) =3D=3D 41) {
 		struct object_id sha1;
=20
@@ -539,15 +536,38 @@ static int check_unreachable(struct object_array =
*reachable,
 			o->flags &=3D ~TMP_MARK;
 		}
 	}
-		for (i =3D get_max_object_index(); 0 < i; ) {
-			o =3D get_indexed_object(--i);
+	for (i =3D get_max_object_index(); 0 < i; i--) {
+		o =3D get_indexed_object(i - 1);
 		if (o && o->type =3D=3D OBJ_COMMIT &&
 		    (o->flags & TMP_MARK)) {
 			add_object_array(o, NULL, reachable);
 				o->flags &=3D ~TMP_MARK;
 		}
 	}
-	}
+	close(cmd.out);
+
+	if (finish_command(&cmd))
+		return -1;
+
+	return 0;
+}
+
+static int check_unreachable(struct object_array *src)
+{
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	int i, ret =3D do_reachable_revlist(&cmd, src, NULL);
+	char buf[1];
+
+	if (ret < 0)
+		return 0;
+
+	/*
+	 * The commits out of the rev-list are not ancestors of
+	 * our ref.
+	 */
+	i =3D read_in_full(cmd.out, buf, 1);
+	if (i)
+		return 0;
 	close(cmd.out);
=20
 	/*
@@ -573,7 +593,7 @@ static void check_non_tip(void)
 	 */
 	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REA=
CHABLE_SHA1))
 		;		/* error */
-	else if (check_unreachable(NULL, &want_obj))
+	else if (check_unreachable(&want_obj))
 		return;
=20
 	/* Pick one of them (we know there at least is one) */
@@ -645,7 +665,7 @@ static void deepen(int depth, int deepen_relative,
 		}
 	else if (deepen_relative) {
 		struct object_array reachable_shallows =3D OBJECT_ARRAY_INIT;
-		(void)check_unreachable(&reachable_shallows, shallows);
+		get_reachable_list(shallows, &reachable_shallows);
 		result =3D get_shallow_commits(&reachable_shallows,
 					     depth + 1,
 					     SHALLOW, NOT_SHALLOW);
@@ -729,7 +749,7 @@ static void receive_needs(void)
 			char *ref =3D NULL;
 			unsigned char sha1[20];
 			if (expand_ref(arg, strlen(arg), sha1, &ref) !=3D 1)
-				die("Ambiguous deepen-not: %s", line);
+				die("git upload-pack: ambiguous deepen-not: %s", line);
 			string_list_append(&deepen_not, ref);
 			free(ref);
 			deepen_rev_list =3D 1;
@@ -791,7 +811,7 @@ static void receive_needs(void)
 	if (depth =3D=3D 0 && !deepen_rev_list && shallows.nr =3D=3D 0)
 		return;
 	if (depth > 0 && deepen_rev_list)
-		die("--depth and --shallow-since (or --shallow-exclude) cannot be us=
ed together");
+		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot=
 be used together");
 	if (depth > 0)
 		deepen(depth, deepen_relative, &shallows);
 	else if (deepen_rev_list) {
@@ -801,16 +821,17 @@ static void receive_needs(void)
 		argv_array_push(&av, "rev-list");
 		if (deepen_since)
 			argv_array_pushf(&av, "--max-age=3D%lu", deepen_since);
-		for (i =3D 0; i < want_obj.nr; i++) {
-			struct object *o =3D want_obj.objects[i].item;
-			argv_array_push(&av, oid_to_hex(&o->oid));
-		}
 		if (deepen_not.nr) {
 			argv_array_push(&av, "--not");
 			for (i =3D 0; i < deepen_not.nr; i++) {
 				struct string_list_item *s =3D deepen_not.items + i;
 				argv_array_push(&av, s->string);
 			}
+			argv_array_push(&av, "--not");
+		}
+		for (i =3D 0; i < want_obj.nr; i++) {
+			struct object *o =3D want_obj.objects[i].item;
+			argv_array_push(&av, oid_to_hex(&o->oid));
 		}
 		deepen_by_rev_list(av.argc, av.argv, &shallows);
 		argv_array_clear(&av);


Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (25):
  remote-curl.c: convert fetch_git() to use argv_array
  transport-helper.c: refactor set_helper_option()
  upload-pack: move shallow deepen code out of receive_needs()
  upload-pack: move "shallow" sending code out of deepen()
  upload-pack: remove unused variable "backup"
  upload-pack: move "unshallow" sending code out of deepen()
  upload-pack: use skip_prefix() instead of starts_with()
  upload-pack: tighten number parsing at "deepen" lines
  upload-pack: move rev-list code out of check_non_tip()
  fetch-pack: use skip_prefix() instead of starts_with()
  fetch-pack: use a common function for verbose printing
  fetch-pack: use a separate flag for fetch in deepening mode
  shallow.c: implement a generic shallow boundary finder based on
    rev-list
  upload-pack: add deepen-since to cut shallow repos based on time
  fetch: define shallow boundary with --shallow-since
  clone: define shallow clone boundary based on time with
    --shallow-since
  t5500, t5539: tests for shallow depth since a specific date
  refs: add expand_ref()
  upload-pack: support define shallow boundary by excluding revisions
  fetch: define shallow boundary with --shallow-exclude
  clone: define shallow clone boundary with --shallow-exclude
  t5500, t5539: tests for shallow depth excluding a ref
  upload-pack: split check_unreachable() in two, prep for
    get_reachable_list()
  upload-pack: add get_reachable_list()
  fetch, upload-pack: --deepen=3DN extends shallow boundary by N commit=
s

 Documentation/fetch-options.txt                   |  14 +
 Documentation/git-clone.txt                       |   8 +
 Documentation/git-fetch-pack.txt                  |  14 +
 Documentation/gitremote-helpers.txt               |  11 +
 Documentation/technical/pack-protocol.txt         |   4 +-
 Documentation/technical/protocol-capabilities.txt |  25 ++
 builtin/clone.c                                   |  32 +-
 builtin/fetch-pack.c                              |  27 +-
 builtin/fetch.c                                   |  58 +++-
 commit.h                                          |   2 +
 fetch-pack.c                                      | 128 ++++----
 fetch-pack.h                                      |   4 +
 object.h                                          |   2 +-
 refs.c                                            |   8 +-
 refs.h                                            |   1 +
 remote-curl.c                                     |  74 +++--
 shallow.c                                         |  77 +++++
 t/t5500-fetch-pack.sh                             |  69 +++++
 t/t5539-fetch-http-shallow.sh                     |  74 +++++
 transport-helper.c                                |  62 +++-
 transport.c                                       |  12 +
 transport.h                                       |  14 +
 upload-pack.c                                     | 338 ++++++++++++++=
++------
 23 files changed, 858 insertions(+), 200 deletions(-)

--=20
2.7.1.532.gd9e3aaa

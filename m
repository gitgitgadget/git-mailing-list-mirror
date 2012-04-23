From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/10] i18n: remote: mark strings for translation
Date: Mon, 23 Apr 2012 19:30:26 +0700
Message-ID: <1335184230-8870-7-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:34:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMITp-0005gz-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab2DWMew convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:34:52 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:48603 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab2DWMev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:34:51 -0400
Received: by dadz8 with SMTP id z8so15500024dad.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WopjrB4WFOiaehzvsjZGaBojbv+IS0rSeJuU2SDO1ic=;
        b=Nlt2NUn62sc+mSB3Xp8ABFlCocaToBCv/tB3eIibNHUrzn1at33kz3wkzcZ7X4cGG8
         LSNvbXGIqlWUJybr2r1MHxq4hKuZTgSWhyrDX/OdUOaC1i71/G1s3ZRiwtAgcAjR3KEa
         OaXQW1m3dFiFp3ANxLVOQBU7FoLND/5IJd2rumSXV12Uc2KuKQxP7oTx7AO30l0irgXI
         PMmQ5+n4/tO4aq2Vtr2PobI/EZEwAQT4cAOFKO068VSmqc55wguM+L3LHYlFkOVPGeOg
         42H3ozWw8xwmhI8itklyFQTwNDP3D02SSy7FdEzh6rKVZvbZ6bpkKsJu4IEJH4QLsVQt
         33MA==
Received: by 10.68.129.65 with SMTP id nu1mr11512381pbb.18.1335184491129;
        Mon, 23 Apr 2012 05:34:51 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id i5sm14294758pbf.19.2012.04.23.05.34.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:34:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:31:33 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196120>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/remote.c |  227 +++++++++++++++++++++++++++++-----------------=
--------
 1 files changed, 121 insertions(+), 106 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1b03473..51434fa 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -95,9 +95,9 @@ static int fetch_remote(const char *name)
 		argv[1] =3D "-v";
 		argv[2] =3D name;
 	}
-	printf("Updating %s\n", name);
+	printf_ln(_("Updating %s"), name);
 	if (run_command_v_opt(argv, RUN_GIT_CMD))
-		return error("Could not fetch %s", name);
+		return error(_("Could not fetch %s"), name);
 	return 0;
 }
=20
@@ -127,8 +127,8 @@ static int add_branch(const char *key, const char *=
branchname,
 }
=20
 static const char mirror_advice[] =3D
-"--mirror is dangerous and deprecated; please\n"
-"\t use --mirror=3Dfetch or --mirror=3Dpush instead";
+N_("--mirror is dangerous and deprecated; please\n"
+   "\t use --mirror=3Dfetch or --mirror=3Dpush instead");
=20
 static int parse_mirror_opt(const struct option *opt, const char *arg,=
 int not)
 {
@@ -136,7 +136,7 @@ static int parse_mirror_opt(const struct option *op=
t, const char *arg, int not)
 	if (not)
 		*mirror =3D MIRROR_NONE;
 	else if (!arg) {
-		warning("%s", mirror_advice);
+		warning("%s", _(mirror_advice));
 		*mirror =3D MIRROR_BOTH;
 	}
 	else if (!strcmp(arg, "fetch"))
@@ -144,7 +144,7 @@ static int parse_mirror_opt(const struct option *op=
t, const char *arg, int not)
 	else if (!strcmp(arg, "push"))
 		*mirror =3D MIRROR_PUSH;
 	else
-		return error("unknown mirror argument: %s", arg);
+		return error(_("unknown mirror argument: %s"), arg);
 	return 0;
 }
=20
@@ -182,9 +182,9 @@ static int add(int argc, const char **argv)
 		usage_with_options(builtin_remote_add_usage, options);
=20
 	if (mirror && master)
-		die("specifying a master branch makes no sense with --mirror");
+		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
-		die("specifying branches to track makes sense only with fetch mirror=
s");
+		die(_("specifying branches to track makes sense only with fetch mirr=
ors"));
=20
 	name =3D argv[0];
 	url =3D argv[1];
@@ -192,11 +192,11 @@ static int add(int argc, const char **argv)
 	remote =3D remote_get(name);
 	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
 			remote->fetch_refspec_nr))
-		die("remote %s already exists.", name);
+		die(_("remote %s already exists."), name);
=20
 	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
 	if (!valid_fetch_refspec(buf2.buf))
-		die("'%s' is not a valid remote name", name);
+		die(_("'%s' is not a valid remote name"), name);
=20
 	strbuf_addf(&buf, "remote.%s.url", name);
 	if (git_config_set(buf.buf, url))
@@ -240,7 +240,7 @@ static int add(int argc, const char **argv)
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
=20
 		if (create_symref(buf.buf, buf2.buf, "remote add"))
-			return error("Could not setup master '%s'", master);
+			return error(_("Could not setup master '%s'"), master);
 	}
=20
 	strbuf_release(&buf);
@@ -296,7 +296,7 @@ static int config_read_branches(const char *key, co=
nst char *value, void *cb)
 		info =3D item->util;
 		if (type =3D=3D REMOTE) {
 			if (info->remote_name)
-				warning("more than one %s", orig_key);
+				warning(_("more than one %s"), orig_key);
 			info->remote_name =3D xstrdup(value);
 		} else if (type =3D=3D MERGE) {
 			char *space =3D strchr(value, ' ');
@@ -336,7 +336,7 @@ static int get_ref_states(const struct ref *remote_=
refs, struct ref_states *stat
=20
 	for (i =3D 0; i < states->remote->fetch_refspec_nr; i++)
 		if (get_fetch_map(remote_refs, states->remote->fetch + i, &tail, 1))
-			die("Could not get fetch map for refspec %s",
+			die(_("Could not get fetch map for refspec %s"),
 				states->remote->fetch_refspec[i]);
=20
 	states->new.strdup_strings =3D 1;
@@ -437,7 +437,7 @@ static int get_push_ref_states_noquery(struct ref_s=
tates *states)
=20
 	states->push.strdup_strings =3D 1;
 	if (!remote->push_refspec_nr) {
-		item =3D string_list_append(&states->push, "(matching)");
+		item =3D string_list_append(&states->push, _("(matching)"));
 		info =3D item->util =3D xcalloc(sizeof(struct push_info), 1);
 		info->status =3D PUSH_STATUS_NOTQUERIED;
 		info->dest =3D xstrdup(item->string);
@@ -445,11 +445,11 @@ static int get_push_ref_states_noquery(struct ref=
_states *states)
 	for (i =3D 0; i < remote->push_refspec_nr; i++) {
 		struct refspec *spec =3D remote->push + i;
 		if (spec->matching)
-			item =3D string_list_append(&states->push, "(matching)");
+			item =3D string_list_append(&states->push, _("(matching)"));
 		else if (strlen(spec->src))
 			item =3D string_list_append(&states->push, spec->src);
 		else
-			item =3D string_list_append(&states->push, "(delete)");
+			item =3D string_list_append(&states->push, _("(delete)"));
=20
 		info =3D item->util =3D xcalloc(sizeof(struct push_info), 1);
 		info->forced =3D spec->force;
@@ -592,19 +592,19 @@ static int migrate_file(struct remote *remote)
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i =3D 0; i < remote->url_nr; i++)
 		if (git_config_set_multivar(buf.buf, remote->url[i], "^$", 0))
-			return error("Could not append '%s' to '%s'",
+			return error(_("Could not append '%s' to '%s'"),
 					remote->url[i], buf.buf);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i =3D 0; i < remote->push_refspec_nr; i++)
 		if (git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", =
0))
-			return error("Could not append '%s' to '%s'",
+			return error(_("Could not append '%s' to '%s'"),
 					remote->push_refspec[i], buf.buf);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i =3D 0; i < remote->fetch_refspec_nr; i++)
 		if (git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$",=
 0))
-			return error("Could not append '%s' to '%s'",
+			return error(_("Could not append '%s' to '%s'"),
 					remote->fetch_refspec[i], buf.buf);
 	if (remote->origin =3D=3D REMOTE_REMOTES)
 		path =3D git_path("remotes/%s", remote->name);
@@ -636,30 +636,30 @@ static int mv(int argc, const char **argv)
=20
 	oldremote =3D remote_get(rename.old);
 	if (!oldremote)
-		die("No such remote: %s", rename.old);
+		die(_("No such remote: %s"), rename.old);
=20
 	if (!strcmp(rename.old, rename.new) && oldremote->origin !=3D REMOTE_=
CONFIG)
 		return migrate_file(oldremote);
=20
 	newremote =3D remote_get(rename.new);
 	if (newremote && (newremote->url_nr > 1 || newremote->fetch_refspec_n=
r))
-		die("remote %s already exists.", rename.new);
+		die(_("remote %s already exists."), rename.new);
=20
 	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new)=
;
 	if (!valid_fetch_refspec(buf.buf))
-		die("'%s' is not a valid remote name", rename.new);
+		die(_("'%s' is not a valid remote name"), rename.new);
=20
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s", rename.old);
 	strbuf_addf(&buf2, "remote.%s", rename.new);
 	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
-		return error("Could not rename config section '%s' to '%s'",
+		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
=20
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
 	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
-		return error("Could not remove config section '%s'", buf.buf);
+		return error(_("Could not remove config section '%s'"), buf.buf);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
 	for (i =3D 0; i < oldremote->fetch_refspec_nr; i++) {
 		char *ptr;
@@ -674,13 +674,13 @@ static int mv(int argc, const char **argv)
 				      strlen(rename.old), rename.new,
 				      strlen(rename.new));
 		} else
-			warning("Not updating non-default fetch respec\n"
-				"\t%s\n"
-				"\tPlease update the configuration manually if necessary.",
+			warning(_("Not updating non-default fetch respec\n"
+				  "\t%s\n"
+				  "\tPlease update the configuration manually if necessary."),
 				buf2.buf);
=20
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
-			return error("Could not append '%s'", buf.buf);
+			return error(_("Could not append '%s'"), buf.buf);
 	}
=20
 	read_branches();
@@ -691,7 +691,7 @@ static int mv(int argc, const char **argv)
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
 			if (git_config_set(buf.buf, rename.new)) {
-				return error("Could not set '%s'", buf.buf);
+				return error(_("Could not set '%s'"), buf.buf);
 			}
 		}
 	}
@@ -713,7 +713,7 @@ static int mv(int argc, const char **argv)
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
-			die("deleting '%s' failed", item->string);
+			die(_("deleting '%s' failed"), item->string);
 	}
 	for (i =3D 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item =3D remote_branches.items + i;
@@ -728,7 +728,7 @@ static int mv(int argc, const char **argv)
 		strbuf_addf(&buf2, "remote: renamed %s to %s",
 				item->string, buf.buf);
 		if (rename_ref(item->string, buf.buf, buf2.buf))
-			die("renaming '%s' failed", item->string);
+			die(_("renaming '%s' failed"), item->string);
 	}
 	for (i =3D 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item =3D remote_branches.items + i;
@@ -747,7 +747,7 @@ static int mv(int argc, const char **argv)
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
 		if (create_symref(buf.buf, buf2.buf, buf3.buf))
-			die("creating '%s' failed", buf.buf);
+			die(_("creating '%s' failed"), buf.buf);
 	}
 	return 0;
 }
@@ -761,7 +761,7 @@ static int remove_branches(struct string_list *bran=
ches)
 		unsigned char *sha1 =3D item->util;
=20
 		if (delete_ref(refname, sha1, 0))
-			result |=3D error("Could not remove branch %s", refname);
+			result |=3D error(_("Could not remove branch %s"), refname);
 	}
 	return result;
 }
@@ -789,14 +789,14 @@ static int rm(int argc, const char **argv)
=20
 	remote =3D remote_get(argv[1]);
 	if (!remote)
-		die("No such remote: %s", argv[1]);
+		die(_("No such remote: %s"), argv[1]);
=20
 	known_remotes.to_delete =3D remote;
 	for_each_remote(add_known_remote, &known_remotes);
=20
 	strbuf_addf(&buf, "remote.%s", remote->name);
 	if (git_config_rename_section(buf.buf, NULL) < 1)
-		return error("Could not remove config section '%s'", buf.buf);
+		return error(_("Could not remove config section '%s'"), buf.buf);
=20
 	read_branches();
 	for (i =3D 0; i < branch_list.nr; i++) {
@@ -830,11 +830,12 @@ static int rm(int argc, const char **argv)
 	string_list_clear(&branches, 1);
=20
 	if (skipped.nr) {
-		fprintf(stderr, skipped.nr =3D=3D 1 ?
-			"Note: A branch outside the refs/remotes/ hierarchy was not removed=
;\n"
-			"to delete it, use:\n" :
-			"Note: Some branches outside the refs/remotes/ hierarchy were not r=
emoved;\n"
-			"to delete them, use:\n");
+		fprintf_ln(stderr,
+			   Q_("Note: A branch outside the refs/remotes/ hierarchy was not r=
emoved;\n"
+			      "to delete it, use:",
+			      "Note: Some branches outside the refs/remotes/ hierarchy were=
 not removed;\n"
+			      "to delete them, use:",
+			      skipped.nr));
 		for (i =3D 0; i < skipped.nr; i++)
 			fprintf(stderr, "  git branch -d %s\n",
 				skipped.items[i].string);
@@ -886,7 +887,7 @@ static int get_remote_ref_states(const char *name,
=20
 	states->remote =3D remote_get(name);
 	if (!states->remote)
-		return error("No such remote: %s", name);
+		return error(_("No such remote: %s"), name);
=20
 	read_branches();
=20
@@ -939,14 +940,14 @@ static int show_remote_info_item(struct string_li=
st_item *item, void *cb_data)
 		const char *fmt =3D "%s";
 		const char *arg =3D "";
 		if (string_list_has_string(&states->new, name)) {
-			fmt =3D " new (next fetch will store in remotes/%s)";
+			fmt =3D _(" new (next fetch will store in remotes/%s)");
 			arg =3D states->remote->name;
 		} else if (string_list_has_string(&states->tracked, name))
-			arg =3D " tracked";
+			arg =3D _(" tracked");
 		else if (string_list_has_string(&states->stale, name))
-			arg =3D " stale (use 'git remote prune' to remove)";
+			arg =3D _(" stale (use 'git remote prune' to remove)");
 		else
-			arg =3D " ???";
+			arg =3D _(" ???");
 		printf("    %-*s", info->width, name);
 		printf(fmt, arg);
 		printf("\n");
@@ -987,21 +988,21 @@ static int show_local_info_item(struct string_lis=
t_item *item, void *cb_data)
 	int i;
=20
 	if (branch_info->rebase && branch_info->merge.nr > 1) {
-		error("invalid branch.%s.merge; cannot rebase onto > 1 branch",
+		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
 			item->string);
 		return 0;
 	}
=20
 	printf("    %-*s ", show_info->width, item->string);
 	if (branch_info->rebase) {
-		printf("rebases onto remote %s\n", merge->items[0].string);
+		printf_ln(_("rebases onto remote %s"), merge->items[0].string);
 		return 0;
 	} else if (show_info->any_rebase) {
-		printf(" merges with remote %s\n", merge->items[0].string);
-		also =3D "    and with remote";
+		printf_ln(_(" merges with remote %s"), merge->items[0].string);
+		also =3D _("    and with remote");
 	} else {
-		printf("merges with remote %s\n", merge->items[0].string);
-		also =3D "   and with remote";
+		printf_ln(_("merges with remote %s"), merge->items[0].string);
+		also =3D _("   and with remote");
 	}
 	for (i =3D 1; i < merge->nr; i++)
 		printf("    %-*s %s %s\n", show_info->width, "", also,
@@ -1043,36 +1044,43 @@ static int show_push_info_item(struct string_li=
st_item *item, void *cb_data)
 {
 	struct show_info *show_info =3D cb_data;
 	struct push_info *push_info =3D item->util;
-	char *src =3D item->string, *status =3D NULL;
+	const char *src =3D item->string, *status =3D NULL;
=20
 	switch (push_info->status) {
 	case PUSH_STATUS_CREATE:
-		status =3D "create";
+		status =3D _("create");
 		break;
 	case PUSH_STATUS_DELETE:
-		status =3D "delete";
-		src =3D "(none)";
+		status =3D _("delete");
+		src =3D _("(none)");
 		break;
 	case PUSH_STATUS_UPTODATE:
-		status =3D "up to date";
+		status =3D _("up to date");
 		break;
 	case PUSH_STATUS_FASTFORWARD:
-		status =3D "fast-forwardable";
+		status =3D _("fast-forwardable");
 		break;
 	case PUSH_STATUS_OUTOFDATE:
-		status =3D "local out of date";
+		status =3D _("local out of date");
 		break;
 	case PUSH_STATUS_NOTQUERIED:
 		break;
 	}
-	if (status)
-		printf("    %-*s %s to %-*s (%s)\n", show_info->width, src,
-			push_info->forced ? "forces" : "pushes",
-			show_info->width2, push_info->dest, status);
-	else
-		printf("    %-*s %s to %s\n", show_info->width, src,
-			push_info->forced ? "forces" : "pushes",
-			push_info->dest);
+	if (status) {
+		if (push_info->forced)
+			printf_ln(_("    %-*s forces to %-*s (%s)"), show_info->width, src,
+			       show_info->width2, push_info->dest, status);
+		else
+			printf_ln(_("    %-*s pushes to %-*s (%s)"), show_info->width, src,
+			       show_info->width2, push_info->dest, status);
+	} else {
+		if (push_info->forced)
+			printf_ln(_("    %-*s forces to %s"), show_info->width, src,
+			       push_info->dest);
+		else
+			printf_ln(_("    %-*s pushes to %s"), show_info->width, src,
+			       push_info->dest);
+	}
 	return 0;
 }
=20
@@ -1107,9 +1115,9 @@ static int show(int argc, const char **argv)
=20
 		get_remote_ref_states(*argv, &states, query_flag);
=20
-		printf("* remote %s\n", *argv);
-		printf("  Fetch URL: %s\n", states.remote->url_nr > 0 ?
-			states.remote->url[0] : "(no URL)");
+		printf_ln(_("* remote %s"), *argv);
+		printf_ln(_("  Fetch URL: %s"), states.remote->url_nr > 0 ?
+		       states.remote->url[0] : _("(no URL)"));
 		if (states.remote->pushurl_nr) {
 			url =3D states.remote->pushurl;
 			url_nr =3D states.remote->pushurl_nr;
@@ -1118,18 +1126,18 @@ static int show(int argc, const char **argv)
 			url_nr =3D states.remote->url_nr;
 		}
 		for (i =3D 0; i < url_nr; i++)
-			printf("  Push  URL: %s\n", url[i]);
+			printf_ln(_("  Push  URL: %s"), url[i]);
 		if (!i)
-			printf("  Push  URL: %s\n", "(no URL)");
+			printf_ln(_("  Push  URL: %s"), "(no URL)");
 		if (no_query)
-			printf("  HEAD branch: (not queried)\n");
+			printf_ln(_("  HEAD branch: %s"), "(not queried)");
 		else if (!states.heads.nr)
-			printf("  HEAD branch: (unknown)\n");
+			printf_ln(_("  HEAD branch: %s"), "(unknown)");
 		else if (states.heads.nr =3D=3D 1)
-			printf("  HEAD branch: %s\n", states.heads.items[0].string);
+			printf_ln(_("  HEAD branch: %s"), states.heads.items[0].string);
 		else {
-			printf("  HEAD branch (remote HEAD is ambiguous,"
-			       " may be one of the following):\n");
+			printf(_("  HEAD branch (remote HEAD is ambiguous,"
+				 " may be one of the following):\n"));
 			for (i =3D 0; i < states.heads.nr; i++)
 				printf("    %s\n", states.heads.items[i].string);
 		}
@@ -1140,9 +1148,10 @@ static int show(int argc, const char **argv)
 		for_each_string_list(&states.tracked, add_remote_to_show_info, &info=
);
 		for_each_string_list(&states.stale, add_remote_to_show_info, &info);
 		if (info.list->nr)
-			printf("  Remote branch%s:%s\n",
-			       info.list->nr > 1 ? "es" : "",
-				no_query ? " (status not queried)" : "");
+			printf_ln(Q_("  Remote branch:%s",
+				     "  Remote branches:%s",
+				     info.list->nr),
+				  no_query ? _(" (status not queried)") : "");
 		for_each_string_list(info.list, show_remote_info_item, &info);
 		string_list_clear(info.list, 0);
=20
@@ -1151,23 +1160,25 @@ static int show(int argc, const char **argv)
 		info.any_rebase =3D 0;
 		for_each_string_list(&branch_list, add_local_to_show_info, &info);
 		if (info.list->nr)
-			printf("  Local branch%s configured for 'git pull':\n",
-			       info.list->nr > 1 ? "es" : "");
+			printf_ln(Q_("  Local branch configured for 'git pull':",
+				     "  Local branches configured for 'git pull':",
+				     info.list->nr));
 		for_each_string_list(info.list, show_local_info_item, &info);
 		string_list_clear(info.list, 0);
=20
 		/* git push info */
 		if (states.remote->mirror)
-			printf("  Local refs will be mirrored by 'git push'\n");
+			printf_ln(_("  Local refs will be mirrored by 'git push'"));
=20
 		info.width =3D info.width2 =3D 0;
 		for_each_string_list(&states.push, add_push_to_show_info, &info);
 		qsort(info.list->items, info.list->nr,
 			sizeof(*info.list->items), cmp_string_with_push);
 		if (info.list->nr)
-			printf("  Local ref%s configured for 'git push'%s:\n",
-				info.list->nr > 1 ? "s" : "",
-				no_query ? " (status not queried)" : "");
+			printf_ln(Q_("  Local ref configured for 'git push'%s:",
+				     "  Local refs configured for 'git push'%s:",
+				     info.list->nr),
+				  no_query ? _(" (status not queried)") : "");
 		for_each_string_list(info.list, show_push_info_item, &info);
 		string_list_clear(info.list, 0);
=20
@@ -1202,10 +1213,10 @@ static int set_head(int argc, const char **argv=
)
 		memset(&states, 0, sizeof(states));
 		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
 		if (!states.heads.nr)
-			result |=3D error("Cannot determine remote HEAD");
+			result |=3D error(_("Cannot determine remote HEAD"));
 		else if (states.heads.nr > 1) {
-			result |=3D error("Multiple remote HEAD branches. "
-					"Please choose one explicitly with:");
+			result |=3D error(_("Multiple remote HEAD branches. "
+					  "Please choose one explicitly with:"));
 			for (i =3D 0; i < states.heads.nr; i++)
 				fprintf(stderr, "  git remote set-head %s %s\n",
 					argv[0], states.heads.items[i].string);
@@ -1214,7 +1225,7 @@ static int set_head(int argc, const char **argv)
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc =3D=3D 1) {
 		if (delete_ref(buf.buf, NULL, REF_NODEREF))
-			result |=3D error("Could not delete %s", buf.buf);
+			result |=3D error(_("Could not delete %s"), buf.buf);
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
=20
@@ -1222,9 +1233,9 @@ static int set_head(int argc, const char **argv)
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
 		if (!ref_exists(buf2.buf))
-			result |=3D error("Not a valid ref: %s", buf2.buf);
+			result |=3D error(_("Not a valid ref: %s"), buf2.buf);
 		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
-			result |=3D error("Could not setup %s", buf.buf);
+			result |=3D error(_("Could not setup %s"), buf.buf);
 		if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
@@ -1260,18 +1271,18 @@ static int prune_remote(const char *remote, int=
 dry_run)
 	int result =3D 0, i;
 	struct ref_states states;
 	const char *dangling_msg =3D dry_run
-		? " %s will become dangling!"
-		: " %s has become dangling!";
+		? _(" %s will become dangling!")
+		: _(" %s has become dangling!");
=20
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
=20
 	if (states.stale.nr) {
-		printf("Pruning %s\n", remote);
-		printf("URL: %s\n",
+		printf_ln(_("Pruning %s"), remote);
+		printf_ln(_("URL: %s"),
 		       states.remote->url_nr
 		       ? states.remote->url[0]
-		       : "(no URL)");
+		       : _("(no URL)"));
 	}
=20
 	for (i =3D 0; i < states.stale.nr; i++) {
@@ -1280,8 +1291,12 @@ static int prune_remote(const char *remote, int =
dry_run)
 		if (!dry_run)
 			result |=3D delete_ref(refname, NULL, 0);
=20
-		printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
-		       abbrev_ref(refname, "refs/remotes/"));
+		if (dry_run)
+			printf_ln(_(" * [would prune] %s"),
+			       abbrev_ref(refname, "refs/remotes/"));
+		else
+			printf_ln(_(" * [pruned] %s"),
+			       abbrev_ref(refname, "refs/remotes/"));
 		warn_dangling_symref(stdout, dangling_msg, refname);
 	}
=20
@@ -1369,7 +1384,7 @@ static int set_remote_branches(const char *remote=
name, const char **branches,
 	strbuf_addf(&key, "remote.%s.fetch", remotename);
=20
 	if (!remote_is_configured(remotename))
-		die("No such remote '%s'", remotename);
+		die(_("No such remote '%s'"), remotename);
 	remote =3D remote_get(remotename);
=20
 	if (!add_mode && remove_all_fetch_refspecs(remotename, key.buf)) {
@@ -1396,7 +1411,7 @@ static int set_branches(int argc, const char **ar=
gv)
 	argc =3D parse_options(argc, argv, NULL, options,
 			     builtin_remote_setbranches_usage, 0);
 	if (argc =3D=3D 0) {
-		error("no remote specified");
+		error(_("no remote specified"));
 		usage_with_options(builtin_remote_setbranches_usage, options);
 	}
 	argv[argc] =3D NULL;
@@ -1429,7 +1444,7 @@ static int set_url(int argc, const char **argv)
 			     PARSE_OPT_KEEP_ARGV0);
=20
 	if (add_mode && delete_mode)
-		die("--add --delete doesn't make sense");
+		die(_("--add --delete doesn't make sense"));
=20
 	if (argc < 3 || argc > 4 || ((add_mode || delete_mode) && argc !=3D 3=
))
 		usage_with_options(builtin_remote_seturl_usage, options);
@@ -1443,7 +1458,7 @@ static int set_url(int argc, const char **argv)
 		oldurl =3D newurl;
=20
 	if (!remote_is_configured(remotename))
-		die("No such remote '%s'", remotename);
+		die(_("No such remote '%s'"), remotename);
 	remote =3D remote_get(remotename);
=20
 	if (push_mode) {
@@ -1469,7 +1484,7 @@ static int set_url(int argc, const char **argv)
=20
 	/* Old URL specified. Demand that one matches. */
 	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
-		die("Invalid old URL pattern: %s", oldurl);
+		die(_("Invalid old URL pattern: %s"), oldurl);
=20
 	for (i =3D 0; i < urlset_nr; i++)
 		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
@@ -1477,9 +1492,9 @@ static int set_url(int argc, const char **argv)
 		else
 			negative_matches++;
 	if (!delete_mode && !matches)
-		die("No such URL found: %s", oldurl);
+		die(_("No such URL found: %s"), oldurl);
 	if (delete_mode && !negative_matches && !push_mode)
-		die("Will not delete all non-push URLs");
+		die(_("Will not delete all non-push URLs"));
=20
 	regfree(&old_regex);
=20
@@ -1580,7 +1595,7 @@ int cmd_remote(int argc, const char **argv, const=
 char *prefix)
 	else if (!strcmp(argv[0], "update"))
 		result =3D update(argc, argv);
 	else {
-		error("Unknown subcommand: %s", argv[0]);
+		error(_("Unknown subcommand: %s"), argv[0]);
 		usage_with_options(builtin_remote_usage, options);
 	}
=20
--=20
1.7.8.36.g69ee2

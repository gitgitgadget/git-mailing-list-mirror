From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 63/72] gettextize: git-describe basic messages
Date: Sat, 19 Feb 2011 19:24:46 +0000
Message-ID: <1298143495-3681-64-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTs-0003Eb-6u
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab1BST22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:28 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41519 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab1BST2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:23 -0500
Received: by ewy5 with SMTP id 5so1970574ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8Y084cNTgf0iYJlGmc8vzESRoSOWPb6u3cpT1a3P+ec=;
        b=NJlTQS4hpVvKsz61rWrPoXSuRNmgbeuGfh2cztqUFDKgUspqHx2/2QksQ1ZSjKEHnS
         3ZFmVfezd6qPlPksXCq7hjQ+QN8R4XLr9bbUd0rVsNyORCTzkFsMXwpHV6pfFLaP+Hty
         nBOBJlvve2IL1rUimfz2yaY+ZGUnsfD1ryPJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eBbCxbtkvo3VIgz8u5jDT61Qcgl2dQsOm0YG92S8FidZfUe0l1iHAspr87jITC7xKB
         Qu2nF6O1CexpZvRzc6YqDX/t26oItSBY5rC8rKTUnI6j8iGLtnHZd4kocCI/pynddPOv
         kZy4nNlOrjfY1LkkVz3hcNz1bAIY3xWdPiQx0=
Received: by 10.14.45.15 with SMTP id o15mr2417946eeb.46.1298143699845;
        Sat, 19 Feb 2011 11:28:19 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.19
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:19 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167340>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/describe.c  |   36 ++++++++++++++++++------------------
 t/t6120-describe.sh |    2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 342129f..037691e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -231,13 +231,13 @@ static void display_name(struct commit_name *n)
 	if (n->prio =3D=3D 2 && !n->tag) {
 		n->tag =3D lookup_tag(n->sha1);
 		if (!n->tag || parse_tag(n->tag))
-			die("annotated tag %s not available", n->path);
+			die(_("annotated tag %s not available"), n->path);
 	}
 	if (n->tag && !n->name_checked) {
 		if (!n->tag->tag)
-			die("annotated tag %s has no embedded name", n->path);
+			die(_("annotated tag %s has no embedded name"), n->path);
 		if (strcmp(n->tag->tag, all ? n->path + 5 : n->path))
-			warning("tag '%s' is really '%s' here", n->tag->tag, n->path);
+			warning(_("tag '%s' is really '%s' here"), n->tag->tag, n->path);
 		n->name_checked =3D 1;
 	}
=20
@@ -264,10 +264,10 @@ static void describe(const char *arg, int last_on=
e)
 	unsigned int unannotated_cnt =3D 0;
=20
 	if (get_sha1(arg, sha1))
-		die("Not a valid object name %s", arg);
+		die(_("Not a valid object name %s"), arg);
 	cmit =3D lookup_commit_reference(sha1);
 	if (!cmit)
-		die("%s is not a valid '%s' object", arg, commit_type);
+		die(_("%s is not a valid '%s' object"), arg, commit_type);
=20
 	n =3D find_commit_name(cmit->object.sha1);
 	if (n && (tags || all || n->prio =3D=3D 2)) {
@@ -284,9 +284,9 @@ static void describe(const char *arg, int last_one)
 	}
=20
 	if (!max_candidates)
-		die("no tag exactly matches '%s'", sha1_to_hex(cmit->object.sha1));
+		die(_("no tag exactly matches '%s'"), sha1_to_hex(cmit->object.sha1)=
);
 	if (debug)
-		fprintf(stderr, "searching to describe %s\n", arg);
+		fprintf(stderr, _("searching to describe %s\n"), arg);
=20
 	if (!have_util) {
 		for_each_hash(&names, set_util);
@@ -326,7 +326,7 @@ static void describe(const char *arg, int last_one)
 		}
 		if (annotated_cnt && !list) {
 			if (debug)
-				fprintf(stderr, "finished search at %s\n",
+				fprintf(stderr, _("finished search at %s\n"),
 					sha1_to_hex(c->object.sha1));
 			break;
 		}
@@ -350,12 +350,12 @@ static void describe(const char *arg, int last_on=
e)
 			return;
 		}
 		if (unannotated_cnt)
-			die("No annotated tags can describe '%s'.\n"
-			    "However, there were unannotated tags: try --tags.",
+			die(_("No annotated tags can describe '%s'.\n"
+			    "However, there were unannotated tags: try --tags."),
 			    sha1_to_hex(sha1));
 		else
-			die("No tags can describe '%s'.\n"
-			    "Try --always, or create some tags.",
+			die(_("No tags can describe '%s'.\n"
+			    "Try --always, or create some tags."),
 			    sha1_to_hex(sha1));
 	}
=20
@@ -375,11 +375,11 @@ static void describe(const char *arg, int last_on=
e)
 				prio_names[t->name->prio],
 				t->depth, t->name->path);
 		}
-		fprintf(stderr, "traversed %lu commits\n", seen_commits);
+		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
 		if (gave_up_on) {
 			fprintf(stderr,
-				"more than %i tags found; listed %i most recent\n"
-				"gave up search at %s\n",
+				_("more than %i tags found; listed %i most recent\n"
+				"gave up search at %s\n"),
 				max_candidates, max_candidates,
 				sha1_to_hex(gave_up_on->object.sha1));
 		}
@@ -429,7 +429,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 	save_commit_buffer =3D 0;
=20
 	if (longformat && abbrev =3D=3D 0)
-		die("--long is incompatible with --abbrev=3D0");
+		die(_("--long is incompatible with --abbrev=3D0"));
=20
 	if (contains) {
 		const char **args =3D xmalloc((7 + argc) * sizeof(char *));
@@ -455,14 +455,14 @@ int cmd_describe(int argc, const char **argv, con=
st char *prefix)
 	init_hash(&names);
 	for_each_rawref(get_name, NULL);
 	if (!names.nr && !always)
-		die("No names found, cannot describe anything.");
+		die(_("No names found, cannot describe anything."));
=20
 	if (argc =3D=3D 0) {
 		if (dirty && !cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1, diff_i=
ndex_args, prefix))
 			dirty =3D NULL;
 		describe("HEAD", 1);
 	} else if (dirty) {
-		die("--dirty is incompatible with committishes");
+		die(_("--dirty is incompatible with committishes"));
 	} else {
 		while (argc-- > 0) {
 			describe(*argv++, argc =3D=3D 0);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 876d1ab..210b9a2 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -123,7 +123,7 @@ cat - >err.expect <<EOF
 warning: tag 'A' is really 'Q' here
 EOF
 check_describe A-* HEAD
-test_expect_success 'warning was displayed for Q' '
+test_expect_success NO_GETTEXT_POISON 'warning was displayed for Q' '
 	test_cmp err.expect err.actual
 '
 test_expect_success 'rename tag Q back to A' '
--=20
1.7.2.3

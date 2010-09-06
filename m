From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/15] gettextize: git-describe basic messages
Date: Mon,  6 Sep 2010 12:21:34 +0000
Message-ID: <1283775704-29440-6-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:22:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osais-0000aR-8d
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab0IFMWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab0IFMWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:18 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so6463612wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5AIM9SJTtt6r+z83AEUTNGlHCPT0b1NoUgAmw2CE2dc=;
        b=PcePAbXtY/A66tW/VDz6CjdowvNQ1ILeza7lrbaHdakt2uWfPkaQ7W3fZaw+eg7Zpx
         FQIUyJ5WAGj0pS9KqsvP/eW3aQalCfiuUYEtrKeszwlKHKncl2yEKxulLNxEAydwgYxn
         o1e2Xbn13I1B0X13n2KQ8JBRS9ROy/UxR/VMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YCn5F2OGxbMUSANjMbaeX328pZ6lgdrCxZG6QBRLp1JbSuG5h45ZIKZaP4yh1i8M0B
         2MHDxUzHeFvMN/aRbi2Ozmk6LFK/xZwX5sQ5po27sqM+IqjkI/yhk1vMt/C3A05APtwP
         9Ro/u/hKpCoe8o+K1EZQCN/c/qfeg9OOUeevk=
Received: by 10.227.141.138 with SMTP id m10mr245414wbu.20.1283775737973;
        Mon, 06 Sep 2010 05:22:17 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155553>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/describe.c  |   36 ++++++++++++++++++------------------
 t/t6120-describe.sh |    2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..616d405 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -202,13 +202,13 @@ static void display_name(struct commit_name *n)
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
@@ -235,10 +235,10 @@ static void describe(const char *arg, int last_on=
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
 	n =3D cmit->util;
 	if (n && (tags || all || n->prio =3D=3D 2)) {
@@ -255,9 +255,9 @@ static void describe(const char *arg, int last_one)
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
 	list =3D NULL;
 	cmit->object.flags =3D SEEN;
@@ -292,7 +292,7 @@ static void describe(const char *arg, int last_one)
 		}
 		if (annotated_cnt && !list) {
 			if (debug)
-				fprintf(stderr, "finished search at %s\n",
+				fprintf(stderr, _("finished search at %s\n"),
 					sha1_to_hex(c->object.sha1));
 			break;
 		}
@@ -316,12 +316,12 @@ static void describe(const char *arg, int last_on=
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
@@ -341,11 +341,11 @@ static void describe(const char *arg, int last_on=
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
@@ -395,7 +395,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 	save_commit_buffer =3D 0;
=20
 	if (longformat && abbrev =3D=3D 0)
-		die("--long is incompatible with --abbrev=3D0");
+		die(_("--long is incompatible with --abbrev=3D0"));
=20
 	if (contains) {
 		const char **args =3D xmalloc((7 + argc) * sizeof(char *));
@@ -420,14 +420,14 @@ int cmd_describe(int argc, const char **argv, con=
st char *prefix)
=20
 	for_each_ref(get_name, NULL);
 	if (!found_names && !always)
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
1.7.2.3.313.gcd15

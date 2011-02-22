From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 64/73] gettextize: git-describe basic messages
Date: Tue, 22 Feb 2011 23:42:23 +0000
Message-ID: <1298418152-27789-65-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 01:00:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps298-0007by-NG
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab1BVX7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:59:53 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:62101 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab1BVX7w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:59:52 -0500
Received: by bwz10 with SMTP id 10so3878147bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QEyPULyV8fqS2g8TVzLzWShaQhalIimPesBN2d09VyU=;
        b=wqoOuPArVHnlgM3mJKgBJf1p4zq4xy7QOoFHOIrtNSDUiR20NEX4bIybdEZNpu8XLb
         TXjROZZusODL2J76bixStmHML7qk7kSA2L5kVZtdEBZX2sY3gG8RxBk6bvfdE+zsAziZ
         nXrHbtXB6teTsBbSQfKMdFKsj2oIKagucLP8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HlE/grblSHKfKyf9hFuPCDvhWBYdHMBwZXioob3ddmCbeSGLpBdaPLrxqcbA+EdifN
         t4nYgL8YUUaG/9m3ndI3AvdgvVB6YY67QRaOLA4zzBQVQcRf3d1kVuMmbujKm5yqLq9a
         KvIcUNrmqqxuRmPcEqMkF7nu7xCy5SAqngCYE=
Received: by 10.204.72.71 with SMTP id l7mr3005058bkj.55.1298418276171;
        Tue, 22 Feb 2011 15:44:36 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.35
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:35 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167665>

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
index 876d1ab..1826996 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -123,7 +123,7 @@ cat - >err.expect <<EOF
 warning: tag 'A' is really 'Q' here
 EOF
 check_describe A-* HEAD
-test_expect_success 'warning was displayed for Q' '
+test_expect_success C_LOCALE_OUTPUT 'warning was displayed for Q' '
 	test_cmp err.expect err.actual
 '
 test_expect_success 'rename tag Q back to A' '
--=20
1.7.2.3

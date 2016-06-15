From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 10/10] tag: add --column
Date: Tue, 28 Feb 2012 18:58:51 +0700
Message-ID: <1330430331-19945-11-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 13:01:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2LkS-0006pF-TG
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 13:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965552Ab2B1MBf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 07:01:35 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65198 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965476Ab2B1MBe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 07:01:34 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so2267772dae.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 04:01:34 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.74.97 as permitted sender) client-ip=10.68.74.97;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.74.97 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.74.97])
        by 10.68.74.97 with SMTP id s1mr53035164pbv.46.1330430494780 (num_hops = 1);
        Tue, 28 Feb 2012 04:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WVQhgHGo7TtEmZWhPpdHz0QJ2ajbbeC2eFUPLM9Eb2I=;
        b=tWnY8AFVfSJ0PT/MMdV8aktnRGX8r9aWiP94dbleuumgyrN6c38zAXGWNWb9E0w8zl
         Yq5uEGYYhOW+Tor5RhGj61JMB5u/uPvfxiM/14gf6lQZtIGe2pY4rwpBGTorspl2d95N
         5q8pb0tQIaQ9sUW5x1nkngYobcLJQTCW1S1XM=
Received: by 10.68.74.97 with SMTP id s1mr44744939pbv.46.1330430494734;
        Tue, 28 Feb 2012 04:01:34 -0800 (PST)
Received: from tre ([115.74.56.186])
        by mx.google.com with ESMTPS id l1sm15523913pbs.34.2012.02.28.04.01.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 04:01:32 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 28 Feb 2012 19:01:39 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191724>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt  |    4 ++++
 Documentation/git-tag.txt |    9 +++++++++
 Makefile                  |    2 +-
 builtin/tag.c             |   26 +++++++++++++++++++++++---
 t/t7004-tag.sh            |   44 +++++++++++++++++++++++++++++++++++++=
+++++++
 5 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ebb210c..145336a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -855,6 +855,10 @@ column.status::
 	Specify whether to output untracked files in `git status` in columns.
 	See `column.ui` for details.
=20
+column.tag::
+	Specify whether to output tag listing in `git tag` in columns.
+	See `column.ui` for details.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8d32b9a..e36a7c3 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
+	[--column[=3D<options>] | --no-column] [<pattern>...]
 	[<pattern>...]
 'git tag' -v <tagname>...
=20
@@ -84,6 +85,14 @@ OPTIONS
 	using fnmatch(3)).  Multiple patterns may be given; if any of
 	them matches, the tag is shown.
=20
+--column[=3D<options>]::
+--no-column::
+	Display tag listing in columns. See configuration variable
+	column.tag for option syntax.`--column` and `--no-column`
+	without options are equivalent to 'always' and 'never' respectively.
++
+This option is only applicable when listing tags without annotation li=
nes.
+
 --contains <commit>::
 	Only list tags which contain the specified commit.
=20
diff --git a/Makefile b/Makefile
index d9c5f00..65fc6b9 100644
--- a/Makefile
+++ b/Makefile
@@ -2168,7 +2168,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
-builtin/branch.o builtin/commit.o column.o help.o pager.o: column.h
+builtin/branch.o builtin/commit.o builtin/tag.o column.o help.o pager.=
o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/tag.c b/builtin/tag.c
index fe7e5e5..e99cbff 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -16,6 +16,7 @@
 #include "revision.h"
 #include "gpg-interface.h"
 #include "sha1-array.h"
+#include "column.h"
=20
 static const char * const git_tag_usage[] =3D {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<he=
ad>]",
@@ -33,6 +34,7 @@ struct tag_filter {
 };
=20
 static struct sha1_array points_at;
+static unsigned int colopts;
=20
 static int match_pattern(const char **patterns, const char *ref)
 {
@@ -263,6 +265,8 @@ static int git_tag_config(const char *var, const ch=
ar *value, void *cb)
 	int status =3D git_gpg_config(var, value, cb);
 	if (status)
 		return status;
+	if (!prefixcmp(var, "column."))
+		return git_column_config(var, value, "tag", &colopts);
 	return git_default_config(var, value, cb);
 }
=20
@@ -459,6 +463,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		OPT_STRING('u', "local-user", &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
+		OPT_COLUMN(0, "column", &colopts, "show tag list in columns"),
=20
 		OPT_GROUP("Tag listing options"),
 		{
@@ -495,9 +500,24 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
-	if (list)
-		return list_tags(argv, lines =3D=3D -1 ? 0 : lines,
-				 with_commit);
+	if (list && lines !=3D -1) {
+		if (explicitly_enable_column(colopts))
+			die(_("--column and -n are incompatible"));
+		colopts =3D 0;
+	}
+	if (list) {
+		int ret;
+		if (colopts & COL_ENABLED) {
+			struct column_options copts;
+			memset(&copts, 0, sizeof(copts));
+			copts.padding =3D 2;
+			run_column_filter(colopts, &copts);
+		}
+		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit);
+		if (colopts & COL_ENABLED)
+			stop_column_filter();
+		return ret;
+	}
 	if (lines !=3D -1)
 		die(_("-n option is only allowed with -l."));
 	if (with_commit)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f8c247a..5189446 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -263,6 +263,50 @@ test_expect_success 'tag -l can accept multiple pa=
tterns' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'listing tags in column' '
+	COLUMNS=3D40 git tag -l --column=3Drow >actual &&
+	cat >expected <<\EOF &&
+a1      aa1     cba     t210    t211
+v0.2.1  v1.0    v1.0.1  v1.1.3
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'listing tags in column with column.*' '
+	git config column.tag row &&
+	git config column.ui dense &&
+	COLUMNS=3D40 git tag -l >actual &&
+	git config --unset column.ui &&
+	git config --unset column.tag &&
+	cat >expected <<\EOF &&
+a1      aa1   cba     t210    t211
+v0.2.1  v1.0  v1.0.1  v1.1.3
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'listing tag with -n --column should fail' '
+	test_must_fail git tag --column -n
+'
+
+test_expect_success 'listing tags -n in column with column.ui ignored'=
 '
+	git config column.ui "row dense" &&
+	COLUMNS=3D40 git tag -l -n >actual &&
+	git config --unset column.ui &&
+	cat >expected <<\EOF &&
+a1              Foo
+aa1             Foo
+cba             Foo
+t210            Foo
+t211            Foo
+v0.2.1          Foo
+v1.0            Foo
+v1.0.1          Foo
+v1.1.3          Foo
+EOF
+	test_cmp expected actual
+'
+
 # creating and verifying lightweight tags:
=20
 test_expect_success \
--=20
1.7.8.36.g69ee2

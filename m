From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 06/9] branch: add --column
Date: Tue, 13 Mar 2012 19:09:18 +0700
Message-ID: <dc618ca926bdbdbb96ae59615cbbe57cde9f763f.1331638663.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com> <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com> <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com> <28f1df2d0cc13d69fa571600c4723094b6fe514b.1331638663.git.pclouds@gmail.com> <dfa792c463da82097de69b1fba5dc54147dd1951.1331638663.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QVt-0005sh-P6
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815Ab2CMMHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:07:01 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59624 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764Ab2CMMG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:06:59 -0400
Received: by mail-pz0-f52.google.com with SMTP id p12so885281dad.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=29Ho22FddTERYul17JXKO3bmbwWBlHHktPQKdfFoHnw=;
        b=bSM7OYSc0yIBqseGVsBbDaMdMfnBt2eT5dWTcUwlkleu5X0KatJppwJ4ZJu6Hn9Q+T
         kAG0IJ4nEKpatOoGemItKoU9FfMa6dj/ys9tX0A2ei6anQEZpqiRh3CzUNc4Zw5eNbyH
         MwU3/STN4ZUPIWMPasMMY/iMfaFEkzsdp1vpwbrWL+yZ7xNO4/XUhZ3g8XjmalljM8jz
         eLa8CMSW56r73dysZ9xoX4yGfYRNB5ut+cro4aY7M/TeYq74LCq/JDWqstYBJE+JJ6nv
         P1Nc/kgEY7GN77SqIhCf4iMgNJroGTsYnuXcrm7wxif/zBZfke4QNALyilbLtlsehMED
         fsIA==
Received: by 10.68.216.3 with SMTP id om3mr4888270pbc.18.1331640419426;
        Tue, 13 Mar 2012 05:06:59 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id 9sm628288pbx.67.2012.03.13.05.06.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:06:57 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:10:06 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <dfa792c463da82097de69b1fba5dc54147dd1951.1331638663.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193006>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt     |    4 ++
 Documentation/git-branch.txt |    9 +++++
 Makefile                     |    2 +-
 builtin/branch.c             |   32 +++++++++++++++--
 t/t3200-branch.sh            |   77 ++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index aacf8ab..31878b7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -847,6 +847,10 @@ column.ui::
 +
 	This option defaults to 'never'.
=20
+column.branch::
+	Specify whether to output branch listing in `git branch` in columns.
+	See `column.ui` for details.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 0427e80..ba5cccb 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git branch' [--color[=3D<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=3D<length> | --no-abbrev]]
+	[--column[=3D<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branch=
name> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -107,6 +108,14 @@ OPTIONS
 	default to color output.
 	Same as `--color=3Dnever`.
=20
+--column[=3D<options>]::
+--no-column::
+	Display branch listing in columns. See configuration variable
+	column.branch for option syntax.`--column` and `--no-column`
+	without options are equivalent to 'always' and 'never' respectively.
++
+This option is only applicable in non-verbose mode.
+
 -r::
 --remotes::
 	List or delete (if used with -d) the remote-tracking branches.
diff --git a/Makefile b/Makefile
index 0998f0d..320d3f8 100644
--- a/Makefile
+++ b/Makefile
@@ -2168,7 +2168,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
-column.o help.o pager.o: column.h
+builtin/branch.o column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index cb17bc3..2da0168 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -15,6 +15,8 @@
 #include "branch.h"
 #include "diff.h"
 #include "revision.h"
+#include "string-list.h"
+#include "column.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -53,6 +55,9 @@ static enum merge_filter {
 } merge_filter;
 static unsigned char merge_filter_ref[20];
=20
+static struct string_list output =3D STRING_LIST_INIT_DUP;
+static unsigned int colopts;
+
 static int parse_branch_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -70,6 +75,8 @@ static int parse_branch_color_slot(const char *var, i=
nt ofs)
=20
 static int git_branch_config(const char *var, const char *value, void =
*cb)
 {
+	if (!prefixcmp(var, "column."))
+		return git_column_config(var, value, "branch", &colopts);
 	if (!strcmp(var, "color.branch")) {
 		branch_use_color =3D git_config_colorbool(var, value);
 		return 0;
@@ -474,7 +481,12 @@ static void print_ref_item(struct ref_item *item, =
int maxwidth, int verbose,
 	else if (verbose)
 		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
 		add_verbose_info(&out, item, verbose, abbrev);
-	printf("%s\n", out.buf);
+	if (COL_ENABLE(colopts)) {
+		assert(!verbose && "--column and --verbose are incompatible");
+		string_list_append(&output, out.buf);
+	} else {
+		printf("%s\n", out.buf);
+	}
 	strbuf_release(&name);
 	strbuf_release(&out);
 }
@@ -727,6 +739,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
+		OPT_COLUMN(0, "column", &colopts, "list branches in columns"),
 		OPT_END(),
 	};
=20
@@ -749,6 +762,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 	}
 	hashcpy(merge_filter_ref, head_sha1);
=20
+
 	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_us=
age,
 			     0);
=20
@@ -760,12 +774,22 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
=20
 	if (abbrev =3D=3D -1)
 		abbrev =3D DEFAULT_ABBREV;
+	finalize_colopts(&colopts, -1);
+	if (verbose) {
+		if (explicitly_enable_column(colopts))
+			die(_("--column and --verbose are incompatible"));
+		colopts =3D 0;
+	}
=20
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (list)
-		return print_ref_list(kinds, detached, verbose, abbrev,
-				      with_commit, argv);
+	else if (list) {
+		int ret =3D print_ref_list(kinds, detached, verbose, abbrev,
+					 with_commit, argv);
+		print_columns(&output, colopts, NULL);
+		string_list_clear(&output, 0);
+		return ret;
+	}
 	else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref =3D STRBUF_INIT;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd1aceb..9f82d5e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -160,6 +160,83 @@ test_expect_success 'git branch --list -d t should=
 fail' '
 	test_path_is_missing .git/refs/heads/t
 '
=20
+test_expect_success 'git branch --column' '
+	COLUMNS=3D81 git branch --column=3Dcolumn >actual &&
+	cat >expected <<\EOF &&
+  a/b/c     bam       foo       l       * master    n         o/p     =
  r
+  abc       bar       j/k       m/m       master2   o/o       q
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'git branch --column with an extremely long branch=
 name' '
+	long=3Dthis/is/a/part/of/long/branch/name &&
+	long=3Dz$long/$long/$long/$long &&
+	test_when_finished "git branch -d $long" &&
+	git branch $long &&
+	COLUMNS=3D80 git branch --column=3Dcolumn >actual &&
+	cat >expected <<EOF &&
+  a/b/c
+  abc
+  bam
+  bar
+  foo
+  j/k
+  l
+  m/m
+* master
+  master2
+  n
+  o/o
+  o/p
+  q
+  r
+  $long
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'git branch with column.*' '
+	git config column.ui column &&
+	git config column.branch "dense" &&
+	COLUMNS=3D80 git branch >actual &&
+	git config --unset column.branch &&
+	git config --unset column.ui &&
+	cat >expected <<\EOF &&
+  a/b/c   bam   foo   l   * master    n     o/p   r
+  abc     bar   j/k   m/m   master2   o/o   q
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'git branch --column -v should fail' '
+	test_must_fail git branch --column -v
+'
+
+test_expect_success 'git branch -v with column.ui ignored' '
+	git config column.ui column &&
+	COLUMNS=3D80 git branch -v | cut -c -10 | sed "s/ *$//" >actual &&
+	git config --unset column.ui &&
+	cat >expected <<\EOF &&
+  a/b/c
+  abc
+  bam
+  bar
+  foo
+  j/k
+  l
+  m/m
+* master
+  master2
+  n
+  o/o
+  o/p
+  q
+  r
+EOF
+	test_cmp expected actual
+'
+
 mv .git/config .git/config-saved
=20
 test_expect_success 'git branch -m q q2 without config should succeed'=
 '
--=20
1.7.8.36.g69ee2

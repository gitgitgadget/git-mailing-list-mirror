From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/9] tag: add --column
Date: Sun, 20 Mar 2011 19:57:52 +0700
Message-ID: <1300625873-18435-9-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:59:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1IEI-0003H7-Mx
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab1CTM7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:59:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36472 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab1CTM73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:59:29 -0400
Received: by iwn34 with SMTP id 34so5554378iwn.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=LyqQhmU0wx0Ok5coaZsspe36dC3c5Bl/A9h/9ggjDYk=;
        b=jyqEIUcrKMS7s0iJwvOuvvJIUWA1WJgCBkLEbqzHcoAu+jsJ3QNtAKhv27I0ATOJ1j
         k3nOLgRumYLeoEMmSEUx9zYtBd2dJfBu//WJTjhFyBpwx8SbWKC7JzB1N+CqVc61+Ln1
         jrtg8Oud0A9HcvmUrRixkHlDeA3I2MVZxFN4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VFoMvp/ZRMOJMTEGYgXsqTX/qPeVBhPzZgZW89lAXKftBEF6OGrGiBaALty+c6Liip
         JQvUAlKwClz3Tsk7/nyhyIAknuxL6SgXXx02Ld+yNCyntH+Q3pInIQHZ5PPl4D9yFo+e
         QNc1sES/lf8F1KGvPSm4He5vNNz672cMue284=
Received: by 10.231.187.232 with SMTP id cx40mr3076784ibb.73.1300625968504;
        Sun, 20 Mar 2011 05:59:28 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id g17sm690792ibb.57.2011.03.20.05.59.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:59:27 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:59:18 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169510>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-tag.txt |   11 ++++++++++-
 Makefile                  |    2 +-
 builtin/tag.c             |   21 +++++++++++++++++----
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8b169e3..0260eea 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
+'git tag' [-n[<num>]] -l [--column[=3D<options>] | --no-column]
+	[--contains <commit>] [<pattern>]
 'git tag' -v <tagname>...
=20
 DESCRIPTION
@@ -71,6 +72,14 @@ OPTIONS
 	List tags with names that match the given pattern (or all if no patte=
rn is given).
 	Typing "git tag" without arguments, also lists all tags.
=20
+--column[=3D<options>]::
+--no-column::
+	Override column.ui settings. See linkgit:git-config.txt[1] for
+	syntax. `--column` and `--no-column` without options are
+	equivalent to 'always' and 'never' respectively. This option
+	is only applicable if `git tag` is used to list tags without
+	annotation lines.
+
 --contains <commit>::
 	Only list tags which contain the specified commit.
=20
diff --git a/Makefile b/Makefile
index ba9944b..e1823dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1958,7 +1958,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
-column.o help.o pager.o: column.h
+builtin/tag.o column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/tag.c b/builtin/tag.c
index aa1f87d..cdf0f74 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -12,6 +12,8 @@
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "string-list.h"
+#include "column.h"
=20
 static const char * const git_tag_usage[] =3D {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<he=
ad>]",
@@ -22,6 +24,8 @@ static const char * const git_tag_usage[] =3D {
 };
=20
 static char signingkey[1000];
+static struct string_list output =3D STRING_LIST_INIT_DUP;
+static int column_mode;
=20
 struct tag_filter {
 	const char *pattern;
@@ -52,7 +56,7 @@ static int show_reference(const char *refname, const =
unsigned char *sha1,
 		}
=20
 		if (!filter->lines) {
-			printf("%s\n", refname);
+			add_to_columns(&output, column_mode, refname);
 			return 0;
 		}
 		printf("%-15s ", refname);
@@ -233,7 +237,7 @@ static int git_tag_config(const char *var, const ch=
ar *value, void *cb)
 		return 0;
 	}
=20
-	return git_default_config(var, value, cb);
+	return git_column_default_config(var, value, cb);
 }
=20
 static void write_tag_body(int fd, const unsigned char *sha1)
@@ -383,6 +387,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
+		OPT_COLUMN(0, "column", &column_mode, "show tag list in columns" ),
=20
 		OPT_GROUP("Tag listing options"),
 		{
@@ -395,6 +400,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	};
=20
 	git_config(git_tag_config, NULL);
+	column_mode =3D git_core_column;
=20
 	argc =3D parse_options(argc, argv, prefix, options, git_tag_usage, 0)=
;
=20
@@ -413,9 +419,16 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
-	if (list)
-		return list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
+	if (list) {
+		int ret;
+
+		if (lines !=3D -1)
+			column_mode =3D 0;
+		ret =3D  list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
 				 with_commit);
+		display_columns(&output, column_mode, term_columns(), 2, "");
+		return ret;
+	}
 	if (lines !=3D -1)
 		die("-n option is only allowed with -l.");
 	if (with_commit)
--=20
1.7.4.74.g639db

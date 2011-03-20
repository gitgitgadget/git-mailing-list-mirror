From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 9/9] branch: add --column
Date: Sun, 20 Mar 2011 19:57:53 +0700
Message-ID: <1300625873-18435-10-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:59:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1IES-0003KU-FP
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab1CTM7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:59:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57792 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab1CTM7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:59:39 -0400
Received: by mail-iy0-f174.google.com with SMTP id 26so5552163iyb.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=IJhWUuds65U++NXqULHYMbplwjquVQIzW1WiMzTcDEE=;
        b=ZZwDm2Au0kNWh3oGr1dGiIhAxbIb0MYDshRU2ZE0+ckYD1ANBafFJ2YW5r4mN5/v0E
         ojG/A+CsFYu3Dk2gdG8CMXoL0FD/TR98xhivMnDDgbj2WLZldnLdxpbHAxMjPU70JbOC
         3Eea7CVWK4SFF25Vj2z5YtHxCEQMr5AQu9prE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cXtXjR9/4CDEcVyFm3RLS4oB4WxrfRWQpNuyftPE6vTTTOXxP0nyWraYsPHnGgn/FY
         JoLOy/a94pPTslk3dsyPOfNjEiaEhsp8tgCXTYzqR7zKy5LU7yUBqAQiSO8CosyWsZZv
         UuLAo1OUANCg6MGIRcAwHPk8m34CDmcf8TatE=
Received: by 10.43.45.2 with SMTP id ui2mr5140165icb.70.1300625978789;
        Sun, 20 Mar 2011 05:59:38 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id g17sm687872ibb.6.2011.03.20.05.59.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:59:37 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:59:29 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169511>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-branch.txt |    9 +++++++++
 Makefile                     |    2 +-
 builtin/branch.c             |   23 +++++++++++++++++++----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 9106d38..a7bf4a8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=3D<when>] | --no-color] [-r | -a]
+	[--column[=3D<options>] | --no-column]
 	[-v [--abbrev=3D<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branch=
name> [<start-point>]
@@ -99,6 +100,14 @@ OPTIONS
 	default to color output.
 	Same as `--color=3Dnever`.
=20
+--column[=3D<options>]::
+--no-column::
+	Override column.ui settings. See linkgit:git-config.txt[1] for
+	syntax. `--column` and `--no-column` without options are
+	equivalent to 'always' and 'never' respectively. This option
+	is only applicable if `git tag` is used to list tags without
+	annotation lines.
+
 -r::
 	List or delete (if used with -d) the remote-tracking branches.
=20
diff --git a/Makefile b/Makefile
index e1823dd..92c49ac 100644
--- a/Makefile
+++ b/Makefile
@@ -1958,7 +1958,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
-builtin/tag.o column.o help.o pager.o: column.h
+builtin/branch.o builtin/tag.o column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index 9e546e4..ff94192 100644
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
+static int column_mode;
+
 static int parse_branch_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -83,7 +88,7 @@ static int git_branch_config(const char *var, const c=
har *value, void *cb)
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
 	}
-	return git_color_default_config(var, value, cb);
+	return git_column_default_config(var, value, cb);
 }
=20
 static const char *branch_get_color(enum color_branch ix)
@@ -451,7 +456,7 @@ static void print_ref_item(struct ref_item *item, i=
nt maxwidth, int verbose,
 		strbuf_release(&stat);
 		strbuf_release(&subject);
 	}
-	printf("%s\n", out.buf);
+	add_to_columns(&output, column_mode, out.buf);
 	strbuf_release(&name);
 	strbuf_release(&out);
 }
@@ -660,6 +665,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
+		OPT_COLUMN(0, "column", &column_mode, "list branches in columns" ),
 		OPT_END(),
 	};
=20
@@ -686,6 +692,8 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 	}
 	hashcpy(merge_filter_ref, head_sha1);
=20
+	column_mode =3D git_core_column | COL_ANSI;
+
 	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_us=
age,
 			     0);
 	if (!!delete + !!rename + !!force_create > 1)
@@ -693,8 +701,15 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
=20
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc =3D=3D 0)
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit)=
;
+	else if (argc =3D=3D 0) {
+		int ret;
+		if (verbose)
+			column_mode =3D 0;
+
+		ret =3D print_ref_list(kinds, detached, verbose, abbrev, with_commit=
);
+		display_columns(&output, column_mode, term_columns(), 1, "");
+		return ret;
+	}
 	else if (rename && (argc =3D=3D 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc =3D=3D 2))
--=20
1.7.4.74.g639db

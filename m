From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 9/9] branch: add --column
Date: Mon, 21 Mar 2011 06:26:31 +0700
Message-ID: <1300663591-28102-1-git-send-email-pclouds@gmail.com>
References: <87oc557env.fsf@mithlond.arda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Mar 21 00:26:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1S1H-0005oF-JO
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 00:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab1CTX0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 19:26:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56469 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1CTX0l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 19:26:41 -0400
Received: by iyb26 with SMTP id 26so5869563iyb.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=hMps7bA3+rWFs82O8WUAEzEduV7eid0lXdU9pKY7t34=;
        b=CN9kM6utVgWOlD23h0lF863pIPC23fRilhnTMUI8+bqlxMwPiX9QLMp85Hi3gVyN4V
         H68K8/UqaQTRoQEiDLHRf2CVJ5S2Y07ZxHYuR+oTTlLzI7e/3vw13PNZiK/HdLsBQKwB
         B7Ud6NqP9tLna3riaQGN1/CtombhEdHlZws1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GxB+kZIWTK/DrOrHHGkHovJhhUlhCVvB8UQsd8dYmmK53sfWvNAFCwMY634Y3Eckx0
         tYdVsuxUzSMMvsADGIjbaijDihzd/dlh1aq0GR2RZVaQxuoNjxaufD99K1GF1D57VZoA
         F4LTWXRQK4L2o4Moey4HbXaNAOqpNp4EeUTWg=
Received: by 10.42.66.7 with SMTP id n7mr5899329ici.20.1300663600786;
        Sun, 20 Mar 2011 16:26:40 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id vr5sm1355415icb.12.2011.03.20.16.26.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 16:26:39 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Mon, 21 Mar 2011 06:26:33 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <87oc557env.fsf@mithlond.arda>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169534>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/3/21 Teemu Likonen <tlikonen@iki.fi>:
 > I admit that I have not been following the development of this featu=
re
 > but I'll confirm this anyway: Do you really mean to speak of "git ta=
g"
 > in the man page of "git branch"?
 >

 Copy/paste error. Fixed

 Documentation/git-branch.txt |    8 ++++++++
 Makefile                     |    2 +-
 builtin/branch.c             |   23 +++++++++++++++++++----
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 9106d38..f129339 100644
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
@@ -99,6 +100,13 @@ OPTIONS
 	default to color output.
 	Same as `--color=3Dnever`.
=20
+--column[=3D<options>]::
+--no-column::
+	Override column.ui settings. See linkgit:git-config.txt[1] for
+	syntax. `--column` and `--no-column` without options are
+	equivalent to 'always' and 'never' respectively. This option
+	is only applicable in non-verbose mode.
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

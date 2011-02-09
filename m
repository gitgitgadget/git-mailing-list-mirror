From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/16] branch: add --column
Date: Wed,  9 Feb 2011 19:24:38 +0700
Message-ID: <1297254284-3729-11-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn993-0007jh-HF
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab1BIM1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:27:33 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60822 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:27:33 -0500
Received: by iyj8 with SMTP id 8so93685iyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=A4GTBx4Z/KAr7S1uKuhHf32xYTYnYosvet232b0ml4g=;
        b=axWsJXCS0jD/VFq716ArxZfGxPXQ+9xdzG5chw+70h41BMwItmQwgSxMkPvmRzEW/e
         73JmCTK4wX1ghnRGGlT1z1JH2ZUCJo6/3O3y8cVLCdWtHUlWFJo6e8D21q3aSFr2rhqj
         MxC3wWgJGDXCmPOkRrlkRf6vQhg5fy0Sa6GiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=N1R2dRy1aWL0OOb48w4lpp28vHi9FHTXzhCUxgUlpexak5k6t8txUrQP78TNZMzFgJ
         pOE1NmffEy9lJFBbxTTpiiYGbznd1rXUmHtqW5NWakoo6ncujiw3dPF2s5n/r1sM4vIK
         b0B+gk4YuwhR7ATqbI1PGanLmC4e8tWQ2h9Q4=
Received: by 10.42.166.136 with SMTP id o8mr2796795icy.311.1297254452518;
        Wed, 09 Feb 2011 04:27:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id t14sm216077icd.10.2011.02.09.04.27.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:27:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:26:02 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166414>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-branch.txt |    6 ++++++
 Makefile                     |    2 +-
 builtin/branch.c             |   23 +++++++++++++++++++----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 9106d38..8a05784 100644
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
@@ -99,6 +100,11 @@ OPTIONS
 	default to color output.
 	Same as `--color=3Dnever`.
=20
+--column::
+--no-column::
+	Whether whow branches in columns. See core.column for options.
+	This option is ignored in verbose mode.
+
 -r::
 	List or delete (if used with -d) the remote-tracking branches.
=20
diff --git a/Makefile b/Makefile
index c9fd9aa..0e459e4 100644
--- a/Makefile
+++ b/Makefile
@@ -1958,7 +1958,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
-column.o pager.o help.o tag.o: column.h
+branch.o column.o pager.o help.o tag.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index 9e546e4..d3eaa00 100644
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
@@ -53,6 +55,8 @@ static enum merge_filter {
 } merge_filter;
 static unsigned char merge_filter_ref[20];
=20
+static struct string_list output;
+
 static int parse_branch_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -451,7 +455,7 @@ static void print_ref_item(struct ref_item *item, i=
nt maxwidth, int verbose,
 		strbuf_release(&stat);
 		strbuf_release(&subject);
 	}
-	printf("%s\n", out.buf);
+	string_list_append(&output, out.buf);
 	strbuf_release(&name);
 	strbuf_release(&out);
 }
@@ -609,7 +613,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 {
 	int delete =3D 0, rename =3D 0, force_create =3D 0;
 	int verbose =3D 0, abbrev =3D DEFAULT_ABBREV, detached =3D 0;
-	int reflog =3D 0;
+	int reflog =3D 0, column_mode;
 	enum branch_track track;
 	int kinds =3D REF_LOCAL_BRANCH;
 	struct commit_list *with_commit =3D NULL;
@@ -660,6 +664,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
+		OPT_COLUMN(0, "column", &column_mode, "list branches in columns" ),
 		OPT_END(),
 	};
=20
@@ -686,6 +691,9 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 	}
 	hashcpy(merge_filter_ref, head_sha1);
=20
+	column_mode =3D core_column | COL_ANSI;
+	output.strdup_strings =3D 1;
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
+			column_mode =3D COL_MODE_PLAIN;
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
1.7.2.2

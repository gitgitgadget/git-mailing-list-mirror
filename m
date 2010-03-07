From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/12] branch: support column output with --columns
Date: Sun,  7 Mar 2010 19:09:42 +0700
Message-ID: <1267963785-473-10-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFNO-0000oh-0C
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab0CGMNp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:45 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:43117 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0CGMNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:42 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so2186141pzk.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rtUl+Wf3pVcQ1/v5T7goci2E/5w245Iw9IDWdmXxNxQ=;
        b=Qx0bo2kricgxU8CQG/WYgjgWB8Zm2jsYZ89mt6xrKmSEk4wgr5LZ3fEYm6VA/s4kND
         z5is807itD5UZhGyPyGnw08BV5AKsMQ+XOC1axmcO3VImg5b5KxmTSaDlDA/yJgOzEty
         98wK6wZUyf/RDjNp8i/owqa167XJDgD6kGLuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PmYsw3jhIfbt18lECR2hkSa1IlUT1KTdK5zI+Ywj9AHd1gX4K19GY5tQo3n254OGl7
         i6gMhysA15+Qa2fEBQBP0jobZZiMpeHE295RxoYM19Oo3r31j21JWL/Lz0DLNbXxc7U4
         yD4tn3FWuXF88qw3QGwOzR5uUEaa6gXlcq85Y=
Received: by 10.143.20.13 with SMTP id x13mr2269656wfi.225.1267964021814;
        Sun, 07 Mar 2010 04:13:41 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3590551pzk.6.2010.03.07.04.13.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:25 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141685>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-branch.txt |    8 ++++++++
 builtin/branch.c             |   18 +++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 903a690..3d1d600 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=3D<when>] | --no-color] [-r | -a]
+	[--columns | --no-columns]
 	[-v [--abbrev=3D<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branch=
name> [<start-point>]
@@ -93,6 +94,13 @@ OPTIONS
 	default to color output.
 	Same as `--color=3Dnever`.
=20
+--columns::
+	Show branches in columns. This option is ignored in verbose mode.
+
+--no-columns::
+	Show branches in a single list. This option is used to override
+	core.columns if set.
+
 -r::
 	List or delete (if used with -d) the remote-tracking branches.
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index 6cf7e72..16273cb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -15,6 +15,7 @@
 #include "branch.h"
 #include "diff.h"
 #include "revision.h"
+#include "column.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -598,7 +599,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 {
 	int delete =3D 0, rename =3D 0, force_create =3D 0;
 	int verbose =3D 0, abbrev =3D DEFAULT_ABBREV, detached =3D 0;
-	int reflog =3D 0;
+	int reflog =3D 0, column_output =3D 0;
 	enum branch_track track;
 	int kinds =3D REF_LOCAL_BRANCH;
 	struct commit_list *with_commit =3D NULL;
@@ -648,10 +649,12 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
+		OPT_BOOLEAN(0, "columns", &column_output, "list branches in columns"=
),
 		OPT_END(),
 	};
=20
 	git_config(git_branch_config, NULL);
+	column_output =3D core_column_output;
=20
 	if (branch_use_color =3D=3D -1)
 		branch_use_color =3D git_use_color_default;
@@ -678,8 +681,17 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
=20
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc =3D=3D 0)
-		print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+	else if (argc =3D=3D 0) {
+		if (verbose)
+			print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		else {
+			if (column_output)
+				start_columnizer(NULL);
+			print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+			if (column_output)
+				stop_columnizer();
+		}
+	}
 	else if (rename && (argc =3D=3D 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc =3D=3D 2))
--=20
1.7.0.1.370.gd3c5

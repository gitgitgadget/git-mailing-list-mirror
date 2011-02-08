From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] branch: support column output with --column
Date: Tue,  8 Feb 2011 22:22:21 +0700
Message-ID: <1297178541-31124-8-git-send-email-pclouds@gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 16:24:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmpQz-00078h-Ap
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 16:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868Ab1BHPYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 10:24:45 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56065 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1BHPYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 10:24:44 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so1139311pva.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 07:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=uQeOYx/fBNIQ+ccr/DmClx2ilRSGUK8fXNzu81lgfNY=;
        b=iW8Dsh1x/2sIpJj+Rp2vZbi4T4js36i2ka/oQwZnQOH0Cvk9HDjyGZjWR4/mEbSzZA
         C+ubke48qUUuXut6YfyFZczylGez5fNItVK4Aid2vNpu5b+MiU2dq5uzN2ytBugwLgut
         gjcEJQjTVLGOnE8Y/lqH6828heZJ5tCyIw5wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kLOznuEzm72n3/Ia6BF+YBgZfDAlTaC+deRI6QfaLjOadF9BjBOqXUpRVtdmrgI2MX
         U/VRK/tfpacO4gFWH4ltIpRgUOW8vvZbFkBDeYc3aMuCU33W3pZjgG97aSBL3wjRKNJW
         VoOghP8EjoYyslIsGYKiXEVzzXOghucP90pTk=
Received: by 10.142.179.4 with SMTP id b4mr17329749wff.222.1297178684348;
        Tue, 08 Feb 2011 07:24:44 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id f5sm7714346wfo.4.2011.02.08.07.24.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 07:24:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Feb 2011 22:23:15 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166359>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-branch.txt |    8 ++++++++
 builtin/branch.c             |   22 +++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 9106d38..3ec997a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=3D<when>] | --no-color] [-r | -a]
+	[--[no-]column[=3D<options>[,<option>]*]]
 	[-v [--abbrev=3D<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branch=
name> [<start-point>]
@@ -99,6 +100,13 @@ OPTIONS
 	default to color output.
 	Same as `--color=3Dnever`.
=20
+--column::
+	Show branches in columns. This option is ignored in verbose mode.
+
+--no-column::
+	Show branches in a single list. This option is used to override
+	core.columns if set.
+
 -r::
 	List or delete (if used with -d) the remote-tracking branches.
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index 9e546e4..803fa5f 100644
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
@@ -53,6 +54,8 @@ static enum merge_filter {
 } merge_filter;
 static unsigned char merge_filter_ref[20];
=20
+static struct column_layout layout;
+
 static int parse_branch_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -451,7 +454,7 @@ static void print_ref_item(struct ref_item *item, i=
nt maxwidth, int verbose,
 		strbuf_release(&stat);
 		strbuf_release(&subject);
 	}
-	printf("%s\n", out.buf);
+	string_list_append(&layout.items, out.buf);
 	strbuf_release(&name);
 	strbuf_release(&out);
 }
@@ -660,6 +663,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
+		OPT_COLUMN(0, "column", &layout, "list branches in columns" ),
 		OPT_END(),
 	};
=20
@@ -686,6 +690,11 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 	}
 	hashcpy(merge_filter_ref, head_sha1);
=20
+	memset(&layout, 0, sizeof(layout));
+	layout.mode =3D core_column;
+	layout.width =3D term_columns();
+	layout.items.strdup_strings =3D 1;
+
 	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_us=
age,
 			     0);
 	if (!!delete + !!rename + !!force_create > 1)
@@ -693,8 +702,15 @@ int cmd_branch(int argc, const char **argv, const =
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
+			layout.mode =3D COL_PLAIN;
+
+		ret =3D print_ref_list(kinds, detached, verbose, abbrev, with_commit=
);
+		display_columns(&layout, 2, "");
+		return ret;
+	}
 	else if (rename && (argc =3D=3D 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc =3D=3D 2))
--=20
1.7.2.2

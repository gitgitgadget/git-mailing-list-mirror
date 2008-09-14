From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/16] ls-files: add --narrow-match=spec option for testing narrow matching
Date: Sun, 14 Sep 2008 20:08:02 +0700
Message-ID: <1221397685-27715-14-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
 <1221397685-27715-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerNX-00064f-SE
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbYINNJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbYINNJz
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:09:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203AbYINNJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:09:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fIlrDfJETBgaaO9Ow7xDvVGER0/+R05IAHYYkUg/Fio=;
        b=duzFxy8Yj0P/jGS9wvtwvc7Di3fIfl50faMgY/vg3Du5ad3TXGJLb7BXqjn1OvA8LY
         XVZbqmqtlH0kOF5MgnAv/PXctoc0ieLPS/bQvsHyDDdfSySNTgeh0tOiNLU9mP0VTKwG
         3SCQS/HyYZxH+XY5KaAT3HeBkyxcOG3wNVfYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m8eJUfXbRYGw3Gu1qfVFSB50RoGkqvpZfJlBMGEhd9pteC9saj5LvDqtTOUmgMoqvO
         FGV+ObOZM1QogxjH5fLRSTmXSUpmdUGDQlHUMZoTYdqy4iEZjTp4B7bVBMirsAq0o1vA
         iilXCALcmNK1anazBTSGeHGHdw8PeSqHZepk0=
Received: by 10.142.174.8 with SMTP id w8mr2267389wfe.33.1221397793381;
        Sun, 14 Sep 2008 06:09:53 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 24sm20047857wfc.6.2008.09.14.06.09.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:09:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:09:44 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-13-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95840>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt   |    7 +++++-
 builtin-ls-files.c               |   14 +++++++++++-
 t/t3003-ls-files-narrow-match.sh |   45 ++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100755 t/t3003-ls-files-narrow-match.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index f74b212..4f5a37e 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git ls-files' [-z] [-t] [-v]
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])\*
 		(-[c|d|o|i|s|u|k|m])\*
-		[--narrow-checkout]
+		[--narrow-checkout] [--narrow-match=3D<narrow_spec>]
 		[-x <pattern>|--exclude=3D<pattern>]
 		[-X <file>|--exclude-from=3D<file>]
 		[--exclude-per-directory=3D<file>]
@@ -78,6 +78,11 @@ OPTIONS
 	index-based selection options like --cached or --stage, only narrowed
 	portion will be printed out.
=20
+--narrow-match=3D<narrow_spec>::
+	Narrow spec can be applied on ls-files output so that you can test
+	your spec. Can only be used with --cached. See linkgit:git-checkout[1=
]
+	for more information about narrow spec.
+
 -z::
 	\0 line termination on output.
=20
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 02fa00b..f48a157 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -10,6 +10,8 @@
 #include "dir.h"
 #include "builtin.h"
 #include "tree.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -29,6 +31,7 @@ static const char **pathspec;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
+static const char *narrow_spec;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -248,6 +251,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 				continue;
 			if (narrow_checkout && ce_no_checkout(ce))
 				continue;
+			if (narrow_spec && !match_narrow_spec(narrow_spec, ce->name, prefix=
))
+				continue;
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
@@ -427,7 +432,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, int prefix_
=20
 static const char ls_files_usage[] =3D
 	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged=
|killed|modified])* "
-	"[ --narrow-checkout ] "
+	"[ --narrow-checkout ] [--narrow-match=3D<narrow_spec>] "
 	"[ --ignored ] [--exclude=3D<pattern>] [--exclude-from=3D<file>] "
 	"[ --exclude-per-directory=3D<filename> ] [--exclude-standard] "
 	"[--full-name] [--abbrev] [--] [<file>]*";
@@ -473,6 +478,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			narrow_checkout =3D 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--narrow-match=3D")) {
+			narrow_spec =3D arg+15;
+			continue;
+		}
 		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted =3D 1;
 			continue;
@@ -607,6 +616,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 	if (narrow_checkout && !show_cached && !show_stage)
 		die("ls-files: --narrow-checkout can only be used with either --cach=
ed or --stage");
=20
+	if (narrow_spec && !show_cached && !show_stage)
+		die("ls-files: --narrow-match can only be used with either --cached =
or --stage");
+
 	read_cache();
 	if (prefix)
 		prune_cache(prefix);
diff --git a/t/t3003-ls-files-narrow-match.sh b/t/t3003-ls-files-narrow=
-match.sh
new file mode 100755
index 0000000..b48fdb2
--- /dev/null
+++ b/t/t3003-ls-files-narrow-match.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description=3D'This test is for narrow spec matching'
+
+. test-lib.sh
+
+test_expect_success 'setup' '
+	touch 1 2 3 &&
+	mkdir -p sub/subsub &&
+	touch sub/1 sub/2 sub/3 &&
+	touch sub/subsub/1 sub/subsub/2 sub/subsub/3 &&
+	git add .
+'
+
+test_expect_success 'exact matches' '
+	test "$(git ls-files --narrow-match=3D1)" =3D 1 &&
+	test -z "$(git ls-files --narrow-match=3Dsub)" && # exact match on a =
directory gives nothing
+	(cd sub &&
+	test "$(git ls-files --full-name --narrow-match=3Dsubsub/1)" =3D sub/=
subsub/1 &&
+	test "$(git ls-files --narrow-match=3Dsubsub/1)" =3D subsub/1)
+'
+
+test_expect_success 'star matches' '
+	test "$(git ls-files --narrow-match=3D\*1)" =3D 1 &&
+	(cd sub &&
+	test "$(git ls-files --full-name --narrow-match=3Dsubsub/\*1)" =3D su=
b/subsub/1 &&
+	test "$(git ls-files --narrow-match=3Dsubsub/\*1)" =3D subsub/1)
+'
+
+cat >starplus-1.expected <<\EOF
+1
+sub/1
+sub/subsub/1
+EOF
+cat >starplus-2.expected <<\EOF
+sub/1
+sub/subsub/1
+EOF
+test_expect_success 'starplus matches' '
+	git ls-files --narrow-match=3D+\*1 | cmp starplus-1.expected
+	(cd sub &&
+	git ls-files --full-name --narrow-match=3D+\*1 | cmp ../starplus-2.ex=
pected)
+'
+
+test_done
--=20
1.6.0.96.g2fad1.dirty

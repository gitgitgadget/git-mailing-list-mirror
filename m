From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/16] ls-files: add --overlay option
Date: Sun, 14 Sep 2008 20:08:05 +0700
Message-ID: <1221397685-27715-17-git-send-email-pclouds@gmail.com>
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
 <1221397685-27715-14-git-send-email-pclouds@gmail.com>
 <1221397685-27715-15-git-send-email-pclouds@gmail.com>
 <1221397685-27715-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerNs-00069e-JB
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbYINNKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbYINNKT
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:10:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbYINNKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:10:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vky8EDdKRZQVOIQlhXQvFxel9A1pYHeGYAmvWeS24K8=;
        b=NBDUzVU8wi9OkOKL50L/Bc/2I7/QMIoqjSAcxSNoL8SeKO74PF8OFECIBNaI8M0sY7
         kLrWwE7dAmiAViErCE8MAsWZlgOvtO05h8NsL15UdhxmN2J5LemFQsnE06FW98kN2t4j
         jNxFOGg/CjWli3Qxt8X6TVO4jbWc7HxGNDmAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xUeSAEqnRjN2BG06n/SoPp2X1KMRsMAly8lAPaGC/2F+YHvdD1/Lhd+7RrC4aXWRE2
         MuacLoBSsrzVbauy8c7a50IDG480HQyDFKXqUFtFdXcouJZXAGQY1w32Re+lvIEUHuvp
         kQkfpQsb6uXbF9E/DVtJfPUYfHQn2wUSIxYJw=
Received: by 10.142.185.13 with SMTP id i13mr2255960wff.219.1221397817184;
        Sun, 14 Sep 2008 06:10:17 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 28sm19633922wfd.4.2008.09.14.06.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:10:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:10:09 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-16-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95843>

Narrow checkout mode introduces an interesting case: some files
are not to be checked out (marked CE_NO_CHECKOUT in index) but still
exist in working directory. Those files will be ignored by Git unless
explicitly specified. In Clearcase, these files are called "eclipsed".
I would call them "overlay" for now. Any better term is welcome.

The same situation happens for "assume unchanged" bit, but I would
expect narrow checkout to be more user-friendly and should notify users
these cases so users will not be confused. On this first step, users
may check by themselves with "git ls-files --overlay", further steps
may make the information visible from "git status".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt |    4 ++++
 builtin-ls-files.c             |   16 +++++++++++++---
 t/t2104-update-index-narrow.sh |    4 ++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 4f5a37e..9e749ef 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -56,6 +56,9 @@ OPTIONS
 --stage::
 	Show staged contents' object name, mode bits and stage number in the =
output.
=20
+--overlay::
+	Show files that are marked no-checkout but exist in working directory=
=2E
+
 --directory::
 	If a whole directory is classified as "other", show just its
 	name (with a trailing slash) and not its whole contents.
@@ -122,6 +125,7 @@ OPTIONS
 	R::	removed/deleted
 	C::	modified/changed
 	K::	to be killed
+	!::	overlay files
 	?::	other
=20
 -v::
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f48a157..6e55207 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -20,6 +20,7 @@ static int show_others;
 static int show_stage;
 static int show_unmerged;
 static int show_modified;
+static int show_overlay;
 static int show_killed;
 static int show_valid_bit;
 static int narrow_checkout;
@@ -39,6 +40,7 @@ static const char *tag_removed =3D "";
 static const char *tag_other =3D "";
 static const char *tag_killed =3D "";
 static const char *tag_modified =3D "";
+static const char *tag_overlay =3D "";
=20
=20
 /*
@@ -256,7 +258,7 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
-	if (show_deleted | show_modified) {
+	if (show_deleted | show_modified | show_overlay) {
 		for (i =3D 0; i < active_nr; i++) {
 			struct cache_entry *ce =3D active_cache[i];
 			struct stat st;
@@ -265,6 +267,8 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 			if (excluded(dir, ce->name, &dtype) !=3D dir->show_ignored)
 				continue;
 			err =3D lstat(ce->name, &st);
+			if (show_overlay && ce_no_checkout(ce) && !err)
+				show_ce_entry(tag_overlay, ce);
 			if (show_deleted && err && ce_checkout(ce))
 				show_ce_entry(tag_removed, ce);
 			if (show_modified && ce_modified(ce, &st, 0))
@@ -431,7 +435,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, int prefix_
 }
=20
 static const char ls_files_usage[] =3D
-	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged=
|killed|modified])* "
+	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged=
|killed|modified|overlay])* "
 	"[ --narrow-checkout ] [--narrow-match=3D<narrow_spec>] "
 	"[ --ignored ] [--exclude=3D<pattern>] [--exclude-from=3D<file>] "
 	"[ --exclude-per-directory=3D<filename> ] [--exclude-standard] "
@@ -466,6 +470,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 			tag_modified =3D "C ";
 			tag_other =3D "? ";
 			tag_killed =3D "K ";
+			tag_overlay =3D "! ";
 			if (arg[1] =3D=3D 'v')
 				show_valid_bit =3D 1;
 			continue;
@@ -491,6 +496,11 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			require_work_tree =3D 1;
 			continue;
 		}
+		if (!strcmp(arg, "--overlay")) {
+			show_overlay =3D 1;
+			require_work_tree =3D 1;
+			continue;
+		}
 		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
 			show_others =3D 1;
 			require_work_tree =3D 1;
@@ -610,7 +620,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
=20
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
-	      show_killed | show_modified))
+	      show_killed | show_modified | show_overlay))
 		show_cached =3D 1;
=20
 	if (narrow_checkout && !show_cached && !show_stage)
diff --git a/t/t2104-update-index-narrow.sh b/t/t2104-update-index-narr=
ow.sh
index 1a3acdd..79da418 100755
--- a/t/t2104-update-index-narrow.sh
+++ b/t/t2104-update-index-narrow.sh
@@ -31,6 +31,10 @@ test_expect_success 'ls-files --deleted ignores no-c=
heckout entries' '
 	touch 1
 '
=20
+test_expect_success 'there are overlay entries' '
+	test "$(git ls-files --overlay|grep 1|wc -l)" =3D 2
+'
+
 test_expect_success 'update-index --checkout' '
 	git update-index --checkout 1 sub/1 &&
 	test "$(git ls-files)" =3D "$(git ls-files --narrow-checkout)"'
--=20
1.6.0.96.g2fad1.dirty

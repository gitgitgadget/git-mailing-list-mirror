From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/9] update-index: add --checkout/--no-checkout to update CE_NO_CHECKOUT bit
Date: Wed,  1 Oct 2008 11:04:05 +0700
Message-ID: <1222833849-22129-6-git-send-email-pclouds@gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
 <1222833849-22129-3-git-send-email-pclouds@gmail.com>
 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
 <1222833849-22129-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:06:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkszG-0001ME-Mz
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 06:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbYJAEFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 00:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbYJAEFm
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 00:05:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:63785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYJAEFl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 00:05:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so384855rvb.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=M2OOZIHLHfM5EaPmic8AVc5ZAHDSc2JuPdhuDEYjC3I=;
        b=oZdRYPOmdK5e+cOhNnmIkn3Tsr1K4nwYWLclG+Wr+vy0NOYC0MkCB5zc/whXIDtdhf
         +sJ/8LgZ+fZ7xsSM8+aDixtg4ZDxR3k/3sg5RIMBhTOXs9wjDzlQx1aGK4jSphFMwghn
         7iXTrRkpgQpqJQ5KzZPM/MybXza4BKHkQ/zeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PCvUWlNh42gBZYOPF6L4sOiL0pI/o1mz/BHwIj9nrZbn2DOyjhmghOykpXPlW5J1MI
         RRxZoYYictRJCSW9tdB9ay36TmhZT7UjoOvrAyomiD5xf1AUy2F5d/hOGXtNE80sDia6
         92JCd/vtHJqedl0aKRTBOVMG5UNIBj7mCOIRE=
Received: by 10.141.210.13 with SMTP id m13mr4042901rvq.25.1222833941520;
        Tue, 30 Sep 2008 21:05:41 -0700 (PDT)
Received: from pclouds@gmail.com ([117.5.46.240])
        by mx.google.com with ESMTPS id f21sm3955331rvb.5.2008.09.30.21.05.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 21:05:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  1 Oct 2008 11:05:34 +0700
X-Mailer: git-send-email 1.6.0.2.488.gf604a
In-Reply-To: <1222833849-22129-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97196>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                          |    1 +
 Documentation/git-checkout.txt      |    3 +-
 Documentation/git-update-index.txt  |   13 ++++++++++++
 Makefile                            |    2 +-
 builtin-update-index.c              |   16 ++++++++++++++-
 t/t2104-update-index-no-checkout.sh |   36 +++++++++++++++++++++++++++=
++++++++
 test-index-version.c                |   14 +++++++++++++
 7 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100755 t/t2104-update-index-no-checkout.sh
 create mode 100644 test-index-version.c

diff --git a/.gitignore b/.gitignore
index bbaf9de..0c35577 100644
--- a/.gitignore
+++ b/.gitignore
@@ -147,6 +147,7 @@ test-date
 test-delta
 test-dump-cache-tree
 test-genrandom
+test-index-version
 test-match-trees
 test-parse-options
 test-path-utils
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 4bd9eba..2b344e1 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -196,7 +196,8 @@ to index, it will be marked "checkout" unless spars=
e patterns are
 applied.  Unmerged files are always "checkout". When you checkout new
 files using "git checkout <file>" they will be automatically marked
 "checkout". Other commands such as "git apply" can also checkout new
-files if they are needed.
+files if they are needed. linkgit:git-update-index[1] can be used to
+update "checkout/no-checkout" status in index.
=20
 "No-checkout" status is very similar to "assume-unchanged bit"
 (see linkgit:git-update-index[1]). The main difference between them
diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 1d9d81a..ec03e05 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=3D(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
+	     [--checkout | --no-checkout]
 	     [--ignore-submodules]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
@@ -99,6 +100,18 @@ in the index e.g. when merging in a commit;
 thus, in case the assumed-untracked file is changed upstream,
 you will need to handle the situation manually.
=20
+--checkout::
+--no-checkout::
+	When one of these flags is specified, the object name recorded
+	for the paths are not updated. Instead, these options
+	set and unset the "no-checkout" bit for the paths. This
+	bit is used for marking files for sparse checkout. If
+	a path is marked "no-checkout", then it should not be
+	checked out unless requested by user or needed for a git
+	command to function.
+	See linkgit:git-checkout[1] for more information about
+	sparse checkout.
+
 -g::
 --again::
 	Runs 'git-update-index' itself on the paths whose index
diff --git a/Makefile b/Makefile
index e0c03c3..edb33cb 100644
--- a/Makefile
+++ b/Makefile
@@ -1327,7 +1327,7 @@ endif
=20
 ### Testing rules
=20
-TEST_PROGRAMS =3D test-chmtime$X test-genrandom$X test-date$X test-del=
ta$X test-sha1$X test-match-trees$X test-parse-options$X test-path-util=
s$X
+TEST_PROGRAMS =3D test-chmtime$X test-genrandom$X test-date$X test-del=
ta$X test-sha1$X test-match-trees$X test-parse-options$X test-path-util=
s$X test-index-version$X
=20
 all:: $(TEST_PROGRAMS)
=20
diff --git a/builtin-update-index.c b/builtin-update-index.c
index ae94739..7514aff 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -24,6 +24,7 @@ static int info_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only;
+static int mark_no_checkout_only;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
=20
@@ -276,6 +277,11 @@ static void update_one(const char *path, const cha=
r *prefix, int prefix_length)
 			die("Unable to mark file %s", path);
 		goto free_return;
 	}
+	if (mark_no_checkout_only) {
+		if (mark_ce_flags(p, CE_NO_CHECKOUT, mark_no_checkout_only =3D=3D MA=
RK_FLAG))
+			die("Unable to mark file %s", path);
+		goto free_return;
+	}
=20
 	if (force_remove) {
 		if (remove_file_from_cache(p))
@@ -386,7 +392,7 @@ static void read_index_info(int line_termination)
 }
=20
 static const char update_index_usage[] =3D
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--u=
nresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file=
>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--checkout|--no-checkout] [--info-only] [--force-remove] [-=
-stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] =
[-z] [--verbose] [--] <file>...";
=20
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
@@ -652,6 +658,14 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
 				mark_valid_only =3D UNMARK_FLAG;
 				continue;
 			}
+			if (!strcmp(path, "--checkout")) {
+				mark_no_checkout_only =3D UNMARK_FLAG;
+				continue;
+			}
+			if (!strcmp(path, "--no-checkout")) {
+				mark_no_checkout_only =3D MARK_FLAG;
+				continue;
+			}
 			if (!strcmp(path, "--info-only")) {
 				info_only =3D 1;
 				continue;
diff --git a/t/t2104-update-index-no-checkout.sh b/t/t2104-update-index=
-no-checkout.sh
new file mode 100755
index 0000000..be9f913
--- /dev/null
+++ b/t/t2104-update-index-no-checkout.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
+#
+
+test_description=3D'git update-index no-checkout bits (a.k.a sparse ch=
eckout)'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir sub &&
+	touch 1 2 sub/1 sub/2 &&
+	git add 1 2 sub/1 sub/2
+'
+
+test_expect_success 'index is at version 2' '
+	test "$(test-index-version < .git/index)" =3D 2
+'
+
+test_expect_success 'update-index --no-checkout' '
+	git update-index --no-checkout 1 sub/1 &&
+	test -z "$(git ls-files --sparse|grep 1)"'
+
+test_expect_success 'index is at version 3 after having some no-checko=
ut entries' '
+	test "$(test-index-version < .git/index)" =3D 3
+'
+
+test_expect_success 'update-index --checkout' '
+	git update-index --checkout 1 sub/1 &&
+	test "$(git ls-files)" =3D "$(git ls-files --sparse)"'
+
+test_expect_success 'index version is back to 2 when there is no no-ch=
eckout entry' '
+	test "$(test-index-version < .git/index)" =3D 2
+'
+
+test_done
diff --git a/test-index-version.c b/test-index-version.c
new file mode 100644
index 0000000..bfaad9e
--- /dev/null
+++ b/test-index-version.c
@@ -0,0 +1,14 @@
+#include "cache.h"
+
+int main(int argc, const char **argv)
+{
+	struct cache_header hdr;
+	int version;
+
+	memset(&hdr,0,sizeof(hdr));
+	if (read(0, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
+		return 0;
+	version =3D ntohl(hdr.hdr_version);
+	printf("%d\n", version);
+	return 0;
+}
--=20
1.6.0.2.488.gf604a

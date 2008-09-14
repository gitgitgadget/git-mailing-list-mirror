From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/16] clone: support narrow checkout with --path option
Date: Sun, 14 Sep 2008 20:08:03 +0700
Message-ID: <1221397685-27715-15-git-send-email-pclouds@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerNh-00067D-KX
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYINNKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754220AbYINNKF
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:10:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226AbYINNKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:10:03 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/uakA1lyX1C/cXcobVj5bNmK58+YFQRNfEQ9JpwRn88=;
        b=cw6hMXfC7wDE5ruX0udJ4hUiJx0evozjSzlmsuAbwqHGdZhIGyvccKcfQwV7uOURvC
         +c/v18b82x6xCN5TgxBsRpanLLsoTz6PCjUwN8VZfid+9JvbtivwoE7jjxp6x7k0O4bo
         u/Sl8BZqsLZBbjoU8BeMvPQzk5hOH9wDfgEsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=c8qmI/tfIMclZwUugeleT7yzO0DBVhXtuHynjZS1ytVy08dWhLOl2TU2+Z6zTXWPuG
         qbkbislIUCpjN1lutggqat5sOWnphr/S7zAaIl5u5gRh97769O7Q5x0R7UPCsY7hb9mb
         fAt5GqcyLQbnEmNA3D1Vs36NyywipRov4/01Q=
Received: by 10.142.223.4 with SMTP id v4mr2267006wfg.107.1221397801763;
        Sun, 14 Sep 2008 06:10:01 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 28sm20026918wfg.15.2008.09.14.06.09.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:10:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:09:53 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-14-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95841>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |    8 +++++++-
 builtin-clone.c             |   13 +++++++++++++
 t/t5703-clone-narrow.sh     |   39 +++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 59 insertions(+), 1 deletions(-)
 create mode 100755 t/t5703-clone-narrow.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0e14e73..0a7d11d 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git clone' [--template=3D<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] [--] <repository> [<directory>]
+	  [--depth <depth>] [--path=3D<narrow_spec>] [--]
+	  <repository> [<directory>]
=20
 DESCRIPTION
 -----------
@@ -94,6 +95,11 @@ then the cloned repository will become corrupt.
 -n::
 	No checkout of HEAD is performed after the clone is complete.
=20
+--path=3D<narrow_spec>::
+	A narrow checkout of HEAD is performed after clone is complete
+	with given narrow spec. Please refer to linkgit:git-checkout[1]
+	for more detail on narrow checkout and narrow spec.
+
 --bare::
 	Make a 'bare' GIT repository.  That is, instead of
 	creating `<directory>` and placing the administrative
diff --git a/builtin-clone.c b/builtin-clone.c
index c843529..37d44ca 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -36,6 +36,7 @@ static const char * const builtin_clone_usage[] =3D {
 static int option_quiet, option_no_checkout, option_bare, option_mirro=
r;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
+static char *option_narrow_path;
 static char *option_origin =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
=20
@@ -43,6 +44,8 @@ static struct option builtin_clone_options[] =3D {
 	OPT__QUIET(&option_quiet),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
+	OPT_STRING(0, "path", &option_narrow_path, "prefixes",
+		    "limit checkout to specified paths (narrow checkout)"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
 	OPT_BOOLEAN(0, "mirror", &option_mirror,
@@ -385,10 +388,15 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		if (option_origin)
 			die("--bare and --origin %s options are incompatible.",
 			    option_origin);
+		if (option_narrow_path)
+			die("--bare and --path options are incompatible.");
 		option_no_checkout =3D 1;
 		use_separate_remote =3D 0;
 	}
=20
+	if (option_no_checkout && option_narrow_path)
+		die("--no-checkout and --path options are incompatible.");
+
 	if (!option_origin)
 		option_origin =3D "origin";
=20
@@ -597,6 +605,11 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		opts.src_index =3D &the_index;
 		opts.dst_index =3D &the_index;
=20
+		if (option_narrow_path) {
+			opts.new_narrow_path =3D 1;
+			opts.narrow_spec =3D option_narrow_path;
+		}
+
 		tree =3D parse_tree_indirect(remote_head->old_sha1);
 		parse_tree(tree);
 		init_tree_desc(&t, tree->buffer, tree->size);
diff --git a/t/t5703-clone-narrow.sh b/t/t5703-clone-narrow.sh
new file mode 100755
index 0000000..3ab9eaf
--- /dev/null
+++ b/t/t5703-clone-narrow.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description=3D'narrow clone'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	rm -fr .git &&
+	test_create_repo src &&
+	(
+		cd src
+		mkdir -p work/sub/dir
+		touch untracked tracked modified added
+		touch work/untracked work/tracked work/modified work/added
+		git add tracked work/tracked
+		git add modified work/modified
+		git commit -m initial
+	)
+
+'
+
+test_expect_success 'narrow clone incompatible with --bare' '
+	rm -fr dst &&
+	test_must_fail git clone --path=3Dwork --bare src dst
+'
+
+test_expect_success 'narrow clone incompatible with --no-checkout' '
+	rm -fr dst &&
+	test_must_fail git clone --path=3Dwork -n src dst
+'
+
+test_expect_success 'clone with --path' '
+	rm -fr dst &&
+	git clone --path=3Dwork src dst &&
+	cd dst &&
+	test -z "$(git ls-files --checkout | grep -v ^work/)"
+'
+
+test_done
--=20
1.6.0.96.g2fad1.dirty

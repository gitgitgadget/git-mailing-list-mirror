From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 10/9] ls-files: support --column
Date: Tue, 13 Mar 2012 19:11:34 +0700
Message-ID: <79a9a0dd76d72d9cda14378acb16a2fc6456dd0e.1331638664.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com> <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com> <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com> <28f1df2d0cc13d69fa571600c4723094b6fe514b.1331638663.git.pclouds@gmail.com> <dfa792c463da82097de69b1fba5dc54147dd1951.1331638663.git.pclouds@gmail.com> <dc618ca926bdbdbb96ae59615cbbe57cde9f763f.1331638663.git.pclouds@gmail.com> <d7319b7a0445fc476ae1e928bdc0750287f7fb42.1331638663.git.pclouds@gmail.com> <45b5fc83af9ef53f79eb66742eedcbfe14a3d532.1331638664.git.pclouds@gmail.com> <b1d1aead1851563dbab0cb98db27db07a1addf19.1331638664.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:08:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QXA-0006ml-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759451Ab2CMMIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:08:46 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:33589 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759398Ab2CMMIo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:08:44 -0400
Received: by dadp12 with SMTP id p12so888550dad.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VqtVcxsiAM9eWIGPE05JjykC+OtxnKWoyqSURzuKVj4=;
        b=QbnjvX4LtYycndQh76xRROVULOti9YRsSr5rH0UwE7EfaHPmZBc5T2QCplqFuPRqtq
         dOd+MgGeMvtmJY2TolBdZbKMEDQM1FoDYg7sTg/HQxYogzws1v5V8nfz66usvtc5913y
         HuxD4+BJsE36xR1cRNBJmARjSfiWW2ItEdkE301GGLMpKw4KloDhbk6HaN1Tyw4BciSm
         uyf+HrQPlaQ9Iz+lyIIMF1Nm9S4NDkFHwzuYD7bBLiHc9bGp/uDC+1Oj0yPnXCIWCQ7S
         KwxVfMlA4BnVgjiSXkWVeVZ7n4we31hNme0nRpGfK/YSNp/awEYXZ/BwhdAs5b6JBctd
         CUaA==
Received: by 10.68.224.225 with SMTP id rf1mr6097173pbc.133.1331640524480;
        Tue, 13 Mar 2012 05:08:44 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id l8sm643952pbi.0.2012.03.13.05.08.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:08:43 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:11:52 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <b1d1aead1851563dbab0cb98db27db07a1addf19.1331638664.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193008>

=2E. because ls-files is a good show case to the next patches..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7cff175..e191f4f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -13,6 +13,7 @@
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
+#include "column.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -35,6 +36,7 @@ static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
+static unsigned int colopts;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -496,6 +498,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
 			"pretend that paths removed since <tree-ish> are still present"),
 		OPT__ABBREV(&abbrev),
+		OPT_COLUMN(0, "column", &colopts, "list branches in columns"),
 		OPT_BOOLEAN(0, "debug", &debug_mode, "show debugging data"),
 		OPT_END()
 	};
@@ -514,6 +517,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
+	finalize_colopts(&colopts, -1);
 	if (show_tag || show_valid_bit) {
 		tag_cached =3D "H ";
 		tag_unmerged =3D "M ";
@@ -575,7 +579,11 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 			die("ls-files --with-tree is incompatible with -s or -u");
 		overlay_tree_on_cache(with_tree, max_prefix);
 	}
+	if (COL_ENABLE(colopts))
+		run_column_filter(colopts, NULL);
 	show_files(&dir);
+	if (COL_ENABLE(colopts))
+		stop_column_filter();
 	if (show_resolve_undo)
 		show_ru_info();
=20
--=20
1.7.8.36.g69ee2

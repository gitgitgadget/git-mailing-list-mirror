From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] add core.column
Date: Tue,  8 Feb 2011 22:22:18 +0700
Message-ID: <1297178541-31124-5-git-send-email-pclouds@gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 16:24:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmpQf-0006vI-U3
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 16:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab1BHPYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 10:24:23 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56065 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab1BHPYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 10:24:22 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so1139311pva.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 07:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=spPaHZLPykudSpcKtUUpDiI4VhjTlj5GUTYhpDNG+/M=;
        b=WwLPoF5YeGHS/qgpyaOwUUEQFPNbXq9ihOHhjP9dIzq7Lh61cK0ZUCj+T7UIwivH/K
         CorV9jE49VVnwoQdp3YnobIX/nkN6vBVndSOz1TCkHaWEcdfhC8S0bsrs42yXpE5CxXS
         lYN3fke0TMEx9KKMgtRSr/cINDtcqA2RovzzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rBoNGNxxAnhTlPz+8IHvaoe5lppZXzKS4PgNiXtcgK7etYDVktDZ2EhEe0hP1MYBMy
         vSdHRnrmuzAZNEqxaDV98lmzHMG1fmpVkB9Ohzi0mB9SOVFY5b+zB0M4kH1A7DpamUot
         hiFCDIGpKusBXB3EflXpFD0M+Of0LbvLYFdxc=
Received: by 10.142.216.1 with SMTP id o1mr17384641wfg.190.1297178662516;
        Tue, 08 Feb 2011 07:24:22 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id c3sm7716780wfa.2.2011.02.08.07.24.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 07:24:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Feb 2011 22:22:54 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166357>

This takes auto, never or always to enable column output for
porcelain commands.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |    8 ++++++++
 cache.h                  |    1 +
 config.c                 |   16 ++++++++++++++++
 environment.c            |    1 +
 4 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..6d7151b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -567,6 +567,14 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
=20
+core.column::
+	Specify whether a command should output in columns. Only commands
+	that support `--column` will be affected by this. This variable can
+	take either `never` (do not output in columns), `auto` (output in
+	columns if the output is to a terminal) or `always` (always output in
+	columns). Setting `--column` or `--no-column` will override this
+	variable. This option defaults to never.
+
 add.ignore-errors::
 add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/cache.h b/cache.h
index bcbd5f2..1fa7656 100644
--- a/cache.h
+++ b/cache.h
@@ -559,6 +559,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_column;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index 625e051..071899f 100644
--- a/config.c
+++ b/config.c
@@ -9,6 +9,8 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "color.h"
+#include "column.h"
=20
 #define MAXNAME (256)
=20
@@ -660,6 +662,20 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.column")) {
+		switch (git_config_colorbool(var, value, -1)) {
+		case 0:
+			core_column =3D COL_PLAIN;
+			break;
+		case 1:
+			core_column =3D COL_COLUMN_FIRST;
+			break;
+		case -1:
+			return -1;
+		}
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 9564475..b420ea2 100644
--- a/environment.c
+++ b/environment.c
@@ -56,6 +56,7 @@ char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
 struct startup_info *startup_info;
+int core_column;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
--=20
1.7.2.2

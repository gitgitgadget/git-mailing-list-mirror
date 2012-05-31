From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] unpack-trees: remove i18n legos in unpack's porcelain error messages
Date: Thu, 31 May 2012 20:04:42 +0700
Message-ID: <1338469482-30936-7-git-send-email-pclouds@gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 15:10:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa58m-0007ZT-Ui
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272Ab2EaNKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:10:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60694 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207Ab2EaNKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 09:10:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1442077pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IAcWcurvYfukHuH7qd2JLjeA5mxIYFK7L3tXenvi2ic=;
        b=aTbD4wICBNQ1u/0x7+8wPNAbb/sTGjtIMnJOklb3rTCQCOkcadl5BkB/jNRuYgyvXx
         IdgsGBGPue7VlSsU0iRKpWepIw7OGzw/utyxMf+z4nXYqWMPin6EdXQHmsqBfRXj5V+b
         QFQNrFb+DCyoX5COOF/evkTNJStIulcWWbtakG0rj5QZTCIG73f5yVPZyAN+onf40ywk
         zPZBONb7Hc5ouEudYhSQ+J0cqC0KxbXoWnw9JguYk7B3+GROMYE3yVBv2MyYSLe4Lins
         Dh6mqNczPhP7jW+QcRWXK/RtEWOWDr216pZCTyjTsFzpsShoZIucR9wYQJyhxNYtHFXx
         BfFw==
Received: by 10.68.219.41 with SMTP id pl9mr6523003pbc.61.1338469806158;
        Thu, 31 May 2012 06:10:06 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.14])
        by mx.google.com with ESMTPS id ok6sm4151656pbb.29.2012.05.31.06.10.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:10:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 31 May 2012 20:05:49 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198894>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c | 55 +++++++++++++++++++++++++++++++++-----------------=
-----
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ad40109..41c5714 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -53,35 +53,46 @@ static const char *unpack_plumbing_errors[NB_UNPACK=
_TREES_ERROR_TYPES] =3D {
 void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd)
 {
-	int i;
+	int i, idx;
 	const char **msgs =3D opts->msgs;
-	const char *msg;
-	char *tmp;
-	const char *cmd2 =3D strcmp(cmd, "checkout") ? cmd : "switch branches=
";
-	if (advice_commit_before_merge)
-		msg =3D "Your local changes to the following files would be overwrit=
ten by %s:\n%%s"
-			"Please, commit your changes or stash them before you can %s.";
+	struct strbuf msg =3D STRBUF_INIT;
+	const char *overwrite_advice[] =3D {
+		"Please, commit your changes or stash them before you can merge.",
+		"Please, commit your changes or stash them before you can switch bra=
nches."
+	};
+	const char *remove_untracked_advice[] =3D {
+		"Please move or remove them before you can merge.",
+		"Please move or remove them before you can switch branches."
+	};
+
+	if (!strcmp(cmd, "merge"))
+		idx =3D 0;
+	else if (!strcmp(cmd, "checkout"))
+		idx =3D 1;
 	else
-		msg =3D "Your local changes to the following files would be overwrit=
ten by %s:\n%%s";
-	tmp =3D xmalloc(strlen(msg) + strlen(cmd) + strlen(cmd2) - 2);
-	sprintf(tmp, msg, cmd, cmd2);
-	msgs[ERROR_WOULD_OVERWRITE] =3D tmp;
-	msgs[ERROR_NOT_UPTODATE_FILE] =3D tmp;
+		die("BUG: unsupported command %s", cmd);
+
+	strbuf_addf(&msg, "Your local changes to the following files "
+		    "would be overwritten by %s:\n%%s", cmd);
+	if (advice_commit_before_merge)
+		strbuf_addstr(&msg, overwrite_advice[idx]);
+	msgs[ERROR_WOULD_OVERWRITE] =3D strbuf_detach(&msg, NULL);
+	msgs[ERROR_NOT_UPTODATE_FILE] =3D msgs[ERROR_WOULD_OVERWRITE];
=20
 	msgs[ERROR_NOT_UPTODATE_DIR] =3D
 		"Updating the following directories would lose untracked files in it=
:\n%s";
=20
+	strbuf_addf(&msg, "The following untracked working tree "
+		    "files would be removed by %s:\n%%s", cmd);
 	if (advice_commit_before_merge)
-		msg =3D "The following untracked working tree files would be %s by %=
s:\n%%s"
-			"Please move or remove them before you can %s.";
-	else
-		msg =3D "The following untracked working tree files would be %s by %=
s:\n%%s";
-	tmp =3D xmalloc(strlen(msg) + strlen(cmd) + strlen("removed") + strle=
n(cmd2) - 4);
-	sprintf(tmp, msg, "removed", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] =3D tmp;
-	tmp =3D xmalloc(strlen(msg) + strlen(cmd) + strlen("overwritten") + s=
trlen(cmd2) - 4);
-	sprintf(tmp, msg, "overwritten", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =3D tmp;
+		strbuf_addstr(&msg, remove_untracked_advice[idx]);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] =3D strbuf_detach(&msg, NULL=
);
+
+	strbuf_addf(&msg, "The following untracked working tree "
+		    "files would be overwritten by %s:\n%%s", cmd);
+	if (advice_commit_before_merge)
+		strbuf_addstr(&msg, remove_untracked_advice[idx]);
+	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =3D strbuf_detach(&msg, =
NULL);
=20
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
--=20
1.7.10.2.549.g9354186

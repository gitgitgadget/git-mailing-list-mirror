From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] commit.c: make "tree" a const pointer in commit_tree*()
Date: Sun, 22 Dec 2013 09:56:41 +0700
Message-ID: <1387681001-3165-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 22 03:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuZDr-0005gf-6R
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 03:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab3LVC4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Dec 2013 21:56:51 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37266 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab3LVC4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 21:56:50 -0500
Received: by mail-pa0-f51.google.com with SMTP id fa1so4117781pad.24
        for <git@vger.kernel.org>; Sat, 21 Dec 2013 18:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=h4CymNFXB+q61CODXNcym45fcGV29u3N+a/CdWg8OQ0=;
        b=aFn6o7noQ0ivphL+yWEl9m5pIf3u3W0XXATC1XFCfVuK25sj6uWix7OkCrP4k49eAQ
         O7cs+3YknZPuRB+gTuchgfN709mvn7LywIhuHGjxPTBqG46wo7hDAyjFFomGpL98ou4U
         QPmfnTK5PiZGi1V2LCU3W66SIYBmkBChJ48igicxk3XpwIUMtv3Ohp8gnr2jFiZWOZqd
         qVdVfIM3FxH/qLk2MbtflrMom0lOH2eRgEQXHvNVW9vEH2FN/vcP/E6TI1cSEOg41Uik
         uqJRUpCYFHTzL21CRDWYKfzgLTBNDDCuKyh1TaTxNNKF6VbIVMf6ub6hQFa9Bq1qZkLF
         daIA==
X-Received: by 10.66.184.168 with SMTP id ev8mr370302pac.152.1387681009583;
        Sat, 21 Dec 2013 18:56:49 -0800 (PST)
Received: from lanh ([115.73.203.37])
        by mx.google.com with ESMTPSA id ja5sm24403915pbc.14.2013.12.21.18.56.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Dec 2013 18:56:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 22 Dec 2013 09:56:44 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239629>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c | 4 ++--
 commit.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 5df1df7..5ff5538 100644
--- a/commit.c
+++ b/commit.c
@@ -1356,7 +1356,7 @@ void free_commit_extra_headers(struct commit_extr=
a_header *extra)
 	}
 }
=20
-int commit_tree(const struct strbuf *msg, unsigned char *tree,
+int commit_tree(const struct strbuf *msg, const unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author, const char *sign_commit)
 {
@@ -1485,7 +1485,7 @@ static const char commit_utf8_warn[] =3D
 "You may want to amend it after fixing the message, or set the config\=
n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
=20
-int commit_tree_extended(const struct strbuf *msg, unsigned char *tree=
,
+int commit_tree_extended(const struct strbuf *msg, const unsigned char=
 *tree,
 			 struct commit_list *parents, unsigned char *ret,
 			 const char *author, const char *sign_commit,
 			 struct commit_extra_header *extra)
diff --git a/commit.h b/commit.h
index 934af88..f8a451d 100644
--- a/commit.h
+++ b/commit.h
@@ -232,11 +232,11 @@ struct commit_extra_header {
 extern void append_merge_tag_headers(struct commit_list *parents,
 				     struct commit_extra_header ***tail);
=20
-extern int commit_tree(const struct strbuf *msg, unsigned char *tree,
+extern int commit_tree(const struct strbuf *msg, const unsigned char *=
tree,
 		       struct commit_list *parents, unsigned char *ret,
 		       const char *author, const char *sign_commit);
=20
-extern int commit_tree_extended(const struct strbuf *msg, unsigned cha=
r *tree,
+extern int commit_tree_extended(const struct strbuf *msg, const unsign=
ed char *tree,
 				struct commit_list *parents, unsigned char *ret,
 				const char *author, const char *sign_commit,
 				struct commit_extra_header *);
--=20
1.8.5.2.221.g812bf82.dirty

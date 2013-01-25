From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] branch: mark more strings for translation
Date: Fri, 25 Jan 2013 19:50:25 +0700
Message-ID: <1359118225-14356-3-git-send-email-pclouds@gmail.com>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
 <1359118225-14356-1-git-send-email-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 13:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyik4-0003Dg-Kf
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 13:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258Ab3AYMu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 07:50:26 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:61394 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744Ab3AYMuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 07:50:22 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so244975pad.37
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 04:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/C1/MHnzMFYA1KbUARm/950twH4qw5p5huOyIDqyjlI=;
        b=Oh7rCYI/W2qooxTYJ8fWOA2KsQrxRYbEfaIKo4VK4kqIplyuagl4D2k1GKqb6/f5NU
         SY6ObCk0R/GYQ+EYgDptpwEcpwpxfnGuNwCmo6RBvveL04dCQskrZMoX5ec50mE+Ju0X
         GEctZPDWvkSVVwPGD+cl7b55Kq4dA8liekf4JAWQUlofVplwnnTUXsz1F5fvK4h8lWLD
         gya0HcNq6nFH2kyrIF+ByX+xyQNdMGx48QDJK/wlVNqErCUAhSGL2wXlSCF7NEhBlpLb
         JAaz/5c9Jc2rEXVw3jvbwOio562ZE6tGheaXh9aGyP8wlWgtd9aoUIx/3OaARdhMXkMC
         VY1A==
X-Received: by 10.68.137.131 with SMTP id qi3mr13847484pbb.114.1359118222382;
        Fri, 25 Jan 2013 04:50:22 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id oi3sm644060pbb.1.2013.01.25.04.50.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 04:50:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 25 Jan 2013 19:50:45 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214549>

---
 builtin/branch.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ca61c5b..597b578 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -466,7 +466,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 			     int verbose, int abbrev)
 {
 	struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
-	const char *sub = " **** invalid ref ****";
+	const char *sub = _(" **** invalid ref ****");
 	struct commit *commit = item->commit;
 
 	if (commit && !parse_commit(commit)) {
@@ -590,7 +590,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		struct commit *filter;
 		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
 		if (!filter)
-			die("object '%s' does not point to a commit",
+			die(_("object '%s' does not point to a commit"),
 			    sha1_to_hex(merge_filter_ref));
 
 		filter->object.flags |= UNINTERESTING;
@@ -854,7 +854,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (!argc) {
 			if (detached)
-				die("Cannot give description to detached HEAD");
+				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1)
 			branch_name = argv[0];
@@ -866,10 +866,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			strbuf_release(&branch_ref);
 
 			if (!argc)
-				return error("No commit on branch '%s' yet.",
+				return error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
-				return error("No such branch '%s'.", branch_name);
+				return error(_("No branch named '%s'."),
+					     branch_name);
 		}
 		strbuf_release(&branch_ref);
 
-- 
1.8.0.rc2.23.g1fb49df

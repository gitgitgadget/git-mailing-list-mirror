From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] branch, tag: use porcelain output
Date: Sun, 11 Oct 2015 18:16:28 +0200
Message-ID: <1444580188-18773-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqa8rp2xku.fsf@grenoble-inp.fr>
 <1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, karthik.188@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 11 18:16:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlJIn-0003e6-Sv
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 18:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbbJKQQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 12:16:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50483 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbbJKQQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 12:16:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGGXuY028530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Oct 2015 18:16:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGGXFI023619;
	Sun, 11 Oct 2015 18:16:35 +0200
X-Mailer: git-send-email 2.6.0.rc2.24.gb06d8e9.dirty
In-Reply-To: <1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 11 Oct 2015 18:16:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9BGGXuY028530
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1445184995.56695@QH13F+2SaAYFQgqLoYOoxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279341>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/branch.c | 2 ++
 builtin/tag.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9d6c062..041c649 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -531,6 +531,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 9e17dca..b6d262f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -372,6 +372,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));
-- 
2.6.0.rc2.24.gb06d8e9.dirty

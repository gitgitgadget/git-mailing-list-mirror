From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH] Add Pascal/Delphi (.pas file) funcname pattern.
Date: Fri,  1 Aug 2008 15:45:15 -0400
Message-ID: <1217619915-9331-1-git-send-email-apenwarr@gmail.com>
Cc: "Avery Pennarun" <apenwarr@gmail.com>
To: <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:02:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0pI-0007tj-D7
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbYHAUBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYHAUBK
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:01:10 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:15869
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753821AbYHAUBJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 16:01:09 -0400
X-Greylist: delayed 919 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Aug 2008 16:01:09 EDT
X-Language-Identified: TRUE
X-Brightmail-Tracker: AAAAAQAAA+k=
thread-index: Acj0DyrlWFOI0gCFRtmMAfYMF4AViQ==
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Fri, 1 Aug 2008 15:45:36 -0400
Received: (qmail 17859 invoked from network); 1 Aug 2008 19:45:19 -0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4133
Content-Class: urn:content-classes:message
Importance: normal
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 1 Aug 2008 19:45:19 -0000
Received: (qmail 17853 invoked from network); 1 Aug 2008 19:45:18 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 1 Aug 2008 19:45:18 -0000
Received: (qmail 17824 invoked from network); 1 Aug 2008 19:45:18 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 1 Aug 2008 19:45:18 -0000
Received: (qmail 17804 invoked from network); 1 Aug 2008 19:45:16 -0000
Received: from unknown (HELO stasis.open.versabanq.com) (10.65.1.127)  by weaver.open.versabanq.com with SMTP; 1 Aug 2008 19:45:16 -0000
Received: by stasis.open.versabanq.com (sSMTP sendmail emulation); Fri, 01 Aug 2008 15:45:15 -0400
X-Mailer: git-send-email 1.6.0.rc1.28.g8976a.dirty
X-OriginalArrivalTime: 01 Aug 2008 19:45:36.0140 (UTC) FILETIME=[2AE50CC0:01C8F40F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91084>

Finds classes, records, functions, procedures, and sections.  Most lines
need to start at the first column, or else there's no way to differentiate
a procedure's definition from its declaration.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---

The Ruby funcname pattern patch inspired me.  Although unlike him, I didn't
check with anyone else for confirmation.  How many Pascal programmers can
there possibly be? :)

 diff.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index cbf2547..c73ba69 100644
--- a/diff.c
+++ b/diff.c
@@ -1380,6 +1380,10 @@ static struct builtin_funcname_pattern {
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
 			"[ 	]*([^;]*\\)$" },
+	{ "pas", "\\(^\\(procedure\\|function\\|constructor\\|"
+			"destructor\\|interface\\|implementation\\|"
+			"type|initialization|finalization\\).*$\\)"
+			"\\|\\(^.*=[ \t]*\\(class\\|record\\).*$\\)" },
 	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
 };
 
-- 
1.6.0.rc1.34.g23b24.dirty

From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [tig] [PATCH] Display line numbers in main view
Date: Thu, 4 Aug 2011 20:06:16 -0500
Message-ID: <20110805010616.GA16045@146653177.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 03:17:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp92K-0005ll-Sf
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 03:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab1HEBRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 21:17:11 -0400
Received: from irongate.mail.utexas.edu ([146.6.25.6]:49030 "EHLO
	irongate.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab1HEBRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 21:17:09 -0400
X-Greylist: delayed 639 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Aug 2011 21:17:09 EDT
X-IronPort-MID: 117715576
X-Utexas-Seen-Inbound: true
Received: from wb7-a.mail.utexas.edu ([128.83.126.146])
  by irongate.mail.utexas.edu with ESMTP; 04 Aug 2011 20:06:22 -0500
Received: (qmail 67825 invoked from network); 5 Aug 2011 01:06:21 -0000
Received: from bluemoon.ece.utexas.edu (HELO aceslinc.WORKGROUP) (a.kumar@128.83.190.3)
  by wb7.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSA; 5 Aug 2011 01:06:21 -0000
Received: from kumar by aceslinc.WORKGROUP with local (Exim 4.72)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)
	id 1Qp8rg-0004B6-2N; Thu, 04 Aug 2011 20:06:16 -0500
Mail-Followup-To: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
X-OS: Linux aceslinc 2.6.32-bpo.5-amd64 x86_64
X-Operating-System: Linux aceslinc 2.6.32-bpo.5-amd64 x86_64
X-Editor: GNU Emacs 24.0.50.1
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178779>

When line numbers are enabled, this enables the display of line
numbers in the main view as well. This is useful for cases where one
would want to quickly navigate to a particular commit by the ordering
displayed in tig, using the `:<num>' approach.
---
 tig.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tig.c b/tig.c
index ed92400..92091ab 100644
--- a/tig.c
+++ b/tig.c
@@ -6194,6 +6194,9 @@ main_draw(struct view *view, struct line *line, unsigned int lineno)
 	if (!commit->author)
 		return FALSE;
 
+	if (opt_line_number && draw_lineno(view, lineno))
+		return TRUE;
+
 	if (draw_date(view, &commit->time))
 		return TRUE;
 
-- 
1.7.2.5

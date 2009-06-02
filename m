From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] add -i: do not dump patch during application
Date: Tue,  2 Jun 2009 23:34:27 +0200
Message-ID: <a25cca7119393bcf20fde0f549e0944079fb25a0.1243978061.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 23:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBbd0-0000lL-Gp
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 23:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbZFBVea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbZFBVe3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 17:34:29 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:34991 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbZFBVe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 17:34:29 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Jun 2009 23:34:29 +0200
Received: from localhost.localdomain ([84.75.150.195]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Jun 2009 23:34:29 +0200
X-Mailer: git-send-email 1.6.3.1.325.g02d91
X-OriginalArrivalTime: 02 Jun 2009 21:34:29.0180 (UTC) FILETIME=[E8E197C0:01C9E3C9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120548>

Remove a debugging print that snuck in at 7a26e65 (Revert
"git-add--interactive: remove hunk coalescing", 2009-05-16).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-add--interactive.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a06172c..df9f231 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1317,7 +1317,6 @@
 		open $fh, '| git apply --cached --recount';
 		for (@{$head->{TEXT}}, @result) {
 			print $fh $_;
-			print STDERR $_;
 		}
 		if (!close $fh) {
 			for (@{$head->{TEXT}}, @result) {
-- 
1.6.3.1.325.g02d91

From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Fix typo on variable name $newref should be $newrev in sample update hook
Date: Fri, 2 Mar 2007 10:27:00 +0000
Message-ID: <200703021027.00203.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 13:01:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN6SM-00084E-1O
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423049AbXCBMBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 07:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423051AbXCBMBq
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:01:46 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:9481 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423049AbXCBMBp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:01:45 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 2 Mar 2007 12:03:49 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HN6SE-0006eY-00
	for <git@vger.kernel.org>; Fri, 02 Mar 2007 12:01:42 +0000
X-TUID: 117131ebcec9b942
X-UID: 280
X-Length: 1115
Content-Disposition: inline
X-OriginalArrivalTime: 02 Mar 2007 12:03:49.0531 (UTC) FILETIME=[D67D86B0:01C75CC2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41200>

The log message would be empty for new branches because git-rev-list was
being passed $newref instead of the correct variable $newrev.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--update |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index fd1f73d..2a707e5 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -148,7 +148,7 @@ case "$refname_type" in
 			# This shows all log entries that are not already covered by
 			# another ref - i.e. commits that are now accessible from this
 			# ref that were previously not accessible
-			git-rev-parse --not --all | git-rev-list --stdin --pretty $newref
+			git-rev-parse --not --all | git-rev-list --stdin --pretty $newrev
 			echo $LOGEND
 		else
 			# oldrev is valid
-- 
1.5.0.2.205.g74e20

From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 1/2] Teach 'rebase -i' to accept and ignore the -f/--force-rebase option.
Date: Wed, 24 Mar 2010 11:41:00 -0400
Message-ID: <1269445261-2941-2-git-send-email-marcnarc@xiplink.com>
References: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 16:56:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuSwR-0007xE-KK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 16:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444Ab0CXPio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 11:38:44 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:39150 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756372Ab0CXPin (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 11:38:43 -0400
Received: from rincewind (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2OFcH5x012148;
	Wed, 24 Mar 2010 11:38:18 -0400
Received: by rincewind (Postfix, from userid 1000)
	id 8BD2D336605; Wed, 24 Mar 2010 11:41:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.1.g59254.dirty
In-Reply-To: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143087>

An interactive rebase implies -f:  The user wants to rewrite some of the
branch's own commits.
---
 git-rebase--interactive.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3e4fd14..aa0ab1a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -22,6 +22,7 @@ p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=        use the given merge strategy
 m,merge            always used (no-op)
 i,interactive      always used (no-op)
+f,force-rebase     always used (no-op)
  Actions:
 continue           continue rebasing process
 abort              abort rebasing process and restore original branch
@@ -733,6 +734,9 @@ first and then run 'git rebase --continue' again."
 	-m)
 		# we use merge anyway
 		;;
+	-f)
+		# we don't need to be forced
+		;;
 	-v)
 		VERBOSE=t
 		;;
-- 
1.7.0.3.1.g59254.dirty

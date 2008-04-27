From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH 1/2] rebase -i: Use : in expr command instead of match.
Date: Sun, 27 Apr 2008 11:10:44 -0400
Message-ID: <20080427151043.GA57955@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 17:11:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq8Xc-0008Dk-Aq
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 17:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbYD0PKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 11:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbYD0PKr
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 11:10:47 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56594 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYD0PKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 11:10:46 -0400
Received: from localhost.localdomain (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	by silverinsanity.com (Postfix) with ESMTP id 51F391FFD6C4
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 15:10:41 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80449>

`expr match $str $pattern` failed on OS X, and we already use
`expr $str : $pattern` in several other commands.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 303b754..2a01182 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -192,7 +192,7 @@ peek_next_command () {
 }
 
 mark_to_ref () {
-	if expr match "$1" "^:[0-9][0-9]*$" >/dev/null
+	if expr "$1" : "^:[0-9][0-9]*$" >/dev/null
 	then
 		echo "$mark_prefix$(printf %d ${1#:})"
 	else
-- 
1.5.5.1.174.g8f57349

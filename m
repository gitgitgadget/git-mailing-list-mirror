From: Greg Price <price@ksplice.com>
Subject: [PATCH RFC 3/4] rebase -i: Add the "ref" command
Date: Tue, 22 Dec 2009 17:22:56 -0500
Message-ID: <20091222222256.GX30538@dr-wily.mit.edu>
References: <20091222222032.GU30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 23:23:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NND8G-0003fu-58
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 23:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbZLVWXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 17:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755201AbZLVWXB
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 17:23:01 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:42033 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755193AbZLVWXA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 17:23:00 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nBMMMMGT007573;
	Tue, 22 Dec 2009 17:22:22 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nBMMN85m028886;
	Tue, 22 Dec 2009 17:23:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20091222222032.GU30538@dr-wily.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135604>

This is useful for, e.g., rewriting a branch that has ancestor
branches along the way.

Signed-off-by: Greg Price <price@ksplice.com>
---
 git-rebase--interactive.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0bd3bf7..25ac3e3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -367,6 +367,10 @@ do_next () {
 		warn
 		exit 0
 		;;
+	ref)
+		mark_action_done
+		git update-ref $sha1 HEAD # $sha1 is actually a refname
+		;;
 	squash|s)
 		comment_for_reflog squash
 
-- 
1.6.6.rc1.9.g2ad41.dirty

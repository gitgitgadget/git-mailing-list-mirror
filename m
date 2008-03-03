From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Remove unused sh functions from git-mergetool.sh
Date: Mon, 3 Mar 2008 22:18:17 +0000
Message-ID: <20080303221817.GA7410@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:19:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWIzv-0000oR-Sb
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 23:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYCCWS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbYCCWS0
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 17:18:26 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:36969 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbYCCWS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 17:18:26 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JWIzK-0002oh-Do; Mon, 03 Mar 2008 22:18:26 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m23MII7B007759;
	Mon, 3 Mar 2008 22:18:18 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m23MIHW4007758;
	Mon, 3 Mar 2008 22:18:17 GMT
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: b1c61fb1e3329fba3e66dcaf597edcf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75988>

The tidy up of git mergetool's backup files handling made the two shell
functions save_backup and remove_backup redundant. This commit removes
these now unused functions.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

This patch belongs on top of the mergetool updates in pu. It removes a
couple of shell functions which were made redundant in commit
6fef6e2...  In fact it should logically be squashed into that commit.


 git-mergetool.sh |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index d12bedf..5c86f69 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -127,18 +127,6 @@ check_unchanged () {
     fi
 }
 
-save_backup () {
-    if test "$status" -eq 0; then
-	mv -- "$BACKUP" "$MERGED.orig"
-    fi
-}
-
-remove_backup () {
-    if test "$status" -eq 0; then
-	rm "$BACKUP"
-    fi
-}

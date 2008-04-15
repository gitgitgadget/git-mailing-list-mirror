From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] git-fast-import: note 1M limit of mark number
Date: Wed, 16 Apr 2008 00:54:48 +1200
Message-ID: <20080415125222.C55C121CE8F@mail.utsl.gen.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 15:30:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JllC3-000338-EA
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 15:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759612AbYDON0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 09:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759313AbYDON0k
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 09:26:40 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60185 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758871AbYDON0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 09:26:40 -0400
X-Greylist: delayed 2055 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Apr 2008 09:26:39 EDT
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id C55C121CE8F; Wed, 16 Apr 2008 00:52:22 +1200 (NZST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79600>

The insert_mark() function in fast-import.c has this limit; note the
limitation in the documentation.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/git-fast-import.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c29a4f8..b5cc3c2 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -410,6 +410,9 @@ or `refs/heads/42`), or an abbreviated SHA-1 which happened to
 consist only of base-10 digits.
 +
 Marks must be declared (via `mark`) before they can be used.
++
+Note that due to current internal limitations, you may not make marks
+with a higher number than 1048575 (2^20-1).
 
 * A complete 40 byte or abbreviated commit SHA-1 in hex.
 
-- 
1.5.4.rc2.85.g7c8f5

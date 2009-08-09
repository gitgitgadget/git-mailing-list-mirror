From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] t0001-init: fix a file name
Date: Sun, 09 Aug 2009 17:38:04 +0200
Message-ID: <4A7EED5C.8050707@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 17:38:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaATO-0000P5-9F
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 17:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbZHIPiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 11:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbZHIPiG
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 11:38:06 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:18796 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbZHIPiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 11:38:05 -0400
Received: from [192.168.1.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F2B211000B;
	Sun,  9 Aug 2009 17:38:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125348>

Without this change, grep fails because it does not find the file
instead of because it does not find the text in the file.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  t/t0001-init.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 49caa29..07e011d 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -251,7 +251,7 @@ test_expect_success 'init creates a new deep directory' '
  		git init --bare --shared=0660 newdir/a/b/c &&
  		test -d newdir/a/b/c/refs &&
  		ls -ld newdir/a newdir/a/b > lsab.out &&
-		! grep -v "^drwxrw[sx]r-x" ls.out &&
+		! grep -v "^drwxrw[sx]r-x" lsab.out &&
  		ls -ld newdir/a/b/c > lsc.out &&
  		! grep -v "^drwxrw[sx]---" lsc.out
  	)
-- 
1.6.4.1186.g1d9a

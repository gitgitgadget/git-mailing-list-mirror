From: Bryan Larsen <bryan@larsen.st>
Subject: [PATCH] posix compatibility for t4200
Date: Wed, 02 May 2007 17:53:23 -0400
Message-ID: <46390853.2030306@larsen.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 23:51:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjMjQ-0005cS-Px
	for gcvg-git@gmane.org; Wed, 02 May 2007 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767110AbXEBVvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 17:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767112AbXEBVvY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 17:51:24 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:39444 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767110AbXEBVvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 17:51:23 -0400
Received: by py-out-1112.google.com with SMTP id a29so242508pyi
        for <git@vger.kernel.org>; Wed, 02 May 2007 14:51:17 -0700 (PDT)
Received: by 10.65.253.6 with SMTP id f6mr2072871qbs.1178142677466;
        Wed, 02 May 2007 14:51:17 -0700 (PDT)
Received: from ?192.168.1.91? ( [206.248.190.98])
        by mx.google.com with ESMTP id e18sm940863qba.2007.05.02.14.51.16;
        Wed, 02 May 2007 14:51:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46048>

Fix t4200 so that it also works on OS X by not relying on gnu extensions 
to sed.

Signed-off-by: Bryan Larsen <bryan@larsen.st>
---
  t/t4200-rerere.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 6ba63d7..300e90e 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -44,7 +44,7 @@ mkdir .git/rr-cache

  test_expect_failure 'conflicting merge' 'git pull . first'

-sha1=$(sed -e 's/\t.*//' .git/rr-cache/MERGE_RR)
+sha1=$(sed -e 's/[[:space:]].*//' .git/rr-cache/MERGE_RR)
  rr=.git/rr-cache/$sha1
  test_expect_success 'recorded preimage' "grep ======= $rr/preimage"

-- 
1.5.1

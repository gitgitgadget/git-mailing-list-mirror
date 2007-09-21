From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-svn: fix test for trunk svn (transaction out of date)
Date: Fri, 21 Sep 2007 14:02:34 +1200
Message-ID: <11903401551812-git-send-email-sam.vilain@catalyst.net.nz>
References: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz>
 <11903401551014-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 04:32:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYYJE-00072h-GE
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 04:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbXIUCb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 22:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753057AbXIUCb4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 22:31:56 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:37155 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbXIUCbz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 22:31:55 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IYXqm-0003ZV-3z; Fri, 21 Sep 2007 14:02:36 +1200
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 010552C6DB; Fri, 21 Sep 2007 14:02:35 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11903401551014-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58818>

Older svn clients did not raise a 'transaction out of date' error here, but
trunk does - so 'svn up'.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 t/t9101-git-svn-props.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 622ea1c..5aac644 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -140,6 +140,7 @@ test_expect_success 'test show-ignore' "
 	cd test_wc &&
 	mkdir -p deeply/nested/directory &&
 	svn add deeply &&
+	svn up &&
 	svn propset -R svn:ignore 'no-such-file*' .
 	svn commit -m 'propset svn:ignore'
 	cd .. &&
-- 
1.5.2.4

From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 3/4] git-p4: one test missing config
 git-p4.skipSubmitEditCheck
Date: Sun, 31 Jul 2011 09:45:38 -0400
Message-ID: <20110731134538.GE6564@arf.padd.com>
References: <20110731003557.GA4867@arf.padd.com>
 <20110731134416.GB6564@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 15:45:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWKw-0005iR-23
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab1GaNpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 09:45:42 -0400
Received: from honk.padd.com ([74.3.171.149]:41019 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab1GaNpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 09:45:41 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 06479330B;
	Sun, 31 Jul 2011 06:45:41 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8D2443149A; Sun, 31 Jul 2011 09:45:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110731134416.GB6564@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178254>

Add this missing line in one of the tests.  Otherwise, on fast
machines, the following git-p4 commit will complain that nobody
edited the submission message.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 t/t9800-git-p4.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index b7eda82..b304707 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -191,6 +191,7 @@ test_expect_success 'refuse to preserve users without perms' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	cd "$git" &&
+	git config git-p4.skipSubmitEditCheck true &&
 	echo "username-noperms: a change by alice" >> file1 &&
 	git commit --author "Alice <alice@localhost>" -m "perms: a change by alice" file1 &&
 	! P4EDITOR=touch P4USER=bob P4PASSWD=secret "$GITP4" commit --preserve-user &&
-- 
1.7.5.4

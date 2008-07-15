From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] t9600: allow testing with cvsps 2.2, including beta versions
Date: Mon, 14 Jul 2008 20:20:19 -0400
Message-ID: <20080715002019.5337.81984.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 02:21:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIYII-0004DJ-E4
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 02:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760425AbYGOAU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 20:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760421AbYGOAU1
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 20:20:27 -0400
Received: from c60.cesmail.net ([216.154.195.49]:18820 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760420AbYGOAU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 20:20:26 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 14 Jul 2008 20:20:25 -0400
Received: from dv.roinet.com (pool-71-185-134-138.phlapa.east.verizon.net [71.185.134.138])
	by relay.cesmail.net (Postfix) with ESMTP id 567664F1869
	for <git@vger.kernel.org>; Mon, 14 Jul 2008 20:20:25 -0400 (EDT)
User-Agent: StGIT/0.14.3.173.g2e37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88487>

Don't assume that unsupported versions are too old, they may be too new.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 t/t9600-cvsimport.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 655f882..f92b47a 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -20,13 +20,15 @@ cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
 case "$cvsps_version" in
 2.1)
 	;;
+2.2*)
+	;;
 '')
 	say 'skipping cvsimport tests, cvsps not found'
 	test_done
 	exit
 	;;
 *)
-	say 'skipping cvsimport tests, cvsps too old'
+	say 'skipping cvsimport tests, unsupported cvsps version'
 	test_done
 	exit
 	;;

From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/7] Bisect: add "bisect dunno" to the documentation.
Date: Sun, 14 Oct 2007 14:30:11 +0200
Message-ID: <20071014143011.7ab31184.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 14:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih2V7-0001A0-8z
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 14:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbXJNMXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 08:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113AbXJNMXJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 08:23:09 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58654 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756082AbXJNMXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 08:23:08 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8E20C1AB2BC;
	Sun, 14 Oct 2007 14:23:06 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 56EBA1AB2BE;
	Sun, 14 Oct 2007 14:23:06 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60841>

Also fix "bisect bad" and "bisect good" short usage description.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 1072fb8..2be2284 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -16,8 +16,9 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect start [<bad> [<good>...]] [--] [<paths>...]
- git bisect bad <rev>
- git bisect good <rev>
+ git bisect bad [<rev>]
+ git bisect good [<rev>...]
+ git bisect dunno [<rev>...]
  git bisect reset [<branch>]
  git bisect visualize
  git bisect replay <logfile>
@@ -134,6 +135,20 @@ $ git reset --hard HEAD~3		# try 3 revs before what
 Then compile and test the one you chose to try. After that, tell
 bisect what the result was as usual.
 
+Bisect dunno
+~~~~~~~~~~~~
+
+Instead of choosing by yourself a nearby commit, you may just want git
+to do it for you using:
+
+------------
+$ git bisect dunno                 # Current version cannot be tested
+------------
+
+But computing the commit to test may be slower afterwards and git may
+eventually not be able to tell the first bad among a bad and one or
+more dunno commits.
+
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.5.3.4.213.g68ad5

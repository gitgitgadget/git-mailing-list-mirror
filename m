From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 8/9] Bisect: add "bisect skip" to the documentation.
Date: Mon, 22 Oct 2007 07:49:23 +0200
Message-ID: <20071022074923.362e4648.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:42:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq3e-0007hy-8h
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbXJVFmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbXJVFmV
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:42:21 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36532 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbXJVFmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:42:20 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 04C271AB2D9;
	Mon, 22 Oct 2007 07:42:20 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B431F1AB2D6;
	Mon, 22 Oct 2007 07:42:19 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61946>

Also fix "bisect bad" and "bisect good" short usage description.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 1072fb8..785f381 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -16,8 +16,9 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect start [<bad> [<good>...]] [--] [<paths>...]
- git bisect bad <rev>
- git bisect good <rev>
+ git bisect bad [<rev>]
+ git bisect good [<rev>...]
+ git bisect skip [<rev>...]
  git bisect reset [<branch>]
  git bisect visualize
  git bisect replay <logfile>
@@ -134,6 +135,20 @@ $ git reset --hard HEAD~3		# try 3 revs before what
 Then compile and test the one you chose to try. After that, tell
 bisect what the result was as usual.
 
+Bisect skip
+~~~~~~~~~~~~
+
+Instead of choosing by yourself a nearby commit, you may just want git
+to do it for you using:
+
+------------
+$ git bisect skip                 # Current version cannot be tested
+------------
+
+But computing the commit to test may be slower afterwards and git may
+eventually not be able to tell the first bad among a bad and one or
+more "skip"ped commits.
+
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.5.3.3.136.g591d1-dirty

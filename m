From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: fix a removed variable that is still used.
Date: Thu, 18 Oct 2007 00:52:56 +0200
Message-ID: <20071018005256.280dfaab.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 00:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiHeP-00073l-50
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 00:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758526AbXJQWpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758832AbXJQWpy
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 18:45:54 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:59860 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758501AbXJQWpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 18:45:54 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5C4971AB2D5;
	Thu, 18 Oct 2007 00:45:52 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id E432D1AB2C9;
	Thu, 18 Oct 2007 00:45:51 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61435>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

	This is fix for something I forgot in the patch named:

	[PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" 
	into "bisect_state".

	I can send an updated version of the above patch if
	needed.

diff --git a/git-bisect.sh b/git-bisect.sh
index b266d17..abae9a6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -406,7 +406,7 @@ bisect_run () {
 
       if [ $res -ne 0 ]; then
 	  echo >&2 "bisect run failed:"
-	  echo >&2 "$next_bisect exited with error code $res"
+	  echo >&2 "'bisect_state $state' exited with error code $res"
 	  exit $res
       fi
 
-- 
1.5.3.3.136.g591d1-dirty

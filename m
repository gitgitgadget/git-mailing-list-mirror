From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH 1/4] git-daemon: call logerror() instead of error()
Date: Thu, 14 Aug 2008 20:02:20 +0200
Message-ID: <20080814180220.15729.34048.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 20:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KThAm-0005Fp-QU
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 20:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759534AbYHNSCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 14:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759527AbYHNSCW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 14:02:22 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47461 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759475AbYHNSCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 14:02:21 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 5A3385465; Thu, 14 Aug 2008 20:02:20 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92384>

Fix wording/case of the two messages.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 daemon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 8dcde73..93e1106 100644
--- a/daemon.c
+++ b/daemon.c
@@ -836,7 +836,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 		if (sockfd < 0)
 			continue;
 		if (sockfd >= FD_SETSIZE) {
-			error("too large socket descriptor.");
+			logerror("Socket descriptor too large");
 			close(sockfd);
 			continue;
 		}
@@ -955,7 +955,7 @@ static int service_loop(int socknum, int *socklist)
 
 		if (poll(pfd, socknum + 1, -1) < 0) {
 			if (errno != EINTR) {
-				error("poll failed, resuming: %s",
+				logerror("Poll failed, resuming: %s",
 				      strerror(errno));
 				sleep(1);
 			}

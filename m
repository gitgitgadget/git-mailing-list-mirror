From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] simplify the "no changes added to commit" message
Date: Sat, 13 Jan 2007 21:23:55 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701132111080.2577@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 03:24:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5v2N-0003pi-RP
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 03:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXANCX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 21:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXANCX5
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 21:23:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30212 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXANCX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 21:23:56 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBU002HT6NVUHA0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 13 Jan 2007 21:23:55 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36790>

Suggesting the use of [-a|-i|-o] with git-commit is unnecessarily 
complex and confusing.  In this context -o is totally useless and -i 
requires extra arguments which are not mentioned.  The only sensible 
hint (besides reading the man page but let's not go there) is
"commit -a".

Signed-off-by: Nicolas Pitre <nico@cam.org> ---

diff --git a/wt-status.c b/wt-status.c
index daba9a6..b7250e4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -335,7 +335,7 @@ void wt_status_print(struct wt_status *s)
 		if (s->amend)
 			printf("# No changes\n");
 		else if (s->workdir_dirty)
-			printf("no changes added to commit (use \"git add\" and/or \"git commit [-a|-i|-o]\")\n");
+			printf("no changes added to commit (use \"git add\" and/or \"git commit -a\")\n");
 		else if (s->workdir_untracked)
 			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
 		else if (s->is_initial)

From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Fix a remove_empty_dir_recursive problem.
Date: Sun, 1 Oct 2006 14:36:49 +0200
Message-ID: <20061001143649.a67d243c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 14:30:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU0Sk-0005Fh-He
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 14:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWJAMaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 08:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWJAMaX
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 08:30:23 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:34022 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932106AbWJAMaX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 08:30:23 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 1D48275C35;
	Sun,  1 Oct 2006 14:30:21 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28178>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 858c534..221eb38 100644
--- a/refs.c
+++ b/refs.c
@@ -498,7 +498,7 @@ static int remove_empty_dir_recursive(ch
 		    strcpy(path + len, e->d_name) &&
 		    !lstat(path, &st) &&
 		    S_ISDIR(st.st_mode) &&
-		    remove_empty_dir_recursive(path, len + namlen))
+		    !remove_empty_dir_recursive(path, len + namlen))
 			continue; /* happy */
 
 		/* path too long, stat fails, or non-directory still exists */
-- 
1.4.2.1.g7bc701-dirty

From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/9 v4] commit: add "bisect_replace_all" prototype to
 "commit.h"
Date: Tue, 11 Nov 2008 06:41:35 +0100
Message-ID: <20081111064135.66db6fcf.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 06:40:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzlzQ-0004Ve-R8
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 06:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYKKFjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 00:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbYKKFjV
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 00:39:21 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:41433 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbYKKFjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 00:39:21 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id E74E33EA0BD;
	Tue, 11 Nov 2008 06:39:19 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id A1DEE3EA0B9;
	Tue, 11 Nov 2008 06:39:19 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100620>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |    2 +-
 commit.h           |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 75cc1fc..7cf5f9e 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -637,7 +637,7 @@ static int bisect_replace(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static void bisect_replace_all(void)
+void bisect_replace_all(void)
 {
 	for_each_branch_ref(bisect_replace, NULL);
 }
diff --git a/commit.h b/commit.h
index 3a7b06a..a0ec2a0 100644
--- a/commit.h
+++ b/commit.h
@@ -144,4 +144,6 @@ static inline int single_parent(struct commit *commit)
 
 struct commit_list *reduce_heads(struct commit_list *heads);
 
+void bisect_replace_all(void);
+
 #endif /* COMMIT_H */
-- 
1.6.0.3.614.g0f3b9

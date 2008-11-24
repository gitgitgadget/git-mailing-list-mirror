From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/9 v5] commit: add "bisect_replace_all" prototype to
 "commit.h"
Date: Mon, 24 Nov 2008 22:16:22 +0100
Message-ID: <20081124221622.9ab2253b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 01:46:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4m4Z-0003kZ-8F
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 01:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbYKYApP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 19:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbYKYApO
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 19:45:14 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:45200 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbYKYApN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 19:45:13 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1A55683CD;
	Tue, 25 Nov 2008 00:09:44 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id 62F8719C63;
	Mon, 24 Nov 2008 22:14:50 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101639>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |    2 +-
 commit.h           |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 693023f..1b18c65 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -637,7 +637,7 @@ static int bisect_replace(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static void bisect_replace_all(void)
+void bisect_replace_all(void)
 {
 	for_each_replace_ref(bisect_replace, NULL);
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
1.5.6.1.1657.g6a50

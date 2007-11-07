From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH MISC 1/1] Make gcc warning about empty if body go away.
Date: Wed,  7 Nov 2007 11:20:26 +0100
Message-ID: <1194430832-6224-2-git-send-email-madcoder@debian.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 11:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi1k-00018B-KF
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbXKGKUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXKGKUg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:20:36 -0500
Received: from pan.madism.org ([88.191.52.104]:35293 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbXKGKUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:20:35 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 078F828E22;
	Wed,  7 Nov 2007 11:20:33 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 06BFEEB6; Wed,  7 Nov 2007 11:20:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1598.gdef4e
In-Reply-To: <1194430832-6224-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63793>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index f77352b..80392a8 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -204,7 +204,7 @@ static void refresh_index_quietly(void)
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close(fd) ||
 		    commit_locked_index(lock_file))
-			; /*
+			(void)0; /*
 			   * silently ignore it -- we haven't mucked
 			   * with the real index.
 			   */
-- 
1.5.3.5.1598.gdef4e

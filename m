From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] revision.c: use proper data type in call to sizeof() within xrealloc
Date: Thu, 13 Nov 2008 14:20:37 -0600
Message-ID: <2NXgsahhUCpkej6JukLNJjebzyoAQgZ4ptQMMrR2j_iWS5yEqKYn0kxHsUBpiY6bkpfbTjxlSn0@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 13 21:22:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0iha-0007fp-91
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbYKMUUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 15:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYKMUUv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 15:20:51 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35144 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbYKMUUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 15:20:50 -0500
Received: by mail.nrlssc.navy.mil id mADKKj21026030; Thu, 13 Nov 2008 14:20:45 -0600
X-OriginalArrivalTime: 13 Nov 2008 20:20:45.0364 (UTC) FILETIME=[4F0D1740:01C945CD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100912>

A type char** was being used instead of char*.
---


Just a little typo, that doesn't make any difference but should be fixed.

-brandon


 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 2f646de..440d152 100644
--- a/revision.c
+++ b/revision.c
@@ -968,7 +968,7 @@ static void add_ignore_packed(struct rev_info *revs, const char *name)
 	int num = ++revs->num_ignore_packed;
 
 	revs->ignore_packed = xrealloc(revs->ignore_packed,
-				       sizeof(const char **) * (num + 1));
+				       sizeof(const char *) * (num + 1));
 	revs->ignore_packed[num-1] = name;
 	revs->ignore_packed[num] = NULL;
 }
-- 
1.6.0.3.552.g12334

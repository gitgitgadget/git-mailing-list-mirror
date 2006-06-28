From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.pm
Date: Wed, 28 Jun 2006 20:35:57 +0200
Message-ID: <20060628183557.GA5713@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Wed Jun 28 20:36:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fveto-0006Ul-2U
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 20:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWF1SgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 14:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWF1SgF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 14:36:05 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:2194 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1750897AbWF1Sf6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 14:35:58 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.62)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1FvetJ-0001US-3M
	for git@vger.kernel.org; Wed, 28 Jun 2006 20:35:57 +0200
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22816>

In commit 6294a10 it was noted that "on x86-64 it seems that Git.xs does
not link without compiling the main git objects with -fPIC". Set it
therefore automatically on this platform.

Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>
---
At the moment this is 'pu' stuff.
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2df5bd4..0f0e25a 100644
--- a/Makefile
+++ b/Makefile
@@ -254,6 +254,9 @@ # we had "elif" things would have been m
 
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
+	ifneq (,$(findstring x86_64,$(uname_M)))
+		USE_PIC = YesPlease
+	endif
 endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
-- 
1.4.1.rc1.g3550-dirty

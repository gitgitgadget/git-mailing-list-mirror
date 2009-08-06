From: Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH 2/2] http-fetch: Fix Makefile dependancies
Date: Thu,  6 Aug 2009 14:14:45 +0100
Message-ID: <3b0689fabea4a0c7b2327bb2a31e2b5fba2ddc99.1249563483.git.mike@abacus.co.uk>
References: <f4271a23eed2a6bc3774fb8e21563e74f9b1fb19.1249563483.git.mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 15:13:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ2m2-0004zb-He
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 15:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbZHFNLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 09:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbZHFNLD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 09:11:03 -0400
Received: from [82.109.193.99] ([82.109.193.99]:45474 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755816AbZHFNK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 09:10:59 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id E965C18AC81; Thu,  6 Aug 2009 14:14:45 +0100 (BST)
X-Mailer: git-send-email 1.6.3.1.54.g99dd
In-Reply-To: <f4271a23eed2a6bc3774fb8e21563e74f9b1fb19.1249563483.git.mike@abacus.co.uk>
In-Reply-To: <f4271a23eed2a6bc3774fb8e21563e74f9b1fb19.1249563483.git.mike@abacus.co.uk>
References: <f4271a23eed2a6bc3774fb8e21563e74f9b1fb19.1249563483.git.mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125067>

Specify git-http-fetch's dependancies explicitly rather than inheriting from
git-http-push, as that may not be built if the libcurl version is too old or
NO_EXPAT is defined

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 97d904b..366b729 100644
--- a/Makefile
+++ b/Makefile
@@ -1502,7 +1502,7 @@ http.o http-walker.o http-push.o: http.h
 
 http.o http-walker.o: $(LIB_H)
 
-git-http-fetch$X: revision.o http.o http-push.o $(GITLIBS)
+git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
-- 
1.6.4.115.g33d49.dirty

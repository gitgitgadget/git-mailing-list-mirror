From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] Makefile: move -Wall from CFLAGS to BASIC_CFLAGS
Date: Mon, 05 Apr 2010 23:14:20 -0400
Message-ID: <1270523660.3648.7.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 05:15:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyzG6-00037R-7e
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 05:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950Ab0DFDPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 23:15:13 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:36831 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab0DFDPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 23:15:12 -0400
Received: from homiemail-a37.g.dreamhost.com (caiajhbdcaid.dreamhost.com [208.97.132.83])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 8E34217BEDB
	for <git@vger.kernel.org>; Mon,  5 Apr 2010 20:15:12 -0700 (PDT)
Received: from [129.2.139.171] (129-2-139-171.wireless.umd.edu [129.2.139.171])
	by homiemail-a37.g.dreamhost.com (Postfix) with ESMTP id 4DB474D64E
	for <git@vger.kernel.org>; Mon,  5 Apr 2010 20:14:31 -0700 (PDT)
X-Mailer: Evolution 2.30.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144089>

-Wall cleanliness is an intended property of the codebase, so -Wall
should be on by default even if the user's CFLAGS doesn't include it
(e.g., the AC_PROG_CC configure test won't include it).
---

Thoughts?  Is there a problem with -Wall being GNU-specific?

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7c616f8..88f9b47 100644
--- a/Makefile
+++ b/Makefile
@@ -241,7 +241,7 @@ endif
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -308,7 +308,7 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
 # Those must not be GNU-specific; they are shared with perl/ which may
 # be built by a different compiler. (Note that this is an artifact now
 # but it still might be nice to keep that distinction.)
-BASIC_CFLAGS = -I.
+BASIC_CFLAGS = -Wall -I.
 BASIC_LDFLAGS =
 
 # Guard against environment variables
-- 
1.7.0.2.288.gb0894e

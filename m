From: Tony Kemp <Tony.Kemp@newcastle.edu.au>
Subject: [PATCH] Turn on USE_ST_TIMESPEC for OpenBSD
Date: Thu, 14 May 2009 16:47:41 +1000
Message-ID: <95834851-9A5E-42D8-9420-0C7505ECB1A5@newcastle.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 09:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Vfx-0003Np-5a
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605AbZENHsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755659AbZENHsK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:48:10 -0400
Received: from reactive.newcastle.edu.au ([134.148.4.74]:60215 "EHLO
	reactive.newcastle.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbZENHsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 03:48:09 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2009 03:48:09 EDT
Received: from pmxchannel-daemon.reactive.newcastle.edu.au by
 reactive.newcastle.edu.au
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 id <0KJM00H1YG87LB00@reactive.newcastle.edu.au> for git@vger.kernel.org; Thu,
 14 May 2009 16:48:07 +1000 (EST)
Received: from cw257-imac20.newcastle.edu.au ([134.148.233.156])
 by reactive.newcastle.edu.au
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0KJM007DSG7H2MD0@reactive.newcastle.edu.au>; Thu,
 14 May 2009 16:47:41 +1000 (EST)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119165>

Like Darwin, OpenBSD's stat struct uses st_ctimespec and st_mtimestruct
rather than st_ctim and st_mtim.

Signed-off-by: Tony Kemp <tony.kemp@newcastle.edu.au>
---
  Makefile |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 6e21643..26d180c 100644
--- a/Makefile
+++ b/Makefile
@@ -749,6 +749,7 @@ endif
  ifeq ($(uname_S),OpenBSD)
  	NO_STRCASESTR = YesPlease
  	NO_MEMMEM = YesPlease
+	USE_ST_TIMESPEC = YesPlease
  	NEEDS_LIBICONV = YesPlease
  	BASIC_CFLAGS += -I/usr/local/include
  	BASIC_LDFLAGS += -L/usr/local/lib
-- 
1.6.2.2

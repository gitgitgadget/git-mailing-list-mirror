From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] minor Makefile and local-pull.c edits for Darwin
Date: Mon, 09 May 2005 23:37:41 -0700
Message-ID: <7v1x8fr3gq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505100019350.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Allen <mrallen1@yahoo.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue May 10 08:31:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVOGS-0002fc-08
	for gcvg-git@gmane.org; Tue, 10 May 2005 08:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVEJGhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 02:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVEJGhs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 02:37:48 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51962 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261563AbVEJGhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 02:37:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510063741.XEXZ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 02:37:41 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0505100019350.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Tue, 10 May 2005 00:23:34 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> Actually, the relevant openssl functionality is always in libcrypto, not
DB> libssl...

Ok, could people try the following single liner, and if it
breaks yell loudly at me (or Daniel ;-)?  It worked for me but I
just want to make sure before I put it in git-jc repository
which I will ask Linus to pull from later.

$ jit-diff 0:7
# - HEAD: Introduce GIT_DIR environment variable.
# + 7: Link with -lcrypto not -lssl
--- a/Makefile
+++ b/Makefile
@@ -60,7 +60,7 @@ ifdef PPC_SHA1
   LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 else
   SHA1_HEADER=<openssl/sha.h>
-  LIBS += -lssl
+  LIBS += -lcrypto
 endif
 endif
 


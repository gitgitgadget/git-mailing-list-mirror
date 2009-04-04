From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] revision.h: add includes of "diff.h" and "commit.h"
Date: Sat, 4 Apr 2009 21:45:54 +0200
Message-ID: <20090404214554.75ada117.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 21:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqBzv-00045f-RT
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 21:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbZDDTrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbZDDTrH
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 15:47:07 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:59488 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755172AbZDDTrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 15:47:06 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 2FD674B009E;
	Sat,  4 Apr 2009 21:46:54 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id B2BF84B0081;
	Sat,  4 Apr 2009 21:46:51 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115592>

Because they are needed by some features included in
"revision.h".

This makes the following just work:

        $ cat >1.c <<\EOF
        #include "cache.h"
        #include "revision.h"
        EOF
        $ cc -Wall -DSHA1_HEADER='<openssl/sha.h>' -c 1.c

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 revision.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/revision.h b/revision.h
index 5adfc91..495d7eb 100644
--- a/revision.h
+++ b/revision.h
@@ -3,6 +3,8 @@
 
 #include "parse-options.h"
 #include "grep.h"
+#include "diff.h"
+#include "commit.h"
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
-- 
1.6.2.1.530.g516a7.dirty

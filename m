From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 14:49:56 -0400
Message-ID: <20080730184956.GF10399@yugib.highrise.ca>
References: <20071205172125.GF12636@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 21:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOH8p-0001zG-IF
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbYG3TOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbYG3TON
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:14:13 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:40006 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbYG3TOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:14:11 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id C207B111E39;
	Wed, 30 Jul 2008 14:49:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071205172125.GF12636@yugib.highrise.ca>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90838>

SCO OpenServer also hides the definitions of (at least) u_short and
friends if _XOPEN_SOURCE is defined.
---
Same patch as last time, updated for current master.

 git-compat-util.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cf89cdf..42e3e0b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -39,7 +39,7 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)      ((int)(sizeof(x) * 2.56 + 0.5) + 1)

-#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX)
+#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(__OPENSERVER__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
--
1.6.0.rc1.dirty

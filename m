From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: add section for SGI IRIX
Date: Mon, 18 Aug 2008 18:02:39 -0500
Message-ID: <g4oal8s8kBLktHCvtMjDXsBf7EJ0qrlynAps5eiTDAl3a6vy6guKmg@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:03:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDlO-0001du-VS
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbYHRXCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYHRXCk
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:02:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55787 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYHRXCk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:02:40 -0400
Received: by mail.nrlssc.navy.mil id m7IN2dnU024111; Mon, 18 Aug 2008 18:02:39 -0500
In-Reply-To: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:02:38.0961 (UTC) FILETIME=[82DE1E10:01C90186]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92749>

---
 Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 52c67c1..890694c 100644
--- a/Makefile
+++ b/Makefile
@@ -705,6 +705,18 @@ ifeq ($(uname_S),GNU)
 	# GNU/Hurd
 	NO_STRLCPY=YesPlease
 endif
+ifeq ($(uname_S),IRIX)
+	NO_SETENV = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_EXTERNAL_GREP = UnfortunatelyYes
+	SHELL_PATH = /usr/gnu/bin/bash
+	ifdef NO_C99_FORMAT
+		BASIC_CFLAGS += -Dinline=__inline
+	endif
+endif
 ifeq ($(uname_S),IRIX64)
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
-- 
1.6.0.13.ge1c8

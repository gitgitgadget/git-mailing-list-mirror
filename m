From: Jonathan Callen <abcd@gentoo.org>
Subject: [PATCH 3/3] Add Interix support
Date: Thu, 27 May 2010 04:19:44 -0400
Message-ID: <1274948384-167-4-git-send-email-abcd@gentoo.org>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
Cc: mduft@gentoo.org, jrnieder@gmail.com,
	Jonathan Callen <abcd@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 27 10:20:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHYK6-00049K-Du
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 10:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431Ab0E0IUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 04:20:03 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:45289 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757378Ab0E0IT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 04:19:59 -0400
Received: from localhost.localdomain (pool-72-86-43-250.clppva.fios.verizon.net [72.86.43.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 39FF01B4063;
	Thu, 27 May 2010 08:19:58 +0000 (UTC)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274948384-167-1-git-send-email-abcd@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147835>

Add an Interix clause in the makefile.  Interix's libc does not have
support for many of the functions that are generally taken for granted.

Signed-off-by: Jonathan Callen <abcd@gentoo.org>
---
 Makefile |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1722bf0..563eec2 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,6 +1071,19 @@ else
 	NO_CURL = YesPlease
 endif
 endif
+ifeq ($(uname_S),Interix)
+	NO_IPV6 = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_STRTOUMAX = YesPlease
+	NO_STRTOULL = YesPlease
+	NO_INET_NTOP = YesPlease
+	NO_INET_PTON = YesPlease
+	NO_NSEC = YesPlease
+	NO_MKSTEMPS = YesPlease
+	NO_POLL = YesPlease
+	NO_INTTYPES_H = YesPlease
+endif
 
 -include config.mak.autogen
 -include config.mak
-- 
1.7.1

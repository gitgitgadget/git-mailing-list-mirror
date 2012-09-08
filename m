From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH v2] Document MKDIR_WO_TRAILING_SLASH in Makefile
Date: Sat, 8 Sep 2012 19:01:31 +0200
Message-ID: <001f01cd8de3$99303b60$cb90b220$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 19:02:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAOQM-0005iN-9g
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 19:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab2IHRCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 13:02:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57306 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab2IHRBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 13:01:44 -0400
Received: from DualCore (dsdf-4db5dae6.pool.mediaWays.net [77.181.218.230])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LsMbE-1TYcG608uu-0123yn; Sat, 08 Sep 2012 19:01:42 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2N42jydgMmk4/HQJaC1fOpTQQlBg==
Content-Language: de
X-Provags-ID: V02:K0:h1C8Sf79JMhe7hP3O2+JB88Pdj5QOhauJGFSQUbMyPt
 Qm+u4dT2swoECaClmjQTUfRJCShzWVwfv6QRZw+puFxvH/Ne0U
 6+KfQ1piDTe8K3lX6dCcz0XbReJHiC5I7tU63fwUwnZ9pJ/o9W
 0NcduQlBk/fKhGX5Pbl+icJRlx9Ifi85ozISu1qA0pV7W3oOuh
 /C0MfKbBbqbR5JVIvG+fEV6II3/hG3Wl/yCynEEh10mp32PuwB
 Q2VYY/t/ySbhUOfkMfetbpvZLUsmfwBFX4+KE4/aAyTRGd+4Jn
 s7F1SABgniS2wPdA6ekcHousxQ5v3F6sH9JY5PuX0EXRx8v3Ox
 VT9FMM8ospB6dSsxcvqtUgs/uYtPyPNwkuiavKwprtkEwBdzS0
 2PncUW8z/BJ9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205019>

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 66e8216..21b4816 100644
--- a/Makefile
+++ b/Makefile
@@ -90,6 +90,8 @@ all::
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
+# Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
+#
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
 # Define NO_STRTOK_R if you don't have strtok_r in the C library.
@@ -1639,6 +1641,10 @@ ifdef NO_MKDTEMP
 	COMPAT_CFLAGS += -DNO_MKDTEMP
 	COMPAT_OBJS += compat/mkdtemp.o
 endif
+ifdef MKDIR_WO_TRAILING_SLASH
+	COMPAT_CFLAGS += -DMKDIR_WO_TRAILING_SLASH
+	COMPAT_OBJS += compat/mkdir.o
+endif
 ifdef NO_MKSTEMPS
 	COMPAT_CFLAGS += -DNO_MKSTEMPS
 endif
-- 
1.7.12

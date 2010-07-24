From: Lynn.Lin@emc.com
Subject: [PATCH] Makefile: don't include git  version file on 'make clean'
Date: Sat, 24 Jul 2010 11:53:47 +0800
Message-ID: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
Cc: Lynn Lin <Lynn.Lin@emc.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 05:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcVoX-0002hw-Pf
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 05:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab0GXDyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 23:54:12 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:52146 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab0GXDyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 23:54:11 -0400
Received: from hop04-l1d11-si04.isus.emc.com (HOP04-L1D11-SI04.isus.emc.com [10.254.111.24])
	by mexforward.lss.emc.com (Switch-3.3.2/Switch-3.1.7) with ESMTP id o6O3sAVi029897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 23:54:10 -0400
Received: from mailhub.lss.emc.com (nagas.lss.emc.com [10.254.144.15]) by hop04-l1d11-si04.isus.emc.com (RSA Interceptor) for <git@vger.kernel.org>; Fri, 23 Jul 2010 23:54:09 -0400
Received: from lynn-platypus.corp.emc.com ([10.32.100.173])
	by mailhub.lss.emc.com (Switch-3.4.2/Switch-3.3.2mp) with ESMTP id o6O3s7LQ016110;
	Fri, 23 Jul 2010 23:54:08 -0400
X-Mailer: git-send-email 1.7.1
X-EMM-EM: Active
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151601>

From: Lynn Lin <Lynn.Lin@emc.com>

---
 Makefile         |    4 +++-
 git-gui/Makefile |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bc3c570..eb28b98 100644
--- a/Makefile
+++ b/Makefile
@@ -238,7 +238,9 @@ all::
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
--include GIT-VERSION-FILE
+ifneq "$(MAKECMDGOALS)" "clean"
+  -include GIT-VERSION-FILE
+endif
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
diff --git a/git-gui/Makefile b/git-gui/Makefile
index 197b55e..91e1ea5 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -9,7 +9,9 @@ all::
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
--include GIT-VERSION-FILE
+ifneq "$(MAKECMDGOALS)" "clean"
+  -include GIT-VERSION-FILE
+endif
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
-- 
1.7.1

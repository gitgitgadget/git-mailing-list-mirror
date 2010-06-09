From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH next 1/2] Makefile: add PYTHON_PATH to GIT-BUILD-OPTIONS
Date: Wed,  9 Jun 2010 16:23:59 -0500
Message-ID: <nduJYSHPH3U3cC4hTqPaVi-iLDqB7pemU3zevJMNRmyDsRKmtq_gVu-G9W-She7bPSFG9LafRk0@cipher.nrlssc.navy.mil>
Cc: srabbelier@gmail.com, johan@herland.net, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 23:24:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSl9-0001ks-ML
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 23:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361Ab0FIVYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 17:24:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40253 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab0FIVYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 17:24:21 -0400
Received: by mail.nrlssc.navy.mil id o59LOCcm014041; Wed, 9 Jun 2010 16:24:13 -0500
X-OriginalArrivalTime: 09 Jun 2010 21:24:13.0121 (UTC) FILETIME=[1B597310:01CB081A]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148820>

From: Brandon Casey <drafnel@gmail.com>

The PYTHON_PATH environment variable is not set when running test scripts
manually i.e. when not using 'make test'.  Scripts which attempt to use
this variable will fail.  So add it to the list of variables written to
the GIT-BUILD-OPTIONS file so that the test suite will import it when
running the test scripts.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 34b7dd5..b529340 100644
--- a/Makefile
+++ b/Makefile
@@ -1949,6 +1949,7 @@ GIT-CFLAGS: FORCE
 GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@
+	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@
 	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
-- 
1.6.6.2

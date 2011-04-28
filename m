From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 02/13] Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
Date: Thu, 28 Apr 2011 21:04:00 +0200
Message-ID: <1304017451-12283-3-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:04:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWW9-00036F-S0
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410Ab1D1TEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:04:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62309 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab1D1TEk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:40 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3481029wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=LSyZJw9i5Ys+EVaDletvsdRN/v9sPJ1qAznTBG32JNQ=;
        b=G/q5Obc4TDM/xBSIeLth5V32Mx6zqXK6N9R/eFFxeTx37C5m4OniTAvTVx8Mr7YTwE
         xAK9xSZGLk4eGfX81mHM4ScG9Yy0chg6scC0VAwHperKC87z0zyvwr4+Qiu6sc/kVur2
         rGqtE6ruN4bkgQe/JRxA8smiwM+GrfNwkMFDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eoKswPnvomWiklFElvD0kmTEsNAIgnpeJC0VE4IYMXwxi1XrXAIhW3Cwx1M4fOPhvg
         UmRpJwR97M9LYq8TPZ9DqfQt6g7BE3G1mBfG4LDnl3ZUZwODm38XeCHtyR9VF77sCLx0
         1R4nu6KcV5DKrtmg/77zzSF4qDI2bw0EPQH+s=
Received: by 10.227.203.145 with SMTP id fi17mr3886228wbb.106.1304017479906;
        Thu, 28 Apr 2011 12:04:39 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.38
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172383>

Now that there is gitweb/Makefile, let's leave only "gitweb" and
"install-gitweb" targets in main Makefile.  Those targets just
delegate to gitweb's Makefile.

Requested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is kind of new in this version of series.

This was [independently] requested in

  Re: [PATCHv2 00/11] gitweb: Change timezone in dates using JavaScript
  http://thread.gmane.org/gmane.comp.version-control.git/171600/focus=171801

This patch was sent to git mailing list as

  [PATCH 12/11] Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
  http://thread.gmane.org/gmane.comp.version-control.git/171600/focus=171802

and included in 'jn/gitweb-js' (a174d61).

This can be considered cleanup after previous patch.

 Makefile |   26 --------------------------
 1 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 8960cee..d0c577b 100644
--- a/Makefile
+++ b/Makefile
@@ -1747,32 +1747,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
-ifdef JSMIN
-GITWEB_PROGRAMS += gitweb/static/gitweb.min.js
-GITWEB_JS = gitweb/static/gitweb.min.js
-else
-GITWEB_JS = gitweb/static/gitweb.js
-endif
-ifdef CSSMIN
-GITWEB_PROGRAMS += gitweb/static/gitweb.min.css
-GITWEB_CSS = gitweb/static/gitweb.min.css
-else
-GITWEB_CSS = gitweb/static/gitweb.css
-endif
-OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_PROGRAMS)
-gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-
-ifdef JSMIN
-gitweb/static/gitweb.min.js: gitweb/static/gitweb.js
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-endif # JSMIN
-ifdef CSSMIN
-gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-endif # CSSMIN
-
-
 git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-- 
1.7.3

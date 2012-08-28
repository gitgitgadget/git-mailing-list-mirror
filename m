From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 02/16] Add git-remote-testsvn to Makefile
Date: Tue, 28 Aug 2012 10:49:36 +0200
Message-ID: <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:51:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWJ-00022f-9r
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679Ab2H1IvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:09 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2H1IvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1532823bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gMMvi+8ddIS1YudQuxVu/uLHb8aR4eRl0m63yd7Lz+I=;
        b=iZgtAr6cPrNF3KV7J2xs5NuE3tNyiiflNuMW+C9k2Agmp5zeTwyRDPSoHHPlLeCuii
         X9nHLChDR9uMgLpzGc/ApeZ2kvTy/k+jReMzjf0wAr1qodIKNTUdzS2jjzdKC73QCn0+
         aB6spuQUA+wZRD43BVUXIVd8/LwhPjMnFxGId8/DudD3RlhAxxlwsMaxDAC2jQVxz3IQ
         j3dsqeThdGa6L4wYy1HEE6CS3JfyBSxXr5r1yj46vmMvIKKm8ZbhJKa1O3CGUaSSzf7i
         qdK/0HQHDS1g/Uw7ysGLysWJMZjrjb9wChr82q+ljpEnBruRlxLwPN/b4APLJBg7d10y
         F/xQ==
Received: by 10.204.130.156 with SMTP id t28mr4730938bks.33.1346143860897;
        Tue, 28 Aug 2012 01:51:00 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.50.48
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:50:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204409>

The link-rule is a copy of the standard git$X rule but adds VCSSVN_LIB.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 66e8216..1b09454 100644
--- a/Makefile
+++ b/Makefile
@@ -477,6 +477,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -2352,6 +2353,10 @@ git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
+	$(VCSSVN_LIB)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
-- 
1.7.9.5

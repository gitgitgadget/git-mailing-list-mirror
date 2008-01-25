From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] autoconf: Add test for sys/select.h header file
Date: Fri, 25 Jan 2008 12:19:41 +0100
Message-ID: <1201259981-7115-1-git-send-email-jnareb@gmail.com>
References: <20080124183446.GJ30676@schiele.dyndns.org>
Cc: Robert Schiele <rschiele@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 12:20:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIMbf-0003Mp-6x
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 12:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbYAYLTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 06:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbYAYLTv
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 06:19:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:54784 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYAYLTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 06:19:50 -0500
Received: by fg-out-1718.google.com with SMTP id e21so621178fga.17
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 03:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oBh1U+XngXmjDPu24NIn2Y9X/8Tgu2ena5cJee4Yl6M=;
        b=EhgDbrdCK+6Bg1Mdj9Q17S0GUcXGuSMtizpkWmY0hGsXFCRJvK2sjMtx+uzZDzZbaBp5N+17TrnGqp/+IsdEzX2hNtGwL4zrOC+KCOtFXilQGs050/iVkue0dVW9Ongd9L4Czsz+8v0+hMECIj1HuXz6SefA2PxdGJ2erwnB7xI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kN1UhmmqptYOLMacxeisKABQhy3BSvq7nEpEIgTFBGHX52kewmMR96gdrxhZ9PXdW/7m9MrZWp32zl5fLPAeLitdgzYsvazOJ8PR29WmCHmOU9hLAUSfC9zS0Uvzw8QUAtowHhopNmdG8GfAY4DYI/tLq10Cc8RVa3XgkacBYJY=
Received: by 10.82.152.16 with SMTP id z16mr3355512bud.17.1201259989133;
        Fri, 25 Jan 2008 03:19:49 -0800 (PST)
Received: from localhost.localdomain ( [83.8.250.186])
        by mx.google.com with ESMTPS id p10sm2522488gvf.8.2008.01.25.03.19.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Jan 2008 03:19:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0PBJhDI007130;
	Fri, 25 Jan 2008 12:19:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0PBJgXY007129;
	Fri, 25 Jan 2008 12:19:42 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <20080124183446.GJ30676@schiele.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71698>

Some systems like HP-UX don't have sys/select.h; the select stuff
is already present in some other headef file (e.g. sys/time.h for
HP-UX).

Companion to
  "some systems don't have (and need) sys/select.h"

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It could be alternately just squashed together with
"some systems don't have (and need) sys/select.h" by Robert Schiele.

Robert, could you please check this patch on HP-UX? It does work
correctly on Linux (which has sys/select.h).

 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 40b14d9..ee6c33d 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -30,6 +30,7 @@ NO_CURL=@NO_CURL@
 NO_EXPAT=@NO_EXPAT@
 NEEDS_LIBICONV=@NEEDS_LIBICONV@
 NEEDS_SOCKET=@NEEDS_SOCKET@
+NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
 NO_D_INO_IN_DIRENT=@NO_D_INO_IN_DIRENT@
 NO_D_TYPE_IN_DIRENT=@NO_D_TYPE_IN_DIRENT@
 NO_SOCKADDR_STORAGE=@NO_SOCKADDR_STORAGE@
diff --git a/configure.ac b/configure.ac
index af177fd..85d7ef5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -235,6 +235,12 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
 ## Checks for header files.
 AC_MSG_NOTICE([CHECKS for header files])
 #
+# Define NO_SYS_SELECT_H if you don't have sys/select.h.
+AC_CHECK_HEADER([sys/select.h],
+[NO_SYS_SELECT_H=],
+[NO_SYS_SELECT_H=UnfortunatelyYes])
+AC_SUBST(NO_SYS_SELECT_H)
+#
 # Define OLD_ICONV if your library has an old iconv(), where the second
 # (input buffer pointer) parameter is declared with type (const char **).
 AC_DEFUN([OLDICONVTEST_SRC], [[
-- 
1.5.3.7

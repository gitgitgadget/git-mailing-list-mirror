From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Build on Debian GNU/Hurd
Date: Fri, 15 Sep 2006 12:58:46 +0000
Message-ID: <20060915125846.10469.qmail@ccc765dd61a02d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 15 14:59:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GODHL-0004Sw-N2
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 14:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWIOM60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 08:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWIOM60
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 08:58:26 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:27578 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751293AbWIOM60 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 08:58:26 -0400
Received: (qmail 10470 invoked by uid 1000); 15 Sep 2006 12:58:46 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27084>

Patch from Cyril Brulebois to make the build process detect and support the
Debian GNU/Hurd architecture, see
 http://bugs.debian.org/379841

Signed-off-by: Gerrit Pape <pape@smarden.org>

---
 Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 7b3114f..6e36eff 100644
--- a/Makefile
+++ b/Makefile
@@ -383,6 +383,11 @@ ifeq ($(uname_S),NetBSD)
 	ALL_CFLAGS += -I/usr/pkg/include
 	ALL_LDFLAGS += -L/usr/pkg/lib -Wl,-rpath,/usr/pkg/lib
 endif
+ifeq ($(uname_S),GNU)
+       # GNU stands for GNU/Hurd
+       NO_STRLCPY = YesPlease
+       ALL_CFLAGS += -DPATH_MAX=4096
+endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
 	NO_STRLCPY = YesPlease
-- 
1.4.2.1

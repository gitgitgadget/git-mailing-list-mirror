From: diger <admin@freenet59.ru>
Subject: patch for fix build git on Haiku
Date: Fri, 22 Feb 2013 20:13:09 +0500
Organization: =?UTF-8?Q?=D0=9E=D0=9E=D0=9E_"=D0=9A=D0=BE=D0=BC=D0=BF=D0=B0=D0=BD=D0=B8=D1=8F_=D0=9A=D0=BE=D1=80=D0=BE=D0=BD=D0=B0"?=
Message-ID: <254e4f8fb172cec1e547413e2828b642@freenet59.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:32:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8ube-00006v-CB
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 16:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287Ab3BVPbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 10:31:49 -0500
Received: from freenet59.ru ([81.4.234.4]:29332 "EHLO freenet59.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757259Ab3BVPbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 10:31:48 -0500
X-Greylist: delayed 1117 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2013 10:31:48 EST
Received: from [192.168.4.7] (helo=mail.freenet59.ru)
	by freenet59.ru with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72 (FreeBSD))
	(envelope-from <admin@freenet59.ru>)
	id 1U8uJB-000HpG-DS
	for git@vger.kernel.org; Fri, 22 Feb 2013 21:13:09 +0600
X-Sender: admin@freenet59.ru
User-Agent: RoundCube Webmail/0.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216835>

This patch fixes build git on Haiku


----------------
$NetBSD$

--- Makefile.orig	2012-10-21 21:32:15.000000000 +0000
+++ Makefile
@@ -1211,6 +1204,16 @@ ifeq ($(uname_S),HP-UX)
 	endif
 	GIT_TEST_CMP = cmp
 endif
+ifeq ($(uname_S),Haiku)
+    NO_R_TO_GCC_LINKER = YesPlease
+    NO_LIBGEN_H = YesPlease
+    NO_MEMMEM = YesPlease
+    NO_MKSTEMPS = YesPlease
+    NEEDS_LIBICONV = YesPlease
+    DEFAULT_EDITOR = nano
+    PTHREAD_LIBS =    -lroot
+    NO_CROSS_DIRECTORY_HARDLINKS = YesPlease
+endif
 ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;









--------------------




-- 
Jabber ID: admin@freenet59.ru
-- 

From: Jeff King <peff@peff.net>
Subject: [PATCH 10/13] Makefile: drop *_SQ variables
Date: Wed, 5 Feb 2014 12:58:59 -0500
Message-ID: <20140205175859.GJ15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:59:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6kd-0005Lv-37
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbaBER7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:59:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:45157 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753029AbaBER7B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:59:01 -0500
Received: (qmail 8118 invoked by uid 102); 5 Feb 2014 17:59:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:59:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:58:59 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241629>

Now that all uses of the SQ variables have been dropped, we
can stop setting the variables.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/Makefile b/Makefile
index b1c3fb4..cd07a70 100644
--- a/Makefile
+++ b/Makefile
@@ -1039,7 +1039,6 @@ endif
 endif
 
 ifdef SANE_TOOL_PATH
-SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
 BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(call sqi,$(SANE_TOOL_PATH)|'
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
@@ -1594,31 +1593,6 @@ MAKE/$1: FORCE
 	fi
 endef
 
-# Shell quote (do not use $(call) to accommodate ancient setups);
-
-SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
-ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
-ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
-
-DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
-bindir_SQ = $(subst ','\'',$(bindir))
-bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
-mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
-infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
-localedir_SQ = $(subst ','\'',$(localedir))
-gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
-template_dir_SQ = $(subst ','\'',$(template_dir))
-htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
-prefix_SQ = $(subst ','\'',$(prefix))
-gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
-
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
-TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
-DIFF_SQ = $(subst ','\'',$(DIFF))
-PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
-
 LIBS = $(GITLIBS) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER=$(call sq,$(SHA1_HEADER)) \
@@ -2302,7 +2276,6 @@ gitexec_instdir = $(gitexecdir)
 else
 gitexec_instdir = $(prefix)/$(gitexecdir)
 endif
-gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
 export gitexec_instdir
 
 ifneq ($(filter /%,$(firstword $(mergetoolsdir))),)
@@ -2310,7 +2283,6 @@ mergetools_instdir = $(mergetoolsdir)
 else
 mergetools_instdir = $(prefix)/$(mergetoolsdir)
 endif
-mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
-- 
1.8.5.2.500.g8060133

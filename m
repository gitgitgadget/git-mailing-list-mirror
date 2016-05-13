From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] git-gui: Remove ancient Cygwin compatibility code
Date: Fri, 13 May 2016 12:11:22 +0100
Message-ID: <20160513111122.GD2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 13:11:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1B0H-0000OX-1h
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 13:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbcEMLL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 07:11:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33746 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbcEMLL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 07:11:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so3017067wme.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BriZb1EXbYB1KsQpCT3MEvLiEwXwL+DoHPbu/4Frk5Q=;
        b=uFg4fH9Q49EEsodASuvy6z5sr1jiBqQxU8TO9IIZvM+gu7qxD+KP67GGlf0O5HjhNK
         ktkS/QPXyipj5KAyq6inSON38fGD0aV6KPVmbrtXYuOicrjpx5GNrszmAPOpTSxQ1at/
         aN5gbFXMuxv/RhFkTNSyDRasO7OPNgv1Y1WnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BriZb1EXbYB1KsQpCT3MEvLiEwXwL+DoHPbu/4Frk5Q=;
        b=Z72K/Dfazmp3EWXEeAJq2CPPcXL2rqpbs24mC/zTgFThN0+bwA3yZ3Q8z7B1A1/rhk
         7/xVHmwtn89C7sSYCBfIx8N9boggkjSZRzyWgmI/KTYnzcSmiK5AOTFeou7GxrJ9Uo9L
         WbwPXWloBMzKLA3QfBUwLWkALzpLJGJsMhRhQXORaVvR0VwjDN13UESMc6P0W+4COqls
         XcKVPQclB1qTo7TLsR+Th8Q1SKXACqD+CKJ+NvtHk3upfzhhBLGgGiH6c6sCvHXpmxJp
         pIQYGDPL3dacUFcogroLR1sypdNOP0xQAYz3eIMYNkdhorQfH9Ry/ZX0IvyqWph4sBc+
         srdQ==
X-Gm-Message-State: AOPr4FXzpD0dOw9ohQ9zNbrc7drdAeV6Lb3hUgYFfCNI+jJK6ZiT0p6Wq0xR5mVyTqSMJQ==
X-Received: by 10.194.17.106 with SMTP id n10mr15148522wjd.131.1463137885700;
        Fri, 13 May 2016 04:11:25 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id x124sm2724159wmg.24.2016.05.13.04.11.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 04:11:24 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294523>

>From 50c9cbb6ce31529316ba004194f63a24ae59b4b0 Mon Sep 17 00:00:00 2001
From: Adam Dinwoodie <adam@dinwoodie.org>
Date: Fri, 13 May 2016 11:52:32 +0100
Subject: [PATCH] git-gui: Remove unused Cygwin compatibility code

Cygwin-distributed builds of git-gui have patched out the
Cygwin-specific compatibility code in the Makefile before compiling
since at least the start of 2012 (specifically since at least Git
v1.7.9).  The compatibility code is clearly not necessary, so remove it
from the official git-gui code as well.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

I originally submitted this patch back in December, but it didn't
generate any more discussion than Junio saying "this looks like a good
thing to have."  I'm resubmitting to try to generate further discussion
/ agreement to include the patch.

An equivalent patch has been included in the downstream Cygwin releases
since v1.7.9, and therefore is clearly stable and not causing any
notable problems.

I've based this patch off the git-gui tree rather than the main Git tree
per the SubmittingPatches doc.  Pipe it through `sed
's!Makekfile!git-gui/\0!g'` for a version that applies cleanly to the
main Git source tree.

 Makefile | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index fe30be3..a0adf3d 100644
--- a/Makefile
+++ b/Makefile
@@ -136,25 +136,11 @@
 GITGUI_RELATIVE :=
 GITGUI_MACOSXAPP :=
 
-ifeq ($(uname_O),Cygwin)
-	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
-
-	# Is this a Cygwin Tcl/Tk binary?  If so it knows how to do
-	# POSIX path translation just like cygpath does and we must
-	# keep libdir in POSIX format so Cygwin packages of git-gui
-	# work no matter where the user installs them.
-	#
-	ifeq ($(shell echo 'puts [file normalize /]' | '$(TCL_PATH_SQ)'),$(shell cygpath --mixed --absolute /))
-		gg_libdir_sed_in := $(gg_libdir)
-	else
-		gg_libdir_sed_in := $(shell cygpath --windows --absolute "$(gg_libdir)")
-	endif
-else
-	ifeq ($(exedir),$(gg_libdir))
-		GITGUI_RELATIVE := 1
-	endif
-	gg_libdir_sed_in := $(gg_libdir)
-endif
+ifeq ($(exedir),$(gg_libdir))
+	GITGUI_RELATIVE := 1
+endif
+gg_libdir_sed_in := $(gg_libdir)
+
 ifeq ($(uname_S),Darwin)
 	ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
 		GITGUI_MACOSXAPP := YesPlease
-- 
2.8.2.692.g8d9a515

From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/2] git-gui: make config gui.warndetachedcommit a boolean
Date: Sat, 22 Oct 2011 21:39:39 +0200
Message-ID: <0f4995b5df707782c73ec83171fb2f512ae887ef.1319312280.git.bert.wesarg@googlemail.com>
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHhQ8-0002ke-Up
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab1JVTjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:39:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56803 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab1JVTjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:39:46 -0400
Received: by bkbzt19 with SMTP id zt19so6300526bkb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=IkQgb0ej5STX/UOlszK4vO83XVSWd5pnACYnTEFyoZk=;
        b=eUsa1wZqs6Prk7X0VnZf9+R8tZTwXiV6qHl0A+zUZcFtbPCam38Uj4Dmo0Yef6UA/K
         eJRVjYZMFqhHpOidQGux+SZJqSquqdcYfyFu9CEwb1MwyWh6cAF2ABuFnIlb7qDtTy6Y
         XeEcUAEetpxOYD8RCoYleP0Uzg2bI+9+oydHU=
Received: by 10.204.141.142 with SMTP id m14mr13310127bku.89.1319312384574;
        Sat, 22 Oct 2011 12:39:44 -0700 (PDT)
Received: from localhost (p5B2AD0E6.dip.t-dialin.net. [91.42.208.230])
        by mx.google.com with ESMTPS id w8sm17785998bks.11.2011.10.22.12.39.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 12:39:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.908.g383b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184122>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/commit.tcl |    2 +-
 lib/option.tcl |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index 372bed9..e27e148 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -263,7 +263,7 @@ proc commit_commitmsg {curHEAD msg_p} {
 	global is_detached repo_config
 	global pch_error
 
-	if {$is_detached && $repo_config(gui.warndetachedcommit)} {
+	if {$is_detached && [is_config_true gui.warndetachedcommit]} {
 		set msg [mc "You are about to commit on a detached head.\
 This is a potentially dangerous thing to do because if you switch\
 to another branch you will loose your changes and it can be difficult\
diff --git a/lib/option.tcl b/lib/option.tcl
index 719103a..f7f866b 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -156,6 +156,7 @@ proc do_options {} {
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		{c gui.encoding {mc "Default File Contents Encoding"}}
+		{b gui.warndetachedcommit {mc "Warn before commiting to a detached head"}}
 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
 		} {
 		set type [lindex $option 0]
-- 
1.7.7.908.g383b5

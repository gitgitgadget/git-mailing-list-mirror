From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: span widgets over the full file output area in the blame view
Date: Thu, 20 Oct 2011 21:30:30 +0200
Message-ID: <16d7f36e4d24d8816035f934836395e5f854f1d3.1319138993.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 21:30:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGyK7-0005fc-MD
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 21:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab1JTTaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 15:30:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36930 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab1JTTae (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 15:30:34 -0400
Received: by bkbzt19 with SMTP id zt19so3919197bkb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=UORpMZfyaYdeRqhewX3i14yeC3QDk8RTVDGtfto3sqg=;
        b=xQV8EUhXyPZwKAevr/gTAmRsXO208BaeQKJ1eFYj7A0UADwIotlS43fsE5ORevJutI
         MibVIzTQauP+Qt2AUIwSLwTkG5fouYa+uVgDftAqv1u0Zw4nfpwPWKAbGCwubjQjzog2
         9gER56brlBX+CSsalxet8ZbNCWHFB4M2lhL7g=
Received: by 10.204.153.217 with SMTP id l25mr8982025bkw.0.1319139033254;
        Thu, 20 Oct 2011 12:30:33 -0700 (PDT)
Received: from localhost (p5B2AD78D.dip.t-dialin.net. [91.42.215.141])
        by mx.google.com with ESMTPS id e14sm10914708bka.0.2011.10.20.12.30.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 12:30:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.759.gfc8c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184038>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/blame.tcl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 49eae19..b031e66 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -219,7 +219,8 @@ constructor new {i_commit i_path i_jump} {
 	eval grid $w_columns $w.file_pane.out.sby -sticky nsew
 	grid conf \
 		$w.file_pane.out.sbx \
-		-column [expr {[llength $w_columns] - 1}] \
+		-column 0 \
+		-columnspan [expr {[llength $w_columns] + 1}] \
 		-sticky we
 	grid columnconfigure \
 		$w.file_pane.out \
@@ -229,12 +230,14 @@ constructor new {i_commit i_path i_jump} {
 
 	set finder [::searchbar::new \
 		$w.file_pane.out.ff $w_file \
-		-column [expr {[llength $w_columns] - 1}] \
+		-column 0 \
+		-columnspan [expr {[llength $w_columns] + 1}] \
 		]
 
 	set gotoline [::linebar::new \
 		$w.file_pane.out.lf $w_file \
-		-column [expr {[llength $w_columns] - 1}] \
+		-column 0 \
+		-columnspan [expr {[llength $w_columns] + 1}] \
 		]
 
 	set w_cviewer $w.file_pane.cm.t
-- 
1.7.7.759.gfc8c6

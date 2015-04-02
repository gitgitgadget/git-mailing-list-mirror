From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] gitk: Remove mc parameter from proc show_error
Date: Thu,  2 Apr 2015 15:05:35 -0600
Message-ID: <1428008735-10943-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: paulus@samba.org, bernt@norang.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 23:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdmJ9-00029U-Sv
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 23:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbbDBVFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 17:05:42 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33294 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbDBVFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 17:05:41 -0400
Received: by pdbnk13 with SMTP id nk13so20676275pdb.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=t6Nm56RwpdkXtBfhv4ba2bWzVJz6IhrgHao9EhcVN+M=;
        b=Aud3PDafHhYTvB/y+e/Dh73wC1t2uFZ6TOlHD0tlBOGMPv6kWXjmuiGacBYpWqZ+pH
         uBO++w3sOiYCD/FNbjMKF1V8MEStdRD7nRQXQFa8wID31d2G45Pa6tqlmiV3KWAqCOfq
         m/w/ewqIYWCwdr8kKc5YtjkETOLihAA9SJ9+Dd39VLRHInWXR/DMdnU7eAjYghAcPRDH
         eNf9EXdxaZMF4/dtr5VycdFza8ZVRbGRwf5vF1/el08Dw/mBiTgF9IpD4e+ruuQJE8N+
         c7mXQZ8pzgjCl2PQdStVJ9dfjLv+KDx0BZoHjMkKar0J6pywS+ZtpdBM7sVlRJK7VJ8S
         lj2Q==
X-Received: by 10.68.97.65 with SMTP id dy1mr90670758pbb.10.1428008741109;
        Thu, 02 Apr 2015 14:05:41 -0700 (PDT)
Received: from alex-wolverine.uconnect.utah.edu ([155.99.227.128])
        by mx.google.com with ESMTPSA id q3sm6125563pds.49.2015.04.02.14.05.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 14:05:39 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266677>

This partially reverts commit 8d849957d81fc0480a52570d66cc3c2a688ecb1b.

This change makes the string "OK" translatable and the string "mc" not
translatable. It will take effect the next time `make update-po` is run.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 30fcd30..7193f6f 100755
--- a/gitk
+++ b/gitk
@@ -1894,13 +1894,13 @@ proc make_transient {window origin} {
     }
 }
 
-proc show_error {w top msg {mc mc}} {
+proc show_error {w top msg} {
     global NS
     if {![info exists NS]} {set NS ""}
     if {[wm state $top] eq "withdrawn"} { wm deiconify $top }
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    ${NS}::button $w.ok -default active -text [$mc OK] -command "destroy $top"
+    ${NS}::button $w.ok -default active -text [mc OK] -command "destroy $top"
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
     bind $top <Key-Return> "destroy $top"
-- 
2.3.5

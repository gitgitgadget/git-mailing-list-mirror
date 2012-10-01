From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] gitk: Add workaround for system where Shift-F5 mapped to Shift-XF86_Switch_VT_5
Date: Mon,  1 Oct 2012 11:16:04 -0400
Message-ID: <1349104564-30812-2-git-send-email-andrew.kw.w@gmail.com>
References: <1349104564-30812-1-git-send-email-andrew.kw.w@gmail.com>
Cc: szeder@ira.uka.de, paulus@samba.org,
	Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 17:17:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIhkO-0002sW-8P
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 17:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab2JAPRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 11:17:19 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49360 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab2JAPRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 11:17:18 -0400
Received: by ieak13 with SMTP id k13so12352519iea.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rPR/Ogh9fdZwpvp+HkfOPb+30kM3eI+4czBADc02ZP8=;
        b=0fKxLp2trEQD/JE/foNxgWuN2Kq4rqgCkNEjoQm8GRU5lCfzOe5XmGlAtwsmuijFIz
         M9V+MlRweFVYpaimVGvDxM+5u4gbhxe5UHqQD8AB0jwhxclQkrSUIfHHik/Z8FxpBGDg
         C4VbtTK1tXKjGYjng9yYplXK7+5At/xgs0dp0aSa/MI1KGgaMmqMOPogrXfoBoYf7r0V
         kiVYO4NRyK8XbdLfvSz/RbF8GPMdSHyBtlLu6uELpKDVj9KSgUY+++kCW0gtkbBjLOxR
         1kdsKrhqPqeRw59OGkc6dMPevjA7K1Nzn/rIORDmKrZIHn8bVZ2d1S/SpCJswnvzyZSw
         5L2w==
Received: by 10.50.7.232 with SMTP id m8mr6005291iga.48.1349104637902;
        Mon, 01 Oct 2012 08:17:17 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id uj6sm7184834igb.4.2012.10.01.08.17.14
        (version=SSLv3 cipher=OTHER);
        Mon, 01 Oct 2012 08:17:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
In-Reply-To: <1349104564-30812-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206736>

The same workaround was used for Shift-F4 in:
  cea07cf8dc9b3677e0c50433c0d72bce83adbdc7

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 gitk-git/gitk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..698b84a 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2496,6 +2496,7 @@ proc makewindow {} {
     bindkey f nextfile
     bind . <F5> updatecommits
     bind . <Shift-F5> reloadcommits
+    catch { bind . <Shift-Key-XF86_Switch_VT_5> reloadcommits }
     bind . <F2> showrefs
     bind . <Shift-F4> {newview 0}
     catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
-- 
1.7.12.1.382.gb0576a6

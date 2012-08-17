From: vi0oss@gmail.com
Subject: [PATCH] git-gui: Fix semi-working shortcuts for unstage and revert
Date: Fri, 17 Aug 2012 06:19:34 +0300
Message-ID: <1345173574-13087-1-git-send-email-vi0oss@gmail.com>
Cc: vi0oss@gmail.com, patthoyts@users.sourceforge.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 05:20:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2D6o-0004jl-0q
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 05:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933667Ab2HQDUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 23:20:18 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:54249 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933650Ab2HQDUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 23:20:17 -0400
Received: by wibhq12 with SMTP id hq12so1088091wib.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2012 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=na8FX0uB2K2AJAHICxJrT8yhiYUifwAa11e+WJ8AVpE=;
        b=JEobQGYakEcor0vE5Y9QRTzzN2JgpzCIraE3caMTsVCO3LIbgeVybvEZ4sZeTbgU9Q
         3YJSXNR97LynsIRSvhtsDosBLahsGgcuwdcwlR1jDS+Cu9N9s08XPpSf6AJcgN9tOFNj
         1SWaXM7DEFc8C4+SW+lnyKzHjMfIWIV6sDOkF2us6HkJI+yqZl6/OoMNvsuEC/hWc5II
         invKdi1z44UpecRaAEQeZUZ9t+h1B/LB9my1lI2ixBqocWfLQMY7rvdQDUkHYgqPp6Z/
         AVREEsxaKlnBH2o/CBDVOiETqv1dWeopqL56NX/Ajvp2JZ7yqG+KBfQgsN9zIAXfO7e8
         uX/A==
Received: by 10.180.84.169 with SMTP id a9mr1310668wiz.8.1345173615338;
        Thu, 16 Aug 2012 20:20:15 -0700 (PDT)
Received: from localhost.localdomain ([87.252.227.84])
        by mx.google.com with ESMTPS id ep14sm7514077wid.0.2012.08.16.20.20.14
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Aug 2012 20:20:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vitaly _Vi Shukela <vi0oss@gmail.com>

Make Ctrl+U for unstaging and Ctrl+J for reverting selection behave
more like Ctrl+T for adding.

They were working only when one area was focused (diff or commit message),
now they should work everywhere.

Signed-off-by: Vitaly _Vi Shukela <vi0oss@gmail.com>
---
No reply to previous email received,
re-sending with new Cc: as recommented on #git-devel.

 git-gui/git-gui.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index ba4e5c1..6618016 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3710,6 +3710,8 @@ bind $ui_diff <$M1B-Key-v> {break}
 bind $ui_diff <$M1B-Key-V> {break}
 bind $ui_diff <$M1B-Key-a> {%W tag add sel 0.0 end;break}
 bind $ui_diff <$M1B-Key-A> {%W tag add sel 0.0 end;break}
+bind $ui_diff <$M1B-Key-j> {do_revert_selection;break}
+bind $ui_diff <$M1B-Key-J> {do_revert_selection;break}
 bind $ui_diff <Key-Up>     {catch {%W yview scroll -1 units};break}
 bind $ui_diff <Key-Down>   {catch {%W yview scroll  1 units};break}
 bind $ui_diff <Key-Left>   {catch {%W xview scroll -1 units};break}
@@ -3742,6 +3744,8 @@ bind .   <$M1B-Key-s> do_signoff
 bind .   <$M1B-Key-S> do_signoff
 bind .   <$M1B-Key-t> do_add_selection
 bind .   <$M1B-Key-T> do_add_selection
+bind .   <$M1B-Key-u> do_unstage_selection
+bind .   <$M1B-Key-U> do_unstage_selection
 bind .   <$M1B-Key-j> do_revert_selection
 bind .   <$M1B-Key-J> do_revert_selection
 bind .   <$M1B-Key-i> do_add_all
-- 
1.7.8.5

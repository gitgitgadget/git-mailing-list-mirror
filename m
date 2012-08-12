From: vi0oss@gmail.com
Subject: [PATCH] git-gui: Fix semi-working shortcuts for unstage and revert
Date: Sun, 12 Aug 2012 18:53:25 +0300
Message-ID: <1344786805-29301-1-git-send-email-vi0oss@gmail.com>
Cc: vi0oss@gmail.com, bert.wesarg@googlemail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 17:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0aVK-0000YL-92
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 17:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab2HLPyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 11:54:20 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47831 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab2HLPyT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 11:54:19 -0400
Received: by weyx8 with SMTP id x8so1997602wey.19
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/m7C2NsKBOCk7vyNUm9UmRcVYM6Q0b2tGFCQSg48dp0=;
        b=PYZFw+HHntHQnEXafNw2qNKUp43dPJcBN1Okgs2UAU79siNGw2T7n63cw53LUbM+PK
         nlwriG1jp/YiFunhBb0qCAqBAnj4NMObNYC8H+za1neMxz+qbyYzOXHV90N+EJ4mwOK7
         z4IjwoqDhcuR1QIOT4Dx05CrC+zy7fZH707frx84iiROanFTw4sHjLfdyjFv393uzxW/
         mShH6Xlfn7eVaJpWKLke6VGQdj+diz2QQfEI6hp2+ZOYHVkY/oX3OkDGC+Sgpo3Y1KID
         ft4Vdybn5/irt8YluiAdUxeREr5duKdUnclC1hMBKihqBM+px4Ca2UBIlM9sP4c1kJQD
         qt8w==
Received: by 10.180.103.136 with SMTP id fw8mr11342562wib.20.1344786858292;
        Sun, 12 Aug 2012 08:54:18 -0700 (PDT)
Received: from localhost.localdomain ([87.252.227.84])
        by mx.google.com with ESMTPS id k20sm11120264wiv.11.2012.08.12.08.54.17
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Aug 2012 08:54:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203310>

From: Vitaly _Vi Shukela <vi0oss@gmail.com>

Make Ctrl+U for unstaging and Ctrl+J for reverting selection behave
more like Ctrl+T for adding.

They were working only when one area was focused (diff or commit message),
now they should work everywhere.

Signed-off-by: Vitaly _Vi Shukela <vi0oss@gmail.com>
---
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

From: vi0oss@gmail.com
Subject: [PATCH] git-gui: Fix semi-working shortcuts for unstage and revert
Date: Sat, 15 Sep 2012 02:36:41 +0300
Message-ID: <1347665801-22634-1-git-send-email-vi0oss@gmail.com>
Cc: vi0oss@gmail.com, patthoyts@users.sourceforge.net,
	bert.wesarg@googlemail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 01:38:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCfSV-0002bc-Ti
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 01:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760295Ab2INXhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 19:37:06 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36508 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab2INXhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 19:37:05 -0400
Received: by wibhi8 with SMTP id hi8so398304wib.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=I+wAYeeZ/wcn0PdaMIpcyMQzbx3dIEjF4gs8RGafcUU=;
        b=wWZXu/LSa5oMrpQYmgZuaQM5k+bQnX75wlCBixROL0tcTDljFmUtvg9TSrChuUjd5M
         fT/WTu0kGwAlEo/doe4Dt7BP+9wjGGvkPHF5C5Jj+fCg06lAkRfirvcUIiVP1q5sHUJm
         vTBrUczAv9p+5JlgtT0JFAxb+c9rwgnX9V8AGi23CFvZaUK36yQCHHFhK1CIBYNS88Zx
         qp496umZJnA25BeL5x4RHFlMJFXHNPROJVZI82E8azD0IvFn9rKxyb1PT4ChtUes4CTi
         PGP/sDvNplHdx/IBLWjW5VzcBHR3EenIIqv/lAxo6cQy1hXLIbiy729M+/ZVtPRpvdsr
         CC0w==
Received: by 10.216.133.148 with SMTP id q20mr2078346wei.201.1347665823778;
        Fri, 14 Sep 2012 16:37:03 -0700 (PDT)
Received: from localhost.localdomain ([87.252.227.84])
        by mx.google.com with ESMTPS id hv8sm5697497wib.0.2012.09.14.16.37.02
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 16:37:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205542>

From: Vitaly _Vi Shukela <vi0oss@gmail.com>

Make Ctrl+U for unstaging and Ctrl+J for reverting selection behave
more like Ctrl+T for adding.

They were working only when one area was focused (diff or commit message),
now they should work everywhere.

Signed-off-by: Vitaly _Vi Shukela <vi0oss@gmail.com>
---
Sending the patch the third time (haven't got any replies to previous two attempts).

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

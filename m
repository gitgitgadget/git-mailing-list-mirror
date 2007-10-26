From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Test suite: reset TERM to its previous value after testing.
Date: Fri, 26 Oct 2007 06:13:50 +0200
Message-ID: <20071026061350.bd090e26.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 06:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlGTQ-0006Ha-S2
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 06:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXJZEGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 00:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbXJZEGw
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 00:06:52 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36055 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbXJZEGv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 00:06:51 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 51F6F1AB2BB;
	Fri, 26 Oct 2007 06:06:50 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 110851AB2B9;
	Fri, 26 Oct 2007 06:06:50 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62391>

Using konsole, I get no colored output at the end of "t7005-editor.sh"
without this patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7005-editor.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

This patch should be applied on top of Pierre Habouzit's
"Add some fancy colors in the test library when terminal supports it."
patch.

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 28643b0..01cc0c0 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -4,6 +4,8 @@ test_description='GIT_EDITOR, core.editor, and stuff'
 
 . ./test-lib.sh
 
+OLD_TERM="$TERM"
+
 for i in GIT_EDITOR core_editor EDITOR VISUAL vi
 do
 	cat >e-$i.sh <<-EOF
@@ -88,4 +90,6 @@ do
 	'
 done
 
+TERM="$OLD_TERM"
+
 test_done
-- 
1.5.3.4.1494.g253d

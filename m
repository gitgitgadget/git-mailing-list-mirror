From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] t7005-editor: Use $SHELL_PATH in the editor scripts
Date: Wed, 25 Mar 2009 21:31:26 +0100
Message-ID: <200903252131.26561.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmZmc-00063p-VY
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 21:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbZCYUbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 16:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZCYUbf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 16:31:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:13020 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbZCYUbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 16:31:34 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 13CBB2C4013;
	Wed, 25 Mar 2009 21:31:27 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 254E61D1D5;
	Wed, 25 Mar 2009 21:31:27 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114658>

The test sets up various shell scripts and uses them as commit message
editors.  On Windows, we need a shebang line in order to recognize the
files as executable shell scripts.  This adds it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This one and the next patch can go on top of js/windows-tests.
 Or you again pull from

   git://repo.or.cz/git/mingw/j6t.git for-junio

 -- Hannes

 t/t7005-editor.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 2f8404a..e83bc8f 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -7,6 +7,7 @@ test_description='GIT_EDITOR, core.editor, and stuff'
 for i in GIT_EDITOR core_editor EDITOR VISUAL vi
 do
 	cat >e-$i.sh <<-EOF
+	#!$SHELL_PATH
 	echo "Edited by $i" >"\$1"
 	EOF
 	chmod +x e-$i.sh
-- 
1.6.2.1.224.g2225f

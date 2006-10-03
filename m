From: Robert Shearman <rob@codeweavers.com>
Subject: [PATCH] git-rebase: Use --ignore-if-in-upstream option when executing
 git-format-patch.
Date: Tue, 03 Oct 2006 17:29:26 +0100
Organization: CodeWeavers
Message-ID: <45228FE6.5060206@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040204020008060205060707"
X-From: git-owner@vger.kernel.org Tue Oct 03 18:30:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUn9k-0002zb-DZ
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 18:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWJCQaB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 12:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWJCQaB
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 12:30:01 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:21910 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1750853AbWJCQ37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 12:29:59 -0400
Received: from host86-139-249-184.range86-139.btcentralplus.com ([86.139.249.184] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GUn9a-00077d-Is
	for git@vger.kernel.org; Tue, 03 Oct 2006 11:29:58 -0500
User-Agent: Thunderbird 1.5.0.7 (X11/20060921)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28274>

This is a multi-part message in MIME format.
--------------040204020008060205060707
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


This reduces the number of conflicts when rebasing after a series of 
patches to the same piece of code is committed upstream.

Signed-off-by: Robert Shearman <rob@codeweavers.com>
---
  git-rebase.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

--------------040204020008060205060707
Content-Type: text/x-patch;
 name="b751c3c0da70a7b1dfddb5dd42412f1d2f1cc73d.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b751c3c0da70a7b1dfddb5dd42412f1d2f1cc73d.diff"

diff --git a/git-rebase.sh b/git-rebase.sh
index a7373c0..413636e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -286,7 +286,7 @@ fi
 
 if test -z "$do_merge"
 then
-	git-format-patch -k --stdout --full-index "$upstream"..ORIG_HEAD |
+	git-format-patch -k --stdout --full-index --ignore-if-in-upstream "$upstream"..ORIG_HEAD |
 	git am --binary -3 -k --resolvemsg="$RESOLVEMSG" \
 		--reflog-action=rebase
 	exit $?


--------------040204020008060205060707--

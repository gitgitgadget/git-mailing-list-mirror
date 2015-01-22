From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] Fix unclosed here document in t3301.sh
Date: Thu, 22 Jan 2015 12:59:36 +0100
Message-ID: <20150122115936.GA2358@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 13:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEGk8-0002TL-Nv
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 13:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbbAVMUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 07:20:09 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:52550 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbbAVMUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 07:20:07 -0500
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2015 07:20:07 EST
Received: from localhost (localhost [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 1AEB61C278;
	Thu, 22 Jan 2015 12:59:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KKYDgTK3Ignm; Thu, 22 Jan 2015 12:59:24 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 9D1D91C1F4;
	Thu, 22 Jan 2015 12:59:24 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 560117E186; Thu, 22 Jan 2015 12:59:36 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262823>

Commit 908a3203632a02568df230c0fccf9a2cd8da24e6 introduced  indentation
to here documents in t3301.sh. However in one place <<-EOF was missing
-, which broke this test when run with mksh-50d. This commit fixes it.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t3301-notes.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 245406a..433f925 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -658,7 +658,7 @@ test_expect_success '--show-notes=* adds to GIT_NOTES_DISPLAY_REF' '
 '
 
 test_expect_success '--no-standard-notes' '
-	cat >expect-commits <<EOF
+	cat >expect-commits <<-EOF
 		commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
 		Author: A U Thor <author@example.com>
 		Date:   Thu Apr 7 15:18:13 2005 -0700
-- 
2.2.2

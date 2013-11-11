From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 5/7] test-hg.sh: avoid obsolete 'test' syntax
Date: Sun, 10 Nov 2013 23:05:10 -0500
Message-ID: <1384142712-2936-6-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 05:08:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfinN-0004P7-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 05:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab3KKEIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 23:08:10 -0500
Received: from smtp.bbn.com ([128.33.0.80]:12991 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab3KKEII (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 23:08:08 -0500
Received: from socket.bbn.com ([192.1.120.102]:57645)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VfinH-0004dy-R7; Sun, 10 Nov 2013 23:08:07 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 207893FF72
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237602>

The POSIX spec says that the '-a', '-o', and parentheses operands to
the 'test' utility are obsolete extensions due to the potential for
ambiguity.  Replace '-o' with '|| test' to avoid unspecified behavior.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-hg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 558a656..84c67ff 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -83,7 +83,7 @@ check_push () {
 		test $ref_ret -ne 0 && echo "match for '$branch' failed" && break
 	done
 
-	if test $expected_ret -ne $ret -o $ref_ret -ne 0
+	if test $expected_ret -ne $ret || test $ref_ret -ne 0
 	then
 		return 1
 	fi
-- 
1.8.5.rc1.207.gc17dd22

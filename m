From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Fri, 24 Apr 2009 18:18:52 -0500
Message-ID: <Co3qF9iC9xgxpoIzGtFpX2wpm0wGMRif6RL6YZX1xKxhwc2RmS02g8PwAw16-_n3Wi-vA_tZ8Mg@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 01:20:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUhK-00085x-K7
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbZDXXTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbZDXXTG
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:19:06 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51210 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbZDXXTG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:19:06 -0400
Received: by mail.nrlssc.navy.mil id n3ONIxT6030532; Fri, 24 Apr 2009 18:18:59 -0500
X-OriginalArrivalTime: 24 Apr 2009 23:18:59.0194 (UTC) FILETIME=[0BFD8DA0:01C9C533]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117515>

The '--no-thread' option is a Getopt::Long boolean option. The '--no-'
prefix (as in --no-thread) for boolean options is not supported in
Getopt::Long version 2.32 which was released with Perl 5.8.0. This version
only supports '--no' as in '--nothread'.  More recent versions of
Getopt::Long, such as version 2.34, support either prefix. So use the older
form in the tests.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9001-send-email.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d9420e0..ce26ea4 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -616,7 +616,7 @@ test_expect_success 'in-reply-to but no threading' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--in-reply-to="<in-reply-id@example.com>" \
-		--no-thread \
+		--nothread \
 		$patches |
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
-- 
1.6.2.4.24.gde59d2

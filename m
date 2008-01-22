From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t9001: add missing && operators
Date: Mon, 21 Jan 2008 22:23:53 -0500
Message-ID: <20080122032353.GB24758@coredump.intra.peff.net>
References: <m2y7aj9glo.fsf@userprimary.net> <1200945466-21154-1-git-send-email-hendeby@isy.liu.se> <1200945466-21154-2-git-send-email-hendeby@isy.liu.se> <20080122031932.GA24758@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustaf Hendeby <hendeby@isy.liu.se>,
	Seth Falcon <seth@userprimary.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 04:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH9kS-0005I4-Gc
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 04:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbYAVDX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 22:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYAVDX4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 22:23:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1732 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbYAVDXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 22:23:55 -0500
Received: (qmail 30524 invoked by uid 111); 22 Jan 2008 03:23:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 21 Jan 2008 22:23:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jan 2008 22:23:53 -0500
Content-Disposition: inline
In-Reply-To: <20080122031932.GA24758@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71409>


The exit value of some commands was not being used for the
test output.

Signed-off-by: Jeff King <peff@peff.net>
---
On Mon, Jan 21, 2008 at 10:19:32PM -0500, Jeff King wrote:

> As penance, I'll send some tests in a moment.

This turned into a 3-patch series because of some cleanup needed. This
first one is just tightening up the setup tests, which will be modified
in the next patch.

 t/t9001-send-email.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4f6822f..08f7c3d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -8,7 +8,7 @@ test_expect_success \
     'prepare reference tree' \
     'echo "1A quick brown fox jumps over the" >file &&
      echo "lazy dog" >>file &&
-     git add file
+     git add file &&
      GIT_AUTHOR_NAME="A" git commit -a -m "Initial."'
 
 test_expect_success \
@@ -20,9 +20,9 @@ test_expect_success \
       echo "  echo \"!\$a!\""
       echo "done >commandline"
       echo "cat > msgtxt"
-      ) >fake.sendmail
-     chmod +x ./fake.sendmail
-     git add fake.sendmail
+      ) >fake.sendmail &&
+     chmod +x ./fake.sendmail &&
+     git add fake.sendmail &&
      GIT_AUTHOR_NAME="A" git commit -a -m "Second."'
 
 test_expect_success 'Extract patches' '
-- 
1.5.4.rc3.1130.gd9718-dirty

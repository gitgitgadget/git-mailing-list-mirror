From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Need to set PAGER in tests
Date: Wed, 10 Aug 2005 22:10:01 -0400
Message-ID: <1123726201.18644.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 11 04:11:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E32WS-0000IT-FB
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 04:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVHKCKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 22:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVHKCKH
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 22:10:07 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:18914 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932178AbVHKCKG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 22:10:06 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E32U2-0006zS-M0
	for git@vger.kernel.org; Wed, 10 Aug 2005 22:07:50 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E32WA-0004tO-A4
	for git@vger.kernel.org; Wed, 10 Aug 2005 22:10:02 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7B2A1Ag018807
	for git@vger.kernel.org; Wed, 10 Aug 2005 22:10:01 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

"t5400-send-pack.sh --verbose" stops waiting for user input.  It happens
because "git log" uses less for output now.  To prevent this, PAGER
should be set to cat.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/t/test-lib.sh b/t/test-lib.sh
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -5,8 +5,9 @@
 
 # For repeatability, reset the environment to known value.
 LANG=C
+PAGER=cat
 TZ=UTC
-export LANG TZ
+export LANG PAGER TZ
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
 unset AUTHOR_NAME

-- 
Regards,
Pavel Roskin

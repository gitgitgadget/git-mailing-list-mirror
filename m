X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/2] Set HOME to the test directory to avoid reading ~/.stgitrc
Date: Tue, 28 Nov 2006 22:59:25 -0500
Message-ID: <20061129035925.6118.78329.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 03:59:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32612>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpGbc-0002HQ-03 for gcvg-git@gmane.org; Wed, 29 Nov
 2006 04:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758631AbWK2D73 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 22:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758644AbWK2D73
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 22:59:29 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:28856 "EHLO
 fencepost.gnu.org") by vger.kernel.org with ESMTP id S1758631AbWK2D72 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 22:59:28 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.52) id
 1GpGbX-0006IJ-9V for git@vger.kernel.org; Tue, 28 Nov 2006 22:59:27 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com) by gnu.org with
 esmtp (Exim 4.63) (envelope-from <proski@gnu.org>) id 1GpGbV-0001an-Pi; Tue,
 28 Nov 2006 22:59:25 -0500
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

This makes the tests more system independent and allows better testing
for "stg mail" command.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 t/test-lib.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6339c54..459d5cb 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -193,7 +193,8 @@ test_done () {
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in trash subdirectory.
 PATH=$(pwd)/..:$PATH
-export PATH
+HOME=$(pwd)/trash
+export PATH HOME
 
 
 # Test repository

From: Scott Moser <smoser@brickies.net>
Subject: [PATCH] explicitly set LANG to 'C' in for guilt run-tests
Date: Mon, 29 Sep 2008 14:51:12 -0400
Message-ID: <1222714272-9557-1-git-send-email-smoser@brickies.net>
Cc: git@vger.kernel.org, Scott Moser <smoser@brickies.net>
To: "Josef \"Jeff\" Sipek" <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:54:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNsc-00010f-7l
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbYI2Swn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbYI2Swn
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:52:43 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:42285 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbYI2Swm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:52:42 -0400
Received: from spunkymail-a17.g.dreamhost.com (sd-green-bigip-83.dreamhost.com [208.97.132.83])
	by hapkido.dreamhost.com (Postfix) with ESMTP id DEFCE17951E
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 11:52:41 -0700 (PDT)
Received: from localhost.localdomain (d14-69-66-169.try.wideopenwest.com [69.14.169.66])
	by spunkymail-a17.g.dreamhost.com (Postfix) with ESMTP id 5580A7350E;
	Mon, 29 Sep 2008 11:51:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97046>

The output of guilt's run-tests is dependent on LANG due to reliance on a
given sorting algorithm. Currently, the test '052' will fail if LANG is
set to 'en_US.UTF-8' (and likely others values).

Remove the assumption by explicitly setting this in run-tests.

Signed-off-by: Scott Moser <smoser@brickies.net>
---
 regression/run-tests |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/regression/run-tests b/regression/run-tests
index 8f572eb..945150b 100755
--- a/regression/run-tests
+++ b/regression/run-tests
@@ -2,6 +2,7 @@
 
 export REG_DIR="$PWD"
 export PATH="$PWD/bin:$PATH"
+export LANG=C
 
 source scaffold
 
-- 
1.5.6.3

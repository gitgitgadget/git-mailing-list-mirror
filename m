From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] everyday: replace 'prune' with 'gc --prune'
Date: Thu, 20 Dec 2007 15:05:45 +0100
Message-ID: <1198159546-11368-1-git-send-email-vmiklos@frugalware.org>
References: <20071219225618.GA7378@genesis.frugalware.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 15:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5M2a-0007EC-4v
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 15:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759061AbXLTOF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 09:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759388AbXLTOF7
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 09:05:59 -0500
Received: from virgo.iok.hu ([193.202.89.103]:16996 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758997AbXLTOF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 09:05:58 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A76571B2513;
	Thu, 20 Dec 2007 15:05:54 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 97EF94465F;
	Thu, 20 Dec 2007 15:04:35 +0100 (CET)
Received: from vmobile.example.net (dsl5401C9AC.pool.t-online.hu [84.1.201.172])
	by genesis.frugalware.org (Postfix) with ESMTP id 19E861190054;
	Thu, 20 Dec 2007 15:05:54 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 5BF53186CD7; Thu, 20 Dec 2007 15:05:46 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.67.gf9c5-dirty
In-Reply-To: <20071219225618.GA7378@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69006>

This document is for newcomers, so it's good to mention gc for housekeeping
tasks instead of running prune manually.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/everyday.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index ce7c170..a09c1d9 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -30,8 +30,6 @@ Everybody uses these commands to maintain git repositories.
 
   * gitlink:git-fsck[1] to check the repository for errors.
 
-  * gitlink:git-prune[1] to remove unused objects in the repository.
-
   * gitlink:git-repack[1] to pack loose objects for efficiency.
 
   * gitlink:git-gc[1] to do common housekeeping tasks such as
@@ -56,13 +54,13 @@ disk space is wasted by not repacking.
 <3> without `-a` repacks incrementally.  repacking every 4-5MB
 of loose objects accumulation may be a good rule of thumb.
 <4> it is easier to use `git gc` than individual housekeeping commands
-such as `prune` and `repack`.  This runs `repack -a -d`.
+such as `prune` and `repack`.
 
 Repack a small project into single pack.::
 +
 ------------
 $ git repack -a -d <1>
-$ git prune
+$ git gc --prune
 ------------
 +
 <1> pack all the objects reachable from the refs into one pack,
@@ -189,7 +187,7 @@ $ git pull <3>
 $ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <4>
 $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <5>
 $ git reset --hard ORIG_HEAD <6>
-$ git prune <7>
+$ git gc --prune <7>
 $ git fetch --tags <8>
 ------------
 +
-- 
1.5.4.rc0.67.gf9c5-dirty

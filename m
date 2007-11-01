From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Document that using -M without other diff options is not a good idea
Date: Thu,  1 Nov 2007 15:57:39 +0100
Message-ID: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:59:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InbW5-0004QH-Ix
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbXKAO7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbXKAO7F
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:59:05 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55125 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbXKAO7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:59:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DAAEA1B2502;
	Thu,  1 Nov 2007 15:59:01 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 282074465B;
	Thu,  1 Nov 2007 15:58:35 +0100 (CET)
Received: from vmobile.example.net (dsl5401C90E.pool.t-online.hu [84.1.201.14])
	by genesis.frugalware.org (Postfix) with ESMTP id 4003F13A40D2;
	Thu,  1 Nov 2007 15:59:01 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6F14B186D6F; Thu,  1 Nov 2007 15:57:40 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62970>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I just noticed that I used 'git log -M' in some scripts which is obviously bad.
People should not use that option without other diff options.

 Documentation/diff-options.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b1f528a..ed827f8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -92,7 +92,9 @@
 	Break complete rewrite changes into pairs of delete and create.
 
 -M::
-	Detect renames.
+	Detect renames. It's no good using this option if you don't use diff
+	options like `--name-status`, `-p` or `--stat` as it will just slow
+	down the revision walker.
 
 -C::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
-- 
1.5.3.5

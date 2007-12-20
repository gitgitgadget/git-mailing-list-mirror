From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] everyday: replace 'repack' with 'gc'
Date: Thu, 20 Dec 2007 15:05:46 +0100
Message-ID: <1198159546-11368-2-git-send-email-vmiklos@frugalware.org>
References: <1198159546-11368-1-git-send-email-vmiklos@frugalware.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 15:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5M2Z-0007EC-GE
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 15:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933AbXLTOF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 09:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758997AbXLTOF5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 09:05:57 -0500
Received: from virgo.iok.hu ([193.202.89.103]:16994 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755726AbXLTOF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 09:05:56 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A2E1D1B2510;
	Thu, 20 Dec 2007 15:05:54 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9B95A44660;
	Thu, 20 Dec 2007 15:04:35 +0100 (CET)
Received: from vmobile.example.net (dsl5401C9AC.pool.t-online.hu [84.1.201.172])
	by genesis.frugalware.org (Postfix) with ESMTP id 1B938119019C;
	Thu, 20 Dec 2007 15:05:54 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 640CD186CD6; Thu, 20 Dec 2007 15:05:46 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.67.gf9c5-dirty
In-Reply-To: <1198159546-11368-1-git-send-email-vmiklos@frugalware.org>
In-Reply-To: <20071219225618.GA7378@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69005>

Most users don't want to run git repack manually, so suggest using gc instead.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/everyday.txt |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index a09c1d9..f1993e2 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -30,8 +30,6 @@ Everybody uses these commands to maintain git repositories.
 
   * gitlink:git-fsck[1] to check the repository for errors.
 
-  * gitlink:git-repack[1] to pack loose objects for efficiency.
-
   * gitlink:git-gc[1] to do common housekeeping tasks such as
     repack and prune.
 
@@ -43,23 +41,20 @@ Check health and remove cruft.::
 ------------
 $ git fsck <1>
 $ git count-objects <2>
-$ git repack <3>
-$ git gc <4>
+$ git gc <3>
 ------------
 +
 <1> running without `\--full` is usually cheap and assures the
 repository health reasonably well.
 <2> check how many loose objects there are and how much
 disk space is wasted by not repacking.
-<3> without `-a` repacks incrementally.  repacking every 4-5MB
-of loose objects accumulation may be a good rule of thumb.
-<4> it is easier to use `git gc` than individual housekeeping commands
-such as `prune` and `repack`.
+<3> repacks the local repository and performs other housekeeping tasks. Running
+without `--prune` is a safe operation even while other ones are in progress.
 
 Repack a small project into single pack.::
 +
 ------------
-$ git repack -a -d <1>
+$ git gc <1>
 $ git gc --prune
 ------------
 +
-- 
1.5.4.rc0.67.gf9c5-dirty

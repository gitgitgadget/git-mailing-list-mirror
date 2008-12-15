From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Force t5302 to use a single thread
Date: Mon, 15 Dec 2008 20:44:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812152044030.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 20:37:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCJFe-0004Eb-8z
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 20:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbYLOTfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 14:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYLOTfw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 14:35:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:51556 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751844AbYLOTfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 14:35:51 -0500
Received: (qmail invoked by alias); 15 Dec 2008 19:35:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 15 Dec 2008 20:35:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wQAxiGeywFO4b5Ys42bR+n98PnQtLTxCnXZnBy6
	uWkaDQDsCtcCE8
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103200>


If the packs are made using multiple threads, they are no longer identical
on the 4-core Xeon I tested on.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	... or did I do something wrong?

 t/t5302-pack-index.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 884e242..e6f70d4 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -10,6 +10,7 @@ test_expect_success \
     'setup' \
     'rm -rf .git
      git init &&
+     git config pack.threads 1 &&
      i=1 &&
      while test $i -le 100
      do
-- 
1.6.0.4.1189.g8876f

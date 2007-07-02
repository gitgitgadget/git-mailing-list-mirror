From: Jeff King <peff@peff.net>
Subject: [PATCH] git-stash: fix "can't shift that many" with no arguments
Date: Mon, 2 Jul 2007 00:20:34 -0400
Message-ID: <20070702042034.GB29384@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@bluebottle.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 06:20:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5DOx-0007mh-DF
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 06:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbXGBEUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 00:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbXGBEUh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 00:20:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3523 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXGBEUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 00:20:36 -0400
Received: (qmail 10761 invoked from network); 2 Jul 2007 04:20:57 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 2 Jul 2007 04:20:57 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2007 00:20:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51341>


Signed-off-by: Jeff King <peff@peff.net>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ec18ef6..7644bd5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -133,7 +133,7 @@ apply_stash () {
 # Main command set
 case "$1" in
 list | '')
-	shift
+	test $# -gt 0 && shift
 	if test $# = 0
 	then
 		set x -n 10
-- 
1.5.2.2.1452.g896f6

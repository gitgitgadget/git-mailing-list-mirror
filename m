From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add test-chmtime: a utility to change mtime on files
Date: Sat, 24 Feb 2007 18:15:12 -0800
Message-ID: <20070225021512.GA31849@mayonaise.dyndns.org>
References: <11723651923476-git-send-email-normalperson@yhbt.net> <Pine.LNX.4.63.0702250220130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 03:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL8v1-0004Xj-Jw
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 03:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933630AbXBYCPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 21:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933631AbXBYCPP
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 21:15:15 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35773 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933630AbXBYCPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 21:15:14 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1C78B2DC01A;
	Sat, 24 Feb 2007 18:15:13 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 24 Feb 2007 18:15:12 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702250220130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40531>

As brought up by Johannes Schindelin, some people run tests
within the t/ directory and often without make.  We need to
check and inform those users to build test-chmtime before
running those tests.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/test-lib.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a403fe0..c075474 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -264,6 +264,12 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
+if ! test -x ../test-chmtime; then
+	echo >&2 'You need to build test-chmtime:'
+	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
+	exit 1
+fi
+
 # Test repository
 test=trash
 rm -fr "$test"
-- 
1.5.0.137.ge6502

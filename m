From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] git-clean fails on files beginning with a dash
Date: Mon, 29 May 2006 17:06:32 +0200
Message-ID: <20060529150632.G6794bab6@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 17:06:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkjKN-0001sb-F1
	for gcvg-git@gmane.org; Mon, 29 May 2006 17:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWE2PGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 11:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWE2PGk
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 11:06:40 -0400
Received: from v345.ncsrv.de ([89.110.145.104]:31132 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1750994AbWE2PGk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 11:06:40 -0400
Received: from leonov.stosberg.net (p213.54.87.107.tisdip.tiscali.de [213.54.87.107])
	by ncs.stosberg.net (Postfix) with ESMTP id EE29F589000C
	for <git@vger.kernel.org>; Mon, 29 May 2006 17:06:28 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 91E941049A6; Mon, 29 May 2006 17:06:32 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Mon, 29 May 2006 14:43:58 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20949>

Reproducible with:

$ git init-db
$ echo "some text" >-file
$ git clean
Removing -file
rm: invalid option -- l
Try `rm --help' for more information.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 git-clean.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-clean.sh b/git-clean.sh
index bb56264..3834323 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -19,8 +19,8 @@ ignored=
 ignoredonly=
 cleandir=
 quiet=
-rmf="rm -f"
-rmrf="rm -rf"
+rmf="rm -f --"
+rmrf="rm -rf --"
 rm_refuse="echo Not removing"
 echo1="echo"
 
-- 
1.3.3+git20060528-dest1

From: Pavel Roskin <proski@gnu.org>
Subject: Re: qgit reports errors in the git repository
Date: Thu, 15 Dec 2005 11:44:55 -0500
Message-ID: <1134665095.27212.22.camel@dv>
References: <1134433440.3798.27.camel@dv>
	 <Pine.LNX.4.64.0512121700010.15597@g5.osdl.org>
	 <1134624477.5360.6.camel@dv>
	 <e5bfff550512150501v48bb65abwf44b3fc21f33bdf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Dec 15 17:51:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmwES-0001e9-KI
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 17:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVLOQpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 11:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVLOQpZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 11:45:25 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:30676 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750767AbVLOQpY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 11:45:24 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EmwCt-0006B4-Ge
	for git@vger.kernel.org; Thu, 15 Dec 2005 11:43:53 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EmwDv-0007KB-G0; Thu, 15 Dec 2005 11:44:55 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550512150501v48bb65abwf44b3fc21f33bdf6@mail.gmail.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13705>

Hello, Marco.

On Thu, 2005-12-15 at 14:01 +0100, Marco Costalba wrote:
> Just one quickly note. The error report says:
> git-cat-file 23ea3e201cea0deea909569e08e950a9ec2345f7

It's stderr from git-cat-file.  I guess git-cat-file could be improved.

> the error message should be:
> git-cat-file tag 23ea3e201cea0deea909569e08e950a9ec2345f7
> 
> because it is just the print out of the command line. Or we have 2 bugs ;-)

qgit doesn't print its command line at all when running commands
synchronously.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/src/myprocess.cpp b/src/myprocess.cpp
index 5eee6e1..baae026 100644
--- a/src/myprocess.cpp
+++ b/src/myprocess.cpp
@@ -49,6 +49,7 @@ int MyProcess::runAsync(SCRef rc, QObjec
 
 bool MyProcess::runSync(SCRef runCmd, QString* ro) {
 
+	this->runCmd = runCmd;
 	runOutput = ro;
 	if (runOutput != NULL)
 		*runOutput = "";



-- 
Regards,
Pavel Roskin

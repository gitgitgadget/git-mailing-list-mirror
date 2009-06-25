From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: man pages oddity from git-fetch.txt
Date: Thu, 25 Jun 2009 19:18:20 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090625171819.GM19869@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 19:45:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJt0p-0002kP-Tf
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 19:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbZFYRpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 13:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbZFYRpB
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 13:45:01 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43285 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbZFYRpA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 13:45:00 -0400
X-Greylist: delayed 1598 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2009 13:45:00 EDT
Received: from localhost (localhost [127.0.0.1])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id E77F5400048A2
	for <git@vger.kernel.org>; Thu, 25 Jun 2009 19:18:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at merkur.ins.uni-bonn.de
Received: from merkur.ins.uni-bonn.de ([127.0.0.1])
	by localhost (merkur.ins.uni-bonn.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSz3y7NZs4WK for <git@vger.kernel.org>;
	Thu, 25 Jun 2009 19:18:21 +0200 (CEST)
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 497474000431F
	for <git@vger.kernel.org>; Thu, 25 Jun 2009 19:18:21 +0200 (CEST)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
X-GMX-UID: E9wlIJYOaHI/GrH39iUlX2JvamdhZASC
X-Flags: 1000
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122226>

Hello giters,

git-fetch.1 and git-pull.1 from the man branch bogusly display for me
like this:

       -a, --append
           Append ref names and object names of fetched refs to the existing contents of will
           be overwritten.

with man 2.5.1, GNU groff 1.18.1 (note the part about FETCH_HEAD is
missing).  This apparently changed in 5ca22945a:man1/git-fetch.1:

-Append ref names and object names of fetched refs to the existing contents of \.git/FETCH_HEAD\
+Append ref names and object names of fetched refs to the existing contents of
+\.git/FETCH_HEAD\. Without this option old data in
+\.git/FETCH_HEAD
+will be overwritten\.

induced by 93d69d86: Refactored merge options into separate merge-options.txt.

--- /dev/null
+++ b/Documentation/fetch-options.txt
@@ -0,0 +1,14 @@
+-a, \--append::
+       Append ref names and object names of fetched refs to the
+       existing contents of `.git/FETCH_HEAD`.  Without this
+       option old data in `.git/FETCH_HEAD` will be overwritten.

[...]
--a, \--append::
-       Append ref names and object names of fetched refs to the
-       existing contents of $GIT_DIR/FETCH_HEAD.  Without this
-       option old data in $GIT_DIR/FETCH_HEAD will be overwritten.


I have no idea whether my man/groff is broken, or your asciidoc program,
or the sources; although, the online copy seems to be ok:
<http://www.kernel.org/pub/software/scm/git/docs/git-fetch.html>.

Cheers, and thanks for maintaining git,
Ralf

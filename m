From: Pavel Roskin <proski@gnu.org>
Subject: git-ls-files in subdirectories ignore higher-up .gitignore
Date: Tue, 24 Jan 2006 12:59:30 -0500
Message-ID: <1138125570.24415.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 24 19:01:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1STR-000133-9F
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 19:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWAXSAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 13:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWAXSAa
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 13:00:30 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:56503 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161014AbWAXSA3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 13:00:29 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F1SRz-00043l-3B
	for git@vger.kernel.org; Tue, 24 Jan 2006 13:00:18 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F1SS2-0002MN-Cc
	for git@vger.kernel.org; Tue, 24 Jan 2006 12:59:30 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15103>

Hello!

git-ls-files appears to behave in a way that may be unexpected to the
users.  When run in a subdirectory, git-ls-files never reads .gitignore
or whatever is specified by --exclude-per-directory in the parent
directories.

This can be demonstrated in git's own repository:

$ touch t/test.o
$ git-ls-files --others --exclude-per-directory=.gitignore
$ cd t
$ git-ls-files --others --exclude-per-directory=.gitignore
test.o
$

Before I attempt to fix it, I'd like to make sure it's a bug, not a
feature.

-- 
Regards,
Pavel Roskin

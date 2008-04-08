From: Joachim B Haga <jobh@broadpark.no>
Subject: git clean removes directories when not asked to
Date: Tue, 08 Apr 2008 20:22:56 +0200
Message-ID: <85prt0jjen.fsf@lupus.strangled.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 20:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjIaq-0007wa-2p
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 20:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbYDHSaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 14:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbYDHSaH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 14:30:07 -0400
Received: from main.gmane.org ([80.91.229.2]:35299 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604AbYDHSaG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 14:30:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JjIa2-00052k-8G
	for git@vger.kernel.org; Tue, 08 Apr 2008 18:30:02 +0000
Received: from 22.80-203-45.nextgentel.com ([80.203.45.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 18:30:02 +0000
Received: from jobh by 22.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 18:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 22.80-203-45.nextgentel.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:jsvUMIAWtOhVr6SqmkOMrhaeEhs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79012>

This is with debian packaged 1.5.4.4.

When invoked from a subdirectory, git clean removes more than it
should. According to the documentation, it should not remove
directories unless "-d" is given. However:


pep ~/src/test 0$ git init
Initialized empty Git repository in .git/
pep ~/src/test|master 0$ mkdir dir
pep ~/src/test|master 0$ mkdir dir/subdir
pep ~/src/test|master 0$ git clean -f
Not removing dir/
pep ~/src/test|master 0$ cd dir
pep ~/src/test/dir|master 0$ git clean -f
Removing subdir/
pep ~/src/test/dir|master 0$ ls subdir
ls: cannot access subdir: No such file or directory


Luckily I just lost some compilation results in this case, but this is
unexpected and dangerous behaviour.


(Additionally, I find the "-f" slightly annoying but that's not an issue here.)


-j

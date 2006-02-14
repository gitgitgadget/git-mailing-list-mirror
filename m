From: Greg KH <greg@kroah.com>
Subject: older git archive access broken in 1.2.0?
Date: Mon, 13 Feb 2006 21:06:16 -0800
Message-ID: <20060214050616.GA28528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 14 06:08:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8sQI-0007rg-DP
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 06:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWBNFGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 00:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWBNFGY
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 00:06:24 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:13205
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030420AbWBNFGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 00:06:15 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F8sOE-0001mO-95
	for git@vger.kernel.org; Mon, 13 Feb 2006 21:06:14 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16111>

I was trying to find where something changed in the historical Linux
kernel git tree:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

when I noticed that the latest version of git doesn't seem to like this
archive.  I can't clone it, but 'git log' and 'git whatchanged' seems to
work fine.

Also, gitk dies with the following error:
$ gitk
Error in startup script: fatal: '.git': unable to chdir or not a git archive
fatal: unexpected EOF
Failed to find remote refs
    while executing
"close $refd"
    (procedure "readrefs" line 41)
    invoked from within
"readrefs"
    (file "/home/greg/bin/gitk" line 3744)


Is this because I just synced the whole tree over using rsync and didn't
use git to clone it a long time ago?  Or that it was created with an
older version of git?

I'm not able to clone it locally either:
	$ git clone history.git/ test
	fatal: '/home/greg/linux/git/history.git/.git': unable to chdir or not a git archive
	fatal: unexpected EOF
	clone-pack from '/home/greg/linux/git/history.git/.git' failed.

I don't know when this broke with git, as it's been a long time since I
looked at this tree...

thanks,

greg k-h

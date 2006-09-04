From: Paul Mackerras <paulus@samba.org>
Subject: New git commit tool
Date: Mon, 4 Sep 2006 21:52:35 +1000
Message-ID: <17660.4995.977221.767112@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Sep 04 13:53:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKD0e-0004SG-A1
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 13:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWIDLwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 07:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWIDLwq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 07:52:46 -0400
Received: from ozlabs.org ([203.10.76.45]:6841 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964826AbWIDLwm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 07:52:42 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8106967BEC; Mon,  4 Sep 2006 21:52:41 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26415>

I have been working on a tool for creating commits, and I think it is
now far enough along to be useful.  I added it to the 'new' branch of
my gitk.git repository (git://git.kernel.org/pub/scm/gitk/gitk.git) or
you can fetch it from http://ozlabs.org/~paulus/gitool.

The way it works is that one "checks in" a set of changes, types a
message into the lower pane, then clicks the "Commit" button to create
the commit.  When the commit has been created, the tool exits.

The changes that have been checked in are recorded in the index.
Gitool can also undo checkins, restoring the index state for a file to
the original state (i.e. the state in the current HEAD commit).

At the top, gitool displays two lists of filenames, with an icon
beside each name.  The left-hand list shows modified files (whether
checked in or not), and the right-hand list shows new files (those
just added, and untracked files).  Clicking on the icon changes the
state of a file, alternating between not-checked-in and checked-in.

Clicking on the filename displays something useful; for a modified
file, it shows the changes made; for a new or untracked file, it shows
the contents of the file.

Files can also be partly checked in, for example, if changes were made
and checked in, and then further changes were made.  Clicking on such
a file will show a 3-way diff (HEAD vs. checked-in state vs. working
file), provided Junio applies my patch to diff-lib.c. :)

Gitool doesn't handle merge commits yet, but that is something I want
to implement soon, hopefully with the ability to resolve merge
conflicts in the tool.  There are quite a few other features I want to
implement as well (key bindings, font size selection, persistent
geometry).

Comments and suggestions are welcome.  Patches are even more
welcome. :)

Paul.

-- 
VGER BF report: U 0.977306

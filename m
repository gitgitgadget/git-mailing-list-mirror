From: Paul Mackerras <paulus@samba.org>
Subject: new gitk feature
Date: Wed, 26 Apr 2006 20:59:29 +1000
Message-ID: <17487.21137.344427.173131@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 26 12:59:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYhkE-0000en-KJ
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 12:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWDZK7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 06:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWDZK7j
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 06:59:39 -0400
Received: from ozlabs.org ([203.10.76.45]:15259 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932388AbWDZK7j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 06:59:39 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6BDC9679F8; Wed, 26 Apr 2006 20:59:38 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19197>

I just pushed some changes to gitk which add a new feature, the
ability to have multiple "views" of a repository.  Each view is a
subgraph of the full graph.  At the moment the only subgraph that you
can specify is the subgraph containing the commits that affect a
specified set of files or directories.  You can switch between views
quickly, and if the currently selected commit exists in the new view
when you switch views, it is selected in the new view.  There is one
view which always exists, the "All files" view.  If files or
directories are specified on the command line, a "Command line" view
is automatically created and selected at startup.

Thus, for the kernel repository I can have a "PPC" view which shows
changes to arch/powerpc, include/asm-powerpc etc.  When looking at a
commit in that view, I can switch to the "All files" view to see where
that commit fits in the overall history.

There is a "View" menu which contains the menu items for creating,
deleting, editing and selecting views.  If you check the "Remember
this view" box, gitk will write the definition of the view to your
~/.gitk file, and it will be automatically put in the list on startup.

I plan to add various other kinds of views, for example, a view that
shows only the commits that affect a selected file (or part of a file,
perhaps), and a view that shows just the current commit together with
all the commits that have tags.  (The latter will require some help
from git-rev-list. :)

Paul.

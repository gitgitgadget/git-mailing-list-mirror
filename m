From: Pavel Roskin <proski@gnu.org>
Subject: Ideas for qgit
Date: Mon, 20 Feb 2006 20:16:20 -0500
Message-ID: <1140484580.5282.54.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Feb 21 02:16:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBM8j-0000Bv-Hc
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 02:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWBUBQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 20:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWBUBQ0
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 20:16:26 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:5516 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161258AbWBUBQ0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 20:16:26 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FBM8c-0007Ac-RX
	for git@vger.kernel.org; Mon, 20 Feb 2006 20:16:22 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FBM8a-00026O-Ko; Mon, 20 Feb 2006 20:16:20 -0500
To: Marco Costalba <mcostalba@gmail.com>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16514>

Hello, Marco!

Many thanks for releasing qgit 1.1!  Here are things I'd like to be
fixed in the next version.

The pop-up menu on revisions gets duplicate entries for tags after using
the file viewer (try qgit on the qgit repository).  This is a pure bug
that may merit a minor release (1.1.1 perhaps).

Tags should be in a submenu.  There are too many of them in some
projects.  Maybe there should be a limit of e.g. 10 tags, and the "more
tags" entry that would invoke a dialog for searching tags (and possibly
other things).

If all branches are loaded, it would be nice to be able to switch
between branches in a similar way.

The "check working dir" feature picks up files unknown to git, such as
editor backups and diff files.  It is very rare that a commit only has
added files but no files are modified.  Maybe I need to learn a habit of
adding any file I'm not going to commit to .gitignore, but as it stands
now, this feature of qgit seems too obtrusive to me.  Neither "cg-diff"
not "stg diff" will pick untracked files, and it's not even an option
for either of them.

Current StGIT creates entries for all patches under .git/refs/patches,
which makes all corresponding entries purple.  I think qgit should
specifically recognize entries under .git/refs/patches
and .git/refs/bases and use other ways to highlight them.  At very
least, .git/refs/patches should be ignored.  More elaborate approach
would be to draw applied StGIT patches differently, e.g. as pluses or
hollow circles.

qgit doesn't display tags except by yellow highlight.  There is no tag
name and no way to see the tag object.  I think one way to do it would
be to draw marks in the description column, like gitk does.  Another
approach would be to put all corresponding information in the patch
description pane, perhaps highlighted.

It would be great to store the cache file somewhere under .git, perhaps
under a simpler name, such as .git/qgit-cache.  The trailing ".z" should
probably be dropped, since the users are not supposed to decompress the
file or know anything about its internal structure.

Settings should be reviewed for usefulness.  Some show go to the menu,
such as "Relative time in date column".  It's hard to imagine that
somebody would use this option permanently.  "Diff against working dir"
is already in the menu, and I don't think it merits to be in the
settings.  qgit can simply remember the menu setting.  "Load file names
in background" should probably become a pair of radio buttons, since the
antithesis is not obvious.


As far as I know, qgit is unique among git front-ends for being written
in a non-interpreted language.  This fits well with git being designed
for speed.  It would be great if qgit received its fair share of
attention from GUI experts that happen to be in the git list ;-)

-- 
Regards,
Pavel Roskin

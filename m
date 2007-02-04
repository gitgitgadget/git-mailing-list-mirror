From: Pavel Roskin <proski@gnu.org>
Subject: Navigating remote branches in qgit
Date: Sun, 04 Feb 2007 02:41:29 -0500
Message-ID: <1170574889.21644.38.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:41:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDc0F-0000Qf-Ou
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbXBDHle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbXBDHle
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:41:34 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48583 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbXBDHld (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:41:33 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDbz9-0003wr-FZ
	for git@vger.kernel.org; Sun, 04 Feb 2007 02:40:27 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDc09-0007oI-Sn; Sun, 04 Feb 2007 02:41:29 -0500
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38664>

Hello, Marco!

The forthcoming git 1.5 uses a different layout for the remote branches.
git-pull loads updates for all remote branches by default.  However,
most remote branches don't have a local branch corresponding to them.
The refs for remote branches are kept under refs/remotes.

It's easy to select qgit tags and local branches using the popup menu.
However, remote branches cannot be selected like this.

It's a pity, because it makes it hard for users to explore development
on remote branches, even though that information is available locally
and is shown by qgit.

It would be great if qgit added remote branches to the popup menu.  I
think the menu needs some grouping, which would be beneficial for new
users who don't know what is what.  Branches should be under "branches",
remote branches should be under "remotes", grouped by remotes, and tags
should be under "tags".

While at that, we should think how to show refs in a more compact manner
in the revision list.  I think "refs/" can be dropped in any case, since
qgit only scans under refs.  Any rectangle implies "refs/" already.
That's what gitk does.

We probably don't what to show StGIT bases at all, since they are rarely
useful for the users, and they are apparent as the first non-StGIT
commit.

Remote refs should recognized and be shown in a new color.  gitk uses
orange (#ffddaa) on the left and green on the right.  I think qgit
should use orange for the whole rectangle and drop "remotes/" in
addition to "refs/", since the color will imply it.

We may want to consider fancy shapes for the identifiers, like
gitk-style triangular tags for tags, some indicator of remoteness for
remotes and some indicator of "weirdness" for the refs we cannot
interpret specifically.  My concern is users with non-standard color
vision.  If we rely on an increasing number of colors, we should provide
a backup in case the colors cannot be distinguished.

It would be nice to have a refs browser that would show both loaded and
non-loaded refs, but I realize that it's not a quick fix type of change.

Please feel free to ask for help with testing and design of the
weirdness indicator :)

-- 
Regards,
Pavel Roskin

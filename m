From: elkten <elkton.gen@gmail.com>
Subject: Git within Git what a git
Date: Wed, 15 Apr 2009 19:10:21 -0700 (PDT)
Message-ID: <23070273.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 04:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuH55-0005kw-EP
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 04:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbZDPCKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 22:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752803AbZDPCKX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 22:10:23 -0400
Received: from kuber.nabble.com ([216.139.236.158]:47467 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbZDPCKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 22:10:22 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LuH3V-0007PD-KE
	for git@vger.kernel.org; Wed, 15 Apr 2009 19:10:21 -0700
X-Nabble-From: elkton.gen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116658>


Hi All,

Before I go hacking the git source code, I would like git to be able to
manage git trees in git trees, however I would like to check it can't
already be done, let me give an example...

Imagine a directory structure thus...

fedora12-rc3/
|-- .git
|-- init
|   `-- .git
|-- kernel
|   `-- .git
`-- libpng
    `-- .git

fedora12-rc3 is the attempt at a fedor12-rc3 build, inside are the packages
for init, the kernel and libpng, each of these init, kernel and libpng have
their own branches which correspond to their respective versions.

Inside the fedora12-rc3 directory is also many branches called fedora12-rc2,
fedora12-rc1 etc...

I would like to be able to "git checkout fedora12-rc1", and it to
automatically checkout the corresponding versions relating to fedora12-rc1,
into init, kernel and libpng.

When I make a new branch in say "init" and check in the changes, when I go
to the fedora12-rc1 branch I would like then to type git commit, and it
record the version change within the init branch, thus when I go to check
out the rc1 branch again I get all my changes.

If I switched branches and there were uncommitted changes in "kernel" it
would warn me and ask me if I wanted to continue.

There are various different merge options that would be nice to, say fred
was working on fedora12-rc2-fred and bob was working on fedroa12-rc2-bob,
and I wanted to merge the two together (and we had made changes to the same
packages) this would all be done for me.

I can understand this might be possible with some scripting, on git hooks,
however this would seem a neat feature for git to support itself, does
anybody have any scripts to do this?

Do other people think this would be a useful feature?

elk



-- 
View this message in context: http://www.nabble.com/Git-within-Git-what-a-git-tp23070273p23070273.html
Sent from the git mailing list archive at Nabble.com.

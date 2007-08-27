From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: git-svn tags and branches
Date: Mon, 27 Aug 2007 16:08:02 +0200
Message-ID: <faulrb$483$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 16:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPfgt-0003qS-F0
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 16:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbXH0OfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 10:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbXH0OfL
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 10:35:11 -0400
Received: from main.gmane.org ([80.91.229.2]:33361 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbXH0OfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 10:35:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IPfgE-0006fm-Dx
	for git@vger.kernel.org; Mon, 27 Aug 2007 16:35:02 +0200
Received: from host-62-10-78-152.cust-adsl.tiscali.it ([62.10.78.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 16:35:02 +0200
Received: from giuseppe.bilotta by host-62-10-78-152.cust-adsl.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 16:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-62-10-78-152.cust-adsl.tiscali.it
User-Agent: KNode/0.10.5
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56844>

Hello all,

I've recently started using git and I like it so much that
I've decided to start using it also for some svn-based
projects (in particular, rbot http://linuxbrit.co.uk/rbot).

The long term goal would be to move the project to git, but
for the time being (among the other things we're waiting for
Trac to have proper support for git, which is something that
won't happen before Trac 0.12 at least) I've decided to
experiment with a dual git/svn development process, using
(of course) git-svn.

My experience with toying around with it for a couple of
hours has been extremely positive, but I've got some
questions, especially about the tags and branch management.

Currently, git-svn imports svn tags as lightweight git tags.
I was susprised when I discovered this (from 'git describe'
failing and some helpful assistance on the IRC channel), so
I'm now wondering: is there a technical reason why they
aren't converted to annotated tags? If not, would it be
possible to implement this in git-svn, possibly with some
way to 'fix' existing git-svn repository?

My second question concerns the uses of branche in git-svn,
but it might come from a not perfect understanding of the
branching mechanism in git (and yes, I've read the
documentation and Wiki pages).

If I understand correctly, svn branches are imported in
git-svn as remote branches (refs/remote/*) and are
automatically updated on git-svn fetch or git-svn fetch-all.

In my experiments, however, I've noticed the following
behaviour.

git branch --track trunk remote/trunk
<do some changes and git commit them, while still on branch master>
git svn dcommit

Now, master and remote/trunk point to the new roundtripped
changes, but the branch 'trunk' (in git) remains pointing to
the old remote/trunk head. I would have expected the --track
option to keep trunk in sync with remote/trunk ...

Or am I missing something obvious?

-- 
Giuseppe "Oblomov" Bilotta

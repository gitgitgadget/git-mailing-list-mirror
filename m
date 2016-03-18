From: Henning Moll <newsScott@gmx.de>
Subject: [RFC] git-log should use the same diff-options as git-show
Date: Fri, 18 Mar 2016 21:47:03 +0000 (UTC)
Message-ID: <loom.20160318T222303-528@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 22:50:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah2Hd-0000lk-4m
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbcCRVuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:50:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:40038 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbcCRVuH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 17:50:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ah2HU-0000gp-A5
	for git@vger.kernel.org; Fri, 18 Mar 2016 22:50:04 +0100
Received: from host-188-174-216-138.customer.m-online.net ([188.174.216.138])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 22:50:04 +0100
Received: from newsScott by host-188-174-216-138.customer.m-online.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 22:50:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.174.216.138 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289258>

Hi

Recently i stumbled upon an old stash entry. It was clear to me that the
stash only contained non-indexed worktree changes. So i assumed to get
insight by doing

    $ git log -1 -p stash@{0}

But surprisingly the result was "no patch" (The problem which i was not
aware at that time was the fact that a stash commit is a merge). So i asked
a question on stackoverflow (1) an learned that there are different default
options used depending on the git command used:

    $ git show stash@{0}
    $ git diff stash@{0}^..stash@{0}

work with default, but for git-log i need to 

    $ git log -1 -p --cc stash@{0}

to make it behave the same. This does not seem reasonable to me, though i
read about commit 1aec791 (2) in git's own repository. What do you think?

Maybe - as a compromise - just show any kind of hint instead of nothing?

Best regards
Henning

(1) -
http://stackoverflow.com/questions/36089674/git-log-1-p-stash0-shows-empty-patch
(2) -
https://git.kaarsemaker.net/git/commit/1aec7917dc52901c6df301ddc8fea70f5ce0db09/

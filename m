From: layer <layer@known.net>
Subject: how to update origin/<branch> after a push to origin <branch>?
Date: Wed, 13 May 2009 21:42:15 -0700
Message-ID: <19640.1242276135@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 06:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Sly-0004P9-Bj
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 06:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbZENEmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 00:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbZENEmO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 00:42:14 -0400
Received: from relay.known.net ([67.121.255.169]:34313 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbZENEmN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 00:42:13 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.19) id 000000039325; Wed, 13 May 2009 21:42:15 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119131>

I'm stumped on this one.

I'm in a repo and I push the master branch.  If I do

  git diff --name-only origin/master..master

after the push, I still see the names of the files I pushed because I
haven't updated origin/master yet, with a fetch.  Of course, a "git
pull" would do it, but I don't want to do that, because I might be
using something other than `origin' and I don't want anything but the
single branch.

So, I naively thought that

  git fetch origin master

would do the trick, but after that command the git diff above still
shows the same files.

To make matters worse (!!), I made this attempt:

  $ git fetch origin master:origin/master
  From git:/repo/git/acl
   * [new branch]      master     -> origin/master
  $ git diff origin/master..master
  warning: refname 'origin/master' is ambiguous.
  $ 

Uh oh.

  $ git branch -a | grep origin/master
    origin/master
    origin/master
  $ find .git/refs -type f | grep origin
  .git/refs/heads/origin/master
  .git/refs/remotes/origin/acl81
  .git/refs/remotes/origin/HEAD
  .git/refs/remotes/origin/master
  $ cat .git/refs/heads/origin/master
  28f0f4f2cdf37640b94cdbd65406898222593f28
  $ cat .git/refs/remotes/origin/master
  4be7cc89d335421a93e4551b40bd06108a030221
  $ 


I'm going to leave my repo as is until a professionals helps me out,
lest I dig the hole deeper.

Thanks.

Kevin

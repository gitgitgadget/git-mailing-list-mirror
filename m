From: <dag@cray.com>
Subject: Grafting Alternate History
Date: Fri, 31 Aug 2012 18:39:58 -0500
Message-ID: <nng7gse7hrl.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 01:49:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7axs-0002nv-Bu
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 01:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab2HaXtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 19:49:22 -0400
Received: from exprod6og105.obsmtp.com ([64.18.1.189]:42495 "EHLO
	exprod6og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab2HaXtV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 19:49:21 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob105.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUEFNgN/ggRaXse+T1aTptswqfmuJnBAv@postini.com; Fri, 31 Aug 2012 16:49:21 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.318.1; Fri, 31 Aug
 2012 18:39:59 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204614>

I have an unfortunate situation where I have two subversion repositories
for the same project, one a public version and one a private version.
Because they are mirrors of svn repositories, they have very different
histories as far as git is concerned.  This is not all that uncommon but
of course I would like to manage things in git.

git-svn is great for interacting with one svn repository.  The public
svn repository has a fully-supported git mirror.  The private repository
also has a fully-supported git mirror.  But I need to check in changes
to the private repository via git-svn.  I eventually need to check in
changes to the public repository as well but that is orders of magnitude
less frequent.  A manual diff+patch+git-svn is acceptable for now.

I am wondering if it's possible to graft the history of one of the git
mirrors onto an empty branch of the other and share changes between
them.  I need to take updates from the public repository and apply them
to the private repository.  This is a frequent operation.  I have been
essentially using manual diff+patch but that is highly error-prone and
annoying.

For example, let's say we take a local copy of the private repository.
I would like to somehow create an empty branch in that local copy and
then populate it with the history of the public repository.  I would
like to be able to specify a git diff-like command on the public graft
branch to get some changes over a range of commits and apply those
changes to one of the private branches (say master).  If I could use a
git-merge-like or git-rebase-like command, so much the better.  I would
like to do the same in reverse but as I said that is a much less common
operation.

Has anyone done anything like this before?  Is it even theoretically
possible to manage disjoint histories like this?

Thanks for your help!

                            -Dave

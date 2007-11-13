From: Sergei Organov <osv@javad.com>
Subject: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 17:25:39 +0300
Message-ID: <874pfq9q8s.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 15:26:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrwiM-0007E5-Nv
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 15:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbXKMOZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 09:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbXKMOZu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 09:25:50 -0500
Received: from javad.com ([216.122.176.236]:4452 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbXKMOZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 09:25:49 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADEPk014029
	for <git@vger.kernel.org>; Tue, 13 Nov 2007 14:25:47 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Irwhv-0002ew-Ku
	for git@vger.kernel.org; Tue, 13 Nov 2007 17:25:39 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64802>

Hello,

I want to get rid of origin/pu remote tracking branch. What do I do? I
RTFM git-branch. What does it suggest?

git branch -d -r origin/pu

So far so good. However, it doesn't seem to work in practice:

$ git --version
git version 1.5.3.4
$ git remote show origin
* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  Remote branch(es) merged with 'git pull' while on branch master
    master
  Tracked remote branches
    html maint man master next pu todo
$ git branch -d -r origin/pu
Deleted remote branch origin/pu.
$ git remote show origin
* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  Remote branch(es) merged with 'git pull' while on branch master
    master
  New remote branches (next fetch will store in remotes/origin)
    pu
  ^^^^^^^^^^^^^^^^^^^ What???  
  Tracked remote branches
    html maint man master next todo
$ git fetch
remote: Generating pack...
remote: Done counting 422 objects.
Result has 281 objects.
remote: Deltifying 281 objects...
remote:  100% (281/281) done
Indexing 281 objects...
remote: Total 281 (delta 206), reused 255 (delta 181)
 100% (281/281) done
Resolving 206 deltas...
 100% (206/206) done
63 objects were added to complete this thin pack.
* refs/remotes/origin/pu: storing branch 'pu' of git://git.kernel.org/pub/scm/git/git
  commit: fc07419
$ git remote show origin
* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  Remote branch(es) merged with 'git pull' while on branch master
    master
  Tracked remote branches
    html maint man master next pu todo
$

... and I get those origin/pu back?!

What do I do wrong?

-- 
Sergei.

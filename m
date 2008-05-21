From: davetron5000 <davetron5000@gmail.com>
Subject: Using git to perform merges between SVN branches
Date: Wed, 21 May 2008 08:50:33 -0700 (PDT)
Message-ID: <a5c338c9-7820-41bd-a3a3-36ba5aad4379@l64g2000hse.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 17:51:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyqbF-0002es-GJ
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 17:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935524AbYEUPui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 11:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757048AbYEUPui
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 11:50:38 -0400
Received: from wr-out-0708.google.com ([64.233.184.243]:44426 "EHLO
	wr-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934519AbYEUPug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 11:50:36 -0400
Received: by wr-out-0708.google.com with SMTP id b35so5630285wra.4
        for <git@vger.kernel.org>; Wed, 21 May 2008 08:50:34 -0700 (PDT)
Received: by 10.100.174.2 with SMTP id w2mr15540ane.16.1211385033878; Wed, 21 
	May 2008 08:50:33 -0700 (PDT)
X-IP: 98.218.223.189
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; 
	rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82553>

Working out of an SVN/subversion repository.  Initially cloned it so I
could work with git via git-svn.  I was given a branch in svn to work
on.  Created local branches connected to the main trunk and my branch
via:

git-checkout -b local-trunk trunk
git branch local-foo FOO

where svn_root/branches/FOO is where I'm to commit changes

commits work fine, etc.

What I'd like to do, for simplicity, and as a demonstration of git's
superior merging, is to do the merge of my code to the main trunk
using git.  My main concern is not getting into a situation where I
cannot commit to svn (since it doesn't track merges)

Would something like this work:

git checkout local-trunk
git-svn rebase
git checkout -b merge-foo local-trunk
git merge local-foo
# Resolve conflicts, etc.  local-foo now has what should go onto SVN's
trunk
git checkout local-trunk
git merge merge-foo
# this should work without any conflicts, since I resolved them on
merge-foo
git-svn dcommit
# Now I've merged my changes to the main trunk

Thanks,

Dave

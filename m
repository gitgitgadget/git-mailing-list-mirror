From: deanhiller <dhiller@ghx.com>
Subject: the standard hotfix from production scenario not working for me in
 git...
Date: Thu, 28 Jul 2011 10:35:08 -0700 (PDT)
Message-ID: <1311874508381-6630648.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 19:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmUUN-0001vt-Bm
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 19:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab1G1RfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 13:35:10 -0400
Received: from sam.nabble.com ([216.139.236.26]:48448 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755823Ab1G1RfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 13:35:09 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <dhiller@ghx.com>)
	id 1QmUUG-0007tV-FL
	for git@vger.kernel.org; Thu, 28 Jul 2011 10:35:08 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178105>

I am doing the typical scenario and have tried much of the documentation but
must be getting something wrong.  I want to do something exactly like
this...

context: I am on branchBigFeature and a production hot fix comes in.  I
would like to
1. git stash --ALL_including_untracked_Files
2. git checkout master
3. git checkout -b newHotfix145
4. work on hotfix, fix it
5. git addANDrm * (is there a way to do this??????)  I don't want to have to
git rm each file to remove!!! or can I do git rm * ....does that work or
will that delete everything....ugh.  Better yet, is there a way to git
commit --skipStaging --includeUntrackedFiles --autoDeleteTheDeletions,
ie...basically any change in the view I want applied(unless files are in
.gitignore of course)
5. git checkout master
6. git merge newHotfix145
7. git push
8. git checkout branchBigFeature
9. git stash pop
and I am back to seeing all my untracked files.

I tried to do this with commit INSTEAD of stash like so but it failed
miserably.  I basically tried commit instead of stash and then to get the
files back to untracked, unversioned on the branchBigFeature, I used git
revert HEAD and this reverted everything but then it was all in the staging
area...maybe there is one more command I need to get it from the staging
area.

and one last question, I 90% of the time want to apply all unstaged files
deletes, adds, modifies...is there just one command I can use like git
commit * --skipstaging or something.  I have been burned too many times by
the build works with ALL the changes and then missing a checkin so I prefer
to check it all in every time and stay in that habit.

thanks,
Dean



--
View this message in context: http://git.661346.n2.nabble.com/the-standard-hotfix-from-production-scenario-not-working-for-me-in-git-tp6630648p6630648.html
Sent from the git mailing list archive at Nabble.com.

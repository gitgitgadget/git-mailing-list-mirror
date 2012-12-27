From: Alex Vandiver <alex@chmrr.net>
Subject: "fatal: git-write-tree: error building trees" from `git stash`
Date: Thu, 27 Dec 2012 13:07:06 -0500
Message-ID: <1356631626.13818.126.camel@umgah.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 19:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToIDc-0006PZ-4w
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 19:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab2L0S3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 13:29:54 -0500
Received: from chmrr.net ([209.67.253.66]:39562 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab2L0S3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 13:29:52 -0500
X-Greylist: delayed 1355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2012 13:29:52 EST
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=[10.1.10.64])
	by utwig.chmrr.net with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1ToHrV-0000DE-2T
	for git@vger.kernel.org; Thu, 27 Dec 2012 13:07:25 -0500
X-Mailer: Evolution 2.32.2 
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2012-12-27 13:07:25
X-Connected-IP: 75.147.59.54:40435
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212207>

  Heya,
I just ran into the following with `git stash`.  The set-up:

        git init
        echo "Initial" > foo
        git add .
        git commit -m 'Initial commit'
        echo "Rewrite" > foo
        git commit -am 'Second commit, rewrites content'
        echo "Stashed changes" >> foo
        git stash
        git co HEAD~
        
$ git stash pop
Auto-merging foo
CONFLICT (content): Merge conflict in foo
Recorded preimage for 'foo'

$ git stash
foo: needs merge
foo: needs merge
foo: unmerged (aeaa7e5e87cf309a7368d5d92a71c1f9e6a8c9e7)
foo: unmerged (a77fa514de2720c72c1a861de098595959a2c97a)
foo: unmerged (4a622d2b991f1a19ba7be313a46dc6f03692cd0a)
fatal: git-write-tree: error building trees
Cannot save the current index state

 - Alex

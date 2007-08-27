From: Kyle Rose <krose@krose.org>
Subject: new to git
Date: Mon, 27 Aug 2007 15:43:47 -0400
Message-ID: <46D32973.8030104@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 22:07:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPkfQ-0003oc-Iv
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 21:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbXH0Ty3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 15:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755763AbXH0Ty3
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 15:54:29 -0400
Received: from kai.krose.org ([140.186.190.96]:48588 "EHLO kai.krose.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757315AbXH0Ty2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 15:54:28 -0400
X-Greylist: delayed 640 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2007 15:54:28 EDT
Received: from [192.168.35.129] (unknown [192.168.35.129])
	by kai.krose.org (Postfix) with ESMTP id E97523DF31
	for <git@vger.kernel.org>; Mon, 27 Aug 2007 15:43:47 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070802)
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56873>

After many years of dissatisfaction with the limitations of CVS, and
after getting fed up with the complexity of configuring and maintaining
a SVN setup, I just started using git for my own personal projects.  I
have to say it's quite nice and fits the UNIX philosophy well: fast,
simple, powerful.

I've been playing with it for a few weeks and generally understand what
is going on, but I do have a few usage questions that I couldn't find
answered in the docs:

(1) Let's say I:

git clone something
git branch foo
git checkout foo
<make some changes>
git commit -a
git checkout master
git pull . foo
git push
git pull

what is actually happening?  The pull appears to do something (i.e., I get:

* refs/remotes/origin/master: fast forward to branch 'master' of
/home/krose/git-repository/baz/
  old..new: 7cf088c..d344f98

), but makes no changes locally since I have the latest revision. 
Another subsequent git pull does, in fact, say everything is up to date.

(2) Any way to disable this warning:

Warning: No merge candidate found because value of config option
         "branch.local.merge" does not match any remote branch fetched.

(3) I notice I can't reset --hard a single file.  So, if I want to
revert a single file to some revision, blowing away my changes, what is
the accepted way of doing this?  Is there a way to do the equivalent of
a p4 print foo@some_revision?

(4) I'm still not clear on when a dst should and should not be used in a
refspec.  It appears that one can only do non-fast forward updates to
the branch that is checked out (which makes sense, since you may need to
resolve), but other than that, what is the difference between

git checkout foo
git pull . master

and

git checkout master
git push . master:foo

?

(5) Are there any tools for managing some of the metadata (e.g., the
origin URL) or is it expected that one edit it directly?

Thanks for all your work on this: git fills a need I didn't know I had
until I actually found myself using it: a completely decentralized patch
management system.

Kyle

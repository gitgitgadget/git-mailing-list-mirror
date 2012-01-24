From: Rick Bragg <lists@gmnet.net>
Subject: {Spam?} Re: push pull not working
Date: Tue, 24 Jan 2012 15:05:30 -0500
Message-ID: <1327435530.21582.211.camel@thor>
References: <1327431631.21582.209.camel@thor>
	 <20120124194153.GB19534@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 24 21:06:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpmd8-0007nI-9f
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 21:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab2AXUGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 15:06:05 -0500
Received: from smtp.gmnet.net ([207.136.225.2]:54784 "EHLO smtp.gmnet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755931Ab2AXUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 15:06:04 -0500
MailScanner-NULL-Check: 1328040195.79062@d9uRi2jzARdfkRhWlmjqBQ
Received: from [192.168.1.36] (pool-70-109-163-238.cncdnh.east.myfairpoint.net [70.109.163.238])
	(authenticated bits=0)
	by smtp.gmnet.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id q0OK3C6D002513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Jan 2012 15:03:14 -0500
In-Reply-To: <20120124194153.GB19534@sigill.intra.peff.net>
X-Mailer: Evolution 2.28.3 
X-MailScanner-ID: q0OK3C6D002513
X-GreenMountainNetwork-MailScanner: Found to be clean
X-GreenMountainNetwork-MailScanner-From: lists@gmnet.net
X-Spam-Status: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189062>

On Tue, 2012-01-24 at 14:41 -0500, Jeff King wrote:
> On Tue, Jan 24, 2012 at 02:00:31PM -0500, Rick Bragg wrote:
> 
> > I cloned a repo from /home/me/repo1 to /home/me/repo2.  Then made
> > changes and a new commit on repo1, then from repo1 did "git
> > push /home/me/repo2 and it says Everything is up-to-date.  How could
> > this be?
> 
> It's hard to say, since you didn't show us the exact commands you ran.
> 
> One possible cause is that you made your commit on a detached HEAD, not
> on a branch, and therefore pushing branches will have no effect. You can
> check this by running "git status", which will report either your
> current branch or "not currently on any branch".
> 
> Another possible cause is that git is not trying to push the branches
> that you think it is.
> 
> For example, imagine repo1 has two branches, "master" and "foo", and the
> "master" branch is checked out. When you clone it, the resulting repo2
> will have remote-tracking branches for both "master" and "foo", but will
> only checkout the "master" branch. Now imagine you make commits on
> "foo" in repo1, and then try to push. Git's default behavior is to push
> only branches which match (by name) a branch on the destination. So we
> would attempt to push "master" (which is up to date), but not "foo".
> 
> You can see which branches are being considered in the push with "git
> push -vv". If you want to push all branches, you can use "git push
> --all", or read up on refspecs in "git help push". If you want to change
> git-push's default behavior, read up on "push.default" in "git help
> config".
> 
> -Peff
> 

Thanks, I went back a few commits and tried again and it works.  I'm not
sure what it was, I will have allot of reading to do.

Thanks again!
Rick

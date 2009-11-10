From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 14:14:32 +0000 (UTC)
Message-ID: <loom.20091110T150242-922@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <20091109183404.GI27126@dpotapov.dyndns.org> <loom.20091110T092404-595@post.gmane.org> <20091110134540.GK27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 15:15:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7rUx-0001Jw-SK
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 15:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbZKJOO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 09:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbZKJOO4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 09:14:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:42321 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbZKJOOz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 09:14:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7rUp-0001GA-IG
	for git@vger.kernel.org; Tue, 10 Nov 2009 15:14:59 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 15:14:59 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 15:14:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132570>

Dmitry Potapov <dpotapov <at> gmail.com> writes:

> I am not sure I understood your question. What 'git archive' does is to
> create a tar or zip archive or any version that you specify. So, you can
> use it to export the snapshot of any version to a temporary directory
> for testing if this testing takes a noticeable time and you want to be
> able to work on something else in meanwhile. If necessary, you can
> create a temporary branch starting at the intesting point and to add
> some commits there (such as a new test case to reproduce the problem)
> and then run test on it. Later, you can either rebase or merge these
> commits to any branch that needs them.

Ok, I got it. So the scenario is something like that:
1. Stash or commit my current changes
2. Sync (reset or checkout) to some other version/branch
3. Create temporary branch 
4. Edit and Commit
5. "git archive" to get snapshot
6. Get back to original change

This looks reasonable. Until you need to correct the fix and test it again.

Perhaps, I have to explain why fix/test cycle is so long. I'm working on mobile 
platform development. It is not so modular, so I need to build the whole image, 
then flash the mobile and test it in a real network. This takes much time and 
need much disk space (about 2GB of source files. In fact, significant number of 
these files are not needed for the build, but it is too hard to force CM 
engineers to fix this :-) )

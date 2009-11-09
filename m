From: Dave Rodgman <dav1dr@eml.cc>
Subject: Re: question: connecting to multiple remote svn projects
Date: Mon, 9 Nov 2009 10:59:25 +0000 (UTC)
Message-ID: <hd8smd$79e$2@ger.gmane.org>
References: <hd1nv2$79e$1@ger.gmane.org>
	<32541b130911061151q68ddcc58w209acf28c5eec2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 12:05:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7S39-0006kj-3S
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 12:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbZKILE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 06:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbZKILE2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 06:04:28 -0500
Received: from lo.gmane.org ([80.91.229.12]:53944 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136AbZKILE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 06:04:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7S0y-0005LY-3h
	for git@vger.kernel.org; Mon, 09 Nov 2009 12:02:28 +0100
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 12:02:28 +0100
Received: from dav1dr by fw-tnat.cambridge.arm.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 12:02:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fw-tnat.cambridge.arm.com
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132456>

>> Given a layout in a single subversion repository like this:
>>
>> module1/branches/1.0/work
>> module2/branches/1.0/work
>>
>> I would like achieve the following layout locally, in git:
>>
>> module1/work
>> module2/work
>>
>> Obviously I can create multiple git repositories in separate
>> directories, but I would like them to be in a single repository. I can
>> also get the same layout as subversion, but this breaks various bits of
>> build infrastructure.
> 
> Can you just create the file structure you want using symlinks?  That
> would be the easiest way.

It would, and this is what I do on Linux. On Windows, obviously, this 
doesn't work.

>> I don't care about tracking the subversion branches in git, or being
>> able to switch between subversion branches.
> 
> Don't care about tracking *any* subversion history, or just the history
> of branches other than the 1.0 branch you've listed above?  I assume the
> latter, because otherwise the problem is easy (just copy the latest
> revision of the files into a git repo and commit).

Indeed. I want history, but only for a given branch. 

> Other options that might work for you: create a "superproject" branch
> and import the two modules using git-submodule, or else import them
> using git-subtree (http://github.com/apenwarr/git-subtree).  Or import
> the svn history and then use git-filter-branch to move stuff around.

As far as I can understand, git-submodule pulls in a specific commit,
as does git subtree? I've experimented a little but with not much success.

I want "git svn rebase" (or some equivalent command, or series of 
commands) to update the contents of module1/work to the latest commit 
into this branch, and similarly "git svn dcommit" should also commit into 
module1, module2, etc. Basically, I want my working copy to have the same 
functionality as if moduleX/work was the actual layout in subversion. I'm
using git as a client for a svn repository, rather than doing a one-time
import. Is this possible?

thanks for your help

Dave

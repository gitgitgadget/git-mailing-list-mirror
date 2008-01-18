From: dherring@ll.mit.edu
Subject: Re: git-svn: how to connect SVN branches?
Date: Fri, 18 Jan 2008 09:43:44 -0500 (EST)
Message-ID: <alpine.LNX.0.999999.0801180932310.3479@mojave>
References: <alpine.LNX.0.999999.0801171237110.3479@mojave> <478FD0E5.2080006@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 15:44:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFsSL-0001w3-Pl
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 15:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761641AbYAROn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 09:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761563AbYAROn5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 09:43:57 -0500
Received: from LLMAIL1.LL.MIT.EDU ([129.55.12.41]:53732 "EHLO ll.mit.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759349AbYAROn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 09:43:56 -0500
Received: (from smtp@localhost)
	by ll.mit.edu (8.12.10/8.8.8) id m0IEhqAk014290
	for <git@vger.kernel.org>; Fri, 18 Jan 2008 09:43:52 -0500 (EST)
Received: from mojave.llan.ll.mit.edu(              ), claiming to be "mojave"
 via SMTP by llpost, id smtpdAAATsaiVB; Fri Jan 18 09:43:43 2008
X-X-Sender: dherring@mojave
In-Reply-To: <478FD0E5.2080006@vilain.net>
User-Agent: Alpine 0.999999 (LNX 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71023>

Sam, Gregory, thanks for solving my problem.

On Thu, 17 Jan 2008, Sam Vilain wrote:
> dherring@ll.mit.edu wrote:
>> `git-svn fetch` pulled the new branch.  However, it created a whole new
>> history for this branch (new git commits from the beginning of the SVN
>> repo).
>>
>> Is there some way to tell git/git-svn to connect these two histories?
>
> git-svn doesn't yet support arbitrary mapping of paths like that.  You
> need to add a separate git-svn remote, and you might have to graft to
> get it started - see below.
>
>> Pictorially, I have
>>
>> SVN1@a---SVN2@a---SVN3@b---SVN4@b---SVNtrunk
>> SVN1@b---SVN2@b---SVN3@b---SVN4@b---SVNbranch
>
> That's unfortunate.  There are many things that git-svn does to try to
> avoid this happening.  You can fix it using the .git/info/grafts
> facility - check the Documentation/ for information on that.  Once
> you've got it looking right, git filter-branch can be used to make it
> permanent, though you should certainly delete the git-svn metadata after
> using that.

Documentation/repository-layout.txt had the best info on grafts.  A few 
graft lines and my git repo looks just right.  For now, I'm scared of 
breaking git-svn again; filter-branch can wait for later.

Thanks again,
Daniel

From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git clone - head not pointing to master
Date: Fri, 30 Dec 2011 16:40:58 +0400
Message-ID: <20111230164058.f127bf2d.kostix@domain007.com>
References: <4EFD9F11.5030309@volitionlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vibin Nair <vibin@volitionlabs.com>
X-From: git-owner@vger.kernel.org Fri Dec 30 13:41:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rgbm5-0003aE-Fv
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 13:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab1L3MlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 07:41:04 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:43402 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab1L3MlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 07:41:03 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id pBUCewtS015315;
	Fri, 30 Dec 2011 16:40:59 +0400
In-Reply-To: <4EFD9F11.5030309@volitionlabs.com>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187801>

On Fri, 30 Dec 2011 16:52:57 +0530
Vibin Nair <vibin@volitionlabs.com> wrote:

>   I am a Git beginner. Recently i started working on a codebase (that
> is checked in to a git repository) of our client, who is not very
> aware about how git works.
> The repository has multiple branches such as
> 
> origin/user1
> origin/master
> origin/user2
> 
> Now when i take a clone of this repository : git clone <repo-url>, a 
> clone of the repo is created on my machine.
> 
> But when i do a : "git branch" it shows
> 
> user1 *
> 
> which means that the "head" is pointing to the "user1" branch.
> 
> The client told me that all the recent code were being merged into
> the "master" branch and hence the "user1" branch has code which is
> older than "master" branch.
> 
> I had 2 queries :
> 
> 1. Is it possible to make the "head" of the remote point to "master" 
> instead of "user1", so that other members of my team get the latest
> code when they try to clone the repository.
`git clone` checks out the branch which the HEAD ref in the remote repo
points to.  You can use `git symbolic-ref` to retarget HEAD if it's a
bare repository.  If the repository is non-bare HEAD tracks what's
checked out, so it can be changed by doing `git checkout`.
Note that you can pass the "-b <branch>" command-line option to `git
clone` to make it create a local tracking branch and check it out for
an arbitrary remote branch <branch>.

> 2. Is there any way to safely merge "user1" to "master".
This question has little sense because it heavily depends on what you
mean by "safely".  The correct way to state a question like this is to
think whether merging user1 to master has sense from the project's
development standpoint.

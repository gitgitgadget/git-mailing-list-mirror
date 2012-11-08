From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: three questions: proper forum? & reverting changes to the
 working directory
Date: Thu, 8 Nov 2012 18:51:55 +0400
Message-ID: <20121108185155.71542c410f6c2b9123083a8b@domain007.com>
References: <A6B9336CDB62BB46B9F8708E686A7EA0115BAA1404@NRHMMS8P02.uicnrh.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: "McKown, John" <John.McKown@healthmarkets.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWTSs-0005C4-8g
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 15:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab2KHOwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 09:52:05 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:49323 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab2KHOwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 09:52:03 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id qA8Eptp8000329;
	Thu, 8 Nov 2012 18:51:56 +0400
In-Reply-To: <A6B9336CDB62BB46B9F8708E686A7EA0115BAA1404@NRHMMS8P02.uicnrh.dom>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209161>

On Thu, 8 Nov 2012 08:26:22 -0600
"McKown, John" <John.McKown@healthmarkets.com> wrote:

> 1) is this the proper forum for asking general git usage questions,
> such as "how to"? If not, what is?

This list is okay for the general usage questions.
But since it's the place where the development questions are discussed
as well, and patches get posted, you might find its signal-to-noise
ratio to be not very convenient for a casual user.

For "mere mortals", we have another list, git-users, hosted on Google
Groups [1].  It deals only with problems Git newbies have with Git.

> 2) I am unsure that I did things the "proper" way. I have a git
> maintained subdirectory. I made some changes and saved them in the
> working directory, but did not "git add" or "git commit" them. I then
> decided that I really messed up what I was doing (basically
> reformatting some source code). So to revert the changes back to what
> was last committed, I did a "git reset --hard HEAD". I think this is
> the proper way. But I picked up that command in the section of the
> documentation which was talking about abandoning a "git merge"
> attempt. What I did worked, but is it the proper way? If not, what
> is?

Yes, that was the proper way.  A failed Git merge attempt could be
considered as just another case of a messed-up state of the work tree
and the index.

You might want to read the "Reset Demystified" [2] document for a
friendly descriptions of how different ways to invoke `git reset`
affect the repository, the index and the work tree.
> 
> 3) More generically, suppose I have a file in my working directory
> that I want to put back the way it was "n" commits ago. The best that
> I can see, so far, is "git show HEAD~n:file >|file", replacing the
> "n" and "file" with appropriate values.

`git checkout` is able to fetch specific versions of the specified
files if called like this:

$ git checkout HEAD~n -- filename 

1. http://groups.google.com/group/git-users/
2. http://git-scm.com/2011/07/11/reset.html

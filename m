From: Luis Gutierrez <luis.gutierrez@xmos.com>
Subject: complex cvs import
Date: Fri, 22 Aug 2008 14:13:22 +0100
Message-ID: <48AEBB72.6060209@xmos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 15:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWWrr-0005Mk-OI
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYHVNiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYHVNiv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:38:51 -0400
Received: from deferred-out-119.livemail.co.uk ([213.171.216.119]:37115 "EHLO
	deferred-out-119.livemail.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751034AbYHVNiv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 09:38:51 -0400
X-Greylist: delayed 1543 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Aug 2008 09:38:50 EDT
Received: from smtp-out-68.livemail.co.uk (smtp-out-68.livemail.co.uk [213.171.216.68])
	by deferred-out-119.livemail.co.uk (Postfix) with ESMTP id 00361390C38E
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 14:13:52 +0100 (BST)
Received: from [10.0.102.43] (unknown [195.26.247.140])
	by smtp-out-68.livemail.co.uk (Postfix) with ESMTP id D6D2345EF2A
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 14:13:05 +0100 (BST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93295>

Hi All,

During the past year or so we have been using a bastardized version of 
CVS in which branches were not 'true' cvs branches, but just a copy of 
the original data in a different folder. For instance, we would have 
something like this:

ProjectX
   \---- dev01
   |       \... normal cvs data
   \---- dev02
   |       \... normal cvs data
   \---- release01
   |       \... normal cvs data
   \---- release02
           \... normal cvs data

While a timeline of the branches looks like this:

                /---release01
----dev01------+                /---release02
                \---dev02------+--

Now that we are trying to move to git, and I'm having problems importing 
the projects with their full history.

What I have done is use git-cvsimport on each of those branches to 
create separate git repositories: dev01, dev02, release01, and release02.

What I was planing on doing next was:
(all from the dev01 branch)
1) git branch dev01
2) git checkout -b release01
3) git pull ssh:/..../release01
4) git checkout -b dev02
5) git pull ssh:/..../dev02
6) git checkout -b release02
7) git pull ssh:/..../release02

Now, the problem I'm seeing is that I get hundreds of conflicts when 
pulling.

Short from doing a git-mergetool 100's of times, is there a better way 
of doing this? One that guarantees I keep the latests version (ie, the 
one I'm pulling from).
Put in another way, is there a way to let git know that it will not 
merge the last version of the files, just the history?

Cheers.

Luis Gutierrez

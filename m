From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and renames
Date: Wed, 11 Jul 2007 01:20:00 -0700
Message-ID: <20070711082000.GA29371@muzzle>
References: <46938594.2010607@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 10:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8XQq-0001Oj-BS
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 10:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbXGKIUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 04:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756244AbXGKIUE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 04:20:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40061 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755610AbXGKIUC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 04:20:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 99DD12DC032;
	Wed, 11 Jul 2007 01:20:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46938594.2010607@dawes.za.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52142>

Rogan Dawes <lists@dawes.za.net> wrote:
> Hi folks,
> 
> I am trying to push my local changes to an imported SVN project back to 
> the SVN repo. For anyone who cares, this is the WebGoat repository which 
> you can find at http://dawes.za.net/rogan/webgoat/webgoat.git/
> 
> I am trying to push it back to the primary GoogleCode repo. I have 
> successfully managed to push 20 or so commits, but I am now running up 
> against a problem with a renamed/moved file.
> 
> I moved a file from a directory to a subdirectory, and made minimal 
> changes to this file so that it remained a valid Java class. i.e. I 
> changed the package, and a few other minor things. As can be seen at 
> <http://dawes.za.net/gitweb.cgi?p=rogan/webgoat/webgoat.git;a=commitdiff;h=486416188a3e49d60e1510166ac197e5e66cc4d2>, 
>  git detects the rename with 93% similarity.
> 
> However, when I try to push this change to the Google repo, git-svn dies 
> with the following error:
> 
> $ git svn dcommit
> RA layer request failed: PROPFIND request failed on '/svn/trunk/ 
> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java': 
> PROPFIND of '/svn/trunk/ 
> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java': 
> 400 Bad Request (https://webgoat.googlecode.com) at 
> /home/rdawes/bin/git-svn line 400
> 
> [Yes, those paths have a space in them, however this does not seem to 
> have prevented me from committing the previous 20 or so changes.]
> 
> I noted the following in the git-svn documentation, with regards to 
> handling renames. However, I am not renaming a directory, only a couple 
> of files.

I've personally noted a rename issue with committing funky characters
"#{}" in filenames (I was renaming to get rid of those funky characters of
course).   Haven't had proper time to look into it.

Did any previous successful commits have renames in them?  You may want
to set similarity to 100% to disable rename detection.

-- 
Eric Wong

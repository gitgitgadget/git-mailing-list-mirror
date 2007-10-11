From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: yet another workflow question...
Date: Thu, 11 Oct 2007 16:10:54 +0100
Message-ID: <200710111610.55364.andyparkins@gmail.com>
References: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Patrick Doyle" <wpdster@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 17:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifzgx-0006ua-3y
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 17:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbXJKPLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 11:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbXJKPLD
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 11:11:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:57394 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXJKPLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 11:11:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so494351nfb
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=IzO9bhkCKP9sNEiBE81tkld5jwX6DFw7msdRf+p6ESU=;
        b=IDtHbceUCcCyznOt4DVzMea0Y1bSS/R/UnEcyxft/x5gSuL/daf/PYUlpnKO8MaewoVIw35lBDWwAXcgp698EGqSA7S40xcPqC+lh/5x7I8FC2ZWKlvRWGsktTd038tPRb8ZGSLCyXawebyQ/am7THz5WqMdAKROqnxjn9g5eS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=llQsktYuWgGvCllHw2WQPvpipcBETzsWTW+4sFNwq4BSWQUYkjulkwj73b1bv52pFEIHxOwSCuc9vZPpqnQUFcz/xIjjoWoh9iFEHRdRmHhWUzcGYhenQqADA8a8RrsBUa1o0sCbLlHOUD0T1wsFmuJuDgp3ZTqvWLDAsHPoWPM=
Received: by 10.86.26.11 with SMTP id 11mr1527464fgz.1192115458557;
        Thu, 11 Oct 2007 08:10:58 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id z34sm12518777ikz.2007.10.11.08.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Oct 2007 08:10:57 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60608>

On Thursday 2007 October 11, Patrick Doyle wrote:

> burning question, "What can git do for me?"  (So far, I have come to
> the conclusion that, for my simple, single developer, branchless,
> linear projects, there's not much that git can do for me that any
> other SCM could do for me.  It appears to have been designed to solve

Here's a few things that are relevant to a simple, single, branchless, linear 
developer:

 - Fast.  Git wipes the floor with everything else, so much so that the SCM
   becomes a tool in itself, not just a recorder of history.  I keep my own
   simple projects in git just as much as my complicated, branchy, team-based
   projects just to get the following tools fast:
    git-diff
    git-status
    git-commit
    git-log

 - Small.  In every project I've converted from SVN to git, the diskspace
   usage has gone down.  SVN peppers the working tree with .svn directories,
   each of which contains a pristine copy of the last checked in version of
   all the working files.  On top of that is the repository disk space itself.

   Git on the other hand keeps one .git directory at the top of the tree and
   that stores the _entire_ repository.  It is, in my experience, smaller than
   the working tree.  That means that git uses less diskspace than svn does
   for a single checkout to store everything it needs.

 - Useful.  The following are so good, that even if you weren't doing any 
   revision tracking you'd still want to use them:
    git-grep
    git-diff

 - Backup.  Backing up subversion repositories requires that you write
   yourself a script that uses svnadmin dump.  With git I just write a couple
   of lines in my .git/config and then git-push produces a highly compact
   backup whenever I want.  Even better, if a disaster happens it's easy to
   pull stuff out of that backup without any additional operations.

 - Mobility.  This one is a bit distributed, but I hope you'll let me have it. 
   I often do work on my desktop at home, my desktop at work and my laptop. 
   By setting my remotes up correctly in git it's really easy to walk to
   another system and pick up exactly where I left off from the other
   computer.  More importantly though, when you accidentally make changes in
   two places, there is no danger of data loss.

Even if you aren't doing complicated stuff, git is the way to go.  I can't 
count the number of ways it's made me more productive and enhanced the code I 
write and the documentation of its development.  If I never worked on another 
group project again I would still use git all day every day.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

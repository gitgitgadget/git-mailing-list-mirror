From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: How can I easily verify my diffs are in parent branch?
Date: Wed, 11 Apr 2007 12:37:54 +0100
Message-ID: <1176291474.11130.12.camel@okra.transitives.com>
References: <1175686583.19898.68.camel@okra.transitives.com>
	 <Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:46:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbb9V-0005m2-Cl
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 13:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbXDKLh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 07:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbXDKLh7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 07:37:59 -0400
Received: from mx.transitive.com ([217.207.128.220]:50342 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752228AbXDKLh6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2007 07:37:58 -0400
Received: from [192.168.1.82] (helo=[192.168.1.82])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1Hbay7-0001Mn-FW; Wed, 11 Apr 2007 11:26:31 +0000
In-Reply-To: <Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
X-Mailer: Evolution 2.8.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44234>

On Wed, 2007-04-04 at 08:12 -0700, Linus Torvalds wrote:
> 
> On Wed, 4 Apr 2007, Alex Bennee wrote:
> > 
> > This is not the case of looking through the logs for my commit as I'm
> > exporting my changes from my tree into the company system through CVS.
> > This means all the usual commit tracking benefits are lost.
> 
> Yeah, sad.
> <snip>
> So all your small diffs get smushed in as part of one *big* change? Or do 
> they still exist in the baseline CVS tree as individual commits?

Unfortunately they are all smushed together :-(

<snip>

> For example, one thing you can do, if the number of commits you have is 
> fairly small, is to just be on your "my-branch" and then do
> 
> 	git rebase [--merge] cvs-upstream

Yeah I've tried using the rebase approach (which I in fact use a lot
when re-baseing my work anyway without losing my micro commit history).
The one fly in the ointment is the branch result at the end contains no
changes so I have no historical record of what I did while creating the
change.

I assume the commit objects are still in git somewhere but I'm not sure
how to get at it. What I would like to ask git is "what did my git-log
look like when 'mybranch' was based off master at A instead of B after O
rebased?"

For the time being I tend to verify my work has got in by generating a
master..branch diff and loading it into emacs patch-mode and testing
each hunk has applied ok. I'm still deciding if I should bite the bullet
and write some more elisp to make it a one button operation or use a bit
of perl with git. 


-- 
Alex, homepage: http://www.bennee.com/~alex/
"The most difficult thing in the world is to know how to do a thing and
to watch someone else do it wrong without comment." -- Theodore H. White

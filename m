From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: newbie question about git push
Date: Wed, 27 Aug 2008 18:06:00 +0200
Message-ID: <g93u19$b0u$1@ger.gmane.org>
References: <48B574B0.4030607@boboco.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 18:07:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYNYM-0003st-7W
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 18:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbYH0QGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 12:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbYH0QGV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 12:06:21 -0400
Received: from main.gmane.org ([80.91.229.2]:55183 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbYH0QGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 12:06:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KYNXA-000766-TQ
	for git@vger.kernel.org; Wed, 27 Aug 2008 16:06:12 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 16:06:12 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 16:06:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48B574B0.4030607@boboco.ie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93899>

Eric Bowman venit, vidit, dixit 27.08.2008 17:37:
> Hi,
> 
> Apologies in advance if this has been covered before ... I've been 
> wading through the archives a bit and couldn't find anything that seemed 
> to address this basic question.
> 
> I have a bunch of machines I use for development, but only one of them 
> is allowed to connect via vpn to where the subversion repository lives, 
> so I'm using git-svn to make things a little easier.
> 
> I've got one machine, itchy, where I've done a git svn clone operation.  
> I do a fair amount of development work there, and typically I just work 
> on the master branch, and periodically commit back to svn using git svn 
> dcommit.
> 
> I've cloned the repository on itchy on a few other machines I 
> occasionally use, and I'm able to push new revisions from itchy with no 
> surprises, and I can pull revisions back to itchy ok with no surprises.
> 
> Where things get a weird is when I push a revision back to itchy from 
> one of my other clones.  I feel like I must be missing some fundamental 
> concept, and I'm wondering if someone can help.
> 
> Suppose I make a change on another machine commit that change, then push 
> it back to itchy:
> 
> git commit -as
> git push origin master
> 
> This works ok, and I can then git svn dcommit that change back to the 
> svn.  But I have a hard time getting that change to show up in the 
> sandbox I have on itchy.
> 
> When I go back to itchy after pushing from a satellite, git thinks that 
> the old revision of the file I modified on another machine, has been 
> modified locally; it doesn't see that the local copy is out of data and 
> this new revision needs to be merged.  But I can't figure out how to get 
> git to do that; the only things that seem to work are fairly drastic 
> measures,  like "git reset --hard" or by stashing and then deleting the 
> stash. Either seems terribly error prone.
> 
> I'm starting to think that I should clone the repo I cloned from svn for 
> doing development work on itchy, but this seems kind of wasteful.  Am I 
> missing some fundamental concept?
> 
> Many thanks for any thoughts.
> 
> cheers,
> Eric

I don't think I understand your situation completely. But could it be
that when you push from satellite to itchy you push into a branch which
is checked out? Most probably, because you seem to push master to
master. You can't merge on push because there may be conflicts.

That setup is generally not a good idea, for the reasons you've
experienced. You may want to pull from itchy instead.

Michael

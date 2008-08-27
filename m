From: Eric Bowman <ebowman@boboco.ie>
Subject: newbie question about git push
Date: Wed, 27 Aug 2008 17:37:20 +0200
Message-ID: <48B574B0.4030607@boboco.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 17:39:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYN6R-0008Sl-JY
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 17:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbYH0Ph2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 11:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbYH0Ph2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 11:37:28 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51906 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753655AbYH0Ph1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 11:37:27 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C616015B40E
	for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:37:26 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 27 Aug 2008 11:37:26 -0400
X-Sasl-enc: pPwZImHuMWq+Q41VYF9pLE0GPK+p2hqlW5I79UW9Cq+l 1219851445
Received: from [127.0.0.1] (unknown [86.43.104.130])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6A65131603
	for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:37:25 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93897>

Hi,

Apologies in advance if this has been covered before ... I've been 
wading through the archives a bit and couldn't find anything that seemed 
to address this basic question.

I have a bunch of machines I use for development, but only one of them 
is allowed to connect via vpn to where the subversion repository lives, 
so I'm using git-svn to make things a little easier.

I've got one machine, itchy, where I've done a git svn clone operation.  
I do a fair amount of development work there, and typically I just work 
on the master branch, and periodically commit back to svn using git svn 
dcommit.

I've cloned the repository on itchy on a few other machines I 
occasionally use, and I'm able to push new revisions from itchy with no 
surprises, and I can pull revisions back to itchy ok with no surprises.

Where things get a weird is when I push a revision back to itchy from 
one of my other clones.  I feel like I must be missing some fundamental 
concept, and I'm wondering if someone can help.

Suppose I make a change on another machine commit that change, then push 
it back to itchy:

git commit -as
git push origin master

This works ok, and I can then git svn dcommit that change back to the 
svn.  But I have a hard time getting that change to show up in the 
sandbox I have on itchy.

When I go back to itchy after pushing from a satellite, git thinks that 
the old revision of the file I modified on another machine, has been 
modified locally; it doesn't see that the local copy is out of data and 
this new revision needs to be merged.  But I can't figure out how to get 
git to do that; the only things that seem to work are fairly drastic 
measures,  like "git reset --hard" or by stashing and then deleting the 
stash. Either seems terribly error prone.

I'm starting to think that I should clone the repo I cloned from svn for 
doing development work on itchy, but this seems kind of wasteful.  Am I 
missing some fundamental concept?

Many thanks for any thoughts.

cheers,
Eric

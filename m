From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Working with remotes; cloning remote references
Date: Fri, 17 Oct 2008 15:50:58 -0400
Message-ID: <48F8ECA2.3040208@xiplink.com>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 21:52:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqvMq-0007xW-Nz
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 21:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757561AbYJQTu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 15:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756978AbYJQTu5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 15:50:57 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:53725 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835AbYJQTu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 15:50:56 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id E4DB77A6C17;
	Fri, 17 Oct 2008 15:50:54 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id BC3A37A73D9;
	Fri, 17 Oct 2008 15:50:54 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <48F8AA5E.6090908@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98491>


Michael J Gruber wrote:
> 
> "pull -s strategy repo master" does a fetch followed by "merge -s
> strategy repomaster", where repomaster is the ref for master on repo.
> So, if you got that branch (repomaster=ThingOne/master) by cloning from
> main you can do the merge (subtree or other) on your clone, even without
> the remote repo config for ThingOne on clone.

I'm afraid I'm having trouble translating what you're saying into actual 
git commands (or are you proposing some new git functionality?).  How 
would I get the ThingOne/master branch into the clone?


After some more thought I realized that the clone can just pull directly 
from the ThingOne repository:

clone/$ git pull -s subtree git://thing/ThingOne.git master

(I'm still getting used to git's ability to match commit IDs from 
anywhere -- it's magic! :) )

This goes a long way to where we want to be, in that we don't have to do 
our merging work in the original main repository.

It would be nice, though, if the clone were able to use the main 
repository's definition of the ThingOne remote.  I can think of some 
plausible scenarios where a person could get confused about which 
repo/branch they're supposed to pull.  It's easy to recover from that 
kind of mistake, but there'd be less chance of a mistake if one could 
tell git to "pull from X as defined in the origin repository".

And actually, git's remote functionality feels a bit crippled if clones 
can't make some use of the origin's remotes.  Is there a reason for 
keeping remote definitions out of a clone?

		Marc

From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 10:07:38 +0200
Message-ID: <47204ECA.7040309@op5.se>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <471FBF29.8030802@op5.se> <Pine.LNX.4.64.0710242315310.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 10:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkxlS-0004HB-Pl
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 10:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759925AbXJYIHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 04:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759936AbXJYIHt
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 04:07:49 -0400
Received: from mail.op5.se ([193.201.96.20]:60418 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758443AbXJYIHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 04:07:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 26B8A1730707;
	Thu, 25 Oct 2007 10:07:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2VPVfE6ohNu; Thu, 25 Oct 2007 10:07:41 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id E662C1730704;
	Thu, 25 Oct 2007 10:07:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710242315310.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62286>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 24 Oct 2007, Andreas Ericsson wrote:
> 
>> Conceptually, I don't think it'll be any problem what so ever telling 
>> anyone that the branches that aren't currently checked out get merged 
>> automatically only if they result in a fast-forward.
> 
> It would be a matter of seconds until someone asks "why only 
> fast-forwards?  Would it not be _much_ better to merge _always_?  Stupid 
> git."
> 
> And all because the concept of "local" vs "remote" was blurred.
> 

It's already blurred, since we have git-pull instead of just git-fetch.
pull is the dwim version of fetch for anyone who isn't frequently pulling
from multiple repos that aren't configured as remotes (99% of git's users).
It really is. You configure it to merge this and that branch to those and
these branches. Sometimes it does and sometimes it doesn't, and the decision
is based on what branch you're currently on.

Only git-fetch has the clear local vs remote distinction, because it *never*
merges anything.

On a side-note, I'm starting to see why hg has gotten such a user-base.
Their docs focus on one repo per branch, which doesn't have this problem at
all.

So in short, letting "git-pull" fast-forward (or rebase; I like that idea)
the local copies of the remote tracking branches onto those remote tracking
branches will make life easier for:
* People who collaborate with others in a shared environment, where branch
  heads frequently change in the mothership repo but all development is
  supposed to be done at the tip of those mothership branches anyway.
  Nearly all corporate users fall into this category.
* People who just want to track and test the latest and greatest version of
  software X. Sometimes trying latest stable, and sometimes going with the
  freshest beta. They won't want to do "git merge beta origin/beta" after
  having done "git checkout beta", but they sure as hell don't want to run
  anything but the latest either. They may contribute once in a while, but
  generally just want to make sure they've got the bleeding edge.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Thu, 01 Feb 2007 00:18:39 +0100
Organization: At home
Message-ID: <epr81s$gaf$1@sea.gmane.org>
References: <87odognuhl.wl%cworth@cworth.org> <20070130231015.GB10075@coredump.intra.peff.net> <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net> <20070131032248.GA17504@coredump.intra.peff.net> <Pine.LNX.4.64.0701310932320.3021@xanadu.home> <20070131170752.GA19527@coredump.intra.peff.net> <7vhcu7uewe.fsf@assigned-by-dhcp.cox.net> <20070131225121.GC20514@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 00:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCOhp-0004mV-QT
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 00:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbXAaXRa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 18:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbXAaXRa
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 18:17:30 -0500
Received: from main.gmane.org ([80.91.229.2]:49709 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030214AbXAaXR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 18:17:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCOhh-0006VZ-5C
	for git@vger.kernel.org; Thu, 01 Feb 2007 00:17:25 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 00:17:25 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 00:17:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38304>

Theodore Tso wrote:
> On Wed, Jan 31, 2007 at 12:20:33PM -0800, Junio C Hamano wrote:

>> I think you (and others in the thread) are forgetting that
>> moving to a particular state by resetting can create a state
>> that you may want to keep a pointer to, but you do not have any
>> existing ref.  That's one of the reasons why we do not merely
>> check if the detached HEAD is not reachable from any of the
>> existing refs when coming back.  Instead, we check and warn if
>> the detached HEAD does not exactly match one of the existing
>> refs.
> 
> Is that an important distinction?  The way the user got there was by
> manually specifying the SHA-1 shash of the commit to git-checkout.  So
> if the user could get there once, the user could get there again a
> second time.  Just because we don't have a name to that precise commit
> inside the git system doesn't necessary mean the user can't get back
> there.   In fact, the user probably could via "history | grep 'git
> checkout'". 

Have you read further? git-bisect could (and probably should) use detached
HEAD instead of special 'bisect' branch. Doing bisection can be hard work
(checking if commit is good or bad might take time) and we don't want to
lose it.

Besides, history has finite length, and you could get to the state not only
via "git checkout", but also via "git reset --hard".

Reflog for detached HEAD would help in this.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

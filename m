From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 12:06:27 -0400
Message-ID: <6C96EBA9-CDCE-40EA-B0EC-F9195DBE83DB@silverinsanity.com>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <Pine.LNX.4.64.0707191310430.14781@racer.site> <86wswwa8ej.fsf@lola.quinscape.zz> <7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com> <Pine.LNX.4.64.0707191642270.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 18:07:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBYX1-00006Z-RF
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 18:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233AbXGSQGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 12:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765299AbXGSQGd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 12:06:33 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52388 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939531AbXGSQG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 12:06:27 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B1AF11FFC243;
	Thu, 19 Jul 2007 16:06:26 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.64.0707191642270.14781@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53001>


On Jul 19, 2007, at 11:43 AM, Johannes Schindelin wrote:

> I do not like it at all. "." already has a very special meaning.   
> It is a
> _directory_, no place holder.

And we're talking about using it to describe the directory.

> More and more I get the impression that this thread is just not  
> worth it.
> The problem was solved long ago, and all that is talked about here  
> is how
> to complicate things.

By solved, you mean ignored?  There is no reason for git not to track  
empty directories other than "we don't like it".

Some projects I work on require certain directories to exist in order  
to run properly, but tend to occasionally do things like delete all  
files in this required directory.  So far, it hasn't been an issue  
because I'm working solo and using git just to bar against  
stupidity.  Git's policy of "don't touch things I don't know about"  
works.  But if I ever had to have someone clone it, they'd need to re- 
create the directories.  In this case, empty directories are part of  
the content I care about.  Yes, I could have a script do it, but  
that's a work around, not a solution.

In another case, I'm using creating a git repository out of source  
that is distributed as occasional tarballs with patches in between.   
Git's lack of ability to track the empty directories means that I can  
NOT re-create appropriate tarballs for the states distributed only as  
patches.  Yes, I could add placeholder files, but then the state is  
not identical.

There are use cases for tracking directories.  I'll agree that it  
shouldn't be used for every source tree.  But there are cases where  
it is useful and there's no reason to simply forbid it.

~~ Brian

From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 16:32:14 +0400
Message-ID: <20070719123214.GB4929@moonlight.home>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <86zm1sbpeh.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 14:32:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBVBe-0004tk-UL
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbXGSMcU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 08:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbXGSMcU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:32:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:43544 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbXGSMcT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:32:19 -0400
Received: by ug-out-1314.google.com with SMTP id j3so395487ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 05:32:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NQq7Nh3TR0StLoBqPVWxYZXt7f5d05zmxeCFqA4gHj8uwI9swB+Y3909MtVO/c1w/k9cLxIJdg6h1tRb3a4/vwtCPxH/3FsJci5OoA+Ueqo/ahngFw1B+fdhy0v+51yU0sHSD1gWZIInvD6Zz+JCIpye5rVoTkzZtJfWFQID7+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pEu/0GQQMoDKckikdk2EC5Ps11H6kvgf99FpNzk98Izp1Y7YKErBZFHJODrZTlsOGr9acksV2OvwRqnGtEf8YT4e4jXSVzfZFM0B68pNhEAJCMRxofp9PnAgem8F+MrwjdKFHx98neXV91aQmPGMEWVUDMuzHwr+W4KSmnz07LM=
Received: by 10.66.220.17 with SMTP id s17mr1156065ugg.1184848337830;
        Thu, 19 Jul 2007 05:32:17 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTPS id k5sm9597199nfh.2007.07.19.05.32.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 05:32:17 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id DA1CF3A8BC;
	Thu, 19 Jul 2007 16:32:14 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l6JCWEwW009268;
	Thu, 19 Jul 2007 16:32:14 +0400
Content-Disposition: inline
In-Reply-To: <86zm1sbpeh.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52983>

Hi David,

On Thu, Jul 19, 2007 at 13:31:50 +0200, David Kastrup wrote:
> core.excludefile: .

Really nice idea to give directories 'DIR/.' name.  I'm sure there are
several other ways to implement your proposal.  But why to put in in
Git itself?  Decomposition and abstraction principle tells me that
this should go to some other place.

Please consider this: I myself use Git to track my own local projects,
and for this usage you proposal have no value for me, i.e. as a
_Source_ Code Management system Git is rather complete.  But I also
track /etc and ~/ in Git, and for this I'd love to have directories,
permissions, ownership, other attributes, to be tracked.  I have Perl
script wrapping Git that allows me to filter tracked paths by full
regexps instead of Git's file globs, and also to filter out too big
files assuming that they are binary anyway.  Most people solving the
same problem moved further and implemented tools to store part of file
system state (permissions and ownership) in a textual representation,
to track that in Git.  I'm sure you've seen such posts in the list.
And my point is that rather than building the support for all of it
into core Git, and then implementing sophisticated configuration to
disable parts of it, wouldn't it be better to have a separate tools
orthogonal to Git itself?

At the extreme case (probably not really seriously), consider the
following design: there are two layers, file system layer, and
contents layer.  On checkout file system layer creates (or examines
existing) directory tree along with all files and their file system
state (permissions, ownership, ACLs, attributes, ...), and then asks
contents layer to update the contents.  This way layers are
independent, and file system layer may be implemented on top of pure
contents tracking.  File system layer may be extended to be made
particular OS/FS dependent if some development team wishes so.  Even
hard links may be supported: since file system layer may deside to
remember that two paths really reference the same inode
(i.e. contents), contents layer may be asked to update the data only
once with either file name/descriptor.

This, BTW, is why I think not tracking file attributes when
versioning, say, /etc, is not a big loss.  When I will move to the new
system, I will mostly be interested in contents diffs of the same
configuration files in /etc.  I will trust their new attributes, and
will not want to restore them to what they were on the old system.

So the essence of my objection is that we should not pollute core Git
with file system state tracking more than it's required to know where
to put the contents to.  Everything else should go elsewhere.

Again, I'd love to have your proposal be implemented, but only in a
way that won't interfere with pure SCM's operations.


-- 
   Tomash Brechko

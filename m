From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries
 too.
Date: Mon, 4 Jun 2007 14:33:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706041429380.23741@woody.linux-foundation.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
 <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org>
 <20070604175751.GL19935@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.98.0706041336440.23741@woody.linux-foundation.org>
 <20070604212121.GA31852@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>,
	Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 23:34:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvKCG-0007Hr-Np
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 23:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbXFDVdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 17:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757183AbXFDVdy
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 17:33:54 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:44003 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753636AbXFDVdx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 17:33:53 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l54LXNDE003443;
	Mon, 4 Jun 2007 14:33:25 -0700
In-Reply-To: <20070604212121.GA31852@dspnet.fr.eu.org>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-3.26 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49131>



On Mon, 4 Jun 2007, Olivier Galibert wrote:

> On Mon, Jun 04, 2007 at 01:45:26PM -0700, Linus Torvalds wrote:
> > I'd like to point out some more upsides and downsides of "git rebase".
> > 
> > Downsides:
> > 
> >  - you're rewriting history, so you MUST NOT have made your pre-rebase 
> >    changes available publicly anywhere else (or you are in a world of pain 
> >    with duplicate history and tons of confusion)
> 
> Wouldn't it be possible to register the rebase somewhere (weak parent?
> some kind of note not influencing the sha1 ?) that pull/merge could
> follow?  Rebases and cherry-picking are a special kind of merge, so
> maybe it can be handled like one where it counts...

Well, it's not like duplicate history is a disaster from a *technical* 
angle. It might be a small space-waster etc, but that's really not the 
real issue.

The problem with duplicate history is that it just makes things much 
harder to look at. IOW, it's *messy*. So the "tons of confusion" part is 
basically purely about humans, not about git itself. Git won't really 
care, and there's no reason to "handle" it specially in that sense.

So I would strongly discourage people from ever making rebased history 
available, but that's not because of any particular git technical issues 
as just because of it being a good way to confuse all the _humans_ 
involved.

(That said, gits own 'pu' branch ends up jumping around, and it hasn't 
caused all that much confusion, so maybe I'm overstating even that human 
confusion)

			Linus

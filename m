From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Mon, 17 Dec 2007 13:13:18 -0800
Message-ID: <20071217211317.GC19816@mail.oracle.com>
References: <m3fxy5qwbq.fsf@roke.D-201> <alpine.LFD.0.999999.0712140836140.8467@xanadu.home> <20071214215206.GB7300@mail.oracle.com> <alpine.LFD.0.999999.0712141724260.8467@xanadu.home> <20071214223957.GC7300@mail.oracle.com> <alpine.LFD.0.999999.0712141744460.8467@xanadu.home> <20071215004230.GF7300@mail.oracle.com> <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:24:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NRr-0000EY-EX
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760695AbXLQVXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760536AbXLQVXd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:23:33 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:51183 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760644AbXLQVXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:23:32 -0500
Received: from rgmgw1.us.oracle.com (rgmgw1.us.oracle.com [138.1.186.110])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id lBHLEl1g022578;
	Mon, 17 Dec 2007 14:14:48 -0700
Received: from acsmt354.oracle.com (acsmt354.oracle.com [141.146.40.154])
	by rgmgw1.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id lBHLEkms013995;
	Mon, 17 Dec 2007 14:14:46 -0700
Received: from ca-server1.us.oracle.com by acsmt354.oracle.com
	with ESMTP id 6406558331197926001; Mon, 17 Dec 2007 13:13:21 -0800
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1J4NH6-0008RM-J0; Mon, 17 Dec 2007 13:13:20 -0800
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68626>

On Mon, Dec 17, 2007 at 03:41:24PM -0500, Nicolas Pitre wrote:
> On Mon, 17 Dec 2007, Joel Becker wrote:
> > 	You may not see a case for actual corruptions, but my coworker
> > updated his tree on a box with 1.5.x, then tried to work on a box with
> > 1.4.x (I think 1.4.2 back then), and ended up with a tree that was
> > unusable.  He had to re-clone, and I think he got lucky recovering
> > pending changes (probably using 1.5.x on the branches with the changes,
> > as master was what got broken).
> 
> I still claim that there wasn't any corruptions.
> 
> Just for fun, just edit some document with Microsoft Office 95, then 
> open the same document with Office 2007 and save it with default 
> settings.  Now try to open it back with Office 95.  It won't work.  
> Does that mean that the document got corrupted?

	No, but when you try to re-open it with Office 2007, you expect
it to work, don't you?  His master was messed up even for 1.5.x.  It was
now months ago, so I don't quite remember all the details, but I think
you'd agree that "1.5.x no longer works" is not correct.

> I'm telling you that there won't be any such corruption.  Just like in 
> the M$ Office case, it is expected that newer versions make data 
> unusable by older versions at some point -- that's the inevitable side 
> effect of progress.

	Sure, we're not complaining about that.  We complain some about
the fast pace (at the time he had his problem, 1.4 installs were not
unusual, and Junio's response suggested that "I use NFS" wasn't strongly
considered as a use case), but more we complain about the obscurity of
the reason.  If it's obvious what happened (not the specifics, just
"please upgrade" or "repository format changed" or something), the user
moves along.

> And we cannot always anticipate what kind of incompatibility will be 
> worth making in the future, so it is hard to come with proper error 
> messages in all cases today.

	How hard is it?  We have core.repositoryformatversion.  We
undoubtably have headers on our files.  As an example, an older version
should be able to ascertain 1) this is a pack file 2) I don't know how
to read it.  Thus, it should always be able to tell the user as such.
This is different from reporting "invalid pack file" or "corrupt pack
file", or "garbage in tree".  Filesystems, as an example, set
compatibility bits or version levels.  When an old kernel tries to mount
it, it does not say "corrupt filesystem", it says "this filesystem has a
feature I don't understand, I'm going to be nice and not do anything,
please upgrade".  This is clear, even though the older kernel doesn't
have any specifics about what the new feature is.

> So I don't see how we could do better in that regard.  Carving the 
> repository format in stone to keep ancient versions working forever is 
> _not_ a solution.

	Once again, we're not asking for that.  We're asking that you
think ahead to what can change, and plan for it, so you can tell the
user.  If the user has a clear idea where to go next, the can solve the
rest themselves.
	Look, not everyone reads this mailing list.  No one outside of
this list reads the Release Notes.  They get their upgrade via yum or
apt-get, along with 100 other packages.  You can't assume that 3 months
of feature discussion here is going to be known to your average user.

Joel

-- 

"Vote early and vote often." 
        - Al Capone

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 19:42:27 +0100
Message-ID: <20071120184227.GB2261MdfPADPa@greensroom.kotnet.org>
References: <20071120155922.GA6271@pvv.org>
 <20071120173350.GA2261MdfPADPa@greensroom.kotnet.org>
 <20071120181932.GA20705@pvv.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:43:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuY3o-0007pg-1j
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbXKTSmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756300AbXKTSmf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:42:35 -0500
Received: from psmtp08.wxs.nl ([195.121.247.22]:49567 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755708AbXKTSme (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:42:34 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JRT001I0IMSK5@psmtp08.wxs.nl> for git@vger.kernel.org; Tue,
 20 Nov 2007 19:42:28 +0100 (MET)
Received: (qmail 11690 invoked by uid 500); Tue, 20 Nov 2007 18:42:27 +0000
In-reply-to: <20071120181932.GA20705@pvv.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65564>

On Tue, Nov 20, 2007 at 07:19:33PM +0100, Finn Arne Gangstad wrote:
> On Tue, Nov 20, 2007 at 06:33:50PM +0100, Sven Verdoolaege wrote:
> 
> > Just "submodule init" and "submodule update" these submodules and
> > it looks like you would get what you want...
> > 
> > > If I make a branch on submodule71, the branch is made in all submodules &
> > > the supermodule.
> > 
> > ... except this one.
> > It's not clear why you would even want this.
> 
> I'll try to boil this down to the simplest case possible. If
> submodules can do this I'll be really happy :)
> 
> Developer A makes a change in submodule1 and in submodule2
> Developer B makes a change in submodule2 and in submodule3

I'm assuming that A and B also make a commit to the supermodule
incorporating their changes to the submodules (as in your
original message).

> A and B don't know about eachother. They send their modifications
> somewhere (push to a shared repository with a well chosen branch name,
> for example), or send a mail "please pull from my repo" to the patch
> queue manager.

The commit A made to the superproject contains his changes
to the submodule, so if someone pulls this superproject commit,
she'll get the submodule changes too.
(Although she may choose not to have some or all of these
submodules checked out.)

> Also - it would be very good if the history in the master repo would
> match the history in all developers' repositories (as the
> modifications are merged in by the patch queue manager). I.e. - you
> should see a "gif support" feature branch, see the commits on it, and
> finally the merge.

You can't change the history in git. [*1]

It's still not clear why you would want new branches to be created
in other modules when you create a new branch in some module.

skimo

[*1] There are tools that allow you to create a new history based
on an old history, but it will be a different history.

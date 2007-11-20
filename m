From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 19:19:33 +0100
Message-ID: <20071120181932.GA20705@pvv.org>
References: <20071120155922.GA6271@pvv.org> <20071120173350.GA2261MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Tue Nov 20 19:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXhV-0006zP-AZ
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbXKTSTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbXKTSTj
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:19:39 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:57021 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbXKTSTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:19:38 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1IuXh7-0005Nk-1w; Tue, 20 Nov 2007 19:19:33 +0100
Content-Disposition: inline
In-Reply-To: <20071120173350.GA2261MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65556>

On Tue, Nov 20, 2007 at 06:33:50PM +0100, Sven Verdoolaege wrote:

> Just "submodule init" and "submodule update" these submodules and
> it looks like you would get what you want...
> 
> > If I make a branch on submodule71, the branch is made in all submodules &
> > the supermodule.
> 
> ... except this one.
> It's not clear why you would even want this.

I'll try to boil this down to the simplest case possible. If
submodules can do this I'll be really happy :)

Developer A makes a change in submodule1 and in submodule2
Developer B makes a change in submodule2 and in submodule3

A and B don't know about eachother. They send their modifications
somewhere (push to a shared repository with a well chosen branch name,
for example), or send a mail "please pull from my repo" to the patch
queue manager.

It is absolutely crucial that for each developer, either both their
modifications go in, or none of them. Git should make picking only
one of their modifications hard.

Also - it would be very good if the history in the master repo would
match the history in all developers' repositories (as the
modifications are merged in by the patch queue manager). I.e. - you
should see a "gif support" feature branch, see the commits on it, and
finally the merge.

- Finn Arne

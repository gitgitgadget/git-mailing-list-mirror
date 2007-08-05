From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Some ideas for StGIT
Date: Sun, 5 Aug 2007 14:56:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051452280.14781@racer.site>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com>
 <1186206085.28481.33.camel@dv> <20070804055110.GP20052@spearce.org>
 <f934ve$3oi$1@sea.gmane.org> <20070805023130.GV20052@spearce.org>
 <20070805133940.GA18835@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Sun Aug 05 15:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHgbN-0000vg-V2
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbXHEN47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbXHEN47
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:56:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:59050 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751427AbXHEN46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:56:58 -0400
Received: (qmail invoked by alias); 05 Aug 2007 13:56:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 05 Aug 2007 15:56:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18evqw+J6cePjh0MfL1d0+7LmdCELm4YbMIEpS4Tl
	miQ+9xIfypTgoc
X-X-Sender: gene099@racer.site
In-Reply-To: <20070805133940.GA18835@filer.fsl.cs.sunysb.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55020>

Hi,

On Sun, 5 Aug 2007, Josef Sipek wrote:

> On Sat, Aug 04, 2007 at 10:31:30PM -0400, Shawn O. Pearce wrote:
> ...
> [rebase is complex but fun]
> 
> Great, but does git have something that could replace
> $QUILT_LIKE_APP refresh?

What does "refresh"?  (I never used quilt, and probably never will, since 
rebase -i does what I need.)

> Sure, if you can take 2 commits and collapse them into one you could 
> fake it by creating a dummy commit with the new changes, and then 
> collapsing, but that's nasty - and reflog might not like that much :)

IIUC you want to edit/amend a patch in the middle of a series?  Two ways 
to go about it:

	1) (preferred)

		* start rebase -i
		* mark the commit as "edit"
		* wait until rebase stops to let you edit it
		* edit, test, commit --amend
		* rebase --continue

	2) (not so preferred, but often convenient)

		* fix bug
		* commit with a dummy message
		* rebase -i
		* move commit just after the commit-to-edit
		* mark second as "squash"
		* when the editor comes up, just delete the second 
		  commit's message, and possibly adjust the first's

Hth,
Dscho

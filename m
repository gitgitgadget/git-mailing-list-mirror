From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Some ideas for StGIT
Date: Sun, 5 Aug 2007 10:06:58 -0400
Message-ID: <20070805140658.GA4570@filer.fsl.cs.sunysb.edu>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv> <20070804055110.GP20052@spearce.org> <f934ve$3oi$1@sea.gmane.org> <20070805023130.GV20052@spearce.org> <20070805133940.GA18835@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.64.0708051452280.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHglO-0003T4-Kz
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbXHEOHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbXHEOHG
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:07:06 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50297 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbXHEOHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 10:07:03 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l75E6wNX006105;
	Sun, 5 Aug 2007 10:06:58 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l75E6w7l006103;
	Sun, 5 Aug 2007 10:06:58 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708051452280.14781@racer.site>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55022>

On Sun, Aug 05, 2007 at 02:56:23PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 5 Aug 2007, Josef Sipek wrote:
> 
> > On Sat, Aug 04, 2007 at 10:31:30PM -0400, Shawn O. Pearce wrote:
> > ...
> > [rebase is complex but fun]
> > 
> > Great, but does git have something that could replace
> > $QUILT_LIKE_APP refresh?
> 
> What does "refresh"?  (I never used quilt, and probably never will, since 
> rebase -i does what I need.)

You understood correctly...see below.

> > Sure, if you can take 2 commits and collapse them into one you could 
> > fake it by creating a dummy commit with the new changes, and then 
> > collapsing, but that's nasty - and reflog might not like that much :)
> 
> IIUC you want to edit/amend a patch in the middle of a series?  Two ways 
> to go about it:
> 
> 	1) (preferred)
> 
> 		* start rebase -i
> 		* mark the commit as "edit"
> 		* wait until rebase stops to let you edit it
> 		* edit, test, commit --amend
> 		* rebase --continue

Ewww...that doesn't seem to scale (read: far too much to type) :) Here's a
quilt/guilt/stgit equivalent:

	$APP push <patchname>

or (depending on where you are in the patch stack)

	$APP pop <patchname>

	<edit>

	$APP refresh # this is the commit --amend part

Josef 'Jeff' Sipek.

-- 
The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself. Therefore all progress
depends on the unreasonable man.
		- George Bernard Shaw

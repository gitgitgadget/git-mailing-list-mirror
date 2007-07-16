From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH 6/6] notes: add notes-index for a substantial speedup.
Date: Mon, 16 Jul 2007 17:29:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707161726430.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160025480.14781@racer.site> <20070716060117.GF32566@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IATTF-0005MX-Cp
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 18:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762120AbXGPQaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762054AbXGPQaR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 12:30:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:47607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759966AbXGPQaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 12:30:15 -0400
Received: (qmail invoked by alias); 16 Jul 2007 16:30:13 -0000
Received: from R412d.r.pppool.de (EHLO noname) [89.54.65.45]
  by mail.gmx.net (mp036) with SMTP; 16 Jul 2007 18:30:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+m4c1VuKOmDbKyQPVFhqzWfZGW83U1EwhMX1r7uK
	nUz5ihmv/3Jysg
X-X-Sender: gene099@racer.site
In-Reply-To: <20070716060117.GF32566@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52685>

Hi,

On Mon, 16 Jul 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > Actually, this commit adds two methods for a notes index:
> > 
> > - a sorted list with a fan out to help binary search, and
> > - a modified hash table.
> > 
> > It also adds a test which is used to determine the best algorithm.
> 
> I know this is a nice backwards compatible way to organize notes,
> and to make them reasonably efficiently found, but I'd almost
> rather just see them crammed into the packfile alongside of the
> commit it annotates, so that the packfile reader can quickly find
> the annotation at the same time it finds the commit.
> 
> aka packv4.
> 
> Ok, enough dreaming for today.

Yes, I also dream of having the time to play with packv4.  If you read my 
comments in the commit-annotation thread, you'll see that I stated that 
packv4 would solve the problem, too.

The reason I did this series was not to push commit notes, but to make 
good for stalling Johan's efforts.  Including a proof that the commit 
notes as I introduced them can be relatively cheap, too.

Ciao,
Dscho

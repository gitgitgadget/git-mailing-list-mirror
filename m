From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Difficulty with getting an accurate changelog after cherry-picking
 and merging.
Date: Tue, 22 Jul 2008 22:14:42 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222209180.8986@racer>
References: <7dc909980807221338g707d6104ob8b1534cdf02a77a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Luuk Paulussen <luuk.paulussen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPD7-0006zQ-WC
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505AbYGVVOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756502AbYGVVOm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:14:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:52092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756485AbYGVVOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:14:42 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:14:40 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp018) with SMTP; 22 Jul 2008 23:14:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/S3fR1nyDShViqa8Wo9Z+gGJEJEG0MEYmCIXUHT3
	y+8VTsIEnqbolx
X-X-Sender: gene099@racer
In-Reply-To: <7dc909980807221338g707d6104ob8b1534cdf02a77a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89531>

Hi,

On Wed, 23 Jul 2008, Luuk Paulussen wrote:

> I'm trying to generate an accurate changelog of changes between 2 tags 
> on a branch.  There is a merge between these 2 points which includes 
> changes that were cherry-picked before the start point.  This causes the 
> changelog to show these changes, despite them already existing before 
> the start point of the log.
>
> [...]
> 
> I have tried git-cherry and git-log with --cherry-pick and various 
> things with git-rev-list and git-merge-base.

cherry and --cherry-pick will only skip patches that are on the 
uninteresting side of a "..." range.

I guess that

	$ git log --cherry-pick master...HEAD^

should filter the commits out, but I haven't tried.

> git cherry-pick :/test1

Heh, that is the first time I see :/ in the wild.  I do not use it 
anymore, and in your case, I would have written "git cherry-pick master^4" 
to be more precise (and not accidentally pick up a wrong one).

Ciao,
Dscho

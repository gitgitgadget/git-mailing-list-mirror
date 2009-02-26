From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] rebase -i optimization
Date: Thu, 26 Feb 2009 15:59:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:01:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lchjl-0007zu-FU
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 16:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbZBZO7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 09:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbZBZO7x
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 09:59:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:47555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753113AbZBZO7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 09:59:53 -0500
Received: (qmail invoked by alias); 26 Feb 2009 14:59:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 26 Feb 2009 15:59:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AMZBDSKFAyc5lyI1sddqZGh0kfehvSreiccvJaw
	+4kORmj2juZqV0
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 26 Feb 2009, Sverre Rabbelier wrote:

> I am currently working on a large set of patches for Melange, and as
> such I'm using rebase -i a lot to polish things a bit. I do this
> mainly by 'git rebase -i master' from my topic branch, then change on
> of the 'pick' lines into an 'edit', and then fix up the commit and
> 'git rebase --continue'. Now I notice I'm waiting a lot for 'rebase
> -i' to finish picking the first bunch of commits that I didn't change.
> Now obviously I couldof done 'git rebase -i <foo>', but then I have
> first figure out what the last commit I want to change is.
> Would there be a reason to not reset to the last 'pick' commit instead
> of to the 'based on' branch (as long as there history is linear)? If
> so, what would be the best way to go around and implement this?

This code is supposed to do exactly what you want:

http://repo.or.cz/w/git/dscho.git?a=blob;f=git-rebase--interactive.sh;h=532f161c1ddce351cf623b096899e0eb057180ca;hb=8394eb1ecee00c2aba9212f3445c42078b41614b#l198

Unfortunately, it seems to be quite broken by all the different directions 
rebase -i was pulled to, but maybe you see the bug right away.  Otherwise, 
I'll try to reschedule my Git time budget later tonight.

Ciao,
Dscho

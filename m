From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and
 Mercurial
Date: Sun, 26 Apr 2009 19:45:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904261943070.10279@pacific.mpi-cbg.de>
References: <200904260703.31243.chriscool@tuxfamily.org> <m363grq13i.fsf@localhost.localdomain> <49F475B8.20903@gmail.com> <alpine.DEB.1.00.0904261854460.10279@pacific.mpi-cbg.de> <49F49AF0.1020301@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly8RZ-0000w1-Fh
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 19:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbZDZRpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 13:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbZDZRpI
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 13:45:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:46028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754716AbZDZRpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 13:45:07 -0400
Received: (qmail invoked by alias); 26 Apr 2009 17:45:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 26 Apr 2009 19:45:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UIKInaZPUjK5ieWi69ILSCK+KnpgQtbvn9scp5b
	ekcEUdxSKDqiV5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49F49AF0.1020301@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117630>

Hi,

On Sun, 26 Apr 2009, A Large Angry SCM wrote:

> Johannes Schindelin wrote:
> 
> > On Sun, 26 Apr 2009, A Large Angry SCM wrote:
> > 
> > > Another important criteria was which, both or neither of Git and Hg 
> > > would actually work and perform well on top of Google Code's 
> > > underling storage system and except to mention they would be using 
> > > Bigtable, the report did not discuss this. Git on top of Bigtable 
> > > will not perform well.
> > 
> > Actually, did we not arrive at the conclusion that it could perform 
> > well at least with the filesystem layer on top of big table, but even 
> > better if the big tables stored certain chunks (not really all that 
> > different from the chunks needed for mirror-sync!)?
> > 
> > Back when I discussed this with a Googler, it was all too obvious that 
> > they are not interested (and in the meantime I understand why, see my 
> > other mail).
> 
> I don't remember the mirror-sync discussion. But I do remember that when 
> the discussion turned to implementing a filesystem on top of Bigtable 
> that would not cause performance problems for Git, my response was that 
> you'd still be much better off going to GFS directly instead of faking a 
> filesystem on top of Bigtable without all of the Bigtable limitations.

Umm, GFS is built on top of Bigtable, no?

> Bigtable _is_ appealing to implement the Git object store on. It's too 
> bad the latency in Bigtable would make it horribly slow.

If you store one object per Bigtable, yes.  If you store a few undelta'd 
objects there, and then use the pack run to optimize those tables, I think 
it would not be horribly slow.  Of course, you'd need to do exactly the 
same optimizations necessary for mirror-sync, but I might have mentioned 
that already ;-)

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: resumable git-clone?
Date: Wed, 8 Aug 2007 10:14:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708081012110.14781@racer.site>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
 <20070808035946.GP9527@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 11:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIhdJ-0003xX-SI
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 11:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759423AbXHHJPL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 05:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759121AbXHHJPK
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 05:15:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:33018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758779AbXHHJPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 05:15:08 -0400
Received: (qmail invoked by alias); 08 Aug 2007 09:15:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 08 Aug 2007 11:15:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vSfNcdkbvmZm+MPQG8oigs9jhVunRK5DA7jyMtN
	oalRIWhwOp4F96
X-X-Sender: gene099@racer.site
In-Reply-To: <20070808035946.GP9527@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55311>

Hi,

On Tue, 7 Aug 2007, Shawn O. Pearce wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > I was on a crappy connection and it was frustrated seeing git-clone
> > reached 80% then failed, then started over again. Can we support
> > resumable git-clone at some level? I think we could split into several
> > small packs, keep fetched ones, just get missing packs until we have
> > all.
> 
> This is uh, difficult over the native git protocol.  The problem
> is the native protocol negotiates what the client already has and
> what it needs by comparing sets of commits.  If the client says
> "I have commit X" then the server assumes it has not only commit
> X _but also every object reachable from it_.

Now here is a thought: after an interrupted fetch, you could do a 
(possibly expensive) analysis what commits are dangling, but do not 
contain broken links in their _complete_ history.  Then mark them as 
(temporary) refs.

Another possibility should be to start with a shallow clone, and to deepen 
it.  However, IIRC there have been complaints that that does not work, and 
it was not my itch, so I did not come around to scratch it.

Ciao,
Dscho

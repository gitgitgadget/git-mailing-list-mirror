From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Wed, 1 Oct 2008 07:52:07 -0700
Message-ID: <20081001145207.GW21310@spearce.org>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de> <20080930231619.GR21310@spearce.org> <20080930234157.GA1453@rdrz.de> <alpine.DEB.1.00.0810011514530.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Raphael Zimmerer <killekulla@rdrz.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:53:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl34s-0004m9-NG
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 16:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYJAOwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 10:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbYJAOwI
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 10:52:08 -0400
Received: from george.spearce.org ([209.20.77.23]:54184 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYJAOwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 10:52:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5F4563835F; Wed,  1 Oct 2008 14:52:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810011514530.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97226>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 1 Oct 2008, Raphael Zimmerer wrote:
> 
> > On Tue, Sep 30, 2008 at 04:16:19PM -0700, Shawn O. Pearce wrote:
> > > Elsewhere in Git we call this "-z", like "git ls-tree -z", "git log 
> > > -z".  Should we match grep or git convention here?
> > 
> > I'd tend to grep's convention, as most options of git-grep mimic those 
> > of grep. grep uses "-z" for \0 on _input_, so that would be very 
> > confusing for grep users...
> 
> I tend to disagree.  Git is _already_ perceived as too heterogenous, and 
> we should not add to that pile.

I already have my brain wired that "\0 terminators in Git are -z".
Thus I'd assume "git grep -z  .. | xargs -0" would work.  Today it
doesn't without this patch, but if the patch was added I'd assume
it would work.

Perhaps I'm too close to git as a contributor and experienced user
to realize any brain damage.

I'd rather stick to "-z" in Git.  At least its consistent.

Its not like tools outside of Git are all that consistent.  GNU
grep uses --null/-Z.  xargs and perl use -0.  find uses -print0.
The human at the keyboard already has to navigate this rats nest
between different tools, but within a tool (git) we should be as
consistent as we can.

-- 
Shawn.

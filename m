From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
 'dirty worktree'
Date: Wed, 4 Feb 2009 19:15:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902041915070.22763@intel-tinevez-2-302>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de> <7vvdrqunog.fsf@gitster.siamese.dyndns.org> <4989CF79.2070209@viscovery.net> <7vvdrqt74k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUmJa-0004uz-7x
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbZBDSP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbZBDSP5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:15:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:50400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753511AbZBDSP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:15:57 -0500
Received: (qmail invoked by alias); 04 Feb 2009 18:15:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 04 Feb 2009 19:15:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CxqM+NhMCflMG6ny8QQe+dG4zMWA0mc5al3HLPw
	gYk8nRSd1a2xsU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vvdrqt74k.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108405>

Hi,

On Wed, 4 Feb 2009, Junio C Hamano wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Because if the repository is non-bare, then filter-branch updates the
> > work-tree at the end of the run; we don't want to overwrite uncommitted
> > work in this case.
> >
> > This behavior is a relic from cg-admin-rewritehist, I think. I've never
> > found it useful.
> 
> Ok, I think "read-tree -m -u HEAD" at the end sort of makes sense, if you
> filtered the branch you are currently sitting on.  Does that mean we do
> not have to barf on dirtyness if we can tell if the filter-branch will not
> touch the current branch at all?  Again, I am not suggesting it as an
> improvement, but I am trying to see if I am talking a total nonsense.

That's correct.  Checking if we would touch the current branch is too 
expensive here, that's why we don't do it.

> Is the reason why you haven't found it is useful is because you never 
> filter the current branch?

Well, _I_ certainly do, and I find it very useful.

Ciao,
Dscho

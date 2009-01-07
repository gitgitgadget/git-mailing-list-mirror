From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Thu, 8 Jan 2009 00:03:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901080001410.7496@intel-tinevez-2-302>
References: <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp>
 <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de> <1231359317.6011.12.camel@maia.lan> <alpine.DEB.1.00.0901072121260.7496@intel-tinevez-2-302> <7v63kqall2.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901072213570.7496@intel-tinevez-2-302>
 <20090107224504.GA29537@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 00:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKhSG-0008KE-AK
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 00:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761000AbZAGXDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 18:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757390AbZAGXDY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 18:03:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:34377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754431AbZAGXDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 18:03:22 -0500
Received: (qmail invoked by alias); 07 Jan 2009 23:03:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 08 Jan 2009 00:03:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hFHJH940hnMjRquPYmM37I+IEcNto74dWqenLWr
	ieu05n9y3v7gfZ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090107224504.GA29537@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104844>

Hi,

On Wed, 7 Jan 2009, Pierre Habouzit wrote:

> On Wed, Jan 07, 2009 at 10:00:07PM +0000, Johannes Schindelin wrote:
> > Therefore I counted the lines between conflict markers (actually, a perl 
> > script did).  Of these 66 merges, on average patience merge produced 
> > 4.46774193548387 _fewer_ lines between conflict markers.
> > 
> > Take that with a grain of salt, though: the standard deviation of this 
> > difference is a hefty 121.163046639509 lines.
> > 
> > The worst case for patience diff was the merge 
> > 4698ef555a1706fe322a68a02a21fb1087940ac3, where the --cc diff line counts 
> > are 1300 (without) vs 1301 (with patience merge), but the lines between 
> > conflict markers are 197 vs a ridiculous 826 lines!
> > 
> > But you should take that also with a grain of salt: this merge is a 
> > _subtree_ merge, and my test redid it as a _non-subtree_ merge.
> > 
> > So I restricted the analysis to the non-subtree merges, and now 
> > non-patience merge comes out 6.97297297297297 conflict lines fewer than 
> > patience merge, with a standard deviation of 58.941106657867 (with a total 
> > count of 37 merges).
> > 
> > Note that ~7 lines difference with a standard deviation of ~59 lines is 
> > pretty close to ~0 lines difference.
> > 
> > In the end, the additional expense of patience merge might just not be 
> > worth it.
> 
> Depends, if it can help generating nicer merges, it's good to have.
> 
> We could have an option to git-merge that tries hard to generate the
> smallest conflict possible.

I also showed you examples, in addition to numbers, exactly to point out 
that shorter conflicts do not necessarily mean nicer conflicts.

Ciao,
Dscho

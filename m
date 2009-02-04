From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
 'dirty worktree'
Date: Wed, 4 Feb 2009 18:24:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902041823330.22763@intel-tinevez-2-302>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de> <7vvdrqunog.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 18:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUlVw-0008WD-3m
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 18:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbZBDRYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 12:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbZBDRYs
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 12:24:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:40611 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752023AbZBDRYs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 12:24:48 -0500
Received: (qmail invoked by alias); 04 Feb 2009 17:24:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 04 Feb 2009 18:24:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+icgZZVc2iGmjdGwiGKg0p09l4olZ01S7x3a/BTr
	xFgtzbeMWk3R9K
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vvdrqunog.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108398>

Hi,

On Wed, 4 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > As filter-branch could not care less about submodules' actual 
> > contents, it does not make sense to check if the checked-out 
> > submodules are up-to-date before running filter-branch.  So do not do 
> > it.
> 
> Sorry, but I am confused.  Is that because even the tree-filter does not 
> use the actual work tree but works in the temporary area .git-rewrite, 
> and a diverged submodule cannot possibly matter (and index-filter works 
> solely on the index anyway)?
> 
> If so, why do we even check dirtiness of anything at all?

I guess it is because we could update the working directory with read-tree 
-u -m HEAD at the end.  Actually, that is exactly what we do.

Submodules do not matter much here, as nothing will be overwritten, 
really, but a dirty working directory matters.

Ciao,
Dscho

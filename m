From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path to do
 sparse clone
Date: Thu, 24 Jul 2008 18:41:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241837441.8986@racer>
References: <20080723145718.GA29134@laptop> <20080724171952.GB21043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4pP-00010Y-Pc
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbYGXRlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYGXRlD
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:41:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:37744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751190AbYGXRlB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:41:01 -0400
Received: (qmail invoked by alias); 24 Jul 2008 17:40:59 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp031) with SMTP; 24 Jul 2008 19:40:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183bTN5xoo39bryx+ewVcsHqlyDbD+IDW4ni0T+t1
	44/WRdpHhDK4Hr
X-X-Sender: gene099@racer
In-Reply-To: <20080724171952.GB21043@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89921>

Hi,

On Thu, 24 Jul 2008, Jeff King wrote:

> As a user, I would expect "sparse clone" to also be sparse on the 
> fetching. That is, to not even bother fetching tree objects that we are 
> not going to check out. But that is a whole other can of worms from 
> local sparseness, so I think it is worth saving for a different series.

I think this is not even worth of a series.  Sure, it would have benefits 
for those who want sparse checkouts.  But it comes for a high price on 
everyone else:

- security issues (you'd need to open the git protocol to give you 
  something else than a ref, _including_ refs that were deleted)

- performance issues (the server would have to do a lot more, faking 
  commits, or in the alternative serving a gazillion more sessions if the 
  client does the reconstruction)

... and I am sure there are tons more issues.

Ciao,
Dscho

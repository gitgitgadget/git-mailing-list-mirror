From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers
 on  active trees]
Date: Wed, 1 Apr 2009 18:13:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904011811460.13502@intel-tinevez-2-302>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>  <20090330153245.GD23521@spearce.org>  <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>  <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302> 
 <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>  <alpine.DEB.1.00.0904010058490.6616@intel-tinevez-2-302> <526944450903311649q358d43edkf07e2e5058a9e527@mail.gmail.com> <alpine.DEB.1.00.0904010247170.10279@pacific.mpi-cbg.de>
 <49D30907.6090606@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: P Baker <me@retrodict.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 01 18:16:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp36u-00053L-E5
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 18:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761066AbZDAQOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbZDAQOE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 12:14:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:49441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760187AbZDAQOC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 12:14:02 -0400
Received: (qmail invoked by alias); 01 Apr 2009 16:13:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 01 Apr 2009 18:13:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QdIcrkhKQZFlrfkUaSchH9xlbjqZMS5/v2REhbL
	qfphzndPuyOqJO
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49D30907.6090606@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115398>

Hi,

On Wed, 1 Apr 2009, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Tue, 31 Mar 2009, P Baker wrote:
> > 
> > > I'll paraphrase to see if I understand your points:
> > >
> > > *Moving objects from submodule .git directories into the base .git/
> > > directory would protect the submodules and is a good idea.
> > 
> > No, I did not say that.
> > 
> > I said that moving submodules' working directory need to protected when
> > renaming/deleting submodules.
> > 
> > Even worse, I think that moving the .git/ directory into the superproject's
> > .git/ would be at least quite a bit awkward in the nested case.
> > 
> 
> Not necessarily. The .git directory of a submodule need not be named .git
> inside the superprojects .git directory. I could well imagine something
> like this:
> 
> .git/modules/submod(.git)/modules/nested-submod(.git)
> 
> For deeply nested submodules (eurgh), one might run into path length limit
> issues though. The point is that we will need some library-like function
> to find the repository of the submodule. Once that's done, the same call
> with a different $gitdir should be able to find the nested submodule.

It appears to me as a solution in need of a problem.

> I'm also thinking of libgit2 here, where each repository will be 
> represented as a struct that must be passed to the various $gitdir 
> searching functions. This is necessary to allow a single program to 
> access multiple repositories, and the .git/modules scheme makes 
> supporting submodules in the library quite trivial.

First: libgit2 is not an issue for this thread AFAIAC.

Second: accessing submodules' repositories is quite trivial at the moment.  
So much so that git-submodule can still get away with being a shell 
script.

Ciao,
Dscho

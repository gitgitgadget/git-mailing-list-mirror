From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: BUG: git rebase -i -p silently looses commits
Date: Wed, 11 Nov 2009 18:32:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911111804520.19111@intel-tinevez-2-302>
References: <20091104214611.GL9139@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 18:33:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8H4c-0006C1-11
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 18:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240AbZKKRcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 12:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbZKKRcn
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 12:32:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:52880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758086AbZKKRcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 12:32:42 -0500
Received: (qmail invoked by alias); 11 Nov 2009 17:32:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 11 Nov 2009 18:32:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XIKE/S5vXtM9SQ0Js/64zKgFUHcKr164V5evouq
	+Mkf27GbSYJrCa
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20091104214611.GL9139@dr-wily.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132679>

Hi,

On Wed, 4 Nov 2009, Greg Price wrote:

> On Mon, 2 Nov 2009, Johannes Schindelin wrote:
> > Having said that, I worked for some time on fixing this issue, and I 
> > actually run a version of rebase -i -p here that allows reordering 
> > commits, but it is far from stable (and due to GSoC and day-job 
> > obligations, I had no time to work on it in months).
> 
> I'm interested in this topic too.  Some weeks ago I took your
> rebase-i-p branch from January and rebased it onto the latest release;
> it's at
>   git://repo.or.cz/git/price.git rebase-i-p
> and now based on v1.6.5.2.  I fixed a few bugs and added a feature,
> and it's the version I run day to day.

That is very interesting!

However, for rebase-i-p to have a chance to be accepted, I think a few 
things are necessary still (this is all from memory, so please take 
everything with a grain of salt):

- reorder the series to have the -i fixes first, the new commands next, 
  and then the changes to the actual -p mode

- rework the mark stuff so that 'todo' works properly, and then change the 
  system to use ':<name>' style bookmarks.

- fix that nasty bug which makes one revision not pass the tests (I forgot 
  which one, but it should be in the TODOs)

- add proper handling for the case when a patch has been applied in 
  upstream already, but was not correctly identified as that by 
  --cherry-pick (well, this TODO is actually not really related to rebase 
  -i -p, but something I deeply care about)

Unfortunately, I am getting more and more deprived of Git time budget 
these days, so that I cannot seem to find a few hours to at least restart 
my efforts.

Ciao,
Dscho

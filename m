From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -p: Preserve --no-ff merges
Date: Fri, 20 Mar 2009 23:04:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903202300360.6865@intel-tinevez-2-302>
References: <alpine.DEB.2.00.0903201633440.4457@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkmqm-0007UF-TY
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 23:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbZCTWEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 18:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbZCTWEb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 18:04:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:53848 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751060AbZCTWEa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 18:04:30 -0400
Received: (qmail invoked by alias); 20 Mar 2009 22:04:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 20 Mar 2009 23:04:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JfR0wBhxJifEb7jDNSk8MtTpU616nUTikoYGrBu
	e+fOvokxvYH7TC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.2.00.0903201633440.4457@vinegar-pot.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114008>

Hi,

On Fri, 20 Mar 2009, Anders Kaseorg wrote:

> Previously, git rebase -p would turn some merges that had been constructed 
> with git merge --no-ff into fast-forwards.  Now it reconstructs those 
> merges using --no-ff as well.
> 
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---

First, could I ask you to hold off with patches for rebase -p for a little 
while?  I did a _lot_ of work on rebase -p recently, but it has not 
reached a state that I can submit yet without being ashamed.

Another thing to keep in mind is that some merges do _not_ want to be 
preserved.  IOW if you have a history like this:

- A - B
    \   \
      C - D - E

And your upstream cherry-picked B, after a rebase you are most likely to 
want

- A' - C' - E'

as a result (rather than

- A' - --
     \    \
       C' - D' - E'

which would be rather awkward).

Ciao,
Dscho

P.S.: FWIW you can see my work as part of my 'master' in 
http://repo.or.cz/w/git/dscho.git/

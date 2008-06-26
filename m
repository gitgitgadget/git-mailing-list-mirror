From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: how do I merge completely unrelated repositories ?
Date: Thu, 26 Jun 2008 17:19:41 +0100
Message-ID: <20080626161941.GX20723@cs-wsok.swansea.ac.uk>
References: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com> <20080626094522.GA29404@genesis.frugalware.org> <alpine.DEB.1.00.0806261224020.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 20:20:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBw4m-0008Dq-T2
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYFZSTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYFZSTM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:19:12 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:38677 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbYFZSTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 14:19:11 -0400
X-Greylist: delayed 7167 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2008 14:19:11 EDT
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1KBuCE-0005xk-3X; Thu, 26 Jun 2008 17:19:42 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 00877DAEBF;
	Thu, 26 Jun 2008 17:19:41 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id DE86F741BA; Thu, 26 Jun 2008 17:19:41 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806261224020.9925@racer>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86467>

Hi,

since a similar question burdens my soul for quite some
time, I would like to take the opportunity to extend
the question a bit:

I have around 10 CVS repositories, each with around 5 modules.
This has developed over time, and now I want to combine them
all into a single Git repository, with a new directory
structure introduced.

One possibility would be to convert these 50 CVS modules 
into git repositories, then for each of these git repositories
introduce the new tree structure (that is, what is relevant
for this part), move all files to their new location (via
"git mv"), and finally pull everything in into the common
repository.

This is all fine, except of the inability to follow the history
nicely (for example, via gitk I will only see the history
from the point on where in those temporary git-repositories
the files have been moved to their new place).

To avoid this break in the history, it would be great if
cvsimport could already move the files to the right place
in the directory hierarchy, that is, if an additional
parameter P could be given, the initial path, and files
will be imported as P/file. Then I could import everything right away into
the final git repository, without problems with clashes.
I can't find something like that in the documentation.

Is there perhaps some other possibility?
It seems easiest to me to do this little bit of surgery
at the time of the import, before git gets into his
troubles with hash-values.

thanks!

Oliver


On Thu, Jun 26, 2008 at 12:25:54PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 26 Jun 2008, Miklos Vajna wrote:
> 
> > On Thu, Jun 26, 2008 at 11:39:37AM +0200, Christian MICHON <christian.michon@gmail.com> wrote:
> > > How would you do it, since merge will not merge if it cannot find a
> > > common ancestor ?
> > 
> > Did you try so?
> > 
> > If there are no conflicting paths then a simple
> > 
> > git pull /path/to/other/repo.git master
> > 
> > or similar should work.
> 
> FWIW this is how gitk got into git.git... See 5569bf9b(Do a cross-project 
> merge of Paul Mackerras' gitk visualizer).  This also was often referred 
> to as the "coolest merge ever".
> 

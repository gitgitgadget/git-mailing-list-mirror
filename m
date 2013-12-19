From: Adam Spiers <git@adamspiers.org>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 20:58:58 +0000
Message-ID: <20131219205858.GJ23496@pacific.linksys.moosehall>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
 <20131219190333.GE23496@pacific.linksys.moosehall>
 <xmqqsitoefvi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 21:59:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtkgf-0006dV-NN
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab3LSU7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:59:00 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45999 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3LSU67 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:58:59 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 4A50F2E30D
	for <git@vger.kernel.org>; Thu, 19 Dec 2013 20:58:58 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqsitoefvi.fsf@gitster.dls.corp.google.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239547>

On Thu, Dec 19, 2013 at 12:37:53PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > On Thu, Dec 19, 2013 at 06:36:45PM +0000, Adam Spiers wrote:
> >> I wanted to be able to experiment with the TREESAME example given in
> >> the git-log(1) man page, so I built this script which recreates it:
> >
> > [snipped]
> >
> >> Would it be worth including this in (say) contrib/, and then referring
> >> to it from the man page, in case anyone else feels a similar urge?
> 
> I doubt it.  75% of the work for such a person to understand the
> behaviour from such an example is to understand what kind of history
> the example is building.

Agreed.  And that's precisely why I wanted a real repository
manifesting the given example: being able to view it in gitk makes
that a lot easier to understand, for obvious reasons.

> As you noticed, we do have existing tests
> to build "interesting" sample histories, but the fact that you did
> not bother with them and instead rolled your own should tell us
> something ;-)

Well I didn't roll my own; I just copied the example from the man
page.  So it only tells you that I was spending a fair amount of
effort trying to understand the man page ;-)  A user should not have to
read the test suite to understand how the thing works - that's only
for developers (conveniently ignoring for the sake of this argument
that I am occasionally a git developer too ;-)

> The next person is unlikely to read your sample in
> contrib/ but will roll his own,

Not if the man page says "if you wish to experiment with these options
yourself, you can easily recreate the repository in this example by
running the script contrib/foo bundled in the source distribution".

> which is probably more efficient way
> than learning from a series of commands.

The goal of sharing the series of commands is not to educate users
through reading them, but simply to save them the time they would have
to spend manually recreating the example scenario given in the man
page.  After all, the useful information is not how to set up a
repository reflecting the scenario, but rather, how the various
git-log options affect behaviour when run on that repository.

> What we _could_ do instead may be to better annotate sample
> histories in the existing tests.  Some of them (e.g. 6004, 6007) do
> have topology illustrations with what paths are changed at each node
> in the graph, but many lack such a visual aid to help readers
> understand what is going on at a glance.

Again, this has the flaw of requiring non-developer users to read the
test suite.  On most distributions, the test suite code isn't even
installed, so this means they would have to accurately recreate the
source from which their installed binary packages were built.  Surely
that is considerably more effort than most users should reasonably be
expected to spend.  In contrast, it would be trivial to extend
standard distro packages to include a file e.g.

  /usr/share/git-core/examples/git-log-history-simplification.sh

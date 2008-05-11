From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git gc & deleted branches
Date: Sun, 11 May 2008 12:11:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805111204580.30431@racer>
References: <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com> <48246A44.7020303@nrlssc.navy.mil> <alpine.LFD.1.10.0805091205580.23581@xanadu.home>
 <7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com> <20080510002014.GH29038@spearce.org> <7vskwr9coz.fsf@gitster.siamese.dyndns.org> <87y76jx6y4.fsf@jeremyms.com> <20080510052548.GA11556@sigill.intra.peff.net> <87tzh6yb2w.fsf@jeremyms.com>
 <alpine.DEB.1.00.0805101003350.30431@racer> <87prruxh3z.fsf@jeremyms.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Sun May 11 13:12:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv9Ta-000517-NY
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 13:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbYEKLLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 07:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbYEKLLJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 07:11:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:33545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752692AbYEKLLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 07:11:08 -0400
Received: (qmail invoked by alias); 11 May 2008 11:11:06 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp020) with SMTP; 11 May 2008 13:11:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ARjkHMZiA1mueFtCxmMnyQA2JGMoXLMMiIYMTgU
	eSHorqjx4wUuNF
X-X-Sender: gene099@racer
In-Reply-To: <87prruxh3z.fsf@jeremyms.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81756>

Hi,

On Sat, 10 May 2008, Jeremy Maitin-Shepard wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 10 May 2008, Jeremy Maitin-Shepard wrote:
> 
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > On Fri, May 09, 2008 at 09:51:15PM -0400, Jeremy Maitin-Shepard 
> >> > wrote:
> 
> >> >> When you create a new working directory, you would also create in 
> >> >> the original repository a symlink named e.g. 
> >> >> orig_repo/.git/peers/<some-arbitrary-name-that-doesn't-matter> 
> >> >> that points to the .git directory of the newly created working 
> >> >> directory.
> >> 
> >> > That assumes you _can_ write to the original repository. That may 
> >> > or may not be the case, depending on your setup.
> 
> > FWIW this argument can be found in the mailing list.  It does not have 
> > to be told over and over again, right?
> 
> Maybe you can point me at the relevant thread.  Fundamentally, though,
> I'd say objects/info/alternates _cannot_ work reliably without the
> source repository knowing about the objects that the sharing
> repositories need.  Otherwise, there is no way for it to know not to
> prune them.  The only way for it to have that information in general is
> to write it in the repository.  In a site-specific setting, it may
> indeed be possible to rely on some site-specific database, but that is
> not particularly relevant.
> 
> Currently repository sharing seems to be used in many cases in quite
> unsafe ways.  It may seem unfortunate that doing things the "safe way"
> is much more of a hassle and doesn't work in certain environments, but
> I'd say that is just the way things have to be.
> 
> Perhaps you can point me to an existing thread that addresses this idea, 
> though.

Unfortunately, a quick search did not turn up anything useful.  Maybe you 
try your luck yourself...

> >> Well, I suppose in that case it could print a warning or maybe fail 
> >> without some "force" option.  If you can't write to the repository, 
> >> then I think it is safe to say that it will never know or care about 
> >> you, so you will fundamentally have a fragile setup.  I'd say that 
> >> except in very special circumstances, you are better off just not 
> >> sharing it at all.
> 
> > Counterexample kernel.org.  Counterexample repo.or.cz.
> 
> repo.or.cz is not a counterexample.  It is completely "managed", and 
> could quite easily implement the approach I described.

Half true... you said "if you can't write to the repository..." and on 
repo.or.cz, the first part is true, the second part not.

> There is the issue that these setuid helper scripts would mean at the 
> very least that if user A can "fork" user B's repository, then to some 
> extent user B can make user A use large amounts of disk space (i.e. 
> exceed his quota or something) by just referencing a bunch of temporary 
> objects that user A happens to have in his repository, and it would take 
> careful examination of the git repository to actually figure out that it 
> is user B's fault.  I don't think this would be a significant problem in 
> practice, though.

Well, I think that the setuid helper script would open a whole bunch of 
other issues.

I think that the shared repository problem is rather a semantic one, i.e. 
it is only solvable between the owners of the repository by good-ole 
talking, not something that can be solved by the tool (Git).

Ciao,
Dscho

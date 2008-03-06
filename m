From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Thu, 6 Mar 2008 03:32:34 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803060330210.15786@racer.site>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>  <7vd4q8kbey.fsf@gitster.siamese.dyndns.org> <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 03:33:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX5v8-0002lT-1e
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 03:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934846AbYCFCcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 21:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934840AbYCFCce
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 21:32:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:33237 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934825AbYCFCcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 21:32:33 -0500
Received: (qmail invoked by alias); 06 Mar 2008 02:32:31 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp035) with SMTP; 06 Mar 2008 03:32:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QNe5L6nVQCQDSw3VMpoTdsAPW4xarorec8MyBW2
	EHOlReOVEUS0Mn
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320803051754o4b45222es524a62a7cac50b94@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76312>

Hi,

On Thu, 6 Mar 2008, Ping Yin wrote:

> On Thu, Mar 6, 2008 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Ping Yin <pkufranky@gmail.com> writes:
> >
> >  > This patch allows multi-level module definition in .gitmodules as
> >  > Linus and Sven Verdoolaege etc. have suggested in mails
> >  > "Let .git/config specify the url for submodules"
> >  > (http://article.gmane.org/gmane.comp.version-control.git/48939).
> >  >
> >  > Following shows an example of such a .gitmodules.
> >  >
> >  > .gitmodules with with multiple level of indirection
> >  > ------------------------------------------------------
> >  > [submodule "service"]
> >  >    submodule = crawler
> >  >    submodule = search
> >  > ...
> >
> > > [submodule "util"]
> >  >    url = git://xyzzy/util.git
> >  > [submodule "imsearch"]
> >  >    path = search/imsearch
> >  >    url = git://xyzzy/imsearch.git
> >  > [submodule "imcrawler"]
> >  >    path = crawler/imcrawter
> >  >    url = git://xyzzy/imcrawter.git
> >  > ------------------------------------------------------
> >
> >  I would agree that allowing the user to use a short-hand to name a group
> >  of modules the user is interested in would be a good idea, but I think
> >  .gitmodules is a wrong place to do so.  The grouping is a user preference,
> >  isn't it?
> >
> >  The place the owner of the repository (not the project) expresses which
> >  modules are of interest, what transports she wants to use to access it,
> >  etc. is $GIT_DIR/config, and .gitmodules is a vehicle to supply hints to
> >  be used when the user populates that information.
> >
> Not always the case.

If it is _not_ always the case, .gitmodules is definitely the wrong place, 
and $GIT_DIR/config is.

Just like we need "init && update", and not have "init" update implicitly, 
like some people wish (who forget that other people might have other 
wishes), we need to allow for different options here.

And as .gitmodules is _meant_ to be tracked, it is not the place to 
express individual wishes differing from the colleagues' wishes.

Ciao,
Dscho


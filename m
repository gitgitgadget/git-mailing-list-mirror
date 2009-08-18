From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save'
 is omitted
Date: Tue, 18 Aug 2009 23:42:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr> <vpqws51l1hb.fsf@bauges.imag.fr> <20090818174509.GA27518@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWRi-0003Go-RH
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbZHRVmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbZHRVmI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:42:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:33170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750902AbZHRVmH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:42:07 -0400
Received: (qmail invoked by alias); 18 Aug 2009 21:42:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 18 Aug 2009 23:42:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191prpizyl1PgzQq2cG5k4KpExvGX4hFlvAVNOOz0
	RBGvWGBDeMjlUs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090818174509.GA27518@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126466>

Hi,

On Tue, 18 Aug 2009, Jeff King wrote:

> On Tue, Aug 18, 2009 at 03:01:52PM +0200, Matthieu Moy wrote:
> 
> > Hmm, googling a bit, I just noticed that there's already something in
> > pu:
> > ea41cfc4f (Make 'git stash -k' a short form for 'git stash save --keep-index')
> > which also does the trick, while adding a -k alias for --keep-index.
> >
> > [...]
> > 
> > Mine has at least two advantages:
> > 
> > * It won't require changing the code again when new options are added
> >   to 'git stash save'.
> > 
> > * It works with 'git stash -k -q' for example, while the other
> >   proposal checks that $# == 1, which won't work if there are more
> >   than one option.
> 
> I think yours is nicer, especially as we have just added the
> '-p|--patch' option, as well. With what is there now, you can do "git
> stash -p", but not "git stash -p -k".

But it is sloppy, in that it blindly accepts options that might be valid 
for several subcommands, not just "save".

That was the reason I did not implement it this way.

But we do not have such ambiguous options yet.

Or do we?  Look at what "list" accepts!

So please register my objection.

Ciao,
Dscho

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Tue, 7 Feb 2012 14:21:02 -0500
Message-ID: <20120207192102.GA887@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
 <20120207051719.GA11598@sigill.intra.peff.net>
 <CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
 <20120207173025.GA22225@sigill.intra.peff.net>
 <m31uq63143.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 20:21:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuqbH-0004g7-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 20:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab2BGTVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 14:21:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59375
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756620Ab2BGTVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 14:21:05 -0500
Received: (qmail 10619 invoked by uid 107); 7 Feb 2012 19:28:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 14:28:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 14:21:02 -0500
Content-Disposition: inline
In-Reply-To: <m31uq63143.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190202>

On Tue, Feb 07, 2012 at 11:16:47AM -0800, Jakub Narebski wrote:

> > Git-config could potentially help with that (and even simplify the
> > current code) by allowing something like:
> > 
> >   $ git config --list-with-sources
> >   /home/peff/.gitconfig user.name=Jeff King
> >   /home/peff/.gitconfig user.email=peff@peff.net
> >   .git/config core.repositoryformatversion=0
> >   .git/config core.bare=false
> >   [etc]
> > 
> > (you would use the "-z" form, of course, and the filenames would be
> > NUL-separated, but I made up a human-readable output format above for
> > illustration purposes).
> 
> That would be _very_ nice to have (even without includes support).
> 
> Filenames would be git-quoted like in ls-tree / diff-tree output without -z,
> isn't it?  And is that TAB or SPC as a separator?

Yeah, the output above is just illustrative. Without -z, I would do
quoted filename, TAB, and then $KEY=$VALUE (I didn't check whether we
quote an "=" in the subsection of a key, but we probably should).

-Peff

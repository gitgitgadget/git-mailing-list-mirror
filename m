From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] Don't cache DESTDIR in perl/perl.mak.
Date: Tue, 18 Dec 2007 14:25:37 +0000
Message-ID: <20071218142537.23571.qmail@5b1a609bf11950.315fe32.mid.smarden.org>
References: <20071210093102.3050.qmail@06e91d20307a62.315fe32.mid.smarden.org> <7vodcyl5dy.fsf@gitster.siamese.dyndns.org> <20071212180050.GA18980@untitled> <20071212200211.GB1060@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 15:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4dOC-0002Im-0n
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 15:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbXLROZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 09:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935AbXLROZV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 09:25:21 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:38279 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753253AbXLROZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 09:25:20 -0500
Received: (qmail 23572 invoked by uid 1000); 18 Dec 2007 14:25:37 -0000
Content-Disposition: inline
In-Reply-To: <20071212200211.GB1060@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68753>

On Wed, Dec 12, 2007 at 09:02:11PM +0100, Pierre Habouzit wrote:
> On Wed, Dec 12, 2007 at 06:01:48PM +0000, Eric Wong wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > Hmph.  That's reverting this:
> > > 
> > > commit 4c5cf8c44ce06a79da5bafd4a92e6d6f598cea2e

> > > Eric, care to comment?
> > 
> > I used to make a statically linked binary package for working on an
> > ancient box that didn't have a lot of libraries I wanted, and I probably
> > just called `make install' into DESTDIR as a single step without calling
> > `make' alone without DESTDIR argument, or I had DESTDIR set in
> > config.mak
> 
>   Actually this fact generated a bug in debian packaging because git is
> built then installed twice in different DESTDIRS, then parts of the
> install is pruned (the two installs are arch-dependant and
> arch-independant files install so it's a very good reason in term of
> packaging).
> 
>   The fact that perl.mak caches the DESTDIR make it install things in
> the wrong place because it doesn't honour make DESTDIR=foo install and
> always use the cached value instead, which is wrong.
> 
>   I think Gerrit won't care if it's cached or not, he just cares that it
> still honours environment if present.

Yes, precisely.  Thanks, Gerrit.

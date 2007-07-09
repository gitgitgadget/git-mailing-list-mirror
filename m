From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch --track: code cleanup and saner handling of local
 branches
Date: Mon, 9 Jul 2007 22:05:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707092203100.5546@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 23:13:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I80XU-0000eO-MI
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 23:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbXGIVM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 17:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755062AbXGIVM4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 17:12:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:34797 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753565AbXGIVMz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 17:12:55 -0400
Received: (qmail invoked by alias); 09 Jul 2007 21:12:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 09 Jul 2007 23:12:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GMEhxWehGuDQNVjf/C4MkRwOk8pZ6HIlkgCdIRy
	3/fHseP6PPXrJg
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52020>

Hi,

On Mon, 9 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > -static int get_remote_branch_name(const char *value)
> > +static int tracking_config(const char *key, const char *value)
> > [...]
> >  	/*
> > -	 * Try an exact match first.  I.e. handle the case where the
> > -	 * value is "$anything:refs/foo/bar/baz" and start_ref is exactly
> > -	 * "refs/foo/bar/baz". Then the name at the remote is $anything.
> > +	 * A remote.<name>.fetch value can have two forms:
> > +	 *
> > +	 * - exact:
> > +	 *
> > +	 *	refs/heads/gnu:refs/heads/my-upstream
> > +	 *
> > +	 * - wildcard:
> > +	 *
> > +	 *	refs/heads/ *:refs/remotes/gnu/ *
> > +	 *
> > +	 * try exact match first:
> >  	 */
> 
> It strikes me a bit odd if Daniel's remote.[ch] infrastructure
> does not give you easy access to this kind of information...

Yes, probably.  However, at the time he was sending that patch, I was 
already preparing the patch.  Besides, we can always go back and change 
the code, if you really want to pull in the remotes stuff into 
builtin-branch (as of yet, they are almost independent).

My vote is to have it indpendent for now, if only to fix existing issues.  
But in the end it is your choice.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Tue, 1 May 2007 09:32:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705010927240.29859@racer.site>
References: <463679EB.2010301@gmail.com> <20070501050633.GZ5942@spearce.org>
 <56b7f5510704302241n79601619kda8251a9f7776884@mail.gmail.com>
 <20070501060340.GD5942@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 09:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HimrK-0008R0-ER
	for gcvg-git@gmane.org; Tue, 01 May 2007 09:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXEAHdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 03:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbXEAHdK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 03:33:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:45287 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964976AbXEAHdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 03:33:08 -0400
Received: (qmail invoked by alias); 01 May 2007 07:33:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 01 May 2007 09:33:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ya60h7lDy8/4yXufhNjJE0s/DiMR8Q8xEQnQn42
	H1dBwLl7zRvGZu
X-X-Sender: gene099@racer.site
In-Reply-To: <20070501060340.GD5942@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45925>

Hi,

On Tue, 1 May 2007, Shawn O. Pearce wrote:

> Dana How <danahow@gmail.com> wrote:
>
> > On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> > >Why not refactor both to use the same implementation and stuff it 
> > >away in say pack-check.c (for lack of a better place), or start a new 
> > >file (pack-write.c)?
> >
> > Actually I didn't just copy it, I tried to rewrite it for my use as 
> > well as the fast-import.c use (note there is a 3rd copy in some 
> > *index*.c file which I didn't try to merge in yet). However I didn't 
> > yet put it in a new file or change fast-import.c to call it since I 
> > wanted to change as little as possible.
> ...
> > I agree with all your arguments.  I had several reasons
> > to avoid extra rearrangements/refactorings:
> > (a) First patch to git, not previously known to me;
> > (b) I prefer to separate new functionality from "clean-up" work;
> 
> A really good reason.  ;-)
> 
> But I'd still rather see it done right the first time, then done
> partially (copied) and wait for someone to clean it up later.

FWIW it is not just a clean up in the sense of making the code more 
elegant. It is about catching bugs. The smaller the code base, and the 
more code is reused for common tasks, the easier it is to

- get at bugs,
- fix bugs, and
- prevent bugs

Some might even argue that the elegance of the code is a direct indicator 
of its quality.

Obviously, I am suggesting to go the slightly slower route. In effect, 
this will turn out to be the faster route, though, since bug fixing 
traditionally makes up for 90% of development time.

Ciao,
Dscho

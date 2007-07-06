From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Fri, 6 Jul 2007 13:03:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061231050.4093@racer.site>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site>
 <81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
 <7vsl82dcj0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707051811310.9789@racer.site>
 <7vfy42d6m0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707052018260.9789@racer.site>
 <7v1wfmi090.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 14:10:58 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6meF-0003jD-7A
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 14:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759745AbXGFMKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 08:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759779AbXGFMKr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 08:10:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:49514 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759720AbXGFMKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 08:10:46 -0400
Received: (qmail invoked by alias); 06 Jul 2007 12:10:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 06 Jul 2007 14:10:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19x2/AlPjBxg/pWLc0iqawg6sTLgHC9fVcCfbLmwW
	fO9fMlSu64fRAf
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wfmi090.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51741>

Hi,

On Thu, 5 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > .... I guess that many distros do not update their templates as often 
> > as the core, because they are much more likely to be modified 
> > distro-specifically.
> 
> Can you back that up?  Fedora and Debian seem to ship them unmodified.

No.

> > Further, there are some platforms which are insane enough that you 
> > cannot trust the executable bit, and therefore the templates are 
> > disabled by default.

But this still holds.

> If you truly want to have rerere enabled by default, it might make sense 
> to:
> 
>  * Remove "if test -d "$GIT_DIR/rr-cache" tests we have in the
>    existing users;
> 
>  * Implement a new test in builtin-rerere.c, as:
> 
>    - if rerere.enabled configuration does not exist, check
>      $GIT_DIR/rr-cache as before;
> 
>    - if rerere.enabled configuration is true, do not bother
>      checking $GIT_DIR/rr-cache, but just do it;
> 
>    - if rerere.enabled configuration is explicitly set to false,
>      never use rerere.
> 
>  * Maybe later we might change the default value for
>    rerere.enabled to "true", IOW, everybody except people who
>    say "[rerere] enabled = false" in their configuration
>    automatically gets rerere.
> 
> Doing it in git-init, either your patch or by installing a new
> template, means existing old repository would never get the
> updated behaviour unless the user runs "git init" there, which
> is not a very intuitive thing to do to begin with.

Well, I finally bit the apple. Will post in a minute.

Ciao,
Dscho

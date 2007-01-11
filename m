From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Thu, 11 Jan 2007 09:22:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701110919040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhcuyaaxq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 09:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4vD7-00063A-Rg
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 09:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbXAKIWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 03:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbXAKIWz
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 03:22:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:39062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030213AbXAKIWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 03:22:54 -0500
Received: (qmail invoked by alias); 11 Jan 2007 08:22:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 11 Jan 2007 09:22:53 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhcuyaaxq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36556>

Hi,

On Wed, 10 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Cygwin, newly builtins are not recognized, because there exist both
> > the executable binaries (with .exe extension) _and_ the now-obsolete
> > scripts (without extension), but the script is executed.
> >
> > "make clean-obsolete-scripts" removes these ambiguities by removing the
> > older of these file pairs.
> 
> I would prefer it to be rather automatic -- how about this instead?

I like your method better. However, does it execute an rm -f for _every_ 
builtin, even if it does not exist? This is a huge performance eater on 
cygwin. Every fork() is _expensive_.

Even worse: are you sure that it does not remove the _builtins_? Maybe you 
noticed that I asked for "git-bla." instead of "git-bla", since the latter 
will happily access "git-bla.exe" (at least when you do an "ls git-bla" 
and "git-bla.exe" exists, but not "git-bla", it _will_ show 
the metadata of "git-bla.exe", but with the name "git-bla").

Will test.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Wed, 10 Jan 2007 14:42:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701101441360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0701100453t63b62867ne67819e91f1319b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jan 10 14:42:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4djB-0007J7-0t
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 14:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbXAJNmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 08:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbXAJNmu
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 08:42:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:37754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932515AbXAJNmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 08:42:50 -0500
Received: (qmail invoked by alias); 10 Jan 2007 13:42:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 10 Jan 2007 14:42:48 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701100453t63b62867ne67819e91f1319b9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36508>

Hi,

On Wed, 10 Jan 2007, Alex Riesen wrote:

> On 1/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Cygwin, newly builtins are not recognized, because there exist both
> > the executable binaries (with .exe extension) _and_ the now-obsolete
> > scripts (without extension), but the script is executed.
> > 
> > "make clean-obsolete-scripts" removes these ambiguities by removing the
> > older of these file pairs.
> 
> Not enough. You have to cleanup the build directory too,
> otherwise tests fail, and git-hacking on git itself is ... complicated.

Doesn't it handle that?

	ls *$X '$(DESTDIR_SQ)$(gitexecdir_SQ)'/*$X

Note the first "*$X". It really should pick up on all executables in the 
build directory. Or do I miss something?

Ciao,
Dscho

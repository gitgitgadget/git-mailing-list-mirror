From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Unchain the git-COMMAND into git
 COMMAND
Date: Tue, 5 Feb 2008 14:10:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802051407540.8543@racer.site>
References: <3as81nbn.fsf@blue.sea.net> <alpine.LSU.1.00.0802042050480.8543@racer.site> <8x1zzemr.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 15:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMOWi-0006nt-3h
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 15:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbYBEOLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 09:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYBEOLW
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 09:11:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:59724 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752061AbYBEOLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 09:11:21 -0500
Received: (qmail invoked by alias); 05 Feb 2008 14:11:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 05 Feb 2008 15:11:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+u/kEZBy6u+vt5FOULGVTZ/AiUFw9z9IX0TFQl1m
	aEW09emTP/vUQP
X-X-Sender: gene099@racer.site
In-Reply-To: <8x1zzemr.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72657>

Hi,

On Tue, 5 Feb 2008, Jari Aalto wrote:

> * Mon 2008-02-04 Johannes Schindelin <Johannes.Schindelin@gmx.de>
> * Message-Id: alpine.LSU.1.00.0802042050480.8543@racer.site
> > Hi,
> >
> > On Mon, 4 Feb 2008, Jari Aalto wrote:
> >
> >> -Example:       git-rebase master~1 topic
> >> +Example:       git rebase master~1 topic
> >
> > From 36e5e70e0f40cf7ca4351b8159d68f8560a2805f(Start deprecating 
> > "git-command" in favor of "git command"):
> >
> >     (For non-builtins, the "git xyzzy" format implies an extra execve(), so
> >     this script leaves those alone).
> 
> Please elaborate. I'm not sure I understand. If the git-<command> syntax
> is being phased out, it should be consistent decision accross the tools.

If you call "git xyz", but git-xyz is a script, you will exec the git 
wrapper first, which will then exec git-xyz.  That is an unnecessary exec.

Since the places you touched are already in a git script (i.e. it was 
already called with PATH extended to git's libexec/ directory, if there is 
one), we can avoid that extra exec.

The git-<command> syntax _is_ phased out, but in several steps.  Let's not 
do the third step before the first, otherwise we'll trip.

Ciao,
Dscho

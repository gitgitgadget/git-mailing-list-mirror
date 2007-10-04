From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsserver commit trouble BUG+Work-around
Date: Thu, 4 Oct 2007 13:56:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041352480.4174@racer.site>
References: <200710031348.50800.wielemak@science.uva.nl>   
 <200710032325.55128.wielemak@science.uva.nl>    <Pine.LNX.4.64.0710032311480.28395@racer.site>
    <200710040927.03977.wielemak@science.uva.nl>
 <46823.146.50.26.20.1191496739.squirrel@webmail.science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Thu Oct 04 14:46:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQ5a-0006yc-G3
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 14:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbXJDMpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 08:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755516AbXJDMpz
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 08:45:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:49225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754145AbXJDMpy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 08:45:54 -0400
Received: (qmail invoked by alias); 04 Oct 2007 12:45:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 04 Oct 2007 14:45:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UpKNHX+LUEFsEfy8ZUuEpzh6eRkjb2Ek8uDc6kt
	3fDEQklQrdYtub
X-X-Sender: gene099@racer.site
In-Reply-To: <46823.146.50.26.20.1191496739.squirrel@webmail.science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59944>

Hi,

On Thu, 4 Oct 2007, Jan Wielemaker wrote:

> Indeed, the trouble is here: git-cvsserver, near line 1203:
> 
>     my $parenthash = `git show-ref -s refs/heads/$state->{module}`;
> 
> $state->{module} is -of course- HEAD. git show-ref -s refs/heads/HEAD 
> indeed gives no output. git show-ref -s refs/heads/master works just 
> fine.

Ah!  Did you do "CVSROOT=:ext:blablub cvs co HEAD"?

You should "co master".  The branches in git are the modules in cvs.

HEAD is too volatile, you cannot make a proper module from it (imagine for 
example "git checkout next" where "next" is a branch, followed by "git 
checkout html", where "html" is another branch).

Ciao,
Dscho

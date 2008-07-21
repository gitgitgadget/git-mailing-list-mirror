From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 12:56:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807211255010.3305@eeepc-johanness>
References: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com> <alpine.DEB.1.00.0807210310330.3305@eeepc-johanness> <1216604693.3673.20.camel@pc7.dolda2000.com> <m3fxq3ws16.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 12:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKt4K-0000G9-0p
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 12:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759062AbYGUKz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 06:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757845AbYGUKzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:55:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:38289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759309AbYGUKzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:55:24 -0400
Received: (qmail invoked by alias); 21 Jul 2008 10:55:22 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp003) with SMTP; 21 Jul 2008 12:55:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8NvQRQfn8dmdgVBJ8Op8764ylnc2mOimtj07L6e
	wfY+NP9vMBByqy
X-X-Sender: user@eeepc-johanness
In-Reply-To: <m3fxq3ws16.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89339>

Hi,

On Mon, 21 Jul 2008, Jakub Narebski wrote:

> Fredrik Tolf <fredrik@dolda2000.com> writes:
> 
> > [...] Here's some makeshift documentation:
> > 
> > The string specified in core.sshcommand is first checked if it matches
> > any of the built-in templates, in which case it is expanded (I've added
> > the templates "openssh" and "plink" by default). When used, the string
> > is split into words, each of which is processed as follows:
> > 
> > * If a word is %p, it is replaced by the port number, if specified.
> >   If the port number is not specified, the word is deleted.
> > * If a word is %h, it is replaced by the remote host name.
> > * If a word begins with %P, it is deleted if no port number is
> >   specified. This is to allow for specifying different port number
> >   flags for different SSH implementations. The syntax is a bit ugly,
> >   but I cannot really think of anything that would look better.
> >   If a port number has been specified, the leading %P is simply deleted.
> 
> There is a syntax which would look better, but perhaps it is a bit
> overkill in this situation.  Namely use either shell conditional
> expansion:
> 
>   ${p:+-P $p}
> 
> or syntax used in RPM spec macros
> 
>   %{?p:-P %p}
> 
> (and there is complementing %{!?<var>:<expansion>} in RPM spec macro
> language).

Yes, this is overkill.  I would even have passed the port argument 
_always_, since the port 22 for ssh is as likely to change as hell will 
not freeze over.  Actually, I am not so sure about the latter.

Ciao,
Dscho

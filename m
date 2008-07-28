From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] builtin-help: make it possible to exclude some
 commands in list_commands()
Date: Mon, 28 Jul 2008 04:43:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807280442330.5526@eeepc-johanness>
References: <cover.1217207602.git.vmiklos@frugalware.org> <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org> <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org>
 <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org> <7vr69ex00x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 04:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNIiK-0007Ia-KN
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 04:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbYG1Cmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 22:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbYG1Cmu
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 22:42:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:38938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751710AbYG1Cmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 22:42:49 -0400
Received: (qmail invoked by alias); 28 Jul 2008 02:42:47 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp003) with SMTP; 28 Jul 2008 04:42:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4fAIpckG4oA4fzWccHjROYHFc0bJ5kzIZwLiQ6V
	zFHFhph46RzWPg
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vr69ex00x.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90396>

Hi,

On Sun, 27 Jul 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > diff --git a/help.h b/help.h
> > index 0741662..85d3b74 100644
> > --- a/help.h
> > +++ b/help.h
> > @@ -1,7 +1,19 @@
> >  #ifndef HELP_H
> >  #define HELP_H
> >  
> > +struct cmdnames {
> > +	int alloc;
> > +	int cnt;
> > +	struct cmdname {
> > +		size_t len;
> > +		char name[1];
> > +	} **names;
> > +};
> 
> I thought we do this kind of thing using FLEX_ARRAY macro.  Is there any
> reason its use is not appropriate here?

I think that came up in the previous review round: the "name" member _is_ 
NUL-terminated, but could have a ".exe" suffix.  The "len" member has the 
length excluding ".exe".

Ciao,
Dscho

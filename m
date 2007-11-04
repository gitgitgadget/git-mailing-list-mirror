From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] pretty describe: add name info to struct commit
Date: Sun, 4 Nov 2007 14:22:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041420430.4362@racer.site>
References: <472DB186.9030909@lsrfire.ath.cx> <20071104140700.GB3078@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IogNz-0007P1-2N
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbXKDOXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 09:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755040AbXKDOXS
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:23:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:35069 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754677AbXKDOXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 09:23:18 -0500
Received: (qmail invoked by alias); 04 Nov 2007 14:23:16 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp012) with SMTP; 04 Nov 2007 15:23:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4yyE6wwb4C4O31017j7o36S1iyHAeei4wFM/i7k
	rDTgZOWmBClcVV
X-X-Sender: gene099@racer.site
In-Reply-To: <20071104140700.GB3078@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63409>

Hi,

On Sun, 4 Nov 2007, Alex Riesen wrote:

> Ren? Scharfe, Sun, Nov 04, 2007 12:48:22 +0100:
> > diff --git a/commit.h b/commit.h
> > index b661503..80e94b9 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -18,6 +18,9 @@ struct commit {
> >  	struct commit_list *parents;
> >  	struct tree *tree;
> >  	char *buffer;
> > +	char *name;
> > +	unsigned int name_flags;
> > +	char name_prio;
> >  };
> 
> It increases size of struct commit by ~12 bytes (assuming 4byte
> allignment), and this is a popular structure.

I was just about to say something similar.

But there is a wonderful solution: Have a look at decorate.[ch].  This is 
the structure you should use IMHO.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] sending errors to stdout under $PAGER
Date: Sun, 17 Feb 2008 15:15:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171515190.30505@racer.site>
References: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org> <20080217144854.56fcb98d.froese@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Edgar Toernig <froese@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 16:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQlFm-0004jI-Hv
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 16:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbYBQPPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 10:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbYBQPPy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 10:15:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:56355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754996AbYBQPPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 10:15:54 -0500
Received: (qmail invoked by alias); 17 Feb 2008 15:15:52 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp037) with SMTP; 17 Feb 2008 16:15:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bv/pap9nbm6fqH5ES+Jl48kJgRA+fOIt8nI9+5a
	KRErBRry8SX9bT
X-X-Sender: gene099@racer.site
In-Reply-To: <20080217144854.56fcb98d.froese@gmx.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74136>

Hi,

On Sun, 17 Feb 2008, Edgar Toernig wrote:

> Junio C Hamano wrote:
> >
> > +	FILE *outto = (pager_in_use() ? stdout : stderr);
> > +
> >  	vsnprintf(msg, sizeof(msg), err, params);
> > -	fprintf(stderr, "%s%s\n", prefix, msg);
> > +	fprintf(outto, "%s%s\n", prefix, msg);
> >
> > What do people think?  Have I overlooked any downsides?
> 
> Wouldn't it be better/safer to redirect stderr to the pager
> in the first place?
> 
> [...]
>
>          /* return in the child */
>         if (!pid) {
>                 dup2(fd[1], 1);
> +               dup2(fd[1], 2);
>                 close(fd[0]);
>                 close(fd[1]);
>                 return;
>         }

I like it.

Ciao,
Dscho

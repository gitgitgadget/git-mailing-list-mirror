From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sun, 3 Feb 2008 01:55:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802030155240.7372@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>  <1201975757-13771-1-git-send-email-hjemli@gmail.com>  <alpine.LSU.1.00.0802021815510.7372@racer.site> <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 02:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLU6S-0000Gq-UD
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 02:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935790AbYBCB40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 20:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935041AbYBCB40
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 20:56:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:37493 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933771AbYBCB4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 20:56:25 -0500
Received: (qmail invoked by alias); 03 Feb 2008 01:56:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp007) with SMTP; 03 Feb 2008 02:56:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oypZvXazo1lV1bCV5q6sxVSxRH5csCr3luExu7K
	p2E9WggNIYjAM4
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72314>

Hi,

On Sat, 2 Feb 2008, Lars Hjemli wrote:

> On Feb 2, 2008 7:19 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sat, 2 Feb 2008, Lars Hjemli wrote:
> >
> > > +     if (len < 10 || buf[len - 1] != '\n' || strncmp(buf, "GITDIR: ", 8))
> >
> > Sorry, missed that earlier: How about
> >
> >         if (!len || buf[len-1] != '\n' || prefixcmp(buf, "GITDIR: "))
> >
> > instead?  (buf does not need be NUL terminated for the prefixcmp(), since
> > we just made sure it is LF terminated)
> 
> That's true, although it feels a bit too clever for me ;-)

:-)

> Maybe this as a compromise?
> 
> 	static char buf[PATH_MAX + 9];  /* "GITDIR: " + "\n"  */
> ...
> 	if (!len || buf[len - 1] != '\n')
> 		return NULL;
> 	buf[len - 1] = '\0';
> 	if (prefixcmp(buf, "GITDIR: "))
> 		return NULL;

Sure!

Thanks,
Dscho

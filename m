From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] OSX Mail.app IMAP cache support for git-mailsplit?
Date: Mon, 5 Nov 2007 10:39:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711051034060.4362@racer.site>
References: <06FE21A2-20D0-4AAA-B0C7-35783C604B68@mac.com>
 <7B209F05-B720-41D6-AE98-39FAFF04B9F6@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Cohen <michaeljosephcohen@mac.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 11:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IozP9-0004ep-2x
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 11:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbXKEKkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 05:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbXKEKkU
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 05:40:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:53272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753507AbXKEKkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 05:40:19 -0500
Received: (qmail invoked by alias); 05 Nov 2007 10:40:17 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 05 Nov 2007 11:40:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DYSxT5H4DpaCPKCkJVxAsN5Q2+11WR7bMc5fWel
	2CVQfeHS6PKI+a
X-X-Sender: gene099@racer.site
In-Reply-To: <7B209F05-B720-41D6-AE98-39FAFF04B9F6@mac.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63494>

Hi,

you have a very weird mail setting; I had to add the git list back to the 
Cc.  This is just annoying enough for me to write an extra paragraph to 
annoy you back ;-)

On Mon, 5 Nov 2007, Michael Cohen wrote:

> On Nov 4, 2007, at 1:49 AM, Michael J. Cohen wrote:
> 
> > Trivially, adding support for checking for Messages/ inside the specified
> > Maildir after cur/ is found not to exist would be enough to make this work.
> 
> my repo at git://home.325i.org/git-osxmail.git should have that portion.
> 
> unsure as to whether to make it an option, a fallback, a config value, or
> whatever...

A fallback would be sufficient.

Several comments (your patch not inlined, since you did not inline it 
either):

- there needs to be a space between the ) and the { in the first if line.

- you probably forgot to remove the original "if (populate...)...".  That 
  means that populate would be called _twice_, even if successful.

- git is written in C.  Therefore, "//" as a way to comment out is wrong.

- if you still return -1 when the dir could not be opened, I wonder what 
  the rationale is to comment the error out.

Ciao,
Dscho

P.S.: You might want to send patches as these right away, without asking 
if anybody cares (you'll see that very soon), but rather in accord with 
Documentation/SubmittingPatches.

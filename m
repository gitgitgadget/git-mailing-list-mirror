From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/8] Add a lockfile function to append to a file
Date: Sun, 20 Apr 2008 15:43:23 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804201528350.19665@iabervon.org>
References: <alpine.LNX.1.00.0804171950140.19665@iabervon.org> <7vtzhxce9g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 21:44:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnfSN-0005xA-4H
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 21:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704AbYDTTnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 15:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755773AbYDTTnZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 15:43:25 -0400
Received: from iabervon.org ([66.92.72.58]:36173 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659AbYDTTnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 15:43:25 -0400
Received: (qmail 9656 invoked by uid 1000); 20 Apr 2008 19:43:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Apr 2008 19:43:23 -0000
In-Reply-To: <7vtzhxce9g.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79981>

On Sat, 19 Apr 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This takes care of copying the original contents into the replacement
> > file after the lock is held, so that concurrent additions can't miss
> > each other's changes.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > How about this? Also doesn't leak a fd and catches trying to append to a 
> > file you can't read. Should I worry about mmap failing after the open?
> 
> We have copy.c to copy small existing files, while detecting failure to
> copy properly.  How about doing something like this instead?

Yeah, that's obviously the right thing to use.

	-Daniel
*This .sig left intentionally blank*

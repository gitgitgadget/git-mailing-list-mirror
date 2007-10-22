From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use only the PATH for exec'ing git commands
Date: Mon, 22 Oct 2007 22:57:37 +0200
Message-ID: <20071022205737.GC23714@steel.home>
References: <1193083141.v2.fusewebmail-240137@f>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 22:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik4LZ-0005mC-2i
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 22:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbXJVU5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbXJVU5r
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 16:57:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:21492 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbXJVU5q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 16:57:46 -0400
Received: from tigra.home (Fab70.f.strato-dslnet.de [195.4.171.112])
	by post.webmailer.de (fruni mo17) (RZmta 13.6)
	with ESMTP id w0395aj9MHbW4W ; Mon, 22 Oct 2007 22:57:42 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 426AA277AE;
	Mon, 22 Oct 2007 22:57:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 9004156D22; Mon, 22 Oct 2007 22:57:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1193083141.v2.fusewebmail-240137@f>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKf+sU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62046>

Scott R Parish, Mon, Oct 22, 2007 21:59:01 +0200:
> > > +        if (old_path)
> > > +                strbuf_addstr(&amp;new_path, old_path);
> > > +        else
> > > +                strbuf_addstr(&amp;new_path, "/usr/local/bin:/usr/bin:/bin");
> >
> > the default PATH is platform-dependent. Git is multi-platform.
> > You should consider putting the path list somewhere in Makefile,
> > config.mak or configure.
> >
> 
> The original code was already doing both of these things (see git.c's
> prepend_to_path())

Well, would be nice if your code was better in this respect.

Anyway, I suspect the mingw people will trash the code anyway sometime
(or not, which is just as well - it is a rare case).

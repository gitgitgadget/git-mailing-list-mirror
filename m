From: Jeff King <peff@peff.net>
Subject: Re: [bug] git-clone over ssh fails when repository has local
	commits
Date: Sun, 6 Apr 2008 14:17:49 -0400
Message-ID: <20080406181749.GA2218@coredump.intra.peff.net>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com> <20080406161120.GB24358@coredump.intra.peff.net> <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com> <20080406165655.GA26060@coredump.intra.peff.net> <1caff7430804061011ye82e74v289dd3536b253bcb@mail.gmail.com> <20080406175136.GB32399@coredump.intra.peff.net> <1caff7430804061106m49a60bc0wbbd9001394e83589@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: seventh guardian <seventhguardian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 20:18:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZS1-0005t9-56
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbYDFSRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 14:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYDFSRw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:17:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3821 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbYDFSRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:17:52 -0400
Received: (qmail 2792 invoked by uid 111); 6 Apr 2008 18:17:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Apr 2008 14:17:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Apr 2008 14:17:49 -0400
Content-Disposition: inline
In-Reply-To: <1caff7430804061106m49a60bc0wbbd9001394e83589@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78906>

On Sun, Apr 06, 2008 at 07:06:40PM +0100, seventh guardian wrote:

> This object is the correct HEAD, but it is a local commit (I rebase
> all local changes so that they stay "on top" of the original code).

That shouldn't matter to git; it doesn't care at all about where commits
were created.

> Sure, I just thought it would confuse more than it would help. I was
> obviously wrong, as I'm actually using git:// instead of http://....
> sorry... ;)

Heh. OK, scratch what I said before then. :)

>  I'm experiencing this with both these repo's, as I have committed
> some local changes to them:
> 
> git://anongit.freedesktop.org/git/nouveau/mesa
> git://anongit.freedesktop.org/git/nouveau/xf86-video-nouveau/

Can you give an exact set of steps to reproduce? There doesn't seem to
be anything wrong with those repos, and I was able to do:

  m1$ git clone git://anongit.freedesktop.org/git/nouveau/xf86-video-nouveau/
  m1$ cd xf86-video-nouveau && echo foo >>COPYING && git commit -a -m foo
  m2$ git clone ssh://m1/path/to/xf86-video-nouveau

So now my guess is when you make local changes, something funny is going
on. Can you describe that process in more detail?

-Peff

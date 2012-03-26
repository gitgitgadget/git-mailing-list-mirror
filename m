From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Mon, 26 Mar 2012 14:19:54 -0400
Message-ID: <1332785666-sup-5513@pinkfloyd.chass.utoronto.ca>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca> <20120326011148.GA4428@burratino> <1332768900-sup-4533@pinkfloyd.chass.utoronto.ca> <20120326181238.GH7942@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, gitster <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:20:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEWa-000887-LP
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933332Ab2CZST5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:19:57 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:49440 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933290Ab2CZST4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 14:19:56 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:33477 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCEWI-0006UC-Mb; Mon, 26 Mar 2012 14:19:54 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCEWI-0003iw-LS; Mon, 26 Mar 2012 14:19:54 -0400
In-reply-to: <20120326181238.GH7942@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193948>

Excerpts from Jeff King's message of Mon Mar 26 14:12:38 -0400 2012:

> What is /opt/csw/bin/sh? Is it a symlink to bash (which would mean
> bash running in POSIX mode)? Or is it a lightweight shell like ash?
> Or something else?

This is some version of the traditional solaris /bin/sh packaged as
part of schilyutils (Joerg Schilling's utilities).  I'm really not
sure why he packages it or what the differences from /bin/sh
are...Asking him is on my todo list though.  I only just learned it
existed when I hit this glitch.

> The point of SHELL_PATH is to provide a POSIX shell.  Generally,
> bash behavior is a superset of POSIX, so you will not run into any
> incompatibilities by running things with bash. But do be aware that
> you are slightly incompatible with the rest of the world (so things
> that work for you, for example, might not work for people using git
> with the stock "shell is /bin/sh" configuration).

This was a conscious choice I made early in the packaging of git for
OpenCSW.  The idea was that we had a shell that was also under our
packaging control and 'sane' at the same time.  I realize it's a
superset of the POSIX functionality.  It's something I should maybe
change, but I'd need to stage it slowly so as to avoid breakages.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

From: Jeff King <peff@peff.net>
Subject: Re: diffstat and signoff in git-format-patch
Date: Sat, 12 Sep 2009 14:19:19 -0400
Message-ID: <20090912181919.GA20561@coredump.intra.peff.net>
References: <200909121713.13296.robert.wohlrab@gmx.de>
 <200909121717.57896.robert.wohlrab@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robert Wohlrab <robert.wohlrab@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXCU-0006lE-HD
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbZILSTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbZILSTU
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:19:20 -0400
Received: from peff.net ([208.65.91.99]:57118 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbZILSTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:19:20 -0400
Received: (qmail 13399 invoked by uid 107); 12 Sep 2009 18:19:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Sep 2009 14:19:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Sep 2009 14:19:19 -0400
Content-Disposition: inline
In-Reply-To: <200909121717.57896.robert.wohlrab@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128275>

On Sat, Sep 12, 2009 at 05:17:57PM +0200, Robert Wohlrab wrote:

> > Hi,
> > I am currently trying to use git-format-patch in a script to generate files
> > which must be in a special format. This means that I have to override also
> > changes by users. This is as far as I can see suffix, signoff and some
> >  more. Most of the stuff works, but I cannot get away the signoff message
> >  as their is nothing like --no-signoff and the -p option which should be
> >  disable generation of diffstat doesn't do anything. How can I disable them
> >  anyway?
> > git version 1.6.3.3
> And can i disable this "--\n1.6.3.3" at the end of the patch?

format-patch isn't very configurable in its output. Maybe you want to
just do:

  git log -1 --pretty=email -p

instead (or if you want to tweak the format even further, try
--pretty=format)?

-Peff

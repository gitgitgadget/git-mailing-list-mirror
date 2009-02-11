From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-sh-setup: Use "cd" option, not /bin/pwd, for
	symlinked work tree
Date: Wed, 11 Feb 2009 13:16:53 -0500
Message-ID: <20090211181653.GD19749@coredump.intra.peff.net>
References: <7viqq1hghw.fsf@gitster.siamese.dyndns.org> <1233977068-24861-1-git-send-email-marcel@oak.homeunix.org> <alpine.DEB.1.00.0902071324230.10279@pacific.mpi-cbg.de> <498F2049.9030608@oak.homeunix.org> <alpine.DEB.1.00.0902082154450.10279@pacific.mpi-cbg.de> <4992E459.1060401@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	ae@op5.se, j.sixt@viscovery.net, git-dev@marzelpan.de,
	win@wincent.com, benji@silverinsanity.com
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJfC-0004jt-QR
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbZBKSQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756768AbZBKSQ4
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:16:56 -0500
Received: from peff.net ([208.65.91.99]:44063 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756760AbZBKSQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:16:55 -0500
Received: (qmail 32217 invoked by uid 107); 11 Feb 2009 18:17:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 13:17:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 13:16:53 -0500
Content-Disposition: inline
In-Reply-To: <4992E459.1060401@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109473>

On Wed, Feb 11, 2009 at 06:44:41AM -0800, Marcel M. Cary wrote:

> > Actually, it was not clear for me how much you researched the portability 
> > of "cd -P".
> 
> I have not.  I've seen only that it's POSIX, is on BSD and Linux, and
> was suggested by Junio.

Even Solaris /usr/xpg4/bin/sh has it. Their /bin/sh does not, but that
is not a surprise: that shell is useless and already unsupported by git.

I don't know about other obscure platforms (wasn't there some guy
running git on antique SCO machines or something?).

I think it is nice to shoot for "more portable" in general, and I don't
particularly care one way or the other about this feature. But I think
we are somewhat hampered by having no clue what the supported set of
platforms is. I'm pretty sure we support at least:

  - various recent Linux distributions
  - FreeBSD 6.x (maybe as far back as 4.x)
  - OS X
  - NetBSD and OpenBSD, but no idea which versions
  - Solaris >= 2.8
  - AIX 5.3

and I suspect most of those have somebody building them regularly enough
that breakages are caught. I have no idea what people are using beyond
that, and how quickly they might catch a portability breakage.

-Peff

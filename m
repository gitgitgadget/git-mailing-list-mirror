From: Jeff King <peff@peff.net>
Subject: Re: segfault in git-remote-http
Date: Tue, 9 Apr 2013 13:47:36 -0400
Message-ID: <20130409174735.GA23494@sigill.intra.peff.net>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com>
 <20130409084718.587e99aa7a935296867a84a1@lavabit.com>
 <20130409171623.GE21972@sigill.intra.peff.net>
 <20130409104134.a9a42b74ec33b3147cd45c81@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 19:47:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPce1-0002Ve-J5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759200Ab3DIRrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:47:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36481 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab3DIRrl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:47:41 -0400
Received: (qmail 24571 invoked by uid 107); 9 Apr 2013 17:49:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 13:49:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 13:47:36 -0400
Content-Disposition: inline
In-Reply-To: <20130409104134.a9a42b74ec33b3147cd45c81@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220599>

On Tue, Apr 09, 2013 at 10:41:34AM -0700, rh wrote:

> > git-remote-http does not touch the openssl code itself at all. We only
> > talk to curl, which handles all of the ssl (and may even be built on
> > gnutls). So if that is the problem, then I think it may be a libcurl
> > bug, not a git one.
> 
> Thanks, I see git-remote-{http,https,ftp,ftps} are the same size.
> Minor nitpick but shouldn't the error thrown say git-remote-https?

They are all hardlinks to the same program (or copies if your platform
does not support hardlinks or symlinks). But I'm not sure which error
you are talking about. We can figure out inside the program which
program was invoked by checking argv, but I do not see us printing
remote-http anywhere.

-Peff

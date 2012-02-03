From: Jeff King <peff@peff.net>
Subject: Re: Push from an SSH Terminal
Date: Fri, 3 Feb 2012 16:35:08 -0500
Message-ID: <20120203213508.GC1890@sigill.intra.peff.net>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Feanil Patel <feanil@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 22:35:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtQms-0004RJ-I2
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 22:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab2BCVfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 16:35:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56019
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab2BCVfL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 16:35:11 -0500
Received: (qmail 2278 invoked by uid 107); 3 Feb 2012 21:42:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 16:42:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 16:35:08 -0500
Content-Disposition: inline
In-Reply-To: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189806>

On Fri, Feb 03, 2012 at 10:50:02AM -0500, Feanil Patel wrote:

> I tried looking for an answer to my problem online without much luck,
> perhaps you can help me.  I'm SSHed from my laptop(Comp A) over to a
> computer(Comp B) that has my git repo on it. I made some changes and
> comitted them. Now I want to push them to my other server(Comp C). The
> repository is password protected so if I'm physically at Comp B, I get
> a gui prompt for my username and password. However Comp A does not
> have X Forwarding setup to Comp B so I can't get the gui interface for
> the username and password when I try to do the push.  Is there an
> alternative way to provide my credentials when doing a git push that
> does not require a gui?

Git should prompt you on the terminal (i.e., the ssh session) if it
needs credentials. If it is not, and the terminal is accessible, it
might be a bug. There were some fixes around this area that went into
1.7.9; you might try using that version.

Also, 1.7.9 ships with support for credential helper scripts, which can
help you avoid putting in your password less frequently (see "git help
credentials" in git 1.7.9).

-Peff

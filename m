From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] improve doc heading for git-bisect
Date: Sun, 8 Jun 2008 00:35:43 -0400
Message-ID: <20080608043543.GB11194@sigill.intra.peff.net>
References: <20080607070637.79B17C7C0E@rwavmlap> <m37id1y4zj.fsf@localhost.localdomain> <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 06:36:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Ce0-0002Za-OR
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 06:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbYFHEfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 00:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbYFHEfq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 00:35:46 -0400
Received: from peff.net ([208.65.91.99]:2069 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbYFHEfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 00:35:45 -0400
Received: (qmail 14403 invoked by uid 111); 8 Jun 2008 04:35:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 08 Jun 2008 00:35:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jun 2008 00:35:43 -0400
Content-Disposition: inline
In-Reply-To: <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84253>

On Sat, Jun 07, 2008 at 09:06:19AM -0700, Robert Anderson wrote:

> > FYI this line is not necessary, and should be removed from
> > git-format-patch output when pasting it to your MUA.
> 
> Err, then shouldn't it be removed from format-patch, rather than
> deleted manually every time format-patch is used?

As others have pointed out, the usual way for using format-patch is to
create an mbox that you then pull into your MUA (e.g., I do "git
format-patch --stdout origin >mbox; mutt -f mbox").

However, sometimes it is desirable to cut and paste, either because it
is inconvenient to bring the message into your MUA this way, or if you
are just putting a commit into an email you have already started
writing.

I was going to suggest a "--paste" option for format-patch which would
produce a nicer output for cutting and pasting, but it is trivial to do
with an alias:

  git config --global \
    alias.pastepatch \
    'format-patch --pretty=format:%s%n%n%b'

(actually, this loses the author information versus using the
--pretty=email format, but if you are just sending your own work, it is
fine).

It is essentially the same as "git log --stat -p" except that the commit
message is indented properly, and the revision arguments are interpreted
as format-patch does.

-Peff

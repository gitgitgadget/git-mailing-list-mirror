From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 15:59:09 -0400
Message-ID: <20090405195908.GB4716@coredump.intra.peff.net>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org> <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com> <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org> <fabb9a1e0904051206l11a629cald95a794815c2d76f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:11:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYWV-0003Yg-IJ
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838AbZDET72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755652AbZDET72
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:59:28 -0400
Received: from peff.net ([208.65.91.99]:37092 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbZDET71 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:59:27 -0400
Received: (qmail 17469 invoked by uid 107); 5 Apr 2009 19:59:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 05 Apr 2009 15:59:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2009 15:59:09 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0904051206l11a629cald95a794815c2d76f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115692>

On Sun, Apr 05, 2009 at 09:06:56PM +0200, Sverre Rabbelier wrote:

> > It is an assert, and I think Peff's die("BUG: ...") would be a good idea.
> 
> As long as the <something that makes sense to the user> does indeed
> make sense, right :).

I think:

  die("BUG: assertion failed in binary search")

would be sufficient to tell the user what is going on, and let them
inform the list what happened.

However, if this "oops" has been there for 2 years and nobody has seen
it, it's entirely possible that somebody actually got the binary search
code right in the first place. ;)

-Peff

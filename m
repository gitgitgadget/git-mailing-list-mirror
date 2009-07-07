From: Jeff King <peff@peff.net>
Subject: Re: =?utf-8?Q?Schr=C3=B6dinger's?= diff
Date: Tue, 7 Jul 2009 15:54:06 -0400
Message-ID: <20090707195406.GA32131@coredump.intra.peff.net>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
 <20090707193605.GA30945@coredump.intra.peff.net>
 <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOGkO-0005JA-C0
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 21:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbZGGTyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 15:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756332AbZGGTyI
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 15:54:08 -0400
Received: from peff.net ([208.65.91.99]:54470 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185AbZGGTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 15:54:07 -0400
Received: (qmail 5923 invoked by uid 107); 7 Jul 2009 19:56:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Jul 2009 15:56:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2009 15:54:06 -0400
Content-Disposition: inline
In-Reply-To: <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122863>

On Tue, Jul 07, 2009 at 12:48:45PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > .... But even that might have holes,
> > I'm afraid -- we don't always look at all of the config in every
> > command, though perhaps we do for such core functionality.
> 
> I personally do not think it is worth it.  If you change the crlf,
> clean/smudge, or anything of that sort, just doing a "rm .git/index"
> followed by "git reset --hard" would restore sanity to your work tree, no?

Yes, that works fine, but:

  1. It blows away anything unrelated you might have staged.

  2. You have to know to do it (and you get very confusing results if
     you don't), which makes it very unfriendly for newbies.

  3. You have to know to do it, and it isn't documented. :)

(3) at least is not too hard to address. And perhaps (2) is not a big
enough issue to care about. This is not a problem we have seen on the
list a lot. I suspect it is because most CRLF users are on Windows, and
therefore have it setup before the tree is checked out, and there are
simply not all that many clean/smudge users.

-Peff

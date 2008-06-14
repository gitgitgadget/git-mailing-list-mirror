From: Jeff King <peff@peff.net>
Subject: Re: git bugs
Date: Sat, 14 Jun 2008 02:25:13 -0400
Message-ID: <20080614062513.GA24508@sigill.intra.peff.net>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com> <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org> <20080613101024.GA8221@sigill.intra.peff.net> <7vbq25j5ke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ben Lynn <benlynn@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 08:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7PDH-0002nt-SL
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 08:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbYFNGZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 02:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbYFNGZR
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 02:25:17 -0400
Received: from peff.net ([208.65.91.99]:3875 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbYFNGZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 02:25:16 -0400
Received: (qmail 25652 invoked by uid 111); 14 Jun 2008 06:25:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 02:25:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 02:25:13 -0400
Content-Disposition: inline
In-Reply-To: <7vbq25j5ke.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84963>

On Fri, Jun 13, 2008 at 04:09:05PM -0700, Junio C Hamano wrote:

> When telling apply to affect index and work tree at the same time (that is
> what --index means), the caller must make sure that the diff-files won't
> report stale stat information.

Ah, I had assumed that git-apply would notice the stale stat information
and fall back to checking the content, which should be accurate.

> I think "reset --hard" without ">empty" is enough as the head commit
> records an empty blob there.

Yes, it is redundant. With your patch I was not able to reproduce the
problem over a few thousand trials.

-Peff

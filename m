From: Jeff King <peff@peff.net>
Subject: Re: "malloc failed"
Date: Thu, 29 Jan 2009 23:49:19 -0500
Message-ID: <20090130044919.GA18655@coredump.intra.peff.net>
References: <878wow7pth.fsf@mcbain.luannocracy.com> <20090128050225.GA18546@coredump.intra.peff.net> <c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141> <87skn3rn5n.fsf@mcbain.luannocracy.com> <20090129052041.GB31507@coredump.intra.peff.net> <20090129055633.GA32609@coredump.intra.peff.net> <87pri6qmvm.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 05:50:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSlL5-0005Pi-Qh
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 05:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbZA3EtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 23:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbZA3EtW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 23:49:22 -0500
Received: from peff.net ([208.65.91.99]:50071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbZA3EtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 23:49:21 -0500
Received: (qmail 26969 invoked by uid 107); 30 Jan 2009 04:49:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 23:49:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 23:49:19 -0500
Content-Disposition: inline
In-Reply-To: <87pri6qmvm.fsf@mcbain.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107769>

On Thu, Jan 29, 2009 at 08:10:05AM -0500, David Abrahams wrote:

> Good work.  I don't know if this matters to you, but I think on a 32-bit
> platform you'll find that size_t, which is supposed to be able to hold
> the size of the largest representable *memory block*, is only 4 bytes
> large:

That should be fine; 32-bit systems can't deal with such large files
anyway, since we want to address the whole thing. Getting around that
would, as Andreas mentioned, involve dealing with large files in chunks,
something that would make the code a lot more complex.

So I think the answer is "tough, if you want files >4G get a 64-bit
machine". Which is unreasonable for a file system to say, but I think is
fine for git.

-Peff

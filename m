From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9302: Protect against OS X normalization
Date: Tue, 9 Feb 2010 01:58:45 -0500
Message-ID: <20100209065845.GA6503@sigill.intra.peff.net>
References: <7vfx5bt6nn.fsf@alter.siamese.dyndns.org>
 <1265688445-46137-1-git-send-email-brian@gernhardtsoftware.com>
 <20100209060845.GD14736@coredump.intra.peff.net>
 <7vocjyq4qq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 07:59:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nek3n-0002I5-PS
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 07:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab0BIG6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 01:58:48 -0500
Received: from peff.net ([208.65.91.99]:55185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489Ab0BIG6r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 01:58:47 -0500
Received: (qmail 16146 invoked by uid 107); 9 Feb 2010 06:58:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Feb 2010 01:58:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 01:58:45 -0500
Content-Disposition: inline
In-Reply-To: <7vocjyq4qq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139375>

On Mon, Feb 08, 2010 at 10:53:49PM -0800, Junio C Hamano wrote:

> I think there is no reliable reproduction recipe for this, as we don't
> control what garbage is in the tail of malloc'ed memory; valgrind would
> have found it, though.
>
> Let's revert the test part of the patch.

IMHO, valgrind finding it is reason enough to keep it. We do run the
test suite against valgrind from time to time, and clearly this code
path was not being exercised prior to this (or my previous valgrind runs
would have caught it).

I think Brian's patch is the best thing to do.

-Peff

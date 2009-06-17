From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] avoid exponential regex match for java and objc
 function names
Date: Wed, 17 Jun 2009 11:56:04 -0400
Message-ID: <20090617155603.GA14545@sigill.intra.peff.net>
References: <20090617102332.GA32353@coredump.intra.peff.net>
 <1245248766-14867-1-git-send-email-bonzini@gnu.org>
 <9b18b3110906170846o5b3c3000r72506bf62765a044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	gitster@pobox.com
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGxUk-0004iJ-94
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 17:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbZFQP4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 11:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbZFQP4E
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 11:56:04 -0400
Received: from peff.net ([208.65.91.99]:35904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbZFQP4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 11:56:03 -0400
Received: (qmail 11519 invoked by uid 107); 17 Jun 2009 15:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 17 Jun 2009 11:57:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2009 11:56:04 -0400
Content-Disposition: inline
In-Reply-To: <9b18b3110906170846o5b3c3000r72506bf62765a044@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121754>

On Wed, Jun 17, 2009 at 05:46:54PM +0200, demerphq wrote:

> Just  a note, but If the  Java regex library you are using supports
> the PCRE compatible (?>...) atomic matching construct (or their
> equivalent *+ and ++) then these patterns can be significantly
> improved beyond their current state.

To clarify, this isn't a java regex library, but rather regexps used to
match function names inside java language files when generating diffs.
The regex library itself is the POSIX regex routines provided by libc.

PCRE syntax is nice, but we don't want to require it for every build,
and it's important to have the same syntax everywhere (so that, e.g.,
your config from one build works on a different build).

-Peff

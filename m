From: Jeff King <peff@peff.net>
Subject: Re: git silently ignores aliases of existing commands
Date: Sat, 18 Jul 2009 06:58:55 -0400
Message-ID: <20090718105855.GA29567@coredump.intra.peff.net>
References: <4A611CE1.3080709@pobox.com>
 <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>
 <4A6176E6.4060708@pobox.com>
 <9b18b3110907180230p7fb432cdq56bfee794afc669e@mail.gmail.com>
 <20090718104631.GA27307@coredump.intra.peff.net>
 <9b18b3110907180355s5bf08f8did180caa0c55b3389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael G Schwern <schwern@pobox.com>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 12:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS7dn-0001Lo-5g
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 12:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165AbZGRK7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 06:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758182AbZGRK7G
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 06:59:06 -0400
Received: from peff.net ([208.65.91.99]:51355 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758165AbZGRK7E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 06:59:04 -0400
Received: (qmail 32035 invoked by uid 107); 18 Jul 2009 11:01:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 18 Jul 2009 07:01:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Jul 2009 06:58:55 -0400
Content-Disposition: inline
In-Reply-To: <9b18b3110907180355s5bf08f8did180caa0c55b3389@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123516>

On Sat, Jul 18, 2009 at 12:55:26PM +0200, demerphq wrote:

> > The silentness makes it harder to diagnose problems, but even with a
> > warning, we can break things by creating new commands. If you have an
> > alias "foo" and we ship "git-foo" in a newer version of git, your alias
> > will just stop working.
> 
> That was my point. At least if there were warnings about this the risk
> would be mitigated.

I don't see how it's mitigated. You don't get any warning until _after_
things are broken. So yes, it may help you diagnose the breakage, but
presumably the fact that the command is doing something completely
different would also alert you to the breakage.

The real problem comes from scripted use, where you don't necessarily
have a user reading warnings on stderr, or notice that some totally
bogus code is being run (especially if said code happens not to produce
a non-zero exit code).

But perhaps that's what you meant, and I'm just nitpicking your
language.

-Peff

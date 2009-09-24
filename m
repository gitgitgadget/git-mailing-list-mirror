From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Thu, 24 Sep 2009 01:55:18 -0400
Message-ID: <20090924055518.GB24486@coredump.intra.peff.net>
References: <871vm0k6jm.fsf@meyering.net>
 <81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com>
 <87ocp4imul.fsf@meyering.net>
 <20090921134427.GA20567@sigio.peff.net>
 <n2z47RdNjxVbPeRfgJuY54nJrfzDfn43bzv8HoH6cEuAzQ6fB1MaBg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Meyering <jim@meyering.net>, Alex Riesen <raa.lkml@gmail.com>,
	git list <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 24 07:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqhIY-0005rT-9e
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 07:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbZIXFzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 01:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbZIXFzJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 01:55:09 -0400
Received: from peff.net ([208.65.91.99]:44627 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbZIXFzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 01:55:08 -0400
Received: (qmail 2876 invoked by uid 107); 24 Sep 2009 05:58:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 24 Sep 2009 01:58:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2009 01:55:18 -0400
Content-Disposition: inline
In-Reply-To: <n2z47RdNjxVbPeRfgJuY54nJrfzDfn43bzv8HoH6cEuAzQ6fB1MaBg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129018>

On Mon, Sep 21, 2009 at 10:58:51AM -0500, Brandon Casey wrote:

> >> I had my doubts, but have just confirmed that Solaris 10's
> >> /usr/bin/tr is still doing it the SYSV way:
> >>
> >>     $ echo foo | LC_ALL=C /usr/bin/tr a-z A-Z
> >>     foo
> >>
> >> There, you have to use /usr/xpg4/bin/tr to get the expected behavior:
> >>
> >>     $ echo foo | LC_ALL=C /usr/xpg4/bin/tr a-z A-Z
> >>     FOO
> >>
> >> So you're right.  Thanks!
> 
> By the way, modern git inserts /usr/xpg4/bin into PATH before /usr/bin on
> Solaris.  So /usr/xpg4/bin/tr should always be used on that platform.

Ah, I forgot about that patch. So it may not matter on Solaris. Are
there other platforms which want the brackets? Maybe HP-UX, but I no
longer have access to a box and I've used deep hypnosis to suppress any
memories of ever having used it.

Anyway, I think Jim's patch is the right fix if there are still
platforms that want the brackets.

-Peff

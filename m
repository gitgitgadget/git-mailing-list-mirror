From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Wed, 18 Feb 2009 19:37:27 -0500
Message-ID: <20090219003727.GA25808@coredump.intra.peff.net>
References: <200902151711.45099.trast@student.ethz.ch> <20090215181818.GA2291@coredump.intra.peff.net> <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com> <20090217163413.GB31297@sigill.intra.peff.net> <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com> <20090217202731.GA16586@coredump.intra.peff.net> <20090218064121.GA16611@coredump.intra.peff.net> <alpine.DEB.1.00.0902181113210.6274@intel-tinevez-2-302> <20090218101615.GA23035@coredump.intra.peff.net> <alpine.DEB.1.00.0902181251160.6274@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZwwl-0008H2-4z
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 01:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbZBSAhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 19:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZBSAhb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 19:37:31 -0500
Received: from peff.net ([208.65.91.99]:57755 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbZBSAha (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 19:37:30 -0500
Received: (qmail 18074 invoked by uid 107); 19 Feb 2009 00:37:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 19:37:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 19:37:27 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902181251160.6274@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110596>

On Wed, Feb 18, 2009 at 12:53:37PM +0100, Johannes Schindelin wrote:

> > Really? Are they not easily replaced with
> > 
> > -test cond1 -a cond2 -o cond3
> > +test cond1 && test cond2 || test cond3
> 
> ...which is substantially harder to read.

I don't agree that it is harder to read, but that is beside the point.
What is important is whether or not the construct is portable enough to
meet git's standards.

"-a" and "-o" are XSI extensions to POSIX, which is usually a sign that
there may be problems. However, besides posh (which at this point I
think can be considered a compliance-testing shell and not an actual
shell in use), I haven't heard of problems in practice. Even FreeBSD's
ash derivative supports it (along with parentheses).

So I don't think it needs to be changed (which is what I said in my
original message). But I also think saying "-a and -o are necessary" is
not true; they can be replaced if it turns out to be a problem.

-Peff

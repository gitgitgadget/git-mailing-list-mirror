From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to
 installed bindir
Date: Sat, 28 Nov 2009 22:43:13 -0500
Message-ID: <20091129034313.GA28379@coredump.intra.peff.net>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net>
 <7vtywefn88.fsf@alter.siamese.dyndns.org>
 <20091128194910.GA17605@coredump.intra.peff.net>
 <7vaay6f4ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 04:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEah2-00017N-PE
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 04:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbZK2DnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 22:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZK2DnH
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 22:43:07 -0500
Received: from peff.net ([208.65.91.99]:43843 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbZK2DnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 22:43:07 -0500
Received: (qmail 3801 invoked by uid 107); 29 Nov 2009 03:47:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Nov 2009 22:47:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2009 22:43:13 -0500
Content-Disposition: inline
In-Reply-To: <7vaay6f4ce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133989>

On Sat, Nov 28, 2009 at 06:32:33PM -0800, Junio C Hamano wrote:

> > Would implementing it that way mean that:
> >
> >   make && cd t && make
> >
> > does not work (or worse, might silently use stale information in
> > test-bin)?
> 
> Why can't t/Makefile have a dependency on its 'default' target that goes
> up and prepares test-bin/, i.e. "cd .. && make test-bin-stuff"?

Yeah, that would work (I really should have phrased my other response
less as a critique and more as "please don't break this workflow"). But
I don't think the default target would be enough. I would also expect

  make && cd t && make tXXXX-YYYY.sh

to work correctly (and to be pedantic, I am actually more interested in
the equivalent situation that one has one window looking at code and
compiling, and another window running a test script, but they are
functionally equivalent here).

I also like to be able to simply run ./tXXXX-YYYY.sh. I can accept
losing that if there is something to be gained, but if we can keep it, I
suspect I am not the only one who uses it.

-Peff

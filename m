From: Jeff King <peff@peff.net>
Subject: Re: "git add -i" with path gives "Argument list too long"
Date: Sun, 21 Mar 2010 21:41:00 -0400
Message-ID: <20100322014100.GA7717@coredump.intra.peff.net>
References: <45CD9D1B-6774-46F2-A444-654B1DEF7F69@wincent.com>
 <20100322003915.GA3212@coredump.intra.peff.net>
 <7vwrx56tet.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 02:41:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtWdk-0004wV-O6
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 02:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab0CVBlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 21:41:05 -0400
Received: from peff.net ([208.65.91.99]:49538 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab0CVBlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 21:41:03 -0400
Received: (qmail 30657 invoked by uid 107); 22 Mar 2010 01:41:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 21 Mar 2010 21:41:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Mar 2010 21:41:00 -0400
Content-Disposition: inline
In-Reply-To: <7vwrx56tet.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142881>

On Sun, Mar 21, 2010 at 06:23:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > their behavior. Junio could probably say more, or you will have to read
> > the code.
> 
> Or read what I already said here a few times ;-) I generally do not want
> to repeat myself.

Well, yeah. :) What I meant was:

> There are two semantics of pathspecs:
> 
>   (1) exact match, or leading path.  e.g.
> 
>   	git ls-files Makefile Documentation/
> 
>   (2) exact match, leading path, or fnmatch(3).
> 
> 	git ls-files Makefile Documentation/ '*.txt'

Is type (2) exactly fnmatch? Or are there subtle corner cases that
should be tested? For the implementation it shouldn't matter, as
hopefully the same code paths will be used, and "just like ls-files"
should be specification enough. But for testing, it might be nice to
enumerate some of the more subtle cases.

-Peff

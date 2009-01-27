From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 0/3] Introduce config variable "diff.primer"
Date: Mon, 26 Jan 2009 23:54:52 -0500
Message-ID: <20090127045452.GB735@coredump.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <7vr62rcee5.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251239000.12651@kiwi.cs.ucla.edu> <20090125220756.GA18855@coredump.intra.peff.net> <alpine.GSO.2.00.0901261734360.16158@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 27 05:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRfzn-0002Hr-Us
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 05:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbZA0Eyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 23:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZA0Eyz
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 23:54:55 -0500
Received: from peff.net ([208.65.91.99]:44017 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbZA0Eyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 23:54:54 -0500
Received: (qmail 8751 invoked by uid 107); 27 Jan 2009 04:55:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 23:55:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 23:54:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0901261734360.16158@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107309>

On Mon, Jan 26, 2009 at 05:47:54PM -0800, Keith Cascio wrote:

> >   2. It is unset. The rationale is that you are using the "c" diff
> >      driver, and it has left the value unset. The default then means "if
> >      you have no diff driver setup".
> 
> I'm in favor of option (2), because [diff] a.k.a [diff ""] serving as

Nit: [diff] and [diff ""] are different. The "dotted" notation which we
use in the code and which git-config respects for a variable "foo" in
each section would look like "diff.foo" and "diff..foo", respectively.

> the fallback for [diff *] feels like a special case.  If a full system
> of precedence 

Yes, I think having a "this is the default driver whose driver-specific
options are used if you don't have a different driver" is semantically
simple and clear.

> and fallbacks is desired for .git/config, we should adopt explicit
> grammar that lets me define an arbitrary precedence tree over all
> sections.  Once a powerful concept is born, somewhere down the road,
> some user will desire its universalization.

OK, now you're scaring me. :) I'm not sure I want to see the grammar you
would use to define an arbitrary precedence tree, or whether such
complexity has any real-world use in git config. I think you would have
to show a concrete example to prove the utility of something like that.

-Peff

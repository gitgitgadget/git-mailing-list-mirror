From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git-mergetool: show original branch names when possible
Date: Tue, 21 Aug 2007 16:55:03 -0400
Message-ID: <20070821205503.GA16777@coredump.intra.peff.net>
References: <20070820075318.GA12478@coredump.intra.peff.net> <7vabsmtxsg.fsf@gitster.siamese.dyndns.org> <20070820085246.GA23764@coredump.intra.peff.net> <20070820181725.GB8542@efreet.light.src> <20070821061014.GB7323@coredump.intra.peff.net> <20070821145943.GI8542@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Aug 21 22:55:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INaks-0000Nu-CX
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 22:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbXHUUzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 16:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbXHUUzJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 16:55:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2884 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbXHUUzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 16:55:07 -0400
Received: (qmail 9490 invoked by uid 111); 21 Aug 2007 20:55:06 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Aug 2007 16:55:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2007 16:55:03 -0400
Content-Disposition: inline
In-Reply-To: <20070821145943.GI8542@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56328>

On Tue, Aug 21, 2007 at 04:59:43PM +0200, Jan Hudec wrote:

> >   1. It does not handle pulls which have no tracking branch (the only
> >      ref we have is FETCH_HEAD, which is not a useful name :) ).
> 
> If there's no useful name, than it's probably hard to do anything at all
> about it. Though FETCH_HEAD is not all that useless -- it at least says it is
> that that you pull.

But there _is_ a useful name, it's just not a ref (it's the information
from FETCH_HEAD "branch 'foo' of git://..."). In this case,
git-mergetool could pull it out of FETCH_HEAD, as well, but I feel like
we're starting to make a lot of fragile cross-tool assumptions.

> I meant it as a fallback, for cases where it for some reason can't be
> recorded or is not recorded. Recording it is obviously better.

Right, in which case I think we should just be more complete about
recording it.

-Peff

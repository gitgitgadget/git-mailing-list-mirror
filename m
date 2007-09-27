From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 27 Sep 2007 09:30:56 -0400
Message-ID: <20070927133056.GA29674@coredump.intra.peff.net>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <854phgfxn7.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 15:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IatSN-0007Hk-4U
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 15:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbXI0NbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 09:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbXI0Na7
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 09:30:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3223 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbXI0Na7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 09:30:59 -0400
Received: (qmail 9477 invoked by uid 111); 27 Sep 2007 13:30:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Sep 2007 09:30:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2007 09:30:56 -0400
Content-Disposition: inline
In-Reply-To: <854phgfxn7.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59297>

On Thu, Sep 27, 2007 at 08:08:44AM +0200, David Kastrup wrote:

> In itself, it does not look like there is all too much room for
> optimization.  One can remove the temporary pointer "optimization" and
> see whether this makes strength reduction possible for the compiler.
> Making this an endless loop wrapped around a loop on bucket might also
> help the compiler in that effect.

I am considering reworking the data structure to be a hash table whose
buckets never overflow. However, Junio indicated that he tried something
similar at one point and was not successful. So we will see. I haven't
had time to play with it yet, but I will post numbers when I do.

-Peff

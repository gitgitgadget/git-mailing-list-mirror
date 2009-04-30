From: Jeff King <peff@peff.net>
Subject: Re: question about a merge result
Date: Thu, 30 Apr 2009 10:26:35 -0400
Message-ID: <20090430142635.GB23550@coredump.intra.peff.net>
References: <38b2ab8a0904300521m9e31867j7848135acfae0faa@mail.gmail.com> <49F99AE3.5090406@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Michael Gaber <Michael.Gaber@gmx.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 16:28:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzXFe-00051E-N5
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 16:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763480AbZD3O0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 10:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762497AbZD3O0m
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 10:26:42 -0400
Received: from peff.net ([208.65.91.99]:60783 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbZD3O0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 10:26:42 -0400
Received: (qmail 19312 invoked by uid 107); 30 Apr 2009 14:26:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 30 Apr 2009 10:26:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2009 10:26:35 -0400
Content-Disposition: inline
In-Reply-To: <49F99AE3.5090406@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118018>

On Thu, Apr 30, 2009 at 02:34:43PM +0200, Michael Gaber wrote:

> > So merging 'b1' into master removed the B file even if in branch 'b1'
> > I restored it.
> > 
> > Could anybody explain me why this is the correct behaviour and why not
> > file 'B' is not restored as it was done in branch 'b1' ?
> 
> well, I'd say the thing is, that in b1 there is no change at all to the
> tree anymore, so when applied to master (without B) there is no b restored

That is exactly it. Git's 3-way merge doesn't look at the intervening
history at all. It looks _only_ at the two endpoints and their
merge-base (well, that is a bit of a simplification, as there may be
multiple merge-bases, but it is what is happening here).

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: remote branches, and branch names in general
Date: Mon, 2 Mar 2009 23:16:31 -0500
Message-ID: <20090303041631.GB18136@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com> <m3vdqrtp84.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 05:18:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeM5H-0005FN-RI
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 05:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757128AbZCCEQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 23:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZCCEQk
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 23:16:40 -0500
Received: from peff.net ([208.65.91.99]:47844 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbZCCEQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 23:16:39 -0500
Received: (qmail 12160 invoked by uid 107); 3 Mar 2009 04:16:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 02 Mar 2009 23:16:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Mar 2009 23:16:31 -0500
Content-Disposition: inline
In-Reply-To: <m3vdqrtp84.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111992>

On Mon, Mar 02, 2009 at 04:38:42PM -0800, Jakub Narebski wrote:

> > I see the remote branches with names of the form remotes/pub/name where
> > pub is the nickname of the place I pull from.  To specify such branches,
> > must I always spell it out with the leading "remotes/", or can that be
> > shorted or implied somehow?  
> 
> You usually can omit "remotes/" prefix, and just use
> "<remote>/<branch>" (or even "<remote>" for "<remote>/HEAD"). You need
> it only if there is need for disambiguation.

Yes. I don't know if they are documented anywhere, but the complete
lookup order is:

  $ git grep -h -A8 ref_rev_parse_rules refs.c
  const char *ref_rev_parse_rules[] = {
          "%.*s",
          "refs/%.*s",
          "refs/tags/%.*s",
          "refs/heads/%.*s",
          "refs/remotes/%.*s",
          "refs/remotes/%.*s/HEAD",
          NULL
  };

-Peff

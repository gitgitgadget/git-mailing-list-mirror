From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git-mergetool: show original branch names when possible
Date: Tue, 21 Aug 2007 02:10:14 -0400
Message-ID: <20070821061014.GB7323@coredump.intra.peff.net>
References: <20070820075318.GA12478@coredump.intra.peff.net> <7vabsmtxsg.fsf@gitster.siamese.dyndns.org> <20070820085246.GA23764@coredump.intra.peff.net> <20070820181725.GB8542@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INMwY-0003iw-RH
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 08:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217AbXHUGKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 02:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbXHUGKT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 02:10:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1694 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756114AbXHUGKR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 02:10:17 -0400
Received: (qmail 32135 invoked by uid 111); 21 Aug 2007 06:10:16 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Aug 2007 02:10:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2007 02:10:14 -0400
Content-Disposition: inline
In-Reply-To: <20070820181725.GB8542@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56280>

On Mon, Aug 20, 2007 at 08:17:25PM +0200, Jan Hudec wrote:

> > I think this is a failing of git-merge, though, for not including that
> > nice human-readable information. We can fix it with something like this:
> 
> Maybe you could call git-name-rev on it if it does not come with
> a human-readable name.

I considered that, but it has two drawbacks:

  1. It does not handle pulls which have no tracking branch (the only
     ref we have is FETCH_HEAD, which is not a useful name :) ).

  2. In some circumstances, it can come up with counter-intuitive
     names. If more than one ref points to a given commit, then you can
     end up with something like "git-merge foo" telling you all about
     the merge conflicts with "bar". But perhaps that is too obscure a
     corner case to worry about.

-Peff

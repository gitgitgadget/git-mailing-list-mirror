From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] ignore unknown color configuration
Date: Tue, 15 Dec 2009 22:46:48 -0500
Message-ID: <20091216034648.GB9742@sigill.intra.peff.net>
References: <20091212122524.GA17547@coredump.intra.peff.net>
 <7vy6l3vh8x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 04:46:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKkqm-0005Rv-3N
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 04:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbZLPDqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 22:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbZLPDqv
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 22:46:51 -0500
Received: from peff.net ([208.65.91.99]:58947 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbZLPDqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 22:46:51 -0500
Received: (qmail 1446 invoked by uid 107); 16 Dec 2009 03:51:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 15 Dec 2009 22:51:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2009 22:46:48 -0500
Content-Disposition: inline
In-Reply-To: <7vy6l3vh8x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135321>

On Tue, Dec 15, 2009 at 05:29:18PM -0800, Junio C Hamano wrote:

> >  	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
> >  		int slot = parse_status_slot(k, 13);
> > +		if (slot < 0)
> > +			return -1;
> 
> Shouldn't this return 0, to say "we handled it (by ignoring), don't
> worry", instead of saying "hey it's error" by returning -1?  That's what
> is done on the "diff" side below...

Yes, thank you for catching it. It should definitely be "return 0" (as
the other two cases are). It was a simple think-o on my part.

-Peff

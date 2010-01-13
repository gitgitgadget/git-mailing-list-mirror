From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: show interesting ident information in
 summary
Date: Wed, 13 Jan 2010 12:30:50 -0500
Message-ID: <20100113173050.GB21318@coredump.intra.peff.net>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154631.GC24957@coredump.intra.peff.net>
 <7v3a2asda8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:31:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV73h-0001LA-LE
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170Ab0AMRbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175Ab0AMRbA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:31:00 -0500
Received: from peff.net ([208.65.91.99]:58500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756198Ab0AMRbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:31:00 -0500
Received: (qmail 25220 invoked by uid 107); 13 Jan 2010 17:35:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 12:35:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 12:30:50 -0500
Content-Disposition: inline
In-Reply-To: <7v3a2asda8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136845>

On Tue, Jan 12, 2010 at 10:57:03PM -0800, Junio C Hamano wrote:

> > +	if (!user_ident_explicitly_given) {
> > +		strbuf_addstr(&format, "\n Committer: ");
> > +		strbuf_percentquote_buf(&format, &committer_ident);
> > +	}
> 
> This is much better.
> 
> We might want an advice message inside the latter case, helping the user
> learn how to spell his name correctly.  This is designed to trigger for
> people/repositories that are not configured, and by definition the
> majority of that target audience are new people.
> 
> The extra message will disappear once committer information is explicitly
> given, there is no need to protect the advice message with the usual
> "advice.*" configuration.

Just adding the "Committer:" reminder is slightly annoying (though
perhaps some people will even like it). Adding a big advice message on
every commit is going to be annoying to everyone who sees it, and is
really crossing the line of "we don't really support implicit identities
anymore", since anyone seeing it is going to want to fix it.

I know there has been some discussion of that area in the last few
months, but I admit I didn't pay any attention. Is that the direction we
want to move in? I don't have a particular problem with it, but I want
to point out that if there _are_ people who really like the implicit
ident feature, we are effectively killing it off for them.

-Peff

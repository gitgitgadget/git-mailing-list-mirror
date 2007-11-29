From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Thu, 29 Nov 2007 09:51:39 -0500
Message-ID: <20071129145139.GC32670@coredump.intra.peff.net>
References: <7vmysx2ac8.fsf@gitster.siamese.dyndns.org> <1196337638-45972-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, dzwell@gmail.com,
	Matthieu.Moy@imag.fr
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 15:52:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxkkF-0004is-Bw
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 15:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbXK2Ovm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 09:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756168AbXK2Ovm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 09:51:42 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2517 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992AbXK2Ovm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 09:51:42 -0500
Received: (qmail 19683 invoked by uid 111); 29 Nov 2007 14:51:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 09:51:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 09:51:39 -0500
Content-Disposition: inline
In-Reply-To: <1196337638-45972-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66538>

On Thu, Nov 29, 2007 at 01:00:38PM +0100, Wincent Colaiuta wrote:

> A new function is added to detect the shortest unique prefix and this
> is used to decide what to highlight. Highlighting is also applied when
> choosing files.

I think this is very nicely implemented.

Acked-by: Jeff King <peff@peff.net>

> +# returns an array of tuples (prefix, remainder)
> +sub find_unique_prefixes {
> +	my @stuff = @_;

I know we generally use this more C-ish argument convention to document
"here are the arguments to this function", but it does actually make a
copy of the @_ array (and using @_ implies a potentially large number of
arguments).

It probably doesn't matter here, though, since add--interactive is not
performance critical, and you probably can't have more than a few dozen
entries before it becomes unreadable anyway.

-Peff

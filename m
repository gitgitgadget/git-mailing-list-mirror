From: Jeff King <peff@peff.net>
Subject: Re: Improving CRLF error message; also, enabling autocrlf and
	safecrlf by default
Date: Sun, 15 Feb 2009 22:18:49 -0500
Message-ID: <20090216031849.GA12348@coredump.intra.peff.net>
References: <loom.20090216T022524-78@post.gmane.org> <20090216030446.GC18780@sigill.intra.peff.net> <7vhc2vf4yx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jason Spiro <jasonspiro4@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYu1s-0005jb-KB
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbZBPDSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 22:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755837AbZBPDSw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:18:52 -0500
Received: from peff.net ([208.65.91.99]:51844 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546AbZBPDSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:18:52 -0500
Received: (qmail 12626 invoked by uid 107); 16 Feb 2009 03:19:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 22:19:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 22:18:49 -0500
Content-Disposition: inline
In-Reply-To: <7vhc2vf4yx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110123>

On Sun, Feb 15, 2009 at 07:14:30PM -0800, Junio C Hamano wrote:

> > I'm happy you want to improve git; but please, if you want to report
> > problems, check what the status is in a more recent version (or at least
> > tell us your version, which can help).
> > ...
> > It might be worth splitting the trailing whitespace detection into
> > "spaces and tabs at the end" and "CRLF", and providing different
> > messages (though it is hopefully also obvious with the new output that
> > it is a CRLF issue).
> 
> I think the status on this in a more recent version can be found by
> running "git grep cr-at-eol" ;-)

Heh. You didn't quote the part where I already claimed to be clueless.
;)

But seriously, might it not be useful for users seeing --check warnings
for the first time to print:

  file:1: trailing whitespace (cr-at-eol).
  +foo^M

That is, there are different rules for trailing whitespace, but we don't
currently tell you which one triggered. Giving the user "cr-at-eol"
gives them something to grep before.

-Peff

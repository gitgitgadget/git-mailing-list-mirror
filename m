From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 04:53:04 -0400
Message-ID: <20080329085304.GC19200@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290819.07280.robin.rosenberg.lists@dewire.com> <20080329072203.GA17625@coredump.intra.peff.net> <200803290944.55273.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 09:53:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfWp0-0006Ce-6n
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 09:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYC2IxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 04:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbYC2IxK
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 04:53:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3921 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895AbYC2IxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 04:53:09 -0400
Received: (qmail 19907 invoked by uid 111); 29 Mar 2008 08:53:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 04:53:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 04:53:04 -0400
Content-Disposition: inline
In-Reply-To: <200803290944.55273.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78457>

On Sat, Mar 29, 2008 at 09:44:55AM +0100, Robin Rosenberg wrote:

> > OK. Do you have an example function that guesses with high probability
> > whether a string is utf-8? If there are non-ascii characters but we
> > _don't_ guess utf-8, what should we do?
> 
> I guess the best bet is to assume the locale. Btw, is the encoding header
> from the commit (when present) completely lost? (not that it can be trusted
> anyway).

What do you mean by "assume the locale"?  Is there a portable way to say
"this is the encoding of the locale the user has chosen?" On my system I
set LANG=en_US, and behind-the-scenes magic chooses utf-8 versus
iso8859-1.

And there is no encoding header for the commit; the point of this patch
is to handle the "cover letter" message created by "send-email
--compose" (we should already be doing the right thing for the patch
emails, since the commit encoding is output by format-patch in a
content-type header before we even get to send-email).

-Peff

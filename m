From: Jeff King <peff@peff.net>
Subject: Re: why still no empty directory support in git
Date: Thu, 1 Jan 2009 15:06:51 -0500
Message-ID: <20090101200651.GB6536@coredump.intra.peff.net>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com> <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net> <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net> <9b18b3110812300043l55a42f6sd995f36bf857543e@mail.gmail.com> <alpine.DEB.2.00.0812300346040.19911@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 21:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LITrb-0001IC-VD
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 21:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbZAAUGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbZAAUGy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 15:06:54 -0500
Received: from peff.net ([208.65.91.99]:2975 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbZAAUGy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 15:06:54 -0500
Received: (qmail 21398 invoked by uid 111); 1 Jan 2009 20:06:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 01 Jan 2009 15:06:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jan 2009 15:06:51 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812300346040.19911@vellum.laroia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104315>

On Tue, Dec 30, 2008 at 03:58:46AM -0500, Asheesh Laroia wrote:

> So, let's say I take your suggestion.
>
> $ touch ~/Maildir/new/.exists
> $ git add ~/Maildir/new/.exists && git commit -m "La di da"
>
> Now a spec-compliant Maildir user agent will attempt to deliver this new  
> "email message" of zero bytes into the mail spool and assign it a message  
> UID.  Doing so will remove it from Maildir/new.

No. The maildir spec says:

  A unique name can be anything that doesn't contain a colon (or slash)
  and doesn't start with a dot.
     -- http://cr.yp.to/proto/maildir.html

where a "unique name" is the filename used for a message. In practice,
every maildir implementation I have seen ignores files starting with a
dot. Do you have one that doesn't?

-Peff

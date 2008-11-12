From: Jeff King <peff@peff.net>
Subject: Re: Possible bug: "git log" ignores "--encoding=UTF-8" option if
	--pretty=format:%e%n%s%n is used
Date: Wed, 12 Nov 2008 06:26:54 -0500
Message-ID: <20081112112654.GA20640@coredump.intra.peff.net>
References: <85647ef50811111112o5449c12elfc571e46e607cfd0@mail.gmail.com> <20081112104318.GA20120@coredump.intra.peff.net> <85647ef50811120311q7bc5451x7c084fd2a7864177@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 12:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Dtf-00011f-UZ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 12:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbYKLL07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 06:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYKLL06
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 06:26:58 -0500
Received: from peff.net ([208.65.91.99]:3767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbYKLL06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 06:26:58 -0500
Received: (qmail 18676 invoked by uid 111); 12 Nov 2008 11:26:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 06:26:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 06:26:54 -0500
Content-Disposition: inline
In-Reply-To: <85647ef50811120311q7bc5451x7c084fd2a7864177@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100743>

[re-adding list to the cc]

On Wed, Nov 12, 2008 at 02:11:46PM +0300, Constantine Plotnikov wrote:

> > I don't actually use any encodings except UTF-8, so maybe there is some
> > subtle reason not to do so that I don't understand, but I would have
> > expected all of the format placeholders to respect any --encoding
> > parameter.
> >
> Even if this is the bug, it would be better to leave the old behavior
> for backward compatibility reasons and introduce new placeholders.
> Currently tools have to decode messages according to the commit
> encoding, and changing behavior of options will break these tools
> that have implemented workaround for this problem.

Are there such tools? I assumed they would have complained about this as
a bug before writing their own encoding conversion tools. And this is,
AFAIK, the first bug report.

I don't mind playing it safe to avoid breaking other people's tools, but
I'm also not excited about adding a second, "respect encoding" version
of many placeholders (and it's not just %s and %b; I think you would
need author and committer names and emails, too).

-Peff

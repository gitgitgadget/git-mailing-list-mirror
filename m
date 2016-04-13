From: Jeff King <peff@peff.net>
Subject: Re: clone hang prevention / timeout?
Date: Wed, 13 Apr 2016 18:29:00 -0400
Message-ID: <20160413222900.GA10011@sigill.intra.peff.net>
References: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Vas Dias <jason.vas.dias@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:29:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTHY-000167-Sx
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbcDMW3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:29:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:49123 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750863AbcDMW3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:29:04 -0400
Received: (qmail 7826 invoked by uid 102); 13 Apr 2016 22:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:29:02 -0400
Received: (qmail 23397 invoked by uid 107); 13 Apr 2016 22:29:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:29:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Apr 2016 18:29:00 -0400
Content-Disposition: inline
In-Reply-To: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291501>

On Mon, Apr 11, 2016 at 10:49:19PM +0100, Jason Vas Dias wrote:

> Is there any option I can specify to get the clone to timeout, or do I manually
> have to strace the git process and send it a signal after a hang is detected?

Oh, one other thing you might consider, it something like "timeout" from
GNU coreutils, which puts a hard cap on the length of time a process can
run.

It's totally unaware of the state of the process, though, so if you
really do have a clone which takes an hour, it might very well kill it
at 99% complete. It has no mechanism for "gee, this process looks like
it hasn't done anything for 5 minutes".

I don't know offhand of a general tool for that.

-Peff

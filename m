From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] refs.c: Write reflogs for notes just like for
 branch heads
Date: Thu, 1 Apr 2010 20:16:41 -0400
Message-ID: <20100402001640.GH16462@coredump.intra.peff.net>
References: <d6c334ec855bf04d9edb432b9cdc3590ab96d6e9.1269867675.git.git@drmicha.warpmail.net>
 <201003291625.22977.johan@herland.net>
 <20100330171932.GE17763@coredump.intra.peff.net>
 <201003302000.35616.johan@herland.net>
 <m3mxxpipqw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 02:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUZG-0003fA-7s
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759064Ab0DBAQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:16:54 -0400
Received: from peff.net ([208.65.91.99]:43547 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755733Ab0DBAQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:16:52 -0400
Received: (qmail 5300 invoked by uid 107); 2 Apr 2010 00:17:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:17:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:16:41 -0400
Content-Disposition: inline
In-Reply-To: <m3mxxpipqw.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143769>

On Tue, Mar 30, 2010 at 12:18:16PM -0700, Jakub Narebski wrote:

> > > I like the idea of having a reflog, just because you could use it to
> > > salvage an old cache if you were playing around with your helper's
> > > options (or debugging your helper :) ). The usual 90-day expiration
> > > time is perhaps too long, though.
> > 
> > Yes, 90 days as a default might be excessive, but you can always 
> > override it with a "git gc --prune=now"...
> 
> You can always set different expire time for notes by using
> 
>   [gc "refs/notes"]
>         reflogExpire = 7 # days, I suppose
> 
> Which is not documented (I have found it in RelNotes-1.6.0.txt).  
> Oh well...

Thanks, I didn't know about that feature. I just posted my series
without dealing with the reflogs at all, but I think it may be sensible
to drop the default for "refs/notes/textconv" in a followup patch.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] upload-archive security issues
Date: Tue, 15 Nov 2011 17:23:20 -0500
Message-ID: <20111115222320.GA28646@sigill.intra.peff.net>
References: <20111115214159.GA20457@sigill.intra.peff.net>
 <CABPQNSZ71==pQvH9nTQ3rD6c1RJiLmkA+k_9KS=T45cQb+PTLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 23:23:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQRPc-0002EZ-SI
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 23:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab1KOWXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 17:23:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42833
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732Ab1KOWXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 17:23:23 -0500
Received: (qmail 10805 invoked by uid 107); 15 Nov 2011 22:23:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 17:23:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 17:23:20 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSZ71==pQvH9nTQ3rD6c1RJiLmkA+k_9KS=T45cQb+PTLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185494>

On Tue, Nov 15, 2011 at 11:01:09PM +0100, Erik Faye-Lund wrote:

> Yikes! Perhaps the whole deal of rewriting the code to take explicit
> file descriptors (and/or dup-bonanza) would have been the better
> choice after all?

It's certainly simpler. This way is not that hard to fix; we just need
to be more careful about the code path getting from upload-archive into
write_archive.

> For the record: I would be fine with c09cd77e simply being reverted
> for this release, and having a better version applied in the near
> future. Windows support for upload-archive is not worth the risk of
> slipping in a remote code execution bug...

I'd be OK with that, too.

> Not only did you fail to spot them, you actually wrote that part of the code ;)
> 
> http://article.gmane.org/gmane.comp.version-control.git/178098
> 
> (I don't mean to shift blame over to you, I'm the one who should have
> spent more time thinking about this as this was "my" series)

Heh. I did say "something like this" in that message, which is usually a
sure sign I haven't actually thought too hard about the code I'm about
to write. I'll be content to share the blame equally with you. :)

-Peff

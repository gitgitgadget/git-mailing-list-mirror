From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: use curl's tcp keepalive if available
Date: Tue, 15 Oct 2013 01:00:28 -0400
Message-ID: <20131015050028.GA8150@sigill.intra.peff.net>
References: <20131012222939.GA24255@dcvr.yhbt.net>
 <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
 <20131014052739.GA16129@dcvr.yhbt.net>
 <20131014214035.GB7007@sigill.intra.peff.net>
 <20131014233839.GA26323@dcvr.yhbt.net>
 <20131015000614.GA10905@sigill.intra.peff.net>
 <20131015045814.GA12312@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 07:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVwkF-0000w0-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 07:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab3JOFAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 01:00:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:49544 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918Ab3JOFAb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 01:00:31 -0400
Received: (qmail 7304 invoked by uid 102); 15 Oct 2013 05:00:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Oct 2013 00:00:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Oct 2013 01:00:28 -0400
Content-Disposition: inline
In-Reply-To: <20131015045814.GA12312@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236164>

On Tue, Oct 15, 2013 at 04:58:14AM +0000, Eric Wong wrote:

> > Subject: http: use curl's tcp keepalive if available
> [...]
> Tested-by: Eric Wong <normalperson@yhbt.net>
> on curl 7.21.0 and 7.26.0, confirmed via strace:
> 
> 	setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, [1], 4) = 0
> 
> I can also confirm 7.26.0 adds:
> 
> 	setsockopt(fd, SOL_TCP, TCP_KEEPIDLE, [60], 4) = 0
> 	setsockopt(fd, SOL_TCP, TCP_KEEPINTVL, [60], 4) = 0
> 
> to the strace on Linux.

Thanks, I didn't actually do any testing myself.

> Case 2 works fine on my Debian Squeeze system.
> 
> > Now we have an extra option:
> > 
> >   c. Tell them to upgrade curl. :)
> 
> Yes, I keep forgetting I still have a Debian Squeeze machine :x

I am more concerned with Windows, which may not compile your original
patch at all.

-Peff

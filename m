From: Jeff King <peff@peff.net>
Subject: Re: project wide: git config entry for [diff] renames=true
Date: Thu, 25 Sep 2014 14:00:05 -0400
Message-ID: <20140925180005.GA11755@peff.net>
References: <Pine.LNX.4.44L0.1409241106100.1580-100000@iolanthe.rowland.org>
 <1411591401-5874-1-git-send-email-sojka@merica.cz>
 <1411591401-5874-4-git-send-email-sojka@merica.cz>
 <20140925150353.GA15325@kroah.com>
 <1411660111.4026.24.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Sojka <sojka@merica.cz>, linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Bryan Wu <cooloney@gmail.com>, Felipe Balbi <balbi@ti.com>,
	Linux LED Subsystem <linux-leds@vger.kernel.org>,
	linux-kernel@vger.kernel.org, michal.vokac@comap.cz,
	git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 20:00:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXDKy-0007IN-Db
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 20:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbaIYSAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 14:00:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:51683 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752722AbaIYSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 14:00:08 -0400
Received: (qmail 24033 invoked by uid 102); 25 Sep 2014 18:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Sep 2014 13:00:08 -0500
Received: (qmail 15588 invoked by uid 107); 25 Sep 2014 18:00:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Sep 2014 14:00:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Sep 2014 14:00:05 -0400
Content-Disposition: inline
In-Reply-To: <1411660111.4026.24.camel@joe-AO725>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257486>

On Thu, Sep 25, 2014 at 08:48:31AM -0700, Joe Perches wrote:

> On Thu, 2014-09-25 at 17:03 +0200, Greg Kroah-Hartman wrote:
> 
> > In the future, please generate a git "move" diff, which makes it easier
> > to review, and prove that nothing really changed.  It also helps if the
> > file is a bit different from what you diffed against, which in my case,
> > was true.
> 
> Maybe it'd be possible to add 
> 
> [diff]
> 	renames = true
> 
> to the .git/config file.
> 
> but I don't find a mechanism to add anything to the
> .git/config and have it be pulled.

There is no such mechanism within git. We've resisted adding one because
of the danger of something like:

  [diff]
    external = rm -rf /

diff.renames is probably safe, but any config-sharing mechanism would
have to deal with either whitelisting, or providing some mechanism for
the puller to review changes before blindly following them.

-Peff

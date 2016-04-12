From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] index-helper: fix UNIX_PATH_MAX redefinition error
 on cygwin
Date: Mon, 11 Apr 2016 21:46:16 -0400
Message-ID: <20160412014616.GA9604@sigill.intra.peff.net>
References: <570ADA5B.5030408@ramsayjones.plus.com>
 <20160411133343.GA7492@sigill.intra.peff.net>
 <1460410162.5540.20.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 03:46:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apnPR-00067N-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 03:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbcDLBqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 21:46:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:47810 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753804AbcDLBqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 21:46:24 -0400
Received: (qmail 30674 invoked by uid 102); 12 Apr 2016 01:46:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 21:46:19 -0400
Received: (qmail 31822 invoked by uid 107); 12 Apr 2016 01:46:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 21:46:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Apr 2016 21:46:16 -0400
Content-Disposition: inline
In-Reply-To: <1460410162.5540.20.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291240>

On Mon, Apr 11, 2016 at 05:29:22PM -0400, David Turner wrote:

> On Mon, 2016-04-11 at 09:33 -0400, Jeff King wrote:
> > On Sun, Apr 10, 2016 at 11:57:31PM +0100, Ramsay Jones wrote:
> > 
> > > So, the approach taken by patch #1 is to forget about UNIX_PATH_MAX
> > > and
> > > simply use sizeof(address.sun_path) instead!
> > 
> > That's what the existing code in unix-socket.c does. Which makes me
> > wonder why the index-helper code is not simply calling that.
> 
> Because I didn't notice it at the time.  Duy pointed it out on another
> comment on this series; I'll fix it.

Thanks. I _think_ it should do everything you need already, but I'm
happy to review any tweaks you need to make to it.

-Peff

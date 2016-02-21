From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon.c: mark a file-local symbol as static
Date: Sun, 21 Feb 2016 18:25:10 -0500
Message-ID: <20160221232510.GB4094@sigill.intra.peff.net>
References: <56C9F4F2.1060100@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:25:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdNP-0006ow-3v
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbcBUXZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:25:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:46389 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752304AbcBUXZN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:25:13 -0500
Received: (qmail 24585 invoked by uid 102); 21 Feb 2016 23:25:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:25:12 -0500
Received: (qmail 13149 invoked by uid 107); 21 Feb 2016 23:25:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:25:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2016 18:25:10 -0500
Content-Disposition: inline
In-Reply-To: <56C9F4F2.1060100@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286842>

On Sun, Feb 21, 2016 at 05:33:38PM +0000, Ramsay Jones wrote:

> If you need to re-roll your 'jk/tighten-alloc' branch, could you
> please squash this into the relevant patch. (ie. "convert manual
> allocations to argv_array").

Thanks, will do. You notice these with sparse, as I recall? I've meant
to look into running that myself, but it looks like we are not
warning-free with sparse currently. I see complaints like:

  connect.c:377:40: warning: incorrect type in argument 2 (invalid types)
  connect.c:377:40:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
  connect.c:377:40:    got struct sockaddr *ai_addr

As far as I can tell, that's just noise. Do you have a ready-made recipe
for silencing it?

-Peff

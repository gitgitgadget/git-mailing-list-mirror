From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 02:16:35 -0500
Message-ID: <20100114071634.GA20567@coredump.intra.peff.net>
References: <op.u6g8jnixg402ra@nb-04>
 <20100113154310.GA7348@Knoppix>
 <op.u6haiiiog402ra@nb-04>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 08:16:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVJwo-00036L-15
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 08:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0ANHQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 02:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594Ab0ANHQl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 02:16:41 -0500
Received: from peff.net ([208.65.91.99]:38934 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755632Ab0ANHQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 02:16:37 -0500
Received: (qmail 4815 invoked by uid 107); 14 Jan 2010 07:21:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 Jan 2010 02:21:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2010 02:16:35 -0500
Content-Disposition: inline
In-Reply-To: <op.u6haiiiog402ra@nb-04>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136957>

On Wed, Jan 13, 2010 at 04:55:20PM +0100, Rudolf Polzer wrote:

> >- Should the tracking be set up even if only part of ref update suceeded
> >(for those that succeeded), not requiring all to succeed?
> 
> Good point, but I simply see no clean way to set it up for the
> succeeded refs. Would be a nice idea for improvement of this.

I don't think it's that hard. In fact, I did a preliminary patch for it
about a year ago:

  http://article.gmane.org/gmane.comp.version-control.git/107750

That patch was held up because there were a lot of cleanups needed in
transport.c before it would make sense (read the whole thread for
details). I think most of those cleanups have happened in the meantime,
so it would be pretty straightforward to use the same setup_tracking()
function and just call it from the right spot in transport.c. But I
haven't actually looked at this topic since the above-referenced thread.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH jk/push-client-deadlock-fix] Windows: add
 pthread_sigmask() that does nothing
Date: Tue, 3 May 2016 00:48:46 -0400
Message-ID: <20160503044845.GC32259@sigill.intra.peff.net>
References: <CACsJy8BrKsasiXZcc3=mm9Pq=qz_h6pi8edzpmT_7mKxwjnAqQ@mail.gmail.com>
 <20160501174535.GB17321@sigill.intra.peff.net>
 <57265425.9050205@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	git-for-windows <git-for-windows@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 03 06:48:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axSGT-0002HK-Fi
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 06:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbcECEst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 00:48:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:60810 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751142AbcECEst (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 00:48:49 -0400
Received: (qmail 11050 invoked by uid 102); 3 May 2016 04:48:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:48:49 -0400
Received: (qmail 22740 invoked by uid 107); 3 May 2016 04:49:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:49:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 00:48:46 -0400
Content-Disposition: inline
In-Reply-To: <57265425.9050205@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293324>

On Sun, May 01, 2016 at 09:08:21PM +0200, Johannes Sixt wrote:

> A previous change introduced a call to pthread_sigmask() in order to block
> SIGPIPE in a thread. Since there are no signal facilities on Windows that
> are similar to POSIX signals, just ignore the request to block the signal.
> In the particular case, the effect of blocking SIGPIPE on POSIX is that
> write() calls return EPIPE when the reader closes the pipe. This is how
> write() behaves on Windows.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Looks good to me based on our earlier discussion (but of course I have
no platform to test it on).

-Peff

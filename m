From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] diff-highlight: exit when a pipe is broken
Date: Tue, 4 Nov 2014 15:09:32 -0500
Message-ID: <20141104200932.GA15149@peff.net>
References: <1415131272-89441-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 21:09:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlkQ8-0003jA-PD
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 21:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbaKDUJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 15:09:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:36745 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751842AbaKDUJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 15:09:35 -0500
Received: (qmail 10718 invoked by uid 102); 4 Nov 2014 20:09:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 14:09:34 -0600
Received: (qmail 7597 invoked by uid 107); 4 Nov 2014 20:09:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 15:09:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2014 15:09:32 -0500
Content-Disposition: inline
In-Reply-To: <1415131272-89441-1-git-send-email-john@szakmeister.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 04, 2014 at 03:01:12PM -0500, John Szakmeister wrote:

> While using diff-highlight with other tools, I have discovered that Python
> ignores SIGPIPE by default.  Unfortunately, this also means that tools
> attempting to launch a pager under Python--and don't realize this is
> happening--means that the subprocess inherits this setting.  In this case, it
> means diff-highlight will be launched with SIGPIPE being ignored.  Let's work
> with those broken scripts by restoring the default SIGPIPE handler.
> 
> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
> Incorporates feedback from Jeff King and now we just restore the default signal
> handler using the correct case of 'DEFAULT'.

Thanks, this version looks much simpler. :)

Acked-by: Jeff King <peff@peff.net>

-Peff

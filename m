From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: fix die recursion with custom handler
Date: Fri, 15 May 2015 02:20:35 -0400
Message-ID: <20150515062034.GA30741@peff.net>
References: <20150513210436.GA7407@gmail.com>
 <20150514004724.GA3059@peff.net>
 <20150514010233.GA7808@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 08:20:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt8zC-0005XB-OH
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 08:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbbEOGUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 02:20:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:59041 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752854AbbEOGUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 02:20:37 -0400
Received: (qmail 22434 invoked by uid 102); 15 May 2015 06:20:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 01:20:37 -0500
Received: (qmail 31413 invoked by uid 107); 15 May 2015 06:20:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 02:20:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 02:20:35 -0400
Content-Disposition: inline
In-Reply-To: <20150514010233.GA7808@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269127>

On Wed, May 13, 2015 at 09:02:33PM -0400, Jeff King wrote:

> +static int die_webcgi_recursing(void)
> +{
> +	dead++;
> +	return dead > 1;
> +}

Ugh, somehow I managed to introduce an off-by-one here while prettifying
the code before sending. It should be "> 2" (or "dead++ > 1" to get the
value before incrementing).

The series I'll post in a moment will have a fixed version.

-Peff

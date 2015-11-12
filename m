From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: fix some printf format warnings
Date: Wed, 11 Nov 2015 19:11:34 -0500
Message-ID: <20151112001134.GA8572@sigill.intra.peff.net>
References: <5643D84E.2070904@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 01:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwfUL-0004Km-3b
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 01:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbbKLALh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 19:11:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:56403 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751671AbbKLALg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 19:11:36 -0500
Received: (qmail 14863 invoked by uid 102); 12 Nov 2015 00:11:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Nov 2015 18:11:36 -0600
Received: (qmail 11299 invoked by uid 107); 12 Nov 2015 00:12:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Nov 2015 19:12:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Nov 2015 19:11:34 -0500
Content-Disposition: inline
In-Reply-To: <5643D84E.2070904@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281210>

On Thu, Nov 12, 2015 at 12:07:42AM +0000, Ramsay Jones wrote:

> Commit f8117f55 ("http: use off_t to store partial file size",
> 02-11-2015) changed the type of some variables from long to off_t.
> Unfortunately, the off_t type is not portable and can be represented
> by several different actual types (even multiple types on the same
> platform). This makes it difficult to print an off_t variable in
> a platform independent way. As a result, this commit causes gcc to
> issue some printf format warnings on a couple of different platforms.
> 
> In order to suppress the warnings, change the format specifier to use
> the PRIuMAX macro and cast the off_t argument to uintmax_t. (See also
> the http_opt_request_remainder() function, which uses the same
> solution).

Thanks, that's even better than what I had ghost-written for you. :)

-Peff

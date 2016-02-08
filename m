From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Mon, 8 Feb 2016 07:08:39 -0500
Message-ID: <20160208120838.GA24217@sigill.intra.peff.net>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
 <20160205112001.GA13397@sigill.intra.peff.net>
 <56B48803.9080909@gmail.com>
 <20160205135855.GA19154@sigill.intra.peff.net>
 <56B87B46.6050304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 13:08:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSkca-00053I-DF
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 13:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbcBHMIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 07:08:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:39133 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751327AbcBHMIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 07:08:44 -0500
Received: (qmail 23963 invoked by uid 102); 8 Feb 2016 12:08:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 07:08:44 -0500
Received: (qmail 4341 invoked by uid 107); 8 Feb 2016 12:08:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 07:08:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 07:08:39 -0500
Content-Disposition: inline
In-Reply-To: <56B87B46.6050304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285757>

On Mon, Feb 08, 2016 at 12:25:58PM +0100, Sebastian Schuberth wrote:

> On 2/5/2016 14:58, Jeff King wrote:
> 
> >Yeah, I agree it's unlikely. And the output is already ambiguous, as the
> >first field could be a blob (though I guess the caller knows if they
> >passed "--blob" or not). If we really wanted an unambiguous output, we
> >could have something like "file:...", "blob:...", etc. But that's a bit
> >less readable for humans, and I don't think solves any real-world
> >problems.
> >
> >So I think it would be OK to use "<command line>" here, as long as the
> >token is documented.
> 
> Thinking about it again, I actually do like Peff's prefix solution better.
> It would solve the real-world problem that my proposed "<command line>"
> marker could in fact be a file name.

I'm OK with that direction, but I think it will need some more
infrastructure in the config code (right now we just set "name" to some
string without recording its type). It probably would not be too hard to
add, though.

-Peff

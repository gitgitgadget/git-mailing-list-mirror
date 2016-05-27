From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Thu, 26 May 2016 23:55:54 -0400
Message-ID: <20160527035553.GA24972@sigill.intra.peff.net>
References: <20160527034610.GA31629@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Fri May 27 05:56:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b68sT-0003E0-Om
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 05:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbcE0Dz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 23:55:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:45056 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750906AbcE0Dz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 23:55:57 -0400
Received: (qmail 1690 invoked by uid 102); 27 May 2016 03:55:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 23:55:56 -0400
Received: (qmail 26596 invoked by uid 107); 27 May 2016 03:56:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 23:56:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 23:55:54 -0400
Content-Disposition: inline
In-Reply-To: <20160527034610.GA31629@zoidberg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295724>

On Thu, May 26, 2016 at 10:46:10PM -0500, Edward Thomson wrote:

> git-log(1) documents that when specifying the `%C(auto)` format
> placeholder will "turn on auto coloring on the next %placeholders
> until the color is switched again."
> 
> However, when `%C(auto)` is used, the present implementation will turn
> colors on unconditionally (even if the color configuration is turned off
> for the current context - for example, `--no-color` was specified or the
> color is `auto` and the output is not a tty).
> 
> Update `format_commit_one` to examine the current context when a format
> string of `%C(auto)` is specified, which ensures that we will not
> unconditionally write colors.  This brings that behavior in line with
> the behavior of `%C(auto,<colorname>)`, and allows the user the ability
> to specify that color should be displayed only when the output is a
> tty.
> 
> Additionally, add a test for `%C(auto)` and update the existing tests
> for `%C(auto,...)` as they were misidentified as being applicable to
> `%C(auto)`.

Explanation and the patch look good.

> Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>
> 
> Tests from Jeff King.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Trailers should all go at the bottom in a single stanza, and should
generally be in chronological order (so you got the bits from with an
s-o-b, and then you signed off the whole thing). IOW:

> Tests from Jeff King.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>

I suspect Junio can just tweak that while applying, unless there's
another reason to re-roll.

(Also for anybody watching, Ed did not just make up my signoff; I gave
it to him off-list).

-Peff

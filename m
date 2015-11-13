From: Jeff King <peff@peff.net>
Subject: Re: Replicating the default "git log" format with a format string.
Date: Fri, 13 Nov 2015 00:38:00 -0500
Message-ID: <20151113053800.GE29708@sigill.intra.peff.net>
References: <loom.20151112T011419-749@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kannan Goundan <kannan@cakoose.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 06:38:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx73o-0002Vr-DY
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 06:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbbKMFiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 00:38:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:56938 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbbKMFiC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 00:38:02 -0500
Received: (qmail 14547 invoked by uid 102); 13 Nov 2015 05:38:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Nov 2015 23:38:02 -0600
Received: (qmail 21507 invoked by uid 107); 13 Nov 2015 05:38:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:38:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 00:38:00 -0500
Content-Disposition: inline
In-Reply-To: <loom.20151112T011419-749@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281238>

On Thu, Nov 12, 2015 at 12:55:53AM +0000, Kannan Goundan wrote:

> For our workflow, author dates aren't very useful.  I'm looking for a way to
> configure Git so that "git log" shows commit dates instead of author dates.
>  "--pretty=fuller" gets me almost what I want, but I'd like to avoid the
> extra two lines if possible.
> 
> I tried achieving this by putting a custom format string in ~/.gitconfig:
> 
> [format]
>   pretty = "%C(auto,yellow)commit %C(auto)%H\nAuthor: %an <%ae>\nDate:  
> %cd\n\n%w(0,4,4)%B"
> 
> This works pretty well, but has a few corner cases.  When you do "git log
> --decorate", the default format decorates commits with ref names.  I can add
> "%d" to my format string, but then the ref names show up all the time, even
> without "--decorate".
> 
> The "--walk-reflogs" option presents a similar problem.  The %g*
> placeholders all become empty strings when "--walk-reflogs" isn't present,
> which is sort of what I want, but it leaves extra blank lines in the output.
> 
> Is it possible to exactly replicate the default "git log" format with a
> format string?

Sadly, no, I don't think it is possible with the current format
specifiers. It would be nice if it was, though.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 10:32:45 -0400
Message-ID: <20160331143244.GD31116@sigill.intra.peff.net>
References: <20160331123507.GC19857@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@collabora.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:32:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldeV-0007OR-LP
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832AbcCaOcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:32:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:41510 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756543AbcCaOcr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:32:47 -0400
Received: (qmail 20526 invoked by uid 102); 31 Mar 2016 14:32:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:32:47 -0400
Received: (qmail 13106 invoked by uid 107); 31 Mar 2016 14:32:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:32:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 10:32:45 -0400
Content-Disposition: inline
In-Reply-To: <20160331123507.GC19857@collabora.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290390>

On Thu, Mar 31, 2016 at 02:35:07PM +0200, Miklos Vajna wrote:

> Hi,
> 
> Some projects like LibreOffice don't use Signed-off-by, instead usually
> use Gerrit for code review, and reviewers add a Reviewed-by line when
> they are OK with a patch.  In this workflow it's a bit unfortunate that
> adding a Signed-off-by line is just a command-line switch, but adding a
> Reviewed-by line is more complex.
> 
> Is there anything in git that could help this situation? I didn't see
> any related config option; I wonder if a patch would be accepted to make
> the "Signed-off-by" line configurable, or there is a better way.

There's git-interpret-trailers, which can do the heavy lifting of adding
it in the right place. But I don't know how you'd want to trigger it; it
would depend on the workflow that people use to add their signoff in the
first place.  I don't think there is anything as easy as "git commit
--amend -s", but I'm not all that familiar with the interpret-trailers
code.

-Peff

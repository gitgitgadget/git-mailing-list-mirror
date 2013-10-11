From: Jeff King <peff@peff.net>
Subject: Re: A workflow for local patch maintenance
Date: Fri, 11 Oct 2013 11:16:14 -0400
Message-ID: <20131011151614.GA29226@sigill.intra.peff.net>
References: <20131010173628.GB24782@sigill.intra.peff.net>
 <247350414.2015225.1381497748024.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Tony Finch <dot@dotat.at>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 17:16:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUeRz-0003BD-Av
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 17:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256Ab3JKPQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 11:16:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:47553 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752244Ab3JKPQT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 11:16:19 -0400
Received: (qmail 1481 invoked by uid 102); 11 Oct 2013 15:16:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Oct 2013 10:16:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Oct 2013 11:16:14 -0400
Content-Disposition: inline
In-Reply-To: <247350414.2015225.1381497748024.JavaMail.root@genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235907>

On Fri, Oct 11, 2013 at 09:22:28AM -0400, Stephen Bash wrote:

> > To mitigate problem 1, I will sometimes revert a local topic before
> > doing the upstream merge, if I know it has been reworked.
> 
> Peff (slightly off topic) - A coworker of mine actually ran into this
> problem earlier this week.  Is there recommended way to revert a merged
> topic branch?  I assume it's essentially reverted each commit introduced
> by the branch, but is there a convenient invocation of revert? (easy to 
> remember and hard to screw up)

If you merged the whole topic in at once, then you can use "git revert
-m 1 $merge_commit" to undo the merge. If it came in individual pieces,
then you have to revert each one individually (though if it was a series
of merges, you can in theory revert each merge in reverse order).

-Peff

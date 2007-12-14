From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't use the pager when running "git diff --check"
Date: Thu, 13 Dec 2007 23:51:27 -0500
Message-ID: <20071214045127.GC10169@sigill.intra.peff.net>
References: <1197552751-53480-2-git-send-email-win@wincent.com> <1197575138-58070-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 05:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J32Wd-00008X-8v
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 05:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124AbXLNEv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 23:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbXLNEv3
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 23:51:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2081 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201AbXLNEv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 23:51:29 -0500
Received: (qmail 20021 invoked by uid 111); 14 Dec 2007 04:51:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 13 Dec 2007 23:51:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2007 23:51:27 -0500
Content-Disposition: inline
In-Reply-To: <1197575138-58070-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68220>

On Thu, Dec 13, 2007 at 08:45:38PM +0100, Wincent Colaiuta wrote:

> In 89d07f75 "git diff" learnt to not run the pager if the user passes
> the --exit-code switch. This commit does the same for the --check
> switch for the same reason: we want the user to get the exit status
> from "git diff", not the pager.

But --check is also producing useful output, which might need paged. So
you are sacrificing existing interactive use of --check for scriptable
exit-code uses. If you really want the exit code, why not "git diff
--check --exit-code"?

OTOH, I am not too sad to lose the paging behavior; it would take quite
a few whitespace errors to scroll off the screen.

-Peff

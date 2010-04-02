From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] git status: refresh the index
Date: Fri, 2 Apr 2010 17:21:20 -0400
Message-ID: <20100402212120.GA28352@coredump.intra.peff.net>
References: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
 <1270211241-10795-5-git-send-email-markus.heidelberg@web.de>
 <20100402165759.GB18576@coredump.intra.peff.net>
 <201004022237.04130.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 02 23:21:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxoJ7-0002t2-I0
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 23:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab0DBVVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 17:21:34 -0400
Received: from peff.net ([208.65.91.99]:60698 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546Ab0DBVVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 17:21:32 -0400
Received: (qmail 18297 invoked by uid 107); 2 Apr 2010 21:22:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Apr 2010 17:22:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Apr 2010 17:21:20 -0400
Content-Disposition: inline
In-Reply-To: <201004022237.04130.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143852>

On Fri, Apr 02, 2010 at 09:37:03PM +0100, Markus Heidelberg wrote:

> > Does this mean we will fail to run in a read-only repository?
> 
> You're right.
> But that was already the case when "status" was "commit --dry-run".
> I have to admit, I didn't think about this scenario, but simply looked
> for the differences between these two commands.

Sort of. See ab68545 (status: don't require the repository to be
writable, 2010-01-19), which went onto maint while the "status is no
longer commit --dry-run" topic was cooking elsewhere. So I think it
would be a regression from 1.6.6.2 onwards.

At any rate, I think we all agree on what it _should_ do, so if you're
willing to do an updated patch, that would be great. The patch from
ab68545 may be helpful, as the code it changed is quite similar to what
you posted in this series.

-Peff

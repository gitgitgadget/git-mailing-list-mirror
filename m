From: Jeff King <peff@peff.net>
Subject: Re: Sending patches via gmail
Date: Tue, 1 Apr 2008 07:03:55 -0400
Message-ID: <20080401110355.GA3777@coredump.intra.peff.net>
References: <57518fd10804010249h4fe43bbfu64cf9576ca2edcf3@mail.gmail.com> <402731c90804010309w6a27d2d1t2df25ac41fff96b9@mail.gmail.com> <57518fd10804010351x341ba728i69cfcad8f3909d6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgeIE-00073T-Va
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 13:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbYDALD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 07:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756399AbYDALD6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 07:03:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1919 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755976AbYDALD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 07:03:58 -0400
Received: (qmail 20443 invoked by uid 111); 1 Apr 2008 11:03:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 01 Apr 2008 07:03:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2008 07:03:55 -0400
Content-Disposition: inline
In-Reply-To: <57518fd10804010351x341ba728i69cfcad8f3909d6a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78643>

On Tue, Apr 01, 2008 at 11:51:38AM +0100, Jonathan del Strother wrote:

> ...which seems to work ok, except for the fact that the From line in
> my patch (the output of git format-patch) then appears at the top of
> my message body in the resulting email (from git send-email).
> Deleting the From line from the patch seems to make everything work as
> expected.  Any ideas what's going on there?

send-email will create a "from" line in the body of the message if the
"sender" (using --from, or answering "Who should the emails appear to be
from") doesn't match the patch's author (the "From:" line in the
generated patch, which comes from the author field of the commit).
The line is interpeted by git-am to properly credit the original author.

It looks like you are committing as jon.delStrother@bestbefore.tv,
but sending the emails as maillist@steelskies.com.

-Peff

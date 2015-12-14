From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: add '-d' as shorthand for '--delete'
Date: Mon, 14 Dec 2015 16:18:57 -0500
Message-ID: <20151214211856.GF14788@sigill.intra.peff.net>
References: <1450106584-22313-1-git-send-email-ps@pks.im>
 <1450106584-22313-2-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:19:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aWQ-0007YG-K3
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbbLNVTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:19:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:41525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753498AbbLNVS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:18:59 -0500
Received: (qmail 19184 invoked by uid 102); 14 Dec 2015 21:18:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 15:18:59 -0600
Received: (qmail 31869 invoked by uid 107); 14 Dec 2015 21:19:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 16:19:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 16:18:57 -0500
Content-Disposition: inline
In-Reply-To: <1450106584-22313-2-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282420>

On Mon, Dec 14, 2015 at 04:23:04PM +0100, Patrick Steinhardt wrote:

> It is only possible to delete branches on remotes by specifying
> the long '--delete' flag. The `git-branch` command, which can be
> used to delete local branches with the same '--delete' flag, also
> accepts the shorthand '-d'. This may cause confusion for users
> which are frequently using the shorthand form of deleting local
> branches and subsequently try to use the same shorthand for
> `git-push`, which will fail.
> 
> Fix this usability issue by adding the '-d' shorthand to
> `git-push` and document it.

I think we didn't give it "-d" originally, because we usually avoid
allocating short-options (which are a limited resource) until an option
has proven itself.

At this point, it seems that "--delete" is useful, and nothing else has
been proposed for "-d" in the intervening years. It seems like a
reasonable use of the flag to me.

I have been bitten by this myself. I know about "git push origin
:ref-to-delete", of course, but my brain would much rather type "-d"
(and it's also easier when piping to xargs).

-Peff

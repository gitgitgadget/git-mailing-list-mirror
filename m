From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 14:49:19 -0500
Message-ID: <20071128194919.GC11396@coredump.intra.peff.net>
References: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org> <20071128194159.GA25977@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxSuj-0003Mp-Qc
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 20:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbXK1TtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 14:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbXK1TtW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 14:49:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4133 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbXK1TtV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 14:49:21 -0500
Received: (qmail 13730 invoked by uid 111); 28 Nov 2007 19:49:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 14:49:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 14:49:19 -0500
Content-Disposition: inline
In-Reply-To: <20071128194159.GA25977@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66417>

On Wed, Nov 28, 2007 at 11:41:59AM -0800, Steven Grimm wrote:

> recieve-pack will now send the post-update SHA1 back to send-pack. If
> it's different than the one that was pushed, git-push won't do the
> fake update of the local tracking ref and will instead inform the user
> that the tracking ref needs to be fetched.

Hrm, this is going to have nasty conflicts with 'next', which already
does the remote ref matching. I think the best way to implement this
would probably be on top of the jk/send-pack topic in next, and add a
new REF_STATUS_REMOTE_CHANGED status type.

-Peff

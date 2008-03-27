From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Thu, 27 Mar 2008 03:38:08 -0400
Message-ID: <20080327073808.GA22548@coredump.intra.peff.net>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net> <200803260759.48922.tlikonen@iki.fi> <20080326062029.GA26286@coredump.intra.peff.net> <20080326083033.GA13933@mithlond.arda.local> <20080326083925.GA31475@coredump.intra.peff.net> <20080326092303.GA17835@mithlond.arda.local> <20080326093310.GA937@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Mar 27 08:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JemhI-0000x8-SZ
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 08:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbYC0HiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 03:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbYC0HiL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 03:38:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1588 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbYC0HiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 03:38:10 -0400
Received: (qmail 16118 invoked by uid 111); 27 Mar 2008 07:38:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 03:38:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 03:38:08 -0400
Content-Disposition: inline
In-Reply-To: <20080326093310.GA937@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78341>

On Wed, Mar 26, 2008 at 05:33:10AM -0400, Jeff King wrote:

> No, I have format-patch do the threading. So something like:
> 
>   git format-patch --cover-letter --thread --stdout upstream >mbox
>   mutt -f mbox
> 
> and then in mutt I bind a key to <resend-message>. For each message, I

Since it looks like you are using mutt also, I will warn you that there
is a problem with this workflow: when mutt does the resend, it generates
a new message-id. Thus the patches are all connected in a thread because
they all in-reply-to the cover letter, but the cover letter is not
connected, since it has a new message-id.

I'm not sure if there is a way to fix this short of patching mutt. :(

-Peff

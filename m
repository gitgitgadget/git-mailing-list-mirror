From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add date formatting and parsing functions relative
 to a given time
Date: Sun, 30 Aug 2009 03:36:19 -0400
Message-ID: <20090830073619.GA14217@coredump.intra.peff.net>
References: <20090828210404.GA11867@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 09:39:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhf0a-00057U-In
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 09:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbZH3HgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 03:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbZH3HgV
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 03:36:21 -0400
Received: from peff.net ([208.65.91.99]:57423 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbZH3HgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 03:36:21 -0400
Received: (qmail 16232 invoked by uid 107); 30 Aug 2009 07:36:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 03:36:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 03:36:19 -0400
Content-Disposition: inline
In-Reply-To: <20090828210404.GA11867@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127396>

On Fri, Aug 28, 2009 at 11:04:04PM +0200, Alex Riesen wrote:

> +const char *show_date_relative(unsigned long time, int tz, const struct timeval *now)
> +{
> +	static char timebuf[100 /* TODO: can be optimized */];

This was 200 in the original version. I doubt that it makes a
difference, but I think in a refactoring patch I think it is best to
simply reorganize and make no other changes.

> +static unsigned long approximation(const char *date, const struct timeval *tv)

I know it's static, but this is a terribly undescriptive function name.
Approximation of what?  Can we call it approxidate_internal or
something?

-Peff

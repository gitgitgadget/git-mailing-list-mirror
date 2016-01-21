From: Jeff King <peff@peff.net>
Subject: Re: git-diff: unable to turn off diff.autorefreshindex with command
 line switch
Date: Thu, 21 Jan 2016 16:38:01 -0500
Message-ID: <20160121213801.GB6664@sigill.intra.peff.net>
References: <4432B7DA-921D-4D1C-8DC5-55A4E3722F73@airbladesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Stewart <boss@airbladesoftware.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 22:38:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMMvh-0003F7-Ef
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 22:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbcAUViE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 16:38:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:58170 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752118AbcAUViE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 16:38:04 -0500
Received: (qmail 15755 invoked by uid 102); 21 Jan 2016 21:38:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Jan 2016 16:38:03 -0500
Received: (qmail 25038 invoked by uid 107); 21 Jan 2016 21:38:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Jan 2016 16:38:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jan 2016 16:38:01 -0500
Content-Disposition: inline
In-Reply-To: <4432B7DA-921D-4D1C-8DC5-55A4E3722F73@airbladesoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284531>

On Thu, Jan 21, 2016 at 10:29:49AM +0000, Andrew Stewart wrote:

> # Now the strange behaviour: no output from the next command
> $ git -c diff.autorefreshindex=0 diff --raw -- README

I can't reproduce here (v2.7.0, Linux).

But note that your whole test is going to be racy, and possibly depend
on the resolution of your filesystem's timestamps. Did you run your test
as a single script, where the initial index write and the `touch` may
happen in the same second? If so, trying running it slowly by hand,
or inserting "sleep 1" between the commands.

-Peff

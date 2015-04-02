From: Jeff King <peff@peff.net>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 2 Apr 2015 14:09:15 -0400
Message-ID: <20150402180914.GA19081@peff.net>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: "Reid Woodbury Jr." <reidw@rawsound.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 20:09:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdjYR-0000yb-T1
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 20:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbbDBSJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 14:09:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:41463 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751054AbbDBSJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 14:09:18 -0400
Received: (qmail 8189 invoked by uid 102); 2 Apr 2015 18:09:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 13:09:17 -0500
Received: (qmail 14094 invoked by uid 107); 2 Apr 2015 18:09:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 14:09:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2015 14:09:15 -0400
Content-Disposition: inline
In-Reply-To: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266653>

On Thu, Apr 02, 2015 at 10:18:33AM -0700, Reid Woodbury Jr. wrote:

> After upgrading from GIT 2.3.3 to 2.3.4 (on Mac OS X 10.10.2,
> installed with MacPorts) I received this error message when doing a
> push:
> 
> $ git push
> ssh: Could not resolve hostname xxxx:: nodename nor servname provided, or not known
> fatal: Could not read from remote repository.

It is hard to tell from the obfuscated output, but perhaps the problem
is the two colons (i.e., git is feeding a hostname like "foo:" when it
should be just "foo"). There were some changes in v2.3.4 related to
parsing ssh URLs. +cc Torsten, who worked on that code.

Can you show us your git config (presumably the host is defined in
remote.origin.url in .git/config of the repository)?

-Peff

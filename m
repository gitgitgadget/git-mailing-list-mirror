From: Jeff King <peff@peff.net>
Subject: Re: git diff timing oddity
Date: Thu, 6 May 2010 01:08:36 -0400
Message-ID: <20100506050836.GA11578@coredump.intra.peff.net>
References: <y2j76718491005052204qb6de9c26k58eb1550f1c5346f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 07:08:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9tKG-0007R4-Un
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 07:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab0EFFIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 01:08:40 -0400
Received: from peff.net ([208.65.91.99]:37591 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab0EFFIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 01:08:39 -0400
Received: (qmail 2498 invoked by uid 107); 6 May 2010 05:08:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 May 2010 01:08:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 May 2010 01:08:36 -0400
Content-Disposition: inline
In-Reply-To: <y2j76718491005052204qb6de9c26k58eb1550f1c5346f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146438>

On Thu, May 06, 2010 at 01:04:18AM -0400, Jay Soffian wrote:

> git version 1.7.1, Mac OS X 10.6.3, largish repo (42K files, 35K
> commits, well packed ~ 1GB). Difference between origin and HEAD is a
> single commit.
> 
> $ time git diff --stat origin  >/dev/null
> 
> real	0m0.942s
> user	0m0.713s
> sys	0m0.223s
>
> [...]
>
> $ time git diff --stat origin HEAD >/dev/null
> 
> real	0m0.022s
> user	0m0.006s
> sys	0m0.012s
>
> [...]
> 
> These should be identical commands, so why is the "origin HEAD" form
> running an order of magnitude faster?

Isn't "git diff --stat origin" comparing against the working tree?

-Peff

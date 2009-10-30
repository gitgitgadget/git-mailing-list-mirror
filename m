From: Jeff King <peff@peff.net>
Subject: Re: finding the merge of two or more commits
Date: Fri, 30 Oct 2009 14:04:29 -0400
Message-ID: <20091030180429.GD18583@coredump.intra.peff.net>
References: <3a69fa7c0910291412l439f7f61vd3b55a77cd7e10b5@mail.gmail.com>
 <32541b130910291434q1b068918x38c5aec543cb1c2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: E R <pc88mxer@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:04:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3vq8-00048m-0d
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 19:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbZJ3SEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 14:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbZJ3SEd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 14:04:33 -0400
Received: from peff.net ([208.65.91.99]:45033 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932712AbZJ3SEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 14:04:33 -0400
Received: (qmail 1958 invoked by uid 107); 30 Oct 2009 18:08:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 14:08:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 14:04:29 -0400
Content-Disposition: inline
In-Reply-To: <32541b130910291434q1b068918x38c5aec543cb1c2a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2009 at 05:34:45PM -0400, Avery Pennarun wrote:

> On Thu, Oct 29, 2009 at 5:12 PM, E R <pc88mxer@gmail.com> wrote:
> > That is, I don't want to merge c1 and c2 myself, but I want to know if
> > someone else has merged c1 and c2, performed any conflict resolution
> > and committed the result.
> 
> Try this:
> 
> (git branch -a --contains c1; git branch -a --contains c2) | sort | uniq -d
> 
> It's not exactly pretty, but it works.

That will tell you whether any branch contains both of them, which is
not exactly what the original poster asked for (though it may have been
what he meant :) ). To see if there is a specific merge of those two
commits, you can do:

  git log --all --format='%H %P' | grep " $c1" | grep " $c2" | cut -d' ' -f1

-Peff

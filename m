From: Jeff King <peff@peff.net>
Subject: Re: htb parallelism on multi-core platforms
Date: Thu, 23 Apr 2009 16:09:32 -0400
Message-ID: <20090423200932.GB3056@coredump.intra.peff.net>
References: <20090423184319.GB2756@ami.dom.local> <Pine.LNX.4.64.0904232103390.13488@ask.diku.dk> <20090423191455.GC2756@ami.dom.local> <Pine.LNX.4.64.0904232136040.13796@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jarek Poplawski <jarkao2@gmail.com>,
	Radu Rendec <radu.rendec@ines.ro>,
	Denys Fedoryschenko <denys@visp.net.lb>,
	netdev <netdev@vger.kernel.org>, git@vger.kernel.org
To: Jesper Dangaard Brouer <hawk@diku.dk>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx5GI-0002aW-IE
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 22:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbZDWUJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbZDWUJg
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 16:09:36 -0400
Received: from peff.net ([208.65.91.99]:49324 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbZDWUJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 16:09:35 -0400
Received: (qmail 24670 invoked by uid 107); 23 Apr 2009 20:09:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Apr 2009 16:09:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2009 16:09:32 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0904232136040.13796@ask.diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117378>

On Thu, Apr 23, 2009 at 09:47:05PM +0200, Jesper Dangaard Brouer wrote:

>>> Is there any easy git way to figure out which release this commit got
>>> into?
>>
>> I guess git-describe, but I prefer clicking at the "raw" (X-Git-Tag):
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=f4c1f3e0c59be0e6566d9c00b1d8b204ffb861a2
>
> I think I prefer the command line edition "git-describe".  But it seems  
> that the two approaches gives a different results.
> (Cc'ing the git mailing list as they might know the reason)

You want "git describe --contains". The default mode for describe is
"you are at tag $X, plus $N commits, and by the way, the sha1 is $H"
(shown as "$X-$N-g$H").

The default mode is useful for generating a unique semi-human-readable
version number (e.g., to be included in your builds).

-Peff

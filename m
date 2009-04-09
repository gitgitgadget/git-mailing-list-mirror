From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow setting default diff options via
	diff.defaultOptions
Date: Thu, 9 Apr 2009 04:49:03 -0400
Message-ID: <20090409084903.GA18947@coredump.intra.peff.net>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrpy4-0003pC-NC
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760098AbZDIItI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 04:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760012AbZDIItI
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:49:08 -0400
Received: from peff.net ([208.65.91.99]:43763 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757165AbZDIItG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 04:49:06 -0400
Received: (qmail 15645 invoked by uid 107); 9 Apr 2009 08:49:06 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 09 Apr 2009 04:49:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Apr 2009 04:49:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116154>

On Thu, Apr 09, 2009 at 10:45:40AM +0200, Johannes Schindelin wrote:

> The proper way would be to have options to _undo_ every diff option, I 
> guess, as this would also help aliases in addition to defaultOptions.

I agree with this sentiment, no matter which approach is taken. I am
more like to say "take my usual defaults, but tweak this one thing" than
to say "turn off all of my defaults".

> Now, it is easy to put a patch on top of my patch to support something 
> like --no-defaults.

No, it's not. We went over this in great detail earlier in the thread.
If you want:

  git diff --no-defaults

then you basically have to parse twice to avoid the chicken-and-egg
problem. Which is why I suggested:

  git --no-defaults diff

which does work. Keith's solution does allow "git diff --no-defaults".

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Wed, 29 Apr 2015 00:39:47 -0400
Message-ID: <20150429043947.GA10702@peff.net>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
 <20150428055506.GJ24580@peff.net>
 <CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Olivier ROLAND <cyrus-dev@edla.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 06:39:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnJmt-0007mL-ND
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 06:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbbD2Ejv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 00:39:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:51510 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751546AbbD2Eju (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 00:39:50 -0400
Received: (qmail 9426 invoked by uid 102); 29 Apr 2015 04:39:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 23:39:50 -0500
Received: (qmail 24301 invoked by uid 107); 29 Apr 2015 04:40:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 00:40:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 00:39:47 -0400
Content-Disposition: inline
In-Reply-To: <CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267956>

On Tue, Apr 28, 2015 at 01:02:17PM +0200, Olivier ROLAND wrote:

> Both versions are builded from source.
> head -1 "$(git --exec-path)/git-filter-branch"
> #!/bin/sh
> 
> sh --version
> GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin14)
> Copyright (C) 2007 Free Software Foundation, Inc.
> 
> /bin/bash --version
> GNU bash, version 4.1.5(1)-release (x86_64-pc-linux-gnu)
> 
> The bug seem really git related.

Yes, but I guessed it might be part of the filter-branch shell script
that behaves differently under two different shells (i.e., that we used
some unportable construct). However, I built bash 3.2.57 on my Linux box
and could not replicate the problem.

The other "usual" thing that causes bugs to show up on OS X but not
Linux is case-folding. But you said you are using a case-sensitive
filesystem, so it's probably not that.

So I can't figure out how to replicate the problem here.

-Peff

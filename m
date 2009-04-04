From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to
	be used
Date: Sat, 4 Apr 2009 19:25:05 -0400
Message-ID: <20090404232505.GA26906@coredump.intra.peff.net>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com> <1238864396-8964-2-git-send-email-dpmcgee@gmail.com> <20090404180601.GA14888@coredump.intra.peff.net> <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 01:26:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFGM-000834-RL
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 01:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbZDDXZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 19:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbZDDXZX
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 19:25:23 -0400
Received: from peff.net ([208.65.91.99]:49838 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbZDDXZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 19:25:23 -0400
Received: (qmail 12977 invoked by uid 107); 4 Apr 2009 23:25:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 04 Apr 2009 19:25:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2009 19:25:05 -0400
Content-Disposition: inline
In-Reply-To: <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115602>

On Sat, Apr 04, 2009 at 01:20:18PM -0500, Dan McGee wrote:

> > That makes sense to me, though I wonder if it may confuse and frustrate
> > users who are expecting their awesome quad-core machine to be using 4
> > threads when it only uses 2. Is it worth printing both values, or some
> > indicator that we could have been using more?
> 
> I thought of this, but decided it wasn't really worth it. The default
> window size of 10 makes it a very rare case that you will use fewer
> than 4 threads. With the default, each thread needs a minimum of 20
> objects, so even a 100-object repository would spawn the 4 threads.

Good point. Though by that logic, isn't your patch also not worth it
(i.e., it is unlikely not to fill the threads, so the output will be the
same with or without it)?

I still think yours is an improvement, though, however slight.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] make diff --color-words customizable
Date: Fri, 9 Jan 2009 04:53:00 -0500
Message-ID: <20090109095300.GA4099@coredump.intra.peff.net>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 09 10:54:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLE4S-00035N-Pp
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 10:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbZAIJxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 04:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbZAIJxE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 04:53:04 -0500
Received: from peff.net ([208.65.91.99]:59680 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbZAIJxC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 04:53:02 -0500
Received: (qmail 17745 invoked by uid 107); 9 Jan 2009 09:53:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 04:53:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 04:53:00 -0500
Content-Disposition: inline
In-Reply-To: <1231459505-14395-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104996>

On Fri, Jan 09, 2009 at 01:05:05AM +0100, Thomas Rast wrote:

> Word diff becomes much more useful especially with TeX, where it is
> common to run together \sequences\of\commands\like\this that the
> current --color-words treats as a single word.

I have run into this, as well, and it would be nice to have configurable
word boundaries.

> Apart from possible bugs, the main issue is: where should I put the
> configuration for this?

It's a per-file thing, so probably in the diff driver that is triggered
via attributes. See userdiff.[ch]; you'll need to add an entry to the
userdiff_driver struct. You can look at the funcname pattern stuff as a
template, as this is very similar.

-Peff

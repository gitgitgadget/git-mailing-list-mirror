From: Jeff King <peff@peff.net>
Subject: Re: git-push segfault
Date: Wed, 24 Feb 2010 04:23:57 -0500
Message-ID: <20100224092356.GA28959@coredump.intra.peff.net>
References: <loom.20100224T043557-954@post.gmane.org>
 <20100224063606.GB12796@coredump.intra.peff.net>
 <20100224082214.GA31559@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dale Rowley <ddrowley3@juno.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 10:24:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkDTW-00041s-4V
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 10:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655Ab0BXJYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 04:24:05 -0500
Received: from peff.net ([208.65.91.99]:50659 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755316Ab0BXJYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 04:24:01 -0500
Received: (qmail 31765 invoked by uid 107); 24 Feb 2010 09:24:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 24 Feb 2010 04:24:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2010 04:23:57 -0500
Content-Disposition: inline
In-Reply-To: <20100224082214.GA31559@inner.home.ulmdo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140922>

On Wed, Feb 24, 2010 at 09:22:14AM +0100, Andreas Krey wrote:

> On Wed, 24 Feb 2010 01:36:06 +0000, Jeff King wrote:
> ...
> > #!/bin/sh
> ...
> > git clone parent child &&
> > cd child &&
> 
> How about 'set -xe' instead of all the &&?

I long ago stopped trying to remember all of the places where "-e" works
and where it doesn't, and just use explicit "&&" (or "|| exit 1"). For
example, the subshell in my recipe needs an explicit error check under
dash, but will exit correctly using bash. I seem to recall there are
some other gotchas, but it has been a long time since I looked.

At any rate, this is not even code for inclusion in git. It is "please
cut and paste this and tell me if it breaks". So I am not too worried
about style.

-Peff

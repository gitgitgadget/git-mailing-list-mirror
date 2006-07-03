From: Jeff King <peff@peff.net>
Subject: Re: Compression speed for large files
Date: Mon, 3 Jul 2006 17:45:03 -0400
Message-ID: <20060703214503.GA3897@coredump.intra.peff.net>
References: <loom.20060703T124601-969@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 23:45:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxWEC-0001K5-PW
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWGCVpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWGCVpH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:45:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:51354 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750883AbWGCVpF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 17:45:05 -0400
Received: (qmail 2072 invoked from network); 3 Jul 2006 17:44:42 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Jul 2006 17:44:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon,  3 Jul 2006 17:45:03 -0400
To: Joachim B Haga <cjhaga@fys.uio.no>
Content-Disposition: inline
In-Reply-To: <loom.20060703T124601-969@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23216>

On Mon, Jul 03, 2006 at 11:13:34AM +0000, Joachim B Haga wrote:

> often binary. In git, committing of large files is very slow; I have
> tested with a 45MB file, which takes about 1 minute to check in (on an
> intel core-duo 2GHz).

I know this has already been somewhat solved, but I found your numbers
curiously high. I work quite a bit with git and large files and I
haven't noticed this slowdown. Can you be more specific about your load?
Are you sure it is zlib?

On my 1.8Ghz Athlon, compressing 45MB of zeros into 20K takes about 2s.
Compressing 45MB of random data into a 45MB object takes 6.3s. In either
case, the commit takes only about 0.5s (since cogito stores the object
during the cg-add).

Is there some specific file pattern which is slow to compress? 

-Peff

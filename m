From: Shaun Ruffell <sruffell@digium.com>
Subject: Re: Files that cannot be added to the index
Date: Sat, 27 Aug 2011 13:40:09 -0500
Message-ID: <20110827184009.GA12767@digium.com>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
 <4E57A93A.6090405@drmicha.warpmail.net>
 <20110826205919.GB8107@sooty-2.local>
 <20110826211233.GB3093@digium.com>
 <20110827060718.GA28136@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	seanh <snhmnd@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 27 20:40:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxNnx-0007NH-D1
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 20:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab1H0SkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 14:40:18 -0400
Received: from mail.digium.com ([216.207.245.2]:60022 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039Ab1H0SkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 14:40:17 -0400
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <sruffell@digium.com>)
	id 1QxNnh-0002O4-Tu; Sat, 27 Aug 2011 13:40:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id D7171D82A5;
	Sat, 27 Aug 2011 13:40:13 -0500 (CDT)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TEbTSJPhLn5o; Sat, 27 Aug 2011 13:40:12 -0500 (CDT)
Received: from digium.com (sruffell.digium.internal [10.19.134.249])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 8CDA6D8024;
	Sat, 27 Aug 2011 13:40:12 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20110827060718.GA28136@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180236>

On Sat, Aug 27, 2011 at 02:07:18AM -0400, Jeff King wrote:
> On Fri, Aug 26, 2011 at 04:12:33PM -0500, Shaun Ruffell wrote:
> 
> > On Fri, Aug 26, 2011 at 10:59:19PM +0200, seanh wrote:
> > > I'm using git version 1.7.4.4 on OSX Lion, from macports. (I was
> > > having the problem on Snow Leopard too.)
> > 
> > Not sure if this is your problem exactly but awhile back I ran into
> > something similar to what you describe and tracked it down to the
> > fact that my filesystem was case insensitive. i.e.
> 
> I think both of you may be seeing the same bug I tracked down here:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/173612/focus=174634
> 
> Does the patch from the very end of the thread solve the problem for
> you? I should probably clean it up for inclusion in git.

I was going to apply the patch and see what happens, however when I
built and tested 1.7.6 as a baseline I no longer could reproduce the
issue.

  $ git commit -m "Makefile"
  [master a931b27] Makefile
   1 files changed, 0 insertions(+), 222 deletions(-)
   delete mode 100644 Makefile
   create mode 100644 makefile
  $ git ls-files -m

The previous version I had installed from one of the OSX package
managers (not sure if it was fink or Macports) was 1.6.5.3.

NOTE: I had to compile git from source like "NO_FINK=1 make" in
order to avoid the "ld: warning: in /sw/lib/libiconv.dylib, file is
not of required architecture" error message.

So, in summary, it looks like this is fixed.

Thanks,
Shaun

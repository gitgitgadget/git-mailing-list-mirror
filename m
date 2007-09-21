From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Fri, 21 Sep 2007 05:19:03 -0400
Message-ID: <20070921091902.GA1870@coredump.intra.peff.net>
References: <20070919202615.GK3076@jukie.net> <Pine.LNX.4.64.0709201132381.28395@racer.site> <20070920123849.GD12076@jukie.net> <Pine.LNX.4.64.0709201403540.28395@racer.site> <20070921041821.GA28245@coredump.intra.peff.net> <Pine.LNX.4.64.0709210904210.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 11:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYefK-00049w-Ik
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 11:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbXIUJTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 05:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbXIUJTI
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 05:19:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3260 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbXIUJTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 05:19:07 -0400
Received: (qmail 20140 invoked by uid 111); 21 Sep 2007 09:19:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 21 Sep 2007 05:19:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2007 05:19:03 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709210904210.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58836>

On Fri, Sep 21, 2007 at 10:10:12AM +0100, Johannes Schindelin wrote:

> Indeed, it has a certain elegance to it.  However, I cannot specify any 
> rev-list options with your method, not even "--stat" or 
> "--pretty=format:%H(%s)".

Actually, you can pass --stat, but it erroneously is counted as part of
the message due to a parsing bug in the script. However you are pointing
out a larger issue, which is that the format must be parseable by the
script. As a final step, the script could turn the output into a list of
commits, and pipe them into a git command which pretty-printed in the
desired format.

But that is doubly hack-ish, and slow to boot.

> So while your script is a good interim solution, I'd like to see a 
> generic grep support for this feature.

Yes, I don't seriously propose it for mainline git. However, I quite
like the interface; unfortunately, to get it to work smoothly (and
efficiently!) the perl interpreter would need to be embedded inside
git-log. And I think I know what you will say about that... :)

-Peff

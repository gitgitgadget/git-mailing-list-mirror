From: Jeff King <peff@peff.net>
Subject: Re: Excluding files from git-diff
Date: Sat, 18 Oct 2008 12:14:24 -0400
Message-ID: <20081018161424.GC20185@coredump.intra.peff.net>
References: <20081017145313.GA23471@eriks> <48F8ACC2.1010903@drmicha.warpmail.net> <48F8BDA7.50901@pflanze.mine.nu> <20081018155912.GA20387@coredump.intra.peff.net> <48FA0A17.9050506@pflanze.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Erik Hahn <erik_hahn@gmx.de>, git@vger.kernel.org
To: Christian Jaeger <christian@pflanze.mine.nu>
X-From: git-owner@vger.kernel.org Sat Oct 18 18:15:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrESq-0002vo-LL
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 18:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbYJRQO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 12:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbYJRQO2
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 12:14:28 -0400
Received: from peff.net ([208.65.91.99]:3281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbYJRQO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 12:14:27 -0400
Received: (qmail 2405 invoked by uid 111); 18 Oct 2008 16:14:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 18 Oct 2008 12:14:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Oct 2008 12:14:24 -0400
Content-Disposition: inline
In-Reply-To: <48FA0A17.9050506@pflanze.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98559>

On Sat, Oct 18, 2008 at 06:08:55PM +0200, Christian Jaeger wrote:

> The problem with this is that it won't show files that aren't there  
> anymore but have been previously; in general, for that to work (also with 

Yes, you're right. You really do want to be telling git not "here is the
list of files I care about" but "I really care about anything _except_
this set".

And I don't think that is currently possible, so a patch would be
necessary (and I think is justified, since there is no other way to do
it).

The most flexible thing would be the ability to say "I want these paths
(or all paths), and exclude these paths" (sort of like we already do for
commits). But defining a good command-line syntax for that would
probably be painful, and I really think the only sane use case is "I
want all paths except for these". In which case your "--invert-match"
seems like a good route.

-Peff

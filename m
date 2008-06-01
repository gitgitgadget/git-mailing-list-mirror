From: Jeff King <peff@peff.net>
Subject: Re: unable to push
Date: Sun, 1 Jun 2008 14:31:34 -0400
Message-ID: <20080601183134.GA2623@sigill.intra.peff.net>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm> <20080531155036.GA27397@sigill.intra.peff.net> <alpine.DEB.1.10.0805310855000.15294@asgard.lang.hm> <20080601182205.GA742@sigill.intra.peff.net> <alpine.DEB.1.10.0806011125340.15294@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Jun 01 20:32:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2sM1-0005yH-Ms
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 20:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYFASbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 14:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbYFASbh
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 14:31:37 -0400
Received: from peff.net ([208.65.91.99]:4298 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbYFASbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 14:31:36 -0400
Received: (qmail 722 invoked by uid 111); 1 Jun 2008 18:31:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 01 Jun 2008 14:31:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jun 2008 14:31:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0806011125340.15294@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83460>

On Sun, Jun 01, 2008 at 11:28:39AM -0700, david@lang.hm wrote:

>> I'm not understanding that, either. You not only created localmaster,
>> but you deleted master. Did you maybe do a "git branch -m"?
>
> in the public repo I had never created a 'master' branch. I had just done  
> a clone, setup git daemon, and pushed to it.

Did you mean "init" here instead of clone? The clone should have created
at least one branch (generally master, but depending on the current
branch of the cloned repo).

> at some point several days later I found that my push didn't work and that 
> I wasn't on any branch in the public repo. in reading the man page for git 
> branch I saw the --track option, so I created the localmaster branch to  
> try and get things working.

Ah, ok. That makes sense. The right fix was to just manually specify the
refspec the first time ("git push public master") after which you could
just do "git push public" if you wanted.

-Peff

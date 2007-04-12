From: Jeff King <peff@peff.net>
Subject: Re: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 02:22:00 -0400
Message-ID: <20070412062200.GA31788@coredump.intra.peff.net>
References: <20070412042308.GA22539@coredump.intra.peff.net> <46a038f90704112205g53ab4750s673f449ee40165b4@mail.gmail.com> <20070412052118.GA30459@coredump.intra.peff.net> <46a038f90704112300k3abd66d0nc4372962dbee8616@mail.gmail.com> <46a038f90704112316v4aaa6246s9e07a3af8262b119@mail.gmail.com> <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com> <20070412042308.GA22539@coredump.intra.peff.net> <46a038f90704112205g53ab4750s673f449ee40165b4@mail.gmail.com> <20070412052118.GA30459@coredump.intra.peff.net> <46a038f90704112300k3abd66d0nc4372962dbee8616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 08:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbsh6-0001Ah-J3
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 08:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161561AbXDLGWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 02:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161563AbXDLGWF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 02:22:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2351 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161561AbXDLGWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 02:22:04 -0400
Received: (qmail 6216 invoked from network); 12 Apr 2007 06:22:41 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 12 Apr 2007 06:22:41 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2007 02:22:00 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90704112316v4aaa6246s9e07a3af8262b119@mail.gmail.com> <46a038f90704112300k3abd66d0nc4372962dbee8616@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44327>

On Thu, Apr 12, 2007 at 06:16:20PM +1200, Martin Langhoff wrote:

> And I think I got it sussed out with:
> 
>   git-clone <repo> mydir
>   cd mydir
>   git-push origin origin/v1.9-maint:refs/heads/v1.9-clientname
>   git-checkout --track -b v1.9-clientname origin/v1.9-clientname

OK, I had misunderstood what you wanted. Yes, that should work, though I
think you will need to do a 'git-fetch' between your push and checkout.

> And then git-pull / git-push will "do the right thing". And `git-pull
> origin/v1.9-maint` will trigger a fetch & merge.

Actually, it should be "git-pull origin v1.9-maint". Of course, you've
been fetching origin/v1.9-maint all along when you pull your other
branch, so you can do it without touching the network at all: "git-merge
origin/v1.9-maint".

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: how to clone/checkout branch/tag vesion from GIT repository
Date: Fri, 11 May 2012 13:22:14 -0400
Message-ID: <20120511172214.GC26916@sigill.intra.peff.net>
References: <1336657187852-7546744.post@n2.nabble.com>
 <20120510135605.GA1495@sigill.intra.peff.net>
 <49A2AA38871E7B41841AA7D659D626A62E2098A2@njexch01.imany.com>
 <20120510143911.GB14711@sigill.intra.peff.net>
 <1336740319206-7550370.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Fri May 11 19:22:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SStYI-0003VS-Pk
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 19:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760706Ab2EKRWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 13:22:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40066
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068Ab2EKRWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 13:22:17 -0400
Received: (qmail 13067 invoked by uid 107); 11 May 2012 17:22:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 May 2012 13:22:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2012 13:22:14 -0400
Content-Disposition: inline
In-Reply-To: <1336740319206-7550370.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197682>

On Fri, May 11, 2012 at 05:45:19AM -0700, supadhyay wrote:

> branch - br6-1-0 is already exists on remote. I have my few data which are
> associated on this branch and I want to get that specific data from br6-1-0.
> 
> I did cvs2git and its working fine without any issue. 
> 
> Also I can see the  list of branches when I run "git branch -r"  on my
> GITserver through "git" user. But after did this migration I do clone from
> git to gitolite on the same server (to manage with user functionality). Now,
> after cloning to gitolite if I run "git branch -r" it shows only master.
> 
> I follow belwo step
> 1- cvs 2 git  >> I can see list of branches here 
> 2- git 2 gitolite  >> I can not see any branch except master.

How did you do the clone? A regular "clone" will clone only local
branches of the remote repository (so if B fetches from A, and C fetches
from B, C will not bother with A's branches).

If you are trying to clone the repository to act as a server repository
in gitolite, I think you would want to use "git clone --mirror". This will
omit the working tree (which you should not need for the server end),
and will fetch all branches (exactly mirroring the state of the original
repository).

-Peff

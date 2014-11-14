From: Jeff King <peff@peff.net>
Subject: Re: Question about chapter "3.1 Git Branching - Branches in a
 Nutshell" in git docu
Date: Fri, 14 Nov 2014 10:15:21 -0500
Message-ID: <20141114151521.GA21950@peff.net>
References: <OF6CCD47D8.ABB2F49C-ONC1257D90.004E1845-C1257D90.005084C1@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Axel Magard <axel_magard@de.ibm.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 16:15:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpIau-00083W-JO
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 16:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbaKNPPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 10:15:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:40361 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964875AbaKNPPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 10:15:24 -0500
Received: (qmail 1857 invoked by uid 102); 14 Nov 2014 15:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 09:15:23 -0600
Received: (qmail 12392 invoked by uid 107); 14 Nov 2014 15:15:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Nov 2014 10:15:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2014 10:15:21 -0500
Content-Disposition: inline
In-Reply-To: <OF6CCD47D8.ABB2F49C-ONC1257D90.004E1845-C1257D90.005084C1@de.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 03:39:29PM +0100, Axel Magard wrote:

> Hi folks,
> either I still didn't grasp it or there is a mistake in chapter 3.1 "3.1 
> Git Branching - Branches in a Nutshell" 
> (http://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)
> 
> The last figure on that page shows that branch 'master' and HEAD are 
> pointing to patch 87ab2, branch 'testing' to c2b9e.
>  
> But the output from git log --oneline --decorate --graph --all 
> shows this:
> 
> * c2b9e (HEAD, master) made other changes
> | * 87ab2 (testing) made a change
> |/
> * f30ab add feature #32 - ability to add new formats to the
> * 34ac2 fixed bug #1328 - stack overflow under certain conditions
> * 98ca9 initial commit of my project
> 
> Shouldn't it look like this ?
> 
> * 87ab2 (HEAD, master) made a change
> | * c2b9e (testing) made other changes
> |/
> * f30ab add feature #32 - ability to add new formats to the
> * 34ac2 fixed bug #1328 - stack overflow under certain conditions
> * 98ca9 initial commit of my project

I think that the git-log output is right. In the examples above, it
shows "made a change" on the "testing" branch, and "made other changes"
on the master branch.

But it is the figure directly above it that is wrong. Even if you look
at the other figures, it is clear that 87ab2 is on the "testing" branch.
But in the final diagram, the two are swapped. Looks like somebody has
reported this upstream already:

  https://github.com/progit/progit2/issues/136

-Peff

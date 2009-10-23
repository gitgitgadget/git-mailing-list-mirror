From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Thu, 22 Oct 2009 22:54:36 -0400
Message-ID: <20091023025434.GA29908@sigio.peff.net>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <alpine.LNX.2.00.0910202044150.14365@iabervon.org> <20091021031528.GB18997@atjola.homenet> <200910211005.29053.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 23 04:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1AGA-0003XG-A1
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 04:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbZJWCu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 22:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbZJWCu4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 22:50:56 -0400
Received: from peff.net ([208.65.91.99]:57110 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbZJWCu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 22:50:56 -0400
Received: (qmail 1007 invoked by uid 1000); 23 Oct 2009 02:54:36 -0000
Content-Disposition: inline
In-Reply-To: <200910211005.29053.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131083>

On Wed, Oct 21, 2009 at 10:05:27AM +0200, Thomas Rast wrote:

> What if any combination of fetch and merge always gave you the long
> form?  After all, even if you do have a tracking branch for whatever
> you are merging, that information is probably useless and it would be
> nicer if all of the following resulted in the long form:
> 
> * git fetch git://git.kernel.org/pub/scm/git/git pu
>   git merge FETCH_HEAD
> 
> * git remote add origin git://git.kernel.org/pub/scm/git/git
>   git fetch origin
>   git merge origin/pu
> 
> * git fetch git://git.kernel.org/pub/scm/git/git pu:tmp
>   git merge tmp

Maybe it's just me, but I actually prefer the shorthand names. Five
years from now when I browse the history and see that I merged
remote branch "mike/topic", I'll know exactly what that means: developer
Mike's version of a certain topic branch. But I am not likely to care
about exactly where we were storing developer repos at that time.

But probably that is an artifact of the workflow. The scenario I am
describing above implies a somewhat centralized workflow, where the
shorthand contains all of the interesting information. In a totally
distributed, we-don't-share-anything-except-the-url-namespace setup of
an open source repo, the full URL makes more sense.

So maybe it is something that should be optional.

-Peff

> 
> and so on.
> 
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

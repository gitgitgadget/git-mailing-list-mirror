From: Jeff King <peff@peff.net>
Subject: Re: Find/prune local branches after upstream branch is deleted?
Date: Fri, 19 Apr 2013 13:37:17 -0400
Message-ID: <20130419173717.GA26964@sigill.intra.peff.net>
References: <87ehe64f91.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFFV-0008Cv-Vh
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab3DSRhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:37:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:44175 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218Ab3DSRhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:37:21 -0400
Received: (qmail 9251 invoked by uid 102); 19 Apr 2013 17:37:25 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 12:37:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2013 13:37:17 -0400
Content-Disposition: inline
In-Reply-To: <87ehe64f91.fsf@mcs.anl.gov>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221784>

On Fri, Apr 19, 2013 at 12:11:38PM -0500, Jed Brown wrote:

> Consider this workflow:
> 
> $ git checkout -b my/branch
> hack, commit, ...
> $ git push -u origin my/branch
> 
> The branch gets reviewed, merged, and eventually deleted upstream.  The
> remote tracking branch gets pruned via 'git fetch --prune' or 'git
> remote prune', but that leaves my local branch with an upstream that has
> been deleted.  Is there a good way to discover this so I can prune my
> local branches?
> 
> $ git branch -vv
>   my/branch        6d32ec0 [origin/my/branch] The commit message
> 
> I can script it, but this seems like a pretty common thing.

Try "git branch --merged master" to get a list of branches that have
already been merged.

-Peff

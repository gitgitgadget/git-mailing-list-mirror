From: Jeff King <peff@peff.net>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Thu, 5 May 2011 05:37:52 -0400
Message-ID: <20110505093752.GB29595@sigill.intra.peff.net>
References: <loom.20110505T103708-225@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 11:38:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHv0S-0006Zc-Nn
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 11:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab1EEJhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 05:37:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59355
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545Ab1EEJhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 05:37:54 -0400
Received: (qmail 29497 invoked by uid 107); 5 May 2011 09:39:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 05:39:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 05:37:52 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110505T103708-225@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172824>

On Thu, May 05, 2011 at 08:47:39AM +0000, chris wrote:

> $ git push origin HEAD:newbranch
> error: unable to push to unqualified destination: newbranch
> The destination refspec neither matches an existing ref on the remote nor
> begins with refs/, and we are unable to guess a prefix based on the source ref.
> error: failed to push some refs to 'ssh://example.com/srv/git/project.git'
> 
> This worked previously[1].  Local git version 1.7.5, remote git version 1.7.2.3.
> 
> 1. I recently upgraded locally from 1.7.4.x

I can't replicate here, using this snippet:

  git init --bare parent &&
  git clone parent child &&
  (cd child &&
   echo content >file &&
   git add file &&
   git commit -m one &&
   git push origin HEAD:newbranch
  )

However, you may see that message if you are on a detached head instead
of a branch. Might that be the case here?

-Peff

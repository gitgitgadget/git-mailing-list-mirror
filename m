From: Jeff King <peff@peff.net>
Subject: Re: Working with Git and CVS in a team.
Date: Fri, 13 Jun 2008 12:09:11 -0400
Message-ID: <20080613160911.GB3140@sigill.intra.peff.net>
References: <200806131633.34980.mirko.stocker@hsr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mirko Stocker <mirko.stocker@hsr.ch>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Bqq-0000In-Tv
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 18:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959AbYFMQJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756936AbYFMQJO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 12:09:14 -0400
Received: from peff.net ([208.65.91.99]:4268 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756883AbYFMQJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 12:09:14 -0400
Received: (qmail 3288 invoked by uid 111); 13 Jun 2008 16:09:12 -0000
Received: from lawn-128-61-17-201.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.17.201)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 12:09:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 12:09:11 -0400
Content-Disposition: inline
In-Reply-To: <200806131633.34980.mirko.stocker@hsr.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84894>

On Fri, Jun 13, 2008 at 04:33:34PM +0200, Mirko Stocker wrote:

> 1) I use git-cvsimport to update the repository every night. /git-proj
>    is a "clone --bare" of the /from-cvs repository.
> 
> 2) After the import, I push the changes from CVS to /git-proj using
>    'git push /git-proj origin'.

You could simplify this by just cvsimporting to an 'upstream' branch in
git-proj.

> 3) Then we have the role of a "Merge-Dude" who pulls the changes from
>    /git-proj and uses 'git merge origin/origin' to update his master.
>    If there are any conflicts, he resolves them and pushes everything
>    back to the master at /git-proj.

And then it works the same: he just pulls 'upstream' occasionally,
merges it into your work, and then pushes the result.

-Peff

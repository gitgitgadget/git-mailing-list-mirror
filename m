From: Jeff King <peff@peff.net>
Subject: Re: pull/push inconsistencies
Date: Wed, 16 May 2007 08:02:37 -0400
Message-ID: <20070516120237.GA11852@coredump.intra.peff.net>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com> <7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 14:02:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoIDN-0002ZM-OB
	for gcvg-git@gmane.org; Wed, 16 May 2007 14:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbXEPMCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 08:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758770AbXEPMCk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 08:02:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3324 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756374AbXEPMCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 08:02:39 -0400
Received: (qmail 15383 invoked from network); 16 May 2007 12:02:39 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 May 2007 12:02:39 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2007 08:02:37 -0400
Content-Disposition: inline
In-Reply-To: <7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47437>

On Tue, May 15, 2007 at 05:24:28PM -0700, Junio C Hamano wrote:

> > My second issue is that git-push does not update
> > remotes/<repo>/<headname> so if I do git-push && gitk --all it looks
> > as if I haven't pushed. Misleading again. :-/
> 
> The standard answer is not to push into a live repository
> without understanding what you are doing.

My impression here is that Martin is saying that pushing does not update
the remote tracking branch in the local repository (as, e.g., cogito has
always done). But I thought somebody (Ted?) recently submitted a patch
to change that.

> git-push without parameters and configuration pushes matching
> branches.  This has been true from day one.  Again, I think we
> should be able to make this safer so that "git-push" in cloned
> repository would do something more restricted (perhaps limiting
> to refs/heads?), but I do not think of a universally acceptable
> canned configuration.

I had done a patch in that direction (actually, it just avoided pushing
refs/remotes/) and have been planning to follow up with restricting
git-push to just refs/heads/. I'll try to work on that in the next day
or so.

-Peff

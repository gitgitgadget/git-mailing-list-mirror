From: Jeff King <peff@peff.net>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Tue, 12 Jan 2010 11:23:55 -0500
Message-ID: <20100112162355.GB25092@coredump.intra.peff.net>
References: <loom.20100111T185144-655@post.gmane.org>
 <7v7hrojukz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gareth Adams <gareth.adams@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 17:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUjXP-0003iZ-2F
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 17:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab0ALQYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 11:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169Ab0ALQYG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 11:24:06 -0500
Received: from peff.net ([208.65.91.99]:33233 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008Ab0ALQYF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 11:24:05 -0500
Received: (qmail 8354 invoked by uid 107); 12 Jan 2010 16:28:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 11:28:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 11:23:55 -0500
Content-Disposition: inline
In-Reply-To: <7v7hrojukz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136736>

On Mon, Jan 11, 2010 at 11:43:40AM -0800, Junio C Hamano wrote:

> The code indeed knows (as you can see "git pull" can figure it out) what
> other ref the current branch is configured to merge with by default.
> There is even a plumbing to do this for script writers.
> 
>     $ git for-each-ref --format='%(upstream)' $(git symbolic-ref HEAD)
> 
> We can teach this short-hand to "git merge", perhaps:
> 
>     $ git merge --default
> 
> But "no argument" cannot be the short-hand, because...

Hmm. If we had the oft-discussed-but-never-agreed-upon shorthand for
"the upstream of" then we wouldn't need a special merge option. You
could just do:

  git merge %HEAD ;# (or git merge %, IIRC the proposal correctly)

-Peff

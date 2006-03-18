From: Jeff King <peff@peff.net>
Subject: Re: First dumb question to the list :)
Date: Fri, 17 Mar 2006 23:25:37 -0500
Message-ID: <20060318042537.GA32348@coredump.intra.peff.net>
References: <4d8e3fd30603160949l655c4f9blb1e202eaf22fbfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 18 05:25:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKT0c-0002VF-7Q
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 05:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWCREZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 23:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWCREZl
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 23:25:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:28377 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1750998AbWCREZl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 23:25:41 -0500
Received: (qmail 10574 invoked from network); 18 Mar 2006 04:25:37 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 18 Mar 2006 04:25:37 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2006 23:25:37 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4d8e3fd30603160949l655c4f9blb1e202eaf22fbfe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17683>

On Thu, Mar 16, 2006 at 06:49:16PM +0100, Paolo Ciarrocchi wrote:

> performed a simple cg-clone git://URItoLinus2.6 linux2.6
> [...]
> What I want to do is to simply keep my repository aligned with Linus
> so I simply have to do:
> cd linus2.6
> cg-fetch
> [...]
> How can I confg git in order to, by default,  use git instead of rsync ?

It should use the git protocol by default; cg-clone will make an
'origin' branch (cogito doesn't support .git/remotes/ yet) pointing to
the original source. Future 'cg-fetch' invocations default to the origin
branch.

Try using 'cg-branch-ls' to see what's on your origin branch.

> Now my dumb question is... since I want to build that kernel do I have
> to locally clone/copy it in order to don't modify any file on my local
> tree?
> If I don't do so, I guess git/cogito will not be happy when I run
> cg-fetch, right?

cg-fetch just pulls Linus' changes to your 'origin' head. You will then
have to cg-merge the changes into your branch. You can do both at once
with cg-update. If there are conflits, then cogito will notify you.

-Peff

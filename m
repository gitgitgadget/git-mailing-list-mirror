From: Jeff King <peff@peff.net>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 11:51:42 -0400
Message-ID: <20071025155142.GB19655@coredump.intra.peff.net>
References: <86oden6z97.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 17:52:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il502-0004kR-3Z
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 17:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759645AbXJYPvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758649AbXJYPvp
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 11:51:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4574 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758181AbXJYPvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 11:51:44 -0400
Received: (qmail 21885 invoked by uid 111); 25 Oct 2007 15:51:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 25 Oct 2007 11:51:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2007 11:51:42 -0400
Content-Disposition: inline
In-Reply-To: <86oden6z97.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62326>

On Thu, Oct 25, 2007 at 07:32:36AM -0700, Randal L. Schwartz wrote:

> I have echo "ref: refs/remotes/origin/master" >.git/refs/heads/upstream
> so that my daily update script can go:
> 
>    git-fetch
>    if [ repo is on master, and is not dirty ];
>       git-merge upstream
>    fi
> 
> Yesterday that worked.
> 
> Today I get a rash of:
> 
>   fatal: Couldn't find remote ref refs/remotes/origin/master
> 
> from my git-fetch.

Works fine here (meaning I can examine 'upstream' as I would any other
branch, and it points to the same place as origin/master).

Why is git-fetch touching your upstream branch at all? Do you have
something in your .git/config instructing it to do so? Or do you mean
that the 'git-merge upstream' command is failing? Can you 'git-show
upstream'? If not, can you 'git-show origin/master'?

-Peff

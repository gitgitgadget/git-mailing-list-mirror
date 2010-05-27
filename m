From: Jeff King <peff@peff.net>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 11:15:14 -0400
Message-ID: <20100527151514.GB18590@coredump.intra.peff.net>
References: <4BFE750B.5030007@llaisdy.com>
 <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com>
 <4BFE83A7.4020604@llaisdy.com>
 <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com>
 <4BFE8A99.5060906@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 17:15:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHeo1-0004Hd-Ho
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096Ab0E0PPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:15:20 -0400
Received: from peff.net ([208.65.91.99]:40413 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab0E0PPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:15:17 -0400
Received: (qmail 22759 invoked by uid 107); 27 May 2010 15:15:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 May 2010 11:15:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 May 2010 11:15:14 -0400
Content-Disposition: inline
In-Reply-To: <4BFE8A99.5060906@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147871>

On Thu, May 27, 2010 at 04:07:05PM +0100, Ivan Uemlianin wrote:

> >It looks like there's something wrong with your installation of Git.
> >Perhaps you'd like to re-install
> The error is like this:
> 
>     $ /opt/libexec/git-core/git-pull
>     /opt/libexec/git-core/git-pull: line 11: git-sh-setup: No such
> file or directory
> 
> I'm calling git-pull from my clone of the repos, so I don't have
> git-sh-setup in my current directory.  That all seems fine: I imagine
> git-pull is not intended to be called directly.

It's not. It expects the git wrapper to have set up the PATH to have
/opt/libexec/git-core in it, which would then find git-sh-setup.

What happens if you run "git pull"? If you get an error, can you try to
run "GIT_TRACE=1 git pull"? Git should then print out exactly what it is
trying to exec that is failing.

-Peff

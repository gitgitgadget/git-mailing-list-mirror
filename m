From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git-pull can't be used without URL - Has worked before
Date: Fri, 16 Mar 2007 23:48:42 +0100
Message-ID: <20070316224842.GA20775@moooo.ath.cx>
References: <6bb9c1030703160324u17d49b85s754ac8358f633bde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pelle Svensson <pelle2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 23:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSLE9-0005XD-2S
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 23:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992445AbXCPWsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 18:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992448AbXCPWsq
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 18:48:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:48012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992445AbXCPWsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 18:48:45 -0400
Received: (qmail invoked by alias); 16 Mar 2007 22:48:44 -0000
X-Provags-ID: V01U2FsdGVkX1/K6WVRG77KlY04kLGJVAvJ43u0GanfxKGrppBM/D
	51FaM6OERkjeQh
Mail-Followup-To: Pelle Svensson <pelle2004@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <6bb9c1030703160324u17d49b85s754ac8358f633bde@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42403>

Pelle Svensson <pelle2004@gmail.com> wrote:
> Did a setup of a new git-kernel, but this time git-pull can't be used 
> without
> full URL. What should I do.

git pull [<remote>] uses the first branch of 'remote' if there is no
special branch.name.{merge,remote} configuration.  But git clone will
setup remote.origin.fetch = +refs/heads/*:refs/remotes/origin/* which
uses wildcards and isn't used as 'first branch'.  You can add another
remote.origin.fetch line before this one in .git/config with

    fetch = +refs/heads/master:refs/remotes/origin/master

which worked for me.

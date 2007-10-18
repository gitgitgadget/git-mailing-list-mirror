From: Mike Galbraith <efault@gmx.de>
Subject: Re: pulling Already up-to-date linux-2.6 repo takes ~8 minutes?
Date: Thu, 18 Oct 2007 07:09:10 +0200
Message-ID: <1192684150.7390.15.camel@Homer.simpson.net>
References: <1192678865.20353.14.camel@Homer.simpson.net>
	 <20071018045001.GA14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNdO-0002HD-8F
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbXJRFJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbXJRFJO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:09:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:43527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751157AbXJRFJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:09:13 -0400
Received: (qmail invoked by alias); 18 Oct 2007 05:09:11 -0000
Received: from p54B5BA2B.dip0.t-ipconnect.de (EHLO [192.168.178.23]) [84.181.186.43]
  by mail.gmx.net (mp034) with SMTP; 18 Oct 2007 07:09:11 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1+CbspzAlKCuoc71o4SBAiF4d39dVQSO7b8xhQOne
	bmq1VyizNcAV01
In-Reply-To: <20071018045001.GA14735@spearce.org>
X-Mailer: Evolution 2.8.2 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61475>

On Thu, 2007-10-18 at 00:50 -0400, Shawn O. Pearce wrote:

> The problem here is you aren't on a branch, you are on a detached
> HEAD.  So we must have setup the wrong thing in .git/FETCH_HEAD
> and we didn't actually merge.

Aha.  (I didn't setup anything that I can recall, followed a howto I
found)

> What version of git is this, exactly (`git version`)?

git version 1.5.3.4.203.gcc61a

> I'd suggest making your life a little bit easier.  Consider creating
> a remote that points to Linus:
> 
>   $ git remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>   $ git checkout -b master   ; # or any other branch
>   $ git config branch.master.remote linus
>   $ git config branch.master.merge refs/heads/master
> 
> Now you can update from Linus with just:
> 
>   $ git pull
> 
> Provided you are on branch "master", or whatever other branches
> you setup those branch.*.remote and branch.*.merge configuration
> options for.

Thanks, I appreciate it, kernel.org likely does too.

	-Mike

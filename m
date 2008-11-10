From: Johan Herland <johan@herland.net>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 22:51:36 +0100
Message-ID: <200811102251.37044.johan@herland.net>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com>
 <200811102101.15285.johan@herland.net>
 <20081110203437.GW24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 22:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzehI-0005z3-Gh
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 22:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYKJVwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 16:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYKJVwI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 16:52:08 -0500
Received: from smtp.getmail.no ([84.208.20.33]:54486 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbYKJVwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 16:52:07 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KA50072Z0QSLW00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 10 Nov 2008 22:52:04 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KA500J3H0Q18J00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 10 Nov 2008 22:51:37 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KA50001P0Q16Y60@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 10 Nov 2008 22:51:37 +0100 (CET)
In-reply-to: <20081110203437.GW24201@genesis.frugalware.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100581>

On Monday 10 November 2008, Miklos Vajna wrote:
> On Mon, Nov 10, 2008 at 09:01:15PM +0100, Johan Herland 
<johan@herland.net> wrote:
> > Does it make sense to teach "git rebase" the -x option from "git
> > cherry-pick"? As with "git cherry-pick -x" it only makes sense to use
> > it if your rebasing from a public branch.
>
> But rebasing a public branch is always something we try to prevent. So
> basically -x would be useful only in case the user does what we asked
> not to do. ;-)

Sorry, I wasn't clear enough: I am talking about a copy-rebase, that is, the 
original public branch is unchanged, but you copy patches from it by making 
a local temporary branch that starts out in the same place and then 
rebasing it onto the other public branch where your want the patches to end 
up (followed by fast-forwarding the target branch and removing the temp 
branch). This is basically identical to cherry-picking a range of commits, 
but since "git cherry-pick" does not support cherry-picking a range of 
commits, this is the only alternative, AFAICS.

However, it would probably be a better solution to make "git cherry-pick" 
work on a commit range... (cf. the ongoing "multiple-commit cherry-pick" 
thread)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

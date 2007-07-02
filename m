From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fetch will leave a ref pointing to a tag
Date: Mon, 2 Jul 2007 22:14:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707022207420.4071@racer.site>
References: <20070702194437.19202.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Jul 02 23:14:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5TDn-0003ko-W5
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbXGBVOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755454AbXGBVOI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:14:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:55349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755445AbXGBVOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 17:14:06 -0400
Received: (qmail invoked by alias); 02 Jul 2007 21:14:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 02 Jul 2007 23:14:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jSmx6KxijfkYcB4Hiy52sWtBNIURHcKBlBjD92N
	j4fLSPDHTG8u/d
X-X-Sender: gene099@racer.site
In-Reply-To: <20070702194437.19202.qmail@science.horizon.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51406>

Hi,

On Mon, 2 Jul 2007, linux@horizon.com wrote:

> $ git branch temp tags/v2.6.22-rc6
> $ git fetch . tags/v2.6.22-rc7:temp

Why not do 'git branch temp v2.6.22-rc7' to begin with? Or even better: 
git checkout -b temp v2.6.22-rc7.

But in any case, you should know that there is no floating tag in git, and 
therefore, by storing it in the "branch" temp, you doom that branch to 
not be able to be committed to.

What you should have done, of course, is

$ git checkout temp
$ git merge v2.6.22-rc7

> $ git checkout temp
> $ (make minor change)
> $ git commit -a
> fatal: 087ea061253277de2b27e82d8572a386835a1b7e is not a valid 'commit' object
> 
> git-fetch does odd things when handed a tag rather than a commit.

No. It is perfectly sane to fetch a tag, and to store it.

> Also, should "git checkout" have complained?

Maybe. Dunno.

Ciao,
Dscho

From: Mike Galbraith <efault@gmx.de>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 12:55:03 +0200
Message-ID: <1208861703.18689.2.camel@marge.simson.net>
References: <1208857733.4695.37.camel@marge.simson.net>
	 <20080422103458.GA14751@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:56:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoGAY-00059w-H5
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbYDVKzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756765AbYDVKzI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:55:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:54340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755084AbYDVKzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:55:07 -0400
Received: (qmail invoked by alias); 22 Apr 2008 10:55:04 -0000
Received: from p54B5AFAD.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [84.181.175.173]
  by mail.gmx.net (mp049) with SMTP; 22 Apr 2008 12:55:04 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1+d+Hlch6GdbB0nzGflrnYigsy/9+mqRe9doRZb++
	Tk+u93U0Kkw8n1
In-Reply-To: <20080422103458.GA14751@sigio.intra.peff.net>
X-Mailer: Evolution 2.12.0 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80098>


On Tue, 2008-04-22 at 06:34 -0400, Jeff King wrote:
> On Tue, Apr 22, 2008 at 11:48:53AM +0200, Mike Galbraith wrote:
> 
> > marge:..git/linux-2.6 # git remote update
> > Updating origin
> > Updating linux-next
> > Updating stable
> > Updating x86
> > >From git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86
> >  ! [rejected]        latest     -> x86/latest  (non fast forward)
> >  ! [rejected]        master     -> x86/master  (non fast forward)
> >  ! [rejected]        testing    -> x86/testing  (non fast forward)
> 
> The x86 tree was presumably rewound or rebased, which means that
> fetching their new position would overwrite your old. This is probably
> OK, since it looks like you have x86/* as tracking branches, and only
> they would get overwritten. So it is probably safe to put a '+' in front
> of the 'fetch' line in your config file. E.g.,
> 
>   [remote "x86"]
>     url = ...
>     fetch = +refs/heads/*:refs/remotes/x86/*
> 
> See 'git help fetch' for details.

Thanks a bunch.  I'll try it.  I notice that origin and linux-next
already had + prefix.  Presumably that came from the home repo.

	-Mike

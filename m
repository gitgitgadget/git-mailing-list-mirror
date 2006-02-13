From: Andrew Morton <akpm@osdl.org>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 01:51:46 -0800
Message-ID: <20060213015146.26e6c09d.akpm@osdl.org>
References: <20060213002502.5c23122c.akpm@osdl.org>
	<7virrj1v44.fsf@assigned-by-dhcp.cox.net>
	<20060213013205.4ba47836.akpm@osdl.org>
	<20060213093938.GC11053@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 10:52:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8aNy-0002ck-6t
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 10:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWBMJwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 04:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWBMJwn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 04:52:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751684AbWBMJwm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 04:52:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1D9qZDZ021918
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Feb 2006 01:52:36 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1D9qZ7H011952;
	Mon, 13 Feb 2006 01:52:35 -0800
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060213093938.GC11053@mythryan2.michonline.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16060>

Ryan Anderson <ryan@michonline.com> wrote:
>
> On Mon, Feb 13, 2006 at 01:32:05AM -0800, Andrew Morton wrote:
> > Junio C Hamano <junkio@cox.net> wrote:
> > >
> > > As humans, we can tell that it is not very plausible that the
> > >  EXTRAVERSION change caused whatever breakage you are chasing,
> > >  but sorry, from your log, I think bisect is doing the right
> > >  thing.
> > 
> > I don't think humans are well-suited to using git.
> > 
> > My current theory is that I was bisecting Linus's tree all along.
> > 
> > What is the correct way in which to switch to git-netdev-all in preparation
> > for performing the bisection?
> 
> First, use "git branch" to show you what branches exist, the * will mark
> the current one.
> 
> Then "git checkout $branch" to switch to one that exists, or "git
> checkout -b $newbranch $sourcebranch" to create a new branch starting
> from $sourcebranch (which can also be a random commit/tag/etc).
> 

Yeah, am (ret)trying that.

Assuming I find the bad commit, how do I extract it as a patch?

I tried

git-format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20 git-netdev-all

and that chewed 10 minutes CPU time and produced no output, so I killed it.

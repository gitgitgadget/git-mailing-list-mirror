From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 15:38:08 +0100
Message-ID: <81b0412b0512220638j382252b5l24e1c6b261165bd6@mail.gmail.com>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	 <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0512220211o74f7f533j11b8e48311b61ec2@mail.gmail.com>
	 <Pine.LNX.4.63.0512221227190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 15:38:20 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpRaA-0006iq-5o
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 15:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbVLVOiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 09:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbVLVOiL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 09:38:11 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:58917 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965169AbVLVOiJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 09:38:09 -0500
Received: by nproxy.gmail.com with SMTP id x29so133859nfb
        for <git@vger.kernel.org>; Thu, 22 Dec 2005 06:38:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LXeWQU+hjYHnsnayI2b1wNiDY1ocgWwnpXl/xPL1VjV6cX6+7hRtDnsR9aKFVbn4ZAHUF/R7/JofDWV6w4N4A4VlIkOVU5JXyM+QhoskQE5INpve4cSy0svo9nrSHxfcs91QdZNLI8z90AIbG27aYWfEEeD1RVZNbFhDPs/936c=
Received: by 10.48.247.14 with SMTP id u14mr91448nfh;
        Thu, 22 Dec 2005 06:38:08 -0800 (PST)
Received: by 10.48.247.10 with HTTP; Thu, 22 Dec 2005 06:38:08 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512221227190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13948>

On 12/22/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > >
> > > > >     [core]
> > > > >             umask = 0002
> > > So, I tend to say: use core.umask only in shared setups (in which you
> > > should not checkout files unless you know exactly what you are doing).
> >
> > May be "shell.umask" or "shared.umask" ?
>
> What would shell.umask do? Be set only when git-shell is called? Then you
> better have the policy to access that particular repository *only* via
> git-shell. Voila, it is the same effect as of core.umask.

I mean it to be set only when git-shell called, but with explicit semantics
("for git-shell only").

> What would shared.umask do? Be set only when writing to GIT_DIR? This is a
> major task, since you have to find out which writes are to the working
> directory, which ones go to GIT_DIR.

shared.mask = shell.mask. Just a name to express what it is for

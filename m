From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 16:14:24 +0100
Message-ID: <81b0412b0512220714w7fb1d9c2j95bbe620fd88cf95@mail.gmail.com>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	 <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0512220211o74f7f533j11b8e48311b61ec2@mail.gmail.com>
	 <Pine.LNX.4.63.0512221227190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0512220638j382252b5l24e1c6b261165bd6@mail.gmail.com>
	 <Pine.LNX.4.63.0512221603490.18668@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 16:14:35 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpS9E-0003FJ-AT
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 16:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVLVPO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 10:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVLVPO0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 10:14:26 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:32496 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751083AbVLVPOZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 10:14:25 -0500
Received: by nproxy.gmail.com with SMTP id x29so137007nfb
        for <git@vger.kernel.org>; Thu, 22 Dec 2005 07:14:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h1h9s4npqXTlxC+6Gkb05nWfJlAYECHMZGSLB0GG5FkQ7lDEmz+aRPaWIPD9AVkq8MtDl3ko4sWlAAHQkKhb2p6r5gdQ96AUlYgIlV7reDjTgfVfnDaTnrfIEUlekGljZv9/Aj2HNsgZuHZZvgG28sUyU0P7o3O+SQNFbqy7Jl0=
Received: by 10.48.246.4 with SMTP id t4mr94351nfh;
        Thu, 22 Dec 2005 07:14:24 -0800 (PST)
Received: by 10.48.247.10 with HTTP; Thu, 22 Dec 2005 07:14:24 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512221603490.18668@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13950>

On 12/22/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > What would shell.umask do? Be set only when git-shell is called? Then you
> > > better have the policy to access that particular repository *only* via
> > > git-shell. Voila, it is the same effect as of core.umask.
> >
> > I mean it to be set only when git-shell called, but with explicit semantics
> > ("for git-shell only").
>
> But if somebody writes to the same repository with another umask, say
> 0022, you have problems. Example:
>
> - I push -- via ssh/bash -- to the repository. The ref refs/heads/bruchpilot
>   is updated (mode: 0644).
>
> - My colleague pushes -- via ssh/git-shell -- to the repository. When she
>   tries to write refs/heads/bruchpilot, it fails, even if she set the
>   correct umask.
>
> See what I mean? It makes no sense to allow different umasks on the
> repository.

Does it make sense to allow different access methods to a shared repository?

> > > What would shared.umask do? Be set only when writing to GIT_DIR? This is a
> > > major task, since you have to find out which writes are to the working
> > > directory, which ones go to GIT_DIR.
> >
> > shared.mask = shell.mask. Just a name to express what it is for
>
> You do mean different umasks for different access methods, don't you? See
> above why I don't think that makes sense.

No, just different names for the same access method.

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Improve handling of "." and ".." in git-diff-*
Date: Tue, 23 Aug 2005 21:54:55 +0200
Message-ID: <81b0412b05082312542bd1ecc@mail.gmail.com>
References: <Pine.LNX.4.58.0508162037080.3553@g5.osdl.org>
	 <81b0412b050823124938d735bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 21:56:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7erO-0002xP-Bl
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 21:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVHWTy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 15:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVHWTy7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 15:54:59 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:27085 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932355AbVHWTy6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 15:54:58 -0400
Received: by nproxy.gmail.com with SMTP id x37so381576nfc
        for <git@vger.kernel.org>; Tue, 23 Aug 2005 12:54:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e1zykqycQLvG8x+dJin/6AzfUi2hNb52qcvT/dcrKYUORIS3L1Ym8fGKwyRV4emP/MNcI+l0oS9b+TTnE2Si5QlIDv9aioeLaFYxHvMAcyuYT/BfZD2gpcBfrLBcA7bB2fupBeYBUVejK/BS4heib5ubaWN86HXG2m60Vy8KSe0=
Received: by 10.48.30.20 with SMTP id d20mr248810nfd;
        Tue, 23 Aug 2005 12:54:55 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Tue, 23 Aug 2005 12:54:55 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <81b0412b050823124938d735bf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7665>

On 8/23/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 8/17/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > NOTE! This does _not_ handle ".." or "." in the _middle_ of a pathspec. If
> > you have people who do
> 
> BTW, could this (below) be useful for something?
> 

Well, a bit of explanation is certainly missing, sorry. The code tries
to emulate
(on purely text level)  the behaviour of chdir(2), including stopping at root,
going back and forth and removing useless (not changing directory)
parts like "/./".

The file in the previous message can be tested with :

  gcc -DCHECK_PATHEXPAND patchexpand.c && ./aout

Cheers,
Alex Riesen.

PS: Before anyone asked: the code is mine and free for any use.

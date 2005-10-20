From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cg-fetch will now retrieve commits related to tags if missing.
Date: Thu, 20 Oct 2005 17:59:50 +1300
Message-ID: <46a038f90510192159h25aad025kf377e3e33b5d30d@mail.gmail.com>
References: <1129769745158-git-send-email-martin@catalyst.net.nz>
	 <7voe5lvv1q.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90510192118s31c52fe7m73d88a9779653f4c@mail.gmail.com>
	 <7virvsu79c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 07:01:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESSX7-0006TA-Pc
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 07:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbVJTE7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 00:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbVJTE7w
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 00:59:52 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:11830 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751745AbVJTE7w convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 00:59:52 -0400
Received: by qproxy.gmail.com with SMTP id v40so253747qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 21:59:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SZVouEf98aS7tHpSiFvvF55OYb4T6dOi6Ko5jeNdvzy56dAXcxVICdkyvl5V7UTnThkG8kJrnCl5Xa0oG8GnCmQ2B9SQKFxg4fHuHXYHkCtWXFT6dzb0dPn99zH9f6yrpArPMwjh016rMzOzxCH+iiw4kUeMzFtZrAVUJJe1Dwk=
Received: by 10.64.210.13 with SMTP id i13mr1195907qbg;
        Wed, 19 Oct 2005 21:59:50 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 21:59:50 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virvsu79c.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10347>

On 10/20/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
> >>         GIT_DIR=../.. git-rev-parse --verify "$tagid^0" >/dev/null 2>&1 && continue
> >
> > Note however that git-rev-parse is lazy and won't check that the
> > commit is there. I have to call git-cat-file and check whether it
> > succeeds to know if we have the object.
>
> Are you sure?
>
> What "rev^0" does is:

Ok -- I was using ^{commit} which _is_ lazy, but you are right, ^0 isn't lazy.

> BTW, I just got a SEGV while pulling Cogito repository over
> git-fetch-pack after interrupting rsync transfer (I wanted to
> switch to git transfer).  I am running with Johaness patch from
> today so the cause may be different from yours, but now I have
> something to look at, which is better than before.
>
> Fetching with rsync (and interrupting in the middle) is a good
> way to simulate a broken repository ;-).

Cool. That's something for you to play with I guess, to tell you the
truth, I'm not useful with gdb ;)

martin

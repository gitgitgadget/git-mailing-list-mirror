From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: 'upstream' branches.
Date: Mon, 7 May 2007 10:39:56 +0200
Message-ID: <81b0412b0705070139v49f045d2j3929b38846e20120@mail.gmail.com>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	 <20070505174416.GA2898@steel.home>
	 <1178387429.17680.35.camel@shinybook.infradead.org>
	 <20070505225249.GE2898@steel.home>
	 <7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
	 <1178436926.17680.74.camel@shinybook.infradead.org>
	 <7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
	 <20070506092129.GA2434@steel.home>
	 <7vtzup6pzl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David Woodhouse" <dwmw2@infradead.org>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 10:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkylK-000634-3x
	for gcvg-git@gmane.org; Mon, 07 May 2007 10:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbXEGIj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 04:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbXEGIj5
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 04:39:57 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:17774 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbXEGIj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 04:39:57 -0400
Received: by an-out-0708.google.com with SMTP id d18so122744and
        for <git@vger.kernel.org>; Mon, 07 May 2007 01:39:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JjXaO4LyvF0k6WFivN+5jxToNiJplagWhy5KHXDHMY7rpSBZvNrvhU8eRJwGeKWq/1/RHKt8R7amgGMItqZfg5gEQsAWqFMut2bPa0WN1XX8eABzHScFAknxaqaU2BHUCyP/U6/rYvNOGC6lB9nO/AYW42scHgqHimiYqvtjqmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SDw6D2D54ybbvHCfpu/3hZ32vSKgzxxyr0nmTnR6aXYYxhUqa6blG5wmggC54bVyxet2df9wzdlAMsqvHAR3FoHqIHy289FVNZGkW2DUTEvYyDsH6U6PZEOeuma1thotzab1NzaHqEumhc9LL2EDlf2RKdA+YPlMKOOVBUkwAO8=
Received: by 10.100.40.17 with SMTP id n17mr4606479ann.1178527196370;
        Mon, 07 May 2007 01:39:56 -0700 (PDT)
Received: by 10.100.202.10 with HTTP; Mon, 7 May 2007 01:39:56 -0700 (PDT)
In-Reply-To: <7vtzup6pzl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46433>

On 5/7/07, Junio C Hamano <junkio@cox.net> wrote:
> >
> > Maybe we should not fail in the case the remote repo is older then
> > local, but just to try to fast-forward local reference after a fetch
> > and fail only if the fast-forward fails?
...
>
> Something like this untested patch should be sufficient if we
> want to go this route, but I am not convinced yet that this is
> the right thing to do.  ...

Now, after I thought about that a bit more (and after your explanation
about David being silly), I think I was kind of silly as well.

The idea looks a bit dangerous (because of the local and remote
can divert from each other). If any, the reference mapping
syntax should clearly reveal that, more like

    "TRY-FAST-FORWARD-MERGE ref1:ref2"

instead of that hideous minus. And come to think about that, I'd still
prefer to do that manually, as a real merge (I cannot know in advance
_when_ the repos divert, and which one of source repos will divert,
to entrust the operation an unattended process, and I have get-fetch
in cron files sometimes), so count me out as a user of that feature.

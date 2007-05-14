From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Suggestions for cgit (was: Re: suggestions for gitweb)
Date: Mon, 14 May 2007 10:50:04 +0200
Message-ID: <8c5c35580705140150i85ef898h6ac0475ab12f8a03@mail.gmail.com>
References: <20070512205529.GS14859@MichaelsNB> <f25mic$1b1$2@sea.gmane.org>
	 <8c5c35580705130952r7c0e353dr9cf20aed61bdd463@mail.gmail.com>
	 <200705140931.32513.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 10:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnWG7-0007qS-Va
	for gcvg-git@gmane.org; Mon, 14 May 2007 10:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbXENIuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 04:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbXENIuI
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 04:50:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:44909 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012AbXENIuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 04:50:06 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1739708nzf
        for <git@vger.kernel.org>; Mon, 14 May 2007 01:50:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pTDkcNL6Qz9sMd8gkvx/xda79xi6B8HPPeAAKhj1UnHNZQQhkJ8JLyy44SY6X/Lj2WMBHqiSVBzW3FTqoq82VnVy/ChrhwWqWs2JCtPpVBNxCwesxJ9YgD3eITjbWkxC72k4TWpbcMXniPrimAavaLMEfeUI/6XKRoiBeedMZFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s6gjnPmdsokwXBGpq2EW8F5Ur+YlLSSNYFNJZNjLkC2Ljhkii6gofwbSa5+eT9P1cSiCLR0/hTAi4szd5GvfdRZM7SvVpgZ8eVFKJ3/FGUAtmnjzdQWrezOdJmbz/vE107ZDqnzboiHp66RVGhisOysxnsYC757DH4BotWRXnNk=
Received: by 10.115.92.2 with SMTP id u2mr899725wal.1179132604462;
        Mon, 14 May 2007 01:50:04 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Mon, 14 May 2007 01:50:04 -0700 (PDT)
In-Reply-To: <200705140931.32513.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47227>

On 5/14/07, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 13 May 2007, Lars Hjemli <hjemli@gmail.com> wrote:
>
> > I've implemented number of files/lines changed in cgit's log view and
> > pushed it to http://hjemli.net/git/
> >
> > It does consume some cpu (especially on the linux-2.6 repo), but it's
> > not terribly bad (and the caching helps out). But I felt like changing
> > the number of commits per page to 50, so I added a knob for this in
> > the config file while at it.
> >
> > I'll try to get a proper diffstat on the commit page + file history
> > via tree view next (filesize has always been part of cgits tree view
> > btw).
>
> What I lack in cgit is using git diff and showing extended diff headers
> (and the ugly tight box around diff doesn't help either), and gitweb's
> 'commitdiff' view / git's git-show / git's git-format-patch.

Yes, this has been lacking. Last night I pushed initial support for
'commitdiff', but it doesn't show git's extended diff headers, nor is
there any plain/patch view (but the ugly tiny box is still there, I'm
lousy at web design :)

That said, extended headers/patch view should be trivial to support so
I'll look into it.


> I don't think displaying filesize slows cgit much (you need to find and
> read object header for that, as this information is not present in a
> tree object...

True, I do

  type = sha1_object_info(sha1, &size)

per entry in tree view to get the size. It's fast.


> By the way, what do you think about http://git.or.cz/gitwiki/Gitweb
> page?

Nice, I hadn't noticed this page, maybe cgit should get one too? Well,
it probably should get some users first (are there anyone besides
myself?)

-- 
larsh

From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 3/6] Add 'resolve_gitlink_ref()' helper function
Date: Tue, 10 Apr 2007 17:35:09 +0200
Message-ID: <81b0412b0704100835vbbfe8e7o2df2f121ce088589@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092114010.6730@woody.linux-foundation.org>
	 <81b0412b0704100238l38ad3765w6c06878e2db654a7@mail.gmail.com>
	 <Pine.LNX.4.64.0704100756060.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 23:17:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbINJ-0007T9-4c
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 17:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbXDJPfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 11:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbXDJPfM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 11:35:12 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:60081 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbXDJPfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 11:35:10 -0400
Received: by an-out-0708.google.com with SMTP id b33so1990601ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 08:35:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i32jSSffp8sOJze/qo0oFGUbE+JyR2aIhVBGI04mZEhrXy6y3boYq9X338sIMxY7YiqVj3BORHhJzHkIemnUXRVF43YFpkiyCf5UbtC8JXpOaV496hGgnoxXgCZK3PmmhFnpbC2GWibT4/R118MrIF2fLD6EH6QWhyT7VOTRU2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OZxNPvBqf1qLAidgLDF4qpVL5eXlMSEfAy6Fnw2w3hpTic8sD3CZDAlF/fPP3iidQXepznpSAc3NmVyEy2QlR8L6PBoOA2DrGZuCA0k5mC5CvsL7u0+BNmtCkwGiiMxgzr9dFHz9J4H7unSeXXpRe6IBK9976n+u8LKarb4gauo=
Received: by 10.100.196.3 with SMTP id t3mr4962368anf.1176219309482;
        Tue, 10 Apr 2007 08:35:09 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 08:35:09 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704100756060.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44141>

On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > Can't a subproject be bare?
>
> Not when it is checked out, no. That's what "checked out" means ;)
>
> If a subproject is bare, it never gets resolved, because it's never
> checked out in a superproject.
>
> So a subproject *can* be bare, but when it's bare it is just a totally
> regular independent git project, simply by *definition* of not being
> checked out inside a superproject.
>
> But hey, that was just a design decision of mine, and if people can argue
> for it being wrong, I don't think I'm married to it ;)

I didn't actually had a use case in mind as I asked it.
After a bit of thinking I could imagine a repo which is
used for integration exclusively (no compilation or looking
at the files at all).

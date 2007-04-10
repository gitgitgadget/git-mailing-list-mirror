From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 3/6] Add 'resolve_gitlink_ref()' helper function
Date: Tue, 10 Apr 2007 17:57:03 +0200
Message-ID: <81b0412b0704100857h7550b3f9r1772dc5789c80426@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092114010.6730@woody.linux-foundation.org>
	 <81b0412b0704100238l38ad3765w6c06878e2db654a7@mail.gmail.com>
	 <Pine.LNX.4.64.0704100756060.6730@woody.linux-foundation.org>
	 <81b0412b0704100835vbbfe8e7o2df2f121ce088589@mail.gmail.com>
	 <Pine.LNX.4.64.0704100849170.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 21:43:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbIiU-0002Jl-98
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 17:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030943AbXDJP5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 11:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030946AbXDJP5H
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 11:57:07 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:20524 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030943AbXDJP5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 11:57:04 -0400
Received: by an-out-0708.google.com with SMTP id b33so1998927ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 08:57:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IPFB+wgBNiIxdsJkRZj0pXKPFXMWu5PKA+CeERSft7TYJBUfoDm49Knly7rsAo2njtOLNTJYB+pblHtDJnFx3leWlvVZDV1A7W6NyKLQVe/8e+z/Md6y7V9pW/P23tUBtPCt8GS5DOq88XbT+ZIpI4J5iGbT3N5QQ+KUf0K47+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ajDBdUR26Iv9TROyPNHMHfp0S/hwUFZLl0lZ7BS9MIzSIabRLNnG0FM+uub4uYmTkHw84AwIizEz1vYxd9mo8jBbMp8i5UD+pWzrddvJrLmMVQXD5sG32LvSAsf2ksd1PrO6iiQFSnM8lPNB+nSToyUlj7+XAUf9I94qh1PrgYk=
Received: by 10.100.35.17 with SMTP id i17mr5013050ani.1176220623585;
        Tue, 10 Apr 2007 08:57:03 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 08:57:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704100849170.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44139>

On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > After a bit of thinking I could imagine a repo which is
> > used for integration exclusively (no compilation or looking
> > at the files at all).
>
> Well, you also cannot *commit* to a bare repository, so it's a bit
> pointless for integration reasons. You'd still have to commit all changes
> somewhere else.

Yes. Subprojects are push-only for storing and reference purposes.
Superproject can have integrated data checks in Makefiles.

> That said, it's definitely designed so that if you want to automate
> tracking other peoples bare repositories, you can do so: you'd just have
> to *really* script it with something like
>
>         git update-index --cacheinfo 0160000 <sha1> <dirname>
>
> (which is how you could create those commits to a bare repo too, so it's
> not like this is really even any different)

Nice :)

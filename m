From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Wed, 15 Dec 2010 20:44:45 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012151931030.25560@debian>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com> <20101215130046.GB25647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 16 02:44:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT2tP-0004L0-Bx
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 02:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab0LPBoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 20:44:12 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53822 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab0LPBoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 20:44:09 -0500
Received: by vws16 with SMTP id 16so1201450vws.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 17:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=AIJ/kTPeTMhdGIhfrNvwHj2wsV5n4apMNCKIoqWv09c=;
        b=o6Gs73tMmfpjUupDsU6XjEhdwf8R440K5dZpMp2Y8v6WRwTYkAxw348h1ejkmcDiy5
         BuZE1ELWQGaEjMls9rpUWdIl1MuSvJKjGW7l+vTcjxaB5baJKZZHLI83w32qa3MIpeev
         9jMvpQBfvz83x7mlhjS83HabWRwjI4TD50NPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=C7RXbH24+RrLjXskOG5qgTlVp3QjuD6vwsqPqXTq+0YKcCMH86A2eCfKGpM5ngESkM
         VRfJPeKxfvyhrXZCjXW04o43RWiTuCrkWBh+rY7welqV5YSO4vWzx4HsYrdHeiYvUJuU
         9QRGQU3PjeguRhlGPddlrOZa5sAdyOdga9SzE=
Received: by 10.220.45.134 with SMTP id e6mr1235068vcf.193.1292463848838;
        Wed, 15 Dec 2010 17:44:08 -0800 (PST)
Received: from [192.168.1.105] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id b26sm774608vby.3.2010.12.15.17.44.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 17:44:07 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20101215130046.GB25647@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163798>

On Wed, 15 Dec 2010, Jeff King wrote:

> On Wed, Dec 15, 2010 at 07:46:53AM +0100, Martin von Zweigbergk wrote:
> 
> > The color.grep.external option has been deleted. Should it be deleted
> > from here or do we want to help users run e.g.
> > 'git config --unset color.grep.external'? Same goes for
> > add.ignore-errors.
> 
> IMHO, they should go away. People who have them can figure out how to
> delete them, but it is more important not to advertise them to people
> who are adding variables.

Sounds good to me. If no one disagrees, I'll send an updated patch in
a day or two, removing both color.grep.external and add.ignore-errors.

> As an aside, I would think "--unset" should actually choose from the set
> of configured variables for completion (i.e., "git config --list | cut
> -d= -f1"). But that would obviously be a separate patch.

Good point. I'll put it on my todo.

> > Some variables are documented with camelCase but read in all
> > lowercase in the code. Not worth updating the code just for that, is
> > it?
> 
> All variables are case-insensitive.

That I knew...

> The config parser down-cases them,
> so all code should treat tham as all-lowercase.

... but not that. Thanks. I could/should have figured that out if I
had noticed that *all* of them were lowercase in the code :-P.

> One note:
> 
> >  		color.diff
> >  		color.diff.commit
> >  		color.diff.frag
> > +		color.diff.func
> >  		color.diff.meta
> >  		color.diff.new
> >  		color.diff.old
> >  		color.diff.plain
> >  		color.diff.whitespace
> 
> We have color.diff.branch coming soon (I think it is in 'next' now).

Strictly speaking, that note is for Junio to think of when he merges,
right? But adding it early is pretty harmless and if that relieves him
of some work, I would be happy to add it in the next submission of
this patch. Is that better?

Thinking a bit more, maybe what you are suggesting is that I base the
next revision of this patch on the branch that adds that variable?


/Martin

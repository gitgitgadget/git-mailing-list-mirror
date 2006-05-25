From: =?ISO-8859-1?Q?Bj=F6rn_Engelmann?= <BjEngelmann@gmx.de>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Thu, 25 May 2006 13:53:35 +0200
Message-ID: <44759ABF.1010209@gmx.de>
References: <4471CF23.1070807@gmx.de>	<7vac99c1hv.fsf@assigned-by-dhcp.cox.net> <44737353.20904@gmx.de>	<7vzmh81gfa.fsf@assigned-by-dhcp.cox.net> <4474B10A.1020704@gmx.de> <7v1wuj6wln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 13:53:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjEPG-0003ID-MO
	for gcvg-git@gmane.org; Thu, 25 May 2006 13:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWEYLx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 07:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWEYLx3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 07:53:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:49579 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965122AbWEYLx3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 07:53:29 -0400
Received: (qmail invoked by alias); 25 May 2006 11:53:27 -0000
Received: from unknown (EHLO [10.79.42.1]) [62.206.42.234]
  by mail.gmx.net (mp006) with SMTP; 25 May 2006 13:53:27 +0200
X-Authenticated: #916101
User-Agent: Mail/News 1.5 (X11/20060228)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wuj6wln.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20735>


> Sorry, I forgot all about hash-objects X-<.  It was a convenient
> way to try out new things such as 'gitlink'.  Thanks for the
> clarification.
>
> As to unification, I am not sure if there are a lot to unify.
> Everybody starts with type, length and a LF, but after that each
> type has its own format constraints.  A grand unified command
> that knows about format constraints of every type under the sun
> does not sound like a good approach.  While we have only handful
> types (and I expect things will stay that way) it is not a big
> deal either way, though.
>   
Oops, sorry, I forgot that "modular" in C means something else than in
the OO-World...
You are right. Probably it is best to have one tool handle each type.

Actually what I am aiming for is not the internal structure. I am more
concerned about cleaning up the user-interface. When I started learning
git I found it very annoying and inconsistent that there are commands
for creating a tag and a tree in a validated fashion, but the command
for creating blobs was named "git-hash-object -w" and also could create
all other objects without validating them at all. Also, AFAIK there is
currently no way of creating a commit object with validating.

I am well aware that all functionality neccessary already exists. I just
want to prevent people learning git in future to have the same
frustrating experience as I did.

Obviously renaming / moving code around like that would break nearly all
tools build ontop of git. Therefore I would prefer to use aliasing. If
you feel like this would introduce too many unneccessary commands, I
would instead focus on improving the documentation.

Bj

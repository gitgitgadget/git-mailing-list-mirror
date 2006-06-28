From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.pm
Date: Wed, 28 Jun 2006 21:21:45 +0200
Message-ID: <20060628192145.GD5713@fiberbit.xs4all.nl>
References: <20060628183557.GA5713@fiberbit.xs4all.nl> <7vr719159v.fsf@assigned-by-dhcp.cox.net> <7virml14za.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 21:22:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvfbl-0006Ip-Qq
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 21:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWF1TVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 15:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWF1TVu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 15:21:50 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:20876 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751047AbWF1TVt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 15:21:49 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.62)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1Fvfbd-0001Yf-Uw; Wed, 28 Jun 2006 21:21:45 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virml14za.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22820>

On Wednesday June 28th 2006 Junio C Hamano wrote:

> >>  ifeq ($(uname_S),Linux)
> >>  	NO_STRLCPY = YesPlease
> >> +	ifneq (,$(findstring x86_64,$(uname_M)))
> >> +		USE_PIC = YesPlease
> >> +	endif
> >>  endif
> 
> In other words, I am wondering why you did not do this more
> obvious one:
> 
>         ifeq ($(uname_M),x86_64)
>                 USE_PIC = YesPlease
>         endif
> 
> My suspicion is that you protected that in Linux on purpose
> because you know that my version would break for somebody else,
> or because you are trying to be cautious not to break other
> platforms you do not have access to, and I cannot tell which.

Sorry for the confusion. Yes that construct is much more readable. I
copy and pasted it from another section in the Makefile and adapted it
to this use. I tested it and it worked so I decided no to change it
anymore. So that clears up the syntactical issue.

I certainly do not know cases outside Linux where this might break on
x86-64. I just tried to limit it to the case I could test. But perhaps
someone with an x86-64 BSD or Solaris might try it?

To paraphrase Dave Jones: I type 'make', it fails. Some 'git log' later
I realise I have to manually define 'USE_PIC'. Hey, why doesn't it work
automagically? Some 'git grep' and I spot a construct for specific
(sub)platforms. Monkey see, monkey do. I type 'make', it works and
monkey sends patch! Thats it! No subtleties involved;-)
-- 
Marco Roeland

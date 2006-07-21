From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Unanticipated test error
Date: Fri, 21 Jul 2006 16:54:57 +0200
Message-ID: <81b0412b0607210754m1e3c8bf9ne717786e666fa7e1@mail.gmail.com>
References: <20060720194013.GC24793@bohr.gbar.dtu.dk>
	 <81b0412b0607210022o562ac326wd149c73cc529f239@mail.gmail.com>
	 <20060721081954.GA29645@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 16:55:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3wPG-0001vg-Oc
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 16:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWGUOzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWGUOy7
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 10:54:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:38562 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750756AbWGUOy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jul 2006 10:54:59 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1309745ugc
        for <git@vger.kernel.org>; Fri, 21 Jul 2006 07:54:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lOhgxk/4o4tPd/aIKtaaa7UxsIuNFHDVRnBO4vF0pyJ1LEPXWi9XnBTlj1cyNLA/1/zlsOii5BAy2yyiKQDm5vwPbzxXT+lWDVxkw17eWU18/8mOFa4inz1Po/1TMzdkwxqRa1TS/K8EWoHY5692u3vC1XB33jgUK73Jkzi91Rk=
Received: by 10.78.164.13 with SMTP id m13mr402750hue;
        Fri, 21 Jul 2006 07:54:58 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Fri, 21 Jul 2006 07:54:57 -0700 (PDT)
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20060721081954.GA29645@bohr.gbar.dtu.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24054>

On 7/21/06, Peter Eriksen <s022018@student.dtu.dk> wrote:
> ...
> > Well, there are differences. Correct translation from memcpy
> > to strlcpy (aside the fact with \0 inside the string) would be
> > something like:
> >
> >  strlcpy(to, from, len + 1);
> >
> > assuming your example with memcpy. strlcpy expects size of
> > storage, and will never write more bytes that it was allowed to.
> > That'll cut off last character of the source string, unless it is
> > \0-terminated before the size of storage.
>
> I see it now.  What I did was wrong.  Appending " + 1" to every
> one of my calls makes the patch survive "make test".  However,
> since strlcpy() calls strlen(from), it would have to be checked,
> that 'from' is always NUL terminated.  The benefits of this patch
> seem to shrink.

Probably, but you still have room to balance benefits.

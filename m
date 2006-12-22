From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Fri, 22 Dec 2006 21:34:50 +0100
Message-ID: <38b2ab8a0612221234x3832c5bfr1f64caccbb8247b9@mail.gmail.com>
References: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
	 <Pine.LNX.4.64.0612211013500.3394@woody.osdl.org>
	 <38b2ab8a0612220135p6925be4cmf003811f616395ba@mail.gmail.com>
	 <7vvek41b29.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jay Cliburn" <jacliburn@bellsouth.net>, git@vger.kernel.org,
	"Jeff Garzik" <jeff@garzik.org>,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 21:35:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxr6c-0005YC-P8
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbWLVUev (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 15:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLVUev
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:34:51 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:36386 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbWLVUeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:34:50 -0500
Received: by wr-out-0506.google.com with SMTP id 68so19903wri
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 12:34:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FUA2+UnbjBzgAEMWOujvTO6/ZN8yX9DJ1hlhtPDzz6d2GbnI4BfASZIOjWUE3A8/6qakG0ycnyeB2MRUuDWqRJJFekD/uY4WA/TiQISeCzj3Yct7cXgtVx3QwwC8+V9dtizSRLfnX4iENPIi8ucg2bIpYDE62mMRBFKOsMjdJ7U=
Received: by 10.90.63.16 with SMTP id l16mr515958aga.1166819690113;
        Fri, 22 Dec 2006 12:34:50 -0800 (PST)
Received: by 10.90.106.16 with HTTP; Fri, 22 Dec 2006 12:34:50 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vvek41b29.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35211>

On 12/22/06, Junio C Hamano <junkio@cox.net> wrote:
> "Francis Moreau" <francis.moro@gmail.com> writes:
>
> > I think this part is really confusing. For a new comer, saying that:
> >
> >       git diff a b == git diff a..b
> >
> > is really not intuitive. Maybe just because adding a new symbol ".."
> > in git diff command line means (for me) that we're doing a special
> > diff. I would never thought by my own that ".." means a simple "to".
>
> We did not originally have "A B"; you were supposed to always
> say "A..B".  But all other SCM had "A B" notation, so we added
> support for both because doing so was trivial and there is no
> risk of confusion (because diff is about two points while log is
> about a set).  These two notations are interchangeable for
> "diff".  If it confuses you, you can stick to the "git diff A B"
> notation.  Of if you are like Linus, stick to "A..B" notation.
> Either way, you can pretend that the other notation does not
> even exist and be happy ;-).
>

no, no, I think you miss my point here. What is confusing, and it
seems I'm not the only one to find it confusing,  is the fact that
"git diff A B == git diff A..B", not the "A..B" notation per se.

git diff A B, is really intuitive and easy to understand because we
all use to using the diff "A B" notation and it always has worked with
2 endpoints. So I would bet that all newbies who use for the first
time the git diff command will use "A B" notation, not "A..B" one.

> Yes, users often wondered why "git diff" accepts "A B", "git
> log" wants "A..B" and "git log A B" is a disaster.  But the root
> cause of the confusion was not about notation but about the
> conceptual difference (two points vs a set).
>
> I do not think changing the meaning of "diff A..B" to what "diff
> A...B" means is a good thing.  The notation "..." even _looks_
> like a magic, and in diff context, what it does _is_ magic (it
> is magic in log context, too).  You are giving two points, but

But ".." is magic too ! I would really expect something magic to
happen when using the "A..B" notation because I'm a new comer in git
and I never used the "A..B" notation before.

And since I already used this notation when using git log command, I
would expect "git diff A..B" to give the current result given by "git
diff A...B".

But yes, now I have understand that git diff works with end points
unlike git log, I can stick with two notations:

        git diff A B
        git diff A...B (3 dots)

and I'm happy ;)

thanks
-- 
Francis

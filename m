From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 19:57:02 -0700
Message-ID: <9af502e50806271957o2df9e0abt9dadcb0514dd4173@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
	 <20080628021444.GI5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 04:58:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCQda-0003uN-9w
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 04:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbYF1C5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 22:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYF1C5H
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 22:57:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:9485 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbYF1C5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 22:57:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so368220fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gQWVysyscvNhT9zprMnf5iovxMztZFlpxXnRIWuY4tg=;
        b=EMoGVItYMx+svoTWW7XL6DisYb8TKrGCTWYTYjBY4YNbtmcv3aPoyh8+mdDSdOwSXz
         Uh+CYLgsdD3PTpfewarWVt2tEOTGpDQs+1dgddDgjOdml3BKIl2qF6AElPSXYPNKGpsz
         Ib+gFmBqK/99qaronce6UlYkugtPEV/rvpGP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qqG5FJ1sF3v1upiTwSS61UcCNHQchsM5mXvodrCsn/60vg5Rm2V8xu0V1Y8Ii/TH/w
         gH+5ebX0IG1OLMbugcrESYFZvHmt3uUMnNwxVV76vc9KyEp+Qvkn8tyrH7KCAoFRQWDB
         2fkxzs195YERvRCRXHFjdQ4jArDZtv8jjWQD0=
Received: by 10.86.98.10 with SMTP id v10mr2851378fgb.46.1214621822561;
        Fri, 27 Jun 2008 19:57:02 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Fri, 27 Jun 2008 19:57:02 -0700 (PDT)
In-Reply-To: <20080628021444.GI5737@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86695>

On Fri, Jun 27, 2008 at 7:14 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Fri, Jun 27, 2008 at 10:14:05AM -0700, Robert Anderson wrote:
>>
>> It is too subtle.  That the index state - which becomes the next
>> committed state - is not available for building or testing before
>> committing is a deep flaw.
>
> And why is that? It is like saying that any editor that does not allow
> you to compile the file without saving it first has a deep flaw.

I don't believe it is like that.  It would be like that if you
intended for your on-tree disk to have a policy to always compile (for
example).  That is not a common use-case.

> In Git, commits are not the same as in CVS.

I have not suggested they were.

> You can commit any changes
> and amend them any time later before you publish your changes.

This is enforcing a two-step process where there only need be one the
vast majority of the time, to require that commit and publish be
separate operations.

> Those who care about quality should have a review process, and the
> review process works best when all changes are slit in a small logical
> steps. How do you propose to that without committing changes first?

I don't understand the question.  The entire point of the facility I
am proposing is to facilitate creating small clean changesets.  Go
back and read my original proposal, or Junio's statement of more or
less the same idea, to see how it is proposed to do this.

> You can verify it, but you do that _after_ you committed changes but
> before you publish them.

Again, this is requiring two steps when it is otherwise not required,
creating an inefficient workflow that is error prone.

> BTW, policy may include that it should be
> compiled and tested on a few platforms, so you cannot do that in
> your working directory anyway.

Huh?  I have done that every day for 15+ years.

> I think the source of your confusion is that you consider git commit
> as cvs commit

No.  I have experience with a wide array of source control systems.
CVS fits my mental model the least well.  git is pretty close, but it
is not there yet.  The current partial commit facility is the biggest
misfire, in my view.

I like that git's philosophy does not include a draconian policy of
not changing history.  That's fine, it's practical, and it's useful,
to cover common scenarios in which you'd like to quickly recover from
a mistake.  However, I am afraid that these facilities have been
abused and turned into something that they are not well-suited for,
i.e., the use of lines of development as both keepers of history and
of scratch spaces where you scribble around with temporary things, all
the while git having no clue which is intended.  That these ideas are
conflated is a mistake.  That's my opinion.  These activities ought to
occur in separate, logically distinct spaces in which they occur,
because they have different requirements and common use-cases.

Bob

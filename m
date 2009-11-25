From: Mike Jarmy <mjarmy@gmail.com>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 12:40:15 -0500
Message-ID: <6b4a562b0911250940k29d5e7eck2bb35d6831ed3af9@mail.gmail.com>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
	 <m38wdublbq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 18:40:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDLqs-0008QU-T7
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 18:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759341AbZKYRkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 12:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759089AbZKYRkL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 12:40:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:47324 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759001AbZKYRkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 12:40:09 -0500
Received: by fg-out-1718.google.com with SMTP id e12so5202fga.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 09:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+M/slTa+sdLFPlOSM3jjND5j7BA3oigysM+/WG+Pn4E=;
        b=ed0uM3NYO8jbzFFuXyBO+SKP2pNjk6lfYHooUIN67ZOj23qa6blJcR/lJLtJ3tXHLd
         n0sfQICmAhXSEJpIsH3XK1sOR+Yiwcyx8LFoL3z8YnIMbm9+z2RTC4vu1T2zaSOoXh1H
         9m7p0NzmWjt1mpWiwzfUU9L1DUau07oUbNjPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dUlDmCaW4sVTjSy9jS28S6aOZ6PwGPD8pEJ6M/9fVlLPb2bosr2QPcxpvbFhctoDgl
         GIuoFtGPH9kP8Kh+wm/dIQAo9nxL1HjdAakXVC4G/tVLAjHm7SXqVQFU9nR2Yvv+Kjd7
         agqeQYpSr+joQq835dtOhHQW/QnOT7Rn4q8d8=
Received: by 10.103.50.22 with SMTP id c22mr3474745muk.54.1259170815308; Wed, 
	25 Nov 2009 09:40:15 -0800 (PST)
In-Reply-To: <m38wdublbq.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133655>

Jakub Narebski wrote:
> Take a look at "Resolving conflicts/dependencies between topic
> branches early" blog post by Junio C Hamano (git maintainer) at
> http://gitster.livejournal.com/27297.html
>
> In short the solution is to create separate topic branch for a bugfix,
> branching off earliest place where it would be relevant, then merge
> this bugfix branch into all development branches you need
> (e.g. maint-v3, maint-v4, maint-v5, master).

Thanks guys.  I think some cross between this and the cherry-picking
idea would work for us most of the time, if we go with the workflow
that I originally specified.  I like the branch-per-bugfix idea -- its
taking some time for me to free my mind to the point where I grok how
lightweight and flexible branching really is.  Just branch off from
the earliest affected release, naming the branch after the bug
('fix-frobulator--issue-1235').  When finished, merge/cherry-pick back
into the various branches.

Thomas's idea of using a more sophisticated workflow has definitely
got me thinking.  Back in the day, once we started working on a new
release, say v6, then the other branches to an extent become
mothballed except for bugfixes.  In that case, using a merge-base
approach would make sense.  More and more though, we have started to
build separate sub-projects on top of specific releases -- in other
words, we are simultaneously making a new product on top of v4, while
preparing to release v5, and getting ready to start work on v6 in
earnest, all the while fixing bugs across mulitple releases going all
the way back to v2.  Its getting very complicated :-).  And our
current VCS is starting to become an active hindrance in helping us
manage all this in a sane way.

What I'm going to do is set up a toy environment that mirrors what I
hope our final repository will look like.  Then I'll play with it for
a while and concoct corner-case scenarios and see how it holds up.
Once I have a workflow that I like, I can demonstrate it to my
colleagues in gitk, and we can think about how to make it better.

Thanks,
Mike Jarmy

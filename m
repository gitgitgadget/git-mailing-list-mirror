From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 17:24:14 +0400
Message-ID: <20090420132414.GD25059@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvtVq-0007WD-LD
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbZDTNYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 09:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbZDTNYp
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 09:24:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:22393 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbZDTNYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 09:24:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1890057rvb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YMt7+U7nSgm7jv79Cy9J6W8zwtjHgrNFJuqTNRvHNek=;
        b=CdSsjP2MdVW/7bCNVGoFx9t0aGVJzD3nGRLAFpkqmz/ZJe1rKoVpCsSsdYebGoktUv
         uwfvxCUMEwE6EzxTRircMX+XhKP0tY3CoPnWqf6EQg6jGWhDdYGjEHG1oDn/PUEI8kKv
         e2jbmHKSvoozXkXIIRtMJfAEkzczxcbg2DTqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tHQYkR/1Rw+cPyeOeqLPt9iTsFBBWNs33ll+1EvNgEXn2hxsdkLtM0PL6fH39qfEsW
         dumvkL+iKb/u3teDv0hMTLQBaHdz/kzHEM4yMhvC1BR+fPphRLgiHH+cdnjdWV/VBRiY
         7ABV/EGdBcALuwSkbDbYMvUUSfU2FWTKXEkOQ=
Received: by 10.140.134.15 with SMTP id h15mr2500338rvd.156.1240233883830;
        Mon, 20 Apr 2009 06:24:43 -0700 (PDT)
Received: from localhost (ppp91-78-50-115.pppoe.mtu-net.ru [91.78.50.115])
        by mx.google.com with ESMTPS id g22sm180668rvb.43.2009.04.20.06.24.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 06:24:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49EC6596.8060208@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116981>

On Mon, Apr 20, 2009 at 02:07:50PM +0200, Michael J Gruber wrote:
> Dmitry Potapov venit, vidit, dixit 20.04.2009 13:32:
> > On Sun, Apr 19, 2009 at 05:17:52PM +0200, Johannes Schindelin wrote:
> >>
> >> But it is important to keep in mind that our concept of branches is not 
> >> intuitive:
> >>
> >> http://longair.net/blog/2009/04/16/git-fetch-and-merge/
> > 
> > I don't see how our concept of branches is any different from what other
> > version control systems have; but I see why it is so confusing for many
> 
> It is very different, and for a good reason, indeed.
> 
> git's branches really are moving tags. As such, there is no single
> branch that a commit would be tied to. A commit does not belong to a
> specific branch; you commit on a branch (usually), and it may be
> contained in 1 or more branches, of course.

When you create a new commit, it is always belong to _one_ branch and
never to two or more branches. After that you can create a child branch
that will also contain this commit, but it is so in any other VCS.

Perhaps, the only difference with some other VCSes can be that some VCS
remember name on what branch the commit was initially created, but you
can add that information to Git commit manually if you really want.

But even better approach is to write the branch name only once when
it is merged to the upstream, and Git does that by default. Have you
seen a lot of merge commits like this:

   Merge branch 'bs/maint-1.6.0-tree-walk-prefix' into maint
   ....

though the name of branch does not exist in the upstream repository,
there is no problem to find all commits created on that branch. In fact,
if Git stored those names in the upstream then Git repository would
contain over 2,000 branches already and that number would be only grow.

> 
> This is fundamentally different from what is named "branch" in hg, e.g.
> There, a commit stores the branch name, which is why you can't delete
> branches easily. [For me, this is also why hg branches are useless, but
> I don't want to start flames here - for me they are useless, for others
> they may still be perfect.]

I don't see it as fundamentally different. Basically, Hg has some
restriction that does not let you to remove branches that outlived their
usefulness (and thus polluting name space), but the underlying structure
is the same...

> 
> Branches in cvs etc. are much like the latter: You commit on a specific
> branch, *and* you can't change that later. The branch name at time of
> creating a commit is stored in the commit.

IIRC, it is not. CVS uses numbers which identify each branch. The name
of branch can be changed later, but you cannot change the underlying ID.
You can even remove the name, but branch will remain, and you can follow
it if you know numbers. Incidentally, you can always follow Git branch
in similar way by using --first-parent option...

> 
> Hg is introducing "bookmarks" now, corresponding to git branches. I
> think this name describes the nature of git branches very well.

Honestly, the first thing that comes to my mind when I hear bookmarks
in relation to VCS is unannotated tags... The idea of self advancing
bookmarks is really weird...


Dmitry

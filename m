From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: multiple working directories for long-running builds (was:
	"git merge" merges too much!)
Date: Wed, 2 Dec 2009 03:10:21 +0300
Message-ID: <20091202001020.GF11235@dpotapov.dyndns.org>
References: <7vskbxewti.fsf@alter.siamese.dyndns.org> <m1NFBAx-000kmgC@most.weird.com> <20091130211744.GA27278@dpotapov.dyndns.org> <m1NFGXS-000kn2C@most.weird.com> <20091201054734.GB11235@dpotapov.dyndns.org> <m1NFX19-000kn4C@most.weird.com> <20091201185114.GC11235@dpotapov.dyndns.org> <m1NFXvL-000kn2C@most.weird.com> <20091201211830.GE11235@dpotapov.dyndns.org> <m1NFbSE-000kn2C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 01:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFcoA-0002Xm-Gt
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 01:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbZLBAKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 19:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbZLBAKi
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 19:10:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:14056 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbZLBAKh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 19:10:37 -0500
Received: by fg-out-1718.google.com with SMTP id e21so78640fga.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 16:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FM2xqeAZ7fFq3v9/6sYUtobZnx7voXrAB+csurIKRSk=;
        b=RrAdkd38X2r9udvxHTrAwsfFbW1ITXUnvZsR/QNHwosyk+CEGnEUpsHIPxU8EWHE5L
         77+wPaVLzfZ5wanJEjamdBopydVmyYsiSUiBRsCMnxLFI2u8jjRWkgskkZ7yc7CSthZB
         E+5Ozu0nylbq9eYyEOOs2opooSeN+rPFYbnHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pPqMsC4/rvo4Tr9fbBT05oMX4VU2McEF7Jt1K6juHzb0d5HABLA0ineFY6vhqF/MyT
         tiWOukLigML15XSimPYSfOOc5HannGLwMTbBvQh7QbLJKF76+7jdATaYeD/wqLTpuZHd
         KDq1fFbgeD57UAPPQYVukh/ElmZKPvpuz76VQ=
Received: by 10.86.249.26 with SMTP id w26mr6015382fgh.49.1259712643459;
        Tue, 01 Dec 2009 16:10:43 -0800 (PST)
Received: from localhost (ppp91-78-50-138.pppoe.mtu-net.ru [91.78.50.138])
        by mx.google.com with ESMTPS id e11sm3656777fga.24.2009.12.01.16.10.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 16:10:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m1NFbSE-000kn2C@most.weird.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134270>

On Tue, Dec 01, 2009 at 05:44:15PM -0500, Greg A. Woods wrote:
> At Wed, 2 Dec 2009 00:18:30 +0300, Dmitry Potapov <dpotapov@gmail.com> wrote:
> Subject: Re: multiple working directories for long-running builds (was:	"git merge" merges too much!)
> > 
> > AFAIK, "git archive" is cheaper than git clone.
> 
> It depends on what you mean by "cheaper"

You said:

>>> "git archive" is likely even more
>>> impossible for some large projects to use than "git clone" 

My point was that I do not see why you believe "git archive" is more
expensive than "git clone". Accordingly to Jeff Epler's numbers,
"git archive" is 20% faster than "git clone"...

> It's clearly going to require
> less disk space.  However it's also clearly going to require more disk
> bandwidth, potentially a _LOT_ more disk bandwidth.

Well, it does, but as I said earlier it is not the case where I expect
things being instantaneous. If you do not a full build and test, then it
is going to take a lot of time anyway, and git-archive is not likely to
be a big overhead in relative terms.

> > I do not say it is fast
> > for huge project, but if you want to run a process such as clean build
> > and test that takes a long time anyway, it does not add much to the
> > total time.
> 
> I think you need to try throwing around an archive of, say, 50,000 small
> files a few times simultaneously on your system to appreciate the issue.
> 
> (i.e. consider the load on a storage subsystem, say a SAN or NAS, where
> with your suggestion there might be a dozen or more developers running
> "git archive" frequently enough that even three or four might be doing
> it at the same time, and this on top of all the i/o bandwidth required
> for the builds all of the other developers are also running at the same
> time.)

First of all, I do not see why it should be done frequently. The full
build and test may be run once or twice a day, and the full test and
build may take an hour. git-archive will take probably less than minute
for 50,000 small files (especially if you use tmpfs). In other words, it
is 1% overhead, but you get a clean build, which is fully tested. You
can sure that no garbage left in the worktree that could influence the
result.

> 
> > > Disk bandwidth is almost always more expensive than disk space.
> > 
> > Disk bandwidth is certainly more expensive than disk space, and the
> > whole point was to avoid a lot of disk bandwidth by using hot cache.
> 
> Huh?  Throwing around the archive has nothing to do with the build
> system in this case.

"git archive" to do full build and test, which is rarely done. Normally,
you just switch between branches, which means a few files are changed
and rebuild, and no archive is involved here.

> 
> I'm just not willing to even consider using what would really be the
> most simplistic and most expensive form of updating a working directory
> as could ever be imagined.  "Git archive" is truly unintelligent, as-is.

"git archive" is NOT for updating your working tree. You use "git
checkout" to switch between branches. "git checkout" is intelligent
enough to overwrite only those files that actually differ between
two versions.

> A major further advantage of multiple working directories is that this
> eliminates one more point of failure -- i.e. you don't end up with
> multiple copies of the repo that _should_ be effectively read-only for
> everything but "push", and perhaps then only to one branch.

Multiple copies of the same repo is never a problem (except taking some
disks space). I really do not understand why you say that some copies
should be effectively read-only... You can start to work on some feature
at one place (using one repo) and then continue in another place using
another repo. (Obviously, it will require to fetch changes from the
first repo, before you will be able to continue, but it is just one
command). In other words, I really do not understand what are you
talking about here.


> 
> I know of at least three very real-world projects where there are tens
> of thousands of small files that really must be managed as one unit, and
> where running a build in that tree could take a whole day or two on even
> the fastest currently available dedicated build server.  Eg. pkgsrc.

Tens of thousands files should not be a problem... For instance, the
Linux kernel has around 30 thousands and Git works very well in this
case. But I would consider to split if it has hundrends of thousands...


Dmitry

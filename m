From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 14 Oct 2006 19:06:10 -0400
Message-ID: <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egrgqe$1i9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 01:06:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYsaN-0007Kp-KQ
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 01:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbWJNXGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 19:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWJNXGM
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 19:06:12 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:40373 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030404AbWJNXGL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 19:06:11 -0400
Received: by py-out-1112.google.com with SMTP id n25so1700954pyg
        for <git@vger.kernel.org>; Sat, 14 Oct 2006 16:06:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NIBeNF94GtVFNw8PVJF17veQTDl8iKJS1PvmUuRs+HqfdLK84pBlzcuGJ4IqkdOC2oHyZBwBkLluiBXsZJV8UxCqi4YsixFFCKK0NkQVIY7aVji+Qsbd4KpWR581CWWwtOQVRXj3k6Qxx3BrAgwDAPTiD/E3bhAwLDeXOuiOSD8=
Received: by 10.35.12.13 with SMTP id p13mr9071121pyi;
        Sat, 14 Oct 2006 16:06:10 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sat, 14 Oct 2006 16:06:10 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <egrgqe$1i9$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28893>

On 10/14/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Jon Smirl wrote:
>
> > I was reading Brendan's blog post about Mozilla 2
> > http://weblogs.mozillazine.org/roadmap/archives/2006/10/mozilla_2.html
>
> You mean:
>  "Oh, and isn't it time that we get off of CVS? The best way to do that
>   without throwing 1.9 into an uproar is to develop Mozilla 2 using a new
>   Version Control System (VCS) that can merge with CVS (since we will want
>   to track changes to files not being revamped at first, or at all; and
>   we'll probably find bugs whose fixes should flow back into 1.9). The
>   problem with VCSes is that there are too many to choose from now.
>   Nevertheless, looking for mostly green columns in that chart should help
>   us make a quick decision. We don't need "the best" or the "newest", but we
>   do need better merging, branching, and renaming support."
>
> There is work by Jon Smirl and Shawn Pearce on CVS to Git importer which can
> manage large and complicated (read: f*cked-up) Mozilla CVS repository.
>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#cvs2git

I am still working with the developers of the cvs2svn import tool to
fix things so that Mozilla CVS can be correctly imported. There are
still outstanding bugs in cvs2svn preventing a correct import. MozCVS
can be imported, but the resulting repository is not entirely correct.

Once they get the base cvs2svn fixed I'll port my patches to turn it
into cvs2git again.

There is no existing CVS importer that will correctly import the
Mozilla CVS. I have tried them all.

> By the way, I'd rather use SCM comparison table on neutral site, not on SCM
> site.
>
>
> I think that Mozilla project should come with it's own set of requirements
> and weights for best SCM _for Mozilla project_.
>
> 1. Converting existing CVS repository. This should be without data loss...
> well, beside data loss that stems from using CVS in first place. "Best" SCM
> would have:
>   * Tool to convert CVS repository, which can then incrementally import
>     changes.
>   * It would be nice to have tool to exchange commits between SCM and CVS,
>     be it like Tailor/git-svn, or via incremental import and exporting
>     commits to CVS like git-cvsexportcommit. This would ease changing SCM,
>     as both new SCM and CVS could be deployed in parallel, for a short time
>     of course.

>From what Brendan wrote they are looking to continue 1.9 in CVS and
start 2.0 in a new SCM. This pretty much mandates tracking CVS into
the new SCM for a long period of time. Possibly as much as two years.
There does not appear to be a need to push 2.0 back into CVS.


>   * It would be nice to have CVS emulation like git-cvsserver, so users
>     accustomed to CVS could still use it.

This can also solve some of the problems with Windows support.

>
> 2. Good support for system which most important developers use, and good
> support for system which most contributors use. If MS Windows is included
> in those, then Git perhaps wouldn't be the best choice.

Better Windows support is needed to make git the first choice among
the various SCMs.

>
> 3. Good support for the workflow used in the project. Is it exchanging
> patches via email (hello, Git!), having ssh access to some central
> repository with central repository to push changes to or net/mesh of
> repositories exchanging information, posting patches on some bug tracking
> software integrated with SCM. Is it using many branches (topic branches),
> or is it using few branches and merging.
>
> But it is equally important to realize what would be the best workflow to
> use, not constraining itself to the workflow imposed by limitations of CVS.

A big problem for Mozilla is outside companies doing major work in a
local CVS. Since CVS is not decentralized these local repos drift away
from the main one over time making things hard to merge. Any new SCM
will have to be distributed.

> 4. Good support for _large_ project, with large history. Namely, that
> developer wouldn't need to download many megabytes and/or wouldn't need
> megabytes of working area. How that is solved, be it partial checkouts,
> lazy/shallow/sparse clone, subprojects, splitting into
> projects/repositories and having some superproject or build-time
> superproject, splitting repository into current and historical... that of
> course depends on SCM.

git has issues here. The smallest Mozilla download we have built so
far is 450MB for the initial checkout.

>
> 5. ....
>
> and probably few more


The three most complex repositories are the kernel, gcc and Mozilla.
Gcc is in SVN now. Mozilla CVS and the kernel git.

There are much larger repositories around for some of the distros, but
they are doing things like checking ISO images in to the repo which
just makes it big,, not complex.

Top two git issues effecting Mozilla choosing it
1) some way to avoid the initial 450MB download
2) better windows support


-- 
Jon Smirl
jonsmirl@gmail.com

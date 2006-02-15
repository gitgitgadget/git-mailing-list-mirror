From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 12:25:02 +0100
Message-ID: <20060215112502.GC26911@diana.vm.bytemark.co.uk>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060215101136.GB26911@diana.vm.bytemark.co.uk> <43F305AF.70808@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Feb 15 12:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Kmp-00039j-2z
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 12:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWBOLZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Feb 2006 06:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWBOLZI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 06:25:08 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:44041 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932449AbWBOLZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 06:25:06 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1F9KmM-0007Gf-00; Wed, 15 Feb 2006 11:25:02 +0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <43F305AF.70808@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16235>

On 2006-02-15 11:42:55 +0100, Andreas Ericsson wrote:

> Karl Hasselstr=F6m wrote:
>
> > You can actually do this today; just create a new branch where you
> > want your new stgit stack to be based, and "stg pick" the
> > commits/patches from the old branch:
> >
> >   $ git-checkout -b new-branch HEAD^^^
> >   $ stg init
> >   $ stg pick old-branch^^^ -n create-foo
> >   $ stg pick old-branch^^ -n improve-foo
> >   $ stg pick old-branch^ -n improve-bar
> >   $ git-branch -D old-branch
> >   $ git-checkout -b old-branch
> >   $ git-branch -d new-branch
> >
> > This series of commands also converts the top three commits to
> > stgit patches, and leaves the user on the same branch where she
> > started (it does _exactly_ the same job as "stg uncommit
> > improve-bar improve-foo create-foo"), but it's a lot of work, and
> > a typo could lose commits.
>
> Isn't this akin to what "git cherry-pick" does, except for the
> "convert to stgit patches" thing?

Yes, "stg pick" and git-cherry-pick are very similar as far as I know,
the only difference being that "stg pick" creates an stgit patch while
git-cherry-pick creates a regular commit. (And an applied stgit patch
is just a regular commit which stgit maintains some metadata about.)

However, using git-cherry-pick in this scenario would just recreate
the initial state exactly, since converting the commits to stgit
patches was what it was all about.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

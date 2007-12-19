From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 12:20:35 +0100
Message-ID: <20071219112035.GA5565@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com> <20071217224812.GA6342@diana.vm.bytemark.co.uk> <20071218052115.GA13422@diana.vm.bytemark.co.uk> <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com> <20071219093400.GA4361@diana.vm.bytemark.co.uk> <b0943d9e0712190209y485bc2f8w806bd2cad309e74b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4wz5-0003jf-9V
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbXLSLUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbXLSLUn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:20:43 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4749 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbXLSLUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 06:20:42 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J4wya-0001VM-00; Wed, 19 Dec 2007 11:20:36 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712190209y485bc2f8w806bd2cad309e74b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68883>

On 2007-12-19 10:09:40 +0000, Catalin Marinas wrote:

> For the 'status --reset', I'll keep it if we have a separate
> 'resolved' command.

?

> In the past, StGIT only used the core git functionality and stayed
> away from the porcelain scripts. We now started to use some of the
> built-in commands more and more and I think it is fine but the git
> scripts look more volatile to me than the C code (look at the many
> variants the git merging went through, from shell scripts to python
> and only now seems to be stabilised with the recursive merge as a
> built-in command).

Hmm? Have we started to use more porcelain lately?

> Adding the functionality I need to git-mergetool would also mean
> always using the latest GIT with StGIT.

It wouldn't keep being the latest git version, though.

> Anyway, if you like git-mergetool, I think you can easily change the
> StGIT configuration to

I don't use interactive merging at all. What I wanted was to get rid
of StGit's own interactive merging.

> On 19/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2007-12-18 16:09:24 +0000, Catalin Marinas wrote:
> >
> > > I also don't find 'git add' to be meaningful for marking a
> > > conflict as solved.
> >
> > So maybe let "stg resolved" be an alias for "git add"?
>
> It's not a simple alias, if you use 'stg resolved -a'. Now, if we
> allow stgit.keeporig, it needs even more functionality.

Hmm, yes.

(I still don't quite like it, because I think that if there's anything
that "stg resolved" does that "git add" can't do, then "git add"
should learn to do it. But until it has learned it, it's a
hypothetical argument.)

> > I think it'd be more productive to let stg do one thing -- patch
> > stacks -- and do it well, and rely on git for everything else.
>
> In principle, yes, but I have some minor problems with the UI of GIT
> (like resolved =3D=3D add). I think there is also a fundamental
> difference between 'git commit' and 'stg refresh'. The former
> requires explicit marking of the files to commit (or use the -a
> option) while the latter always adds all the local changes to the
> current patch. Maybe GIT users are more used to running 'git add'
> after fixing a conflict but I use StGIT almost exclusively.

So you want StGit to do two things: patch stacks, and fix some git UI
warts. Hey, I can live with that. :-) But I firmly believe that the
wart fixing parts of StGit should be (1) optional, so that the same
job can easily be done with just git; and (2) as thin as possible, to
make them easy to explain in terms of git, and cheap to maintain.

> > Of course, if stuff like "stg add" and "stg resolved" are really
> > implemented as three-line wrappers around git commands, we don't
> > have that problem.
>
> For add/rm/cp, they should just be a generic wrapper which doesn't
> even parse the command line options.

OK.

> That's not the case with 'resolved'.

No, I see.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

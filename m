From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 13:10:23 +0100
Message-ID: <20071219121023.GA6272@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com> <20071217224812.GA6342@diana.vm.bytemark.co.uk> <20071218052115.GA13422@diana.vm.bytemark.co.uk> <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com> <20071219093400.GA4361@diana.vm.bytemark.co.uk> <b0943d9e0712190209y485bc2f8w806bd2cad309e74b@mail.gmail.com> <20071219112035.GA5565@diana.vm.bytemark.co.uk> <b0943d9e0712190340p23341dd8lb9ebbbce9b29cb8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 13:11:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xlG-0004nF-UO
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 13:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbXLSMKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 07:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbXLSMKb
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 07:10:31 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2851 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbXLSMKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 07:10:31 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J4xkl-0001jF-00; Wed, 19 Dec 2007 12:10:23 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712190340p23341dd8lb9ebbbce9b29cb8e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68900>

On 2007-12-19 11:40:41 +0000, Catalin Marinas wrote:

> On 19/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2007-12-19 10:09:40 +0000, Catalin Marinas wrote:
> >
> > > For the 'status --reset', I'll keep it if we have a separate
> > > 'resolved' command.
> >
> > ?
>
> It needs to call the resolved_all to remove checked-out stages if
> stgit.keeporig =3D=3D 'yes'.

Ah, right.

> Maybe it could also do some sanity check if HEAD !=3D top. With 'git
> reset --hard', people might easily add an argument and break the
> whole stack.

True.

> > Hmm? Have we started to use more porcelain lately?
>
> I think Yann was complaining about using git-show since it looks
> more like a porcelain command.

We should probably use cat-file or something instead.

> > It wouldn't keep being the latest git version, though.
>
> Yes, but at least initially it should be pretty recent.

:-)

> > I don't use interactive merging at all. What I wanted was to get
> > rid of StGit's own interactive merging.
>
> I use it quite often and I even invoke it automatically
> (stgit.autoimerge). I'll push some patches tonight together with
> most of your safe branch and we can alter them afterwards.

Jolly good! My stack was getting unwieldy ...

> > So you want StGit to do two things: patch stacks, and fix some git
> > UI warts. Hey, I can live with that. :-) But I firmly believe that
> > the wart fixing parts of StGit should be (1) optional, so that the
> > same job can easily be done with just git; and (2) as thin as
> > possible, to make them easy to explain in terms of git, and cheap
> > to maintain.
>
> Unless you need the keeporig functionality, you can now always use
> plain git for solving merges, add/rm/cp, 'reset --hard' etc.

Yes, with David's conflict series.

> At some point, we could make it safe for 'git rebase' but I think we
> need the DAG patches.

I wouldn't resurrect the DAG patches for this; I'd just invoke "stg
repair" automatically when we detect that top !=3D HEAD.

But I think that for "git rebase", we'd want to teach "repair" to
detect that the patches' commits have been changed, rather than just
marking them unapplied.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

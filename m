From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 17:39:42 -0500
Message-ID: <537693aee4fdd_3e4812032fcc@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 17 00:50:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlQxm-0001I6-JA
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 00:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991AbaEPWuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 18:50:46 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:64876 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbaEPWuq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 18:50:46 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so3769387oag.30
        for <git@vger.kernel.org>; Fri, 16 May 2014 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Q01HVtqB7kiObHuI+zb52En/2VSX1Hkon9vdds9/IC0=;
        b=XEzPr02ZkquPwL5UAWqL/rQ8ndGw8wCsT9lsTdrc2Bf3ltFfc0WBdrJeh07LHkn2YD
         VYSBj40vpANJh024VsxmFMzntbE19M+dPpbPA6PKzxGdVnpMBOq+2c34UyfDoRA7fibq
         BdLh7BKViOcEToJFi5iN8Nex8W9MEbQ/cvpmkwRevnqzdVuNy8HydMBjrxRdLFDhwQFq
         R8MJUDkR80Xnk3Omu/Sy7sqRhRKRklSyHhksmk1q++VifKm2W/HHms6PwJtAyOV68vYl
         Zg5QXAF11/2eLHvn6C6WQTTAcHYdPoeuaTbfniPZwJYnKMOosM7bBU/NG+LWdthbzjpv
         agkQ==
X-Received: by 10.182.60.4 with SMTP id d4mr20643451obr.4.1400280645448;
        Fri, 16 May 2014 15:50:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b7sm9129000oed.7.2014.05.16.15.50.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 15:50:44 -0700 (PDT)
In-Reply-To: <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249426>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, May 15, 2014 at 03:56:29PM -0700, Junio C Hamano wrote:
> >
> >> Two announcements for their version 0.2 on the list archive are not
> >> quite enough to advertise them to their users.
> >
> > I do not think this README nor a mention in the release notes will get
> > their attention either, and many people (and packagers) will continue to
> > use the stale versions forever until those versions go away.
> >
> > I would much rather _replace_ them with a README in the long run, and
> > people will notice that they are gone, and then use the README to update
> > their install procedure.
> >
> > For 2.0, I am hesitant to do that, though I do not have a problem with a
> > README like this as a heads-up to prepare packagers for the future. I
> > say hesitant because people may have been test-packaging 2.0.0-rc3 in
> > preparation for release, and it will be annoying to them to suddenly
> > switch.
> 
> I share the latter two of the above three.  I was giving distro
> packagers a bit more credit for their diligence in knowing what they
> are packaging than you seem to be in your first point, but I admit
> that it is a blind faith.

I don't see why anybody would think otherwise. There are dozens of tools
in contrib/ many without documentation, or even a description of that
whey do. I bet most Git developers don't know what half of them do (even
a quarter), how are package maintainers supposed to know?

All the packages I've seen stash everything into /usr/share/git, with a
few exceptions, like shell completions.

> > But that being said, this is Felipe's code. While we have a legal right
> > to distribute it in v2.0, if he would really prefer it out for v2.0, I
> > would respect that.
> 
> I am fine with that.

Are you? Because in two of the three options you list below you wouldn't
be doing that.

> > I would prefer to instrument the code with warnings, as that is the sort
> > of thing a packager moving from -rc3 to -final might not notice, and
> > shipping the warnings to end users who did not package the software in
> > the first place will not help them. It is the attention of the packagers
> > (and source-builders) you want to get.
> 
> I do agree that a new warning every time it is run will be a more
> likely to grab users' attention.  The conclusion I draw from that
> shared observation is that the user will be annoyed all the time,

That's exactly what we do when anything gets deprecated. Try running Git
with an empty configuration for a day and you'll see tons of warnings,
often huge ones every time the user does common operations, like
`git push`.

Why is it OK to warn about minor behavior changes, but not when the
whole code the user is exercising might be broken?

At least the warning I proposed for the remote-helpers is small and to
the point, unlike the warning of `git push` without refspec.

> without having a power to do anything about the annoyance, until the
> report s/he (or other users) Throw at the packager, even when the
> version that was packaged hasn't diverged that much yet, which does
> not help end users.

What do you expect the packagers are going to do? They will simply
ignore the report as it's not related to their package (git).

I suspect this will continue for quite some time, and very likely these
will not be packaged as part of the official distribution, but some
user-based repository. In some distributions they might end up being
unpackaged completely.

Take git-imerge as an example, a very popular tool you yourself are very
fond of. I don't see it packaged either in ArchLinux, Debian, or Fedora,
and I don't think it will ever be packaged.

So, yes, this will hurt our users, that's what every user of an
out-of-tree tool must suffer, and that's what you unilaterally decided
users of git-remote-hg/bzr should suffer.

> I guess the ideal we want is to make sure their build break.

We cannot make 'cp -r contrib /usr/share/git' fail, that's all packagers
do.

I already pointed to the fact that most of the tools in contrib
shouldn't even be there, and that most of them should have tests. If
there was a standardized way to tests contrib, we could make the build
break. But you ignored my call of attention.

> What if we do the README in addition to rename contrib/remote-helpers
> to contrib/obsolete-remote-helpers (or s/obsolete/graduated/)?  It
> will give the packagers three choices and I think it hurts people much
> less.
> 
>  * The packagers that dump the entirety of contrib/ to somewhere
>    without doing anything to expose the scripts to user's PATH do
>    not have to do anything.  The users who chose to pick them up
>    from there notice the missing contrib/remote-helpers, notice
>    "obsolete" (or "graduated"), and read README.

This is wrong. Users will not notice the missing contrib/remote-helpers.
At least not initially. If they setup links to /usr/share, they'll just
see:

  fatal: Unable to find remote helper for 'hg'

Then they'll see the missing helper, read the README, then report the
problem to the packagers. Then they might include the obsolete
directory, or they might decide not to.

>  * The packagers that pick up from contrib/remote-helpers and
>    arrange the scripts to be on user's PATH will find their build
>    broken, because they are no longer where they expect them to be.
>    They will notice "obsolete"(or "graduated"), and read README.
> 
>    - They can choose to pick them up from "obsolete", perhaps for
>      expediency, perhaps for their change aversion, but that will
>      not last once we grabbed their attention, and they will switch
>      their upstream in some later release once such a choice makes
>      them feel dirty enough.
> 
>    - They can choose to switch their upstream right now in response
>      to the breakage.

That's not how packaging works.

Ask your friend Jonathan Nieder, the packager of Git for Debian, if he
would be interested in maintaining a new git-remote-bzr package. My
guess is that he wont. Maybe he would, but he can assure you that other
packages wont.

The fact of the matter is that users cannot depend on packages any more.
Maybe they'll be packaged, maybe not. If they are it will take a long
time before they do. In the meantime they'll have to manually install
them all all out-of-tree tools.

> I would say that the options I see are these three, and I would rank
> the "warn every time" as less helpful to end-users:
> 
>  - rename contrib/remote-helpers to contrib/obsolete-remote-helpers
>    and add README to point at the upstream.

I don't like this. This would only reward lazy packagers, it wouldn't be
clear to the user what happened at first, and even after they use the
new place, they wouldn't be disserviced by that code.

>  - remove contrib/remote-helpers scripts and add README.

Again, the user will still see an unhelpful message at first. I guess it
wouldn't be as bad as the option 1, but it's not as good as the patch I
proposed where they are replaced with stubs (plus a README).

>  - warn every time the user runs the scripts.

I suggested this, but only as a temporary measure.


I am surprised that we are talking about the ways to proceed, and which
ways would affect the users less, and what would be the repercussions.
In particular, your obvious disconnection from the way packaging is
done, I would venture to say you have never made a package in your life.
The fact that you think packagers of git would simply package
git-remote-hg/bzr as well is pretty appalling. You should have thought
about all this *before* making your stupid decision.

-- 
Felipe Contreras

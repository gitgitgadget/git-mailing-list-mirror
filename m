From: Nico Williams <nico@cryptonector.com>
Subject: Re: Rebase safely (Re: cherry picking and merge)
Date: Fri, 8 Aug 2014 13:27:36 -0500
Message-ID: <20140808182735.GC21575@localhost>
References: <53DBBFE8.8060607@gmail.com>
 <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
 <53DBF4C9.2090905@vilain.net>
 <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net>
 <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
 <96B703A6-58B0-458A-8A2D-699EA8F1941B@comcast.net>
 <20140806194457.GD23449@localhost>
 <A769B84E-42D1-44AC-B0A8-0F4E68AB71FB@comcast.net>
 <20140807051129.GJ23449@localhost>
 <894B9D26-F8C5-4C82-B04C-3B31094C2293@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Fri Aug 08 20:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFotC-0005qc-S6
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 20:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbaHHS1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 14:27:38 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:59130 "EHLO
	homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751002AbaHHS1i convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Aug 2014 14:27:38 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id 9D8FA1E076;
	Fri,  8 Aug 2014 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to:content-transfer-encoding; s=
	cryptonector.com; bh=l7gE8S37EHpQ0dqZyWSeew8qZ5Y=; b=YqU4wH72Po8
	X4p/aKJWX3UulVA26x0vFaENaYMl4SsXinmCweITQNQ4Yn2dq7Repe26ulMuU7aP
	wYB8arV8m8ksRcJ8/saOCp0/sT28lYpfBueKjkh1jkWypyuySXd0ja6DWdYC0hvy
	/XiGCSzESJsTe9NFYZGf1NHrHeZnKN3g=
Received: from localhost (108-207-244-174.lightspeed.austtx.sbcglobal.net [108.207.244.174])
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPA id 557C41E071;
	Fri,  8 Aug 2014 11:27:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <894B9D26-F8C5-4C82-B04C-3B31094C2293@comcast.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255062>

On Fri, Aug 08, 2014 at 10:34:43AM -0700, Mike Stump wrote:
> On Aug 6, 2014, at 10:11 PM, Nico Williams <nico@cryptonector.com> wr=
ote:
> > Nah.  Sun managed this for decades without a hitch, and for product=
s
> > much larger than GCC.  See above.
>=20
> Ok.  Ah, ok, perfect.  I see how that method of working would cure th=
e
> cherry-pick and merge don=E2=80=99t work problem mentioned at the top=
 of the
> thread.
>=20
> > Do some experiments based on the above hardcopy.  If that doesn't
> > convince you that it works, oh well, I'll have given it a good try.
>=20
> Thank you for taking the time to diagram that as it appears to violat=
e
> everyones how to use git guide.   I see the workflow does an onto,
> which was the =E2=80=98fix=E2=80=99 people talked about on stack over=
flow, and I see
> just how things would work.

There's nothing scary about --onto.  You're saying "figure out which ar=
e
my local commits (the ones on top of the previous upstream) and pick
them onto the new upstream".

We only need to do it manually (though it can be scripted[*]) because
git doesn't track rebase history so that it can be done automatically.

[*] And then there's Tony Finch's
    https://git.csx.cam.ac.uk/x/ucs/git/git-repub.git , which is kinda
    awesome!

> If the old master branches are deleted and gc is run, then all the ol=
d
> references go away, and then the refs from email and bugzilla then
> don=E2=80=99t work.  Did you guys ever remove them and then prune (or=
 gc)?

Product gates' repos and snapshots stuck around forever, though it was
Teamware, and finding really old ones wasn't necessarily easy,
particularly since their names didn't always reflect product names.

Prominent project gate repos and their snapshots also stuck around
forever.

Lesser project gate repos tended to be as ephemeral as the project.

> Now, the biggest issue, if that is recognized as `fixing=E2=80=99 the
> cherry-pick problem, then certainly the problem is understood to be a
> problem.  If one recognized it as a problem, then one can envision

Not really.  This isn't about git.  We followed a rebase-only workflow
with VCSes that nominally didn't support rebase.  We did it because it
was easier on everyone and kept history in the upstream clean.  We
didn't do it because git has issues when combining merge and
cherry-pick.

> cherry-pick and merge working together so that the problem doesn=E2=80=
=99t
> need fixing in the first place.  And, if it doesn=E2=80=99t need fixi=
ng, then

If you buy into the Sun model then this is all a non-issue.  If you
don't then I think you have other problems (because I have bought into
the Sun model) :)

> the cost of the solution isn=E2=80=99t needed either.  The biggest pr=
oblem
> with git, is that two features don=E2=80=99t work nicely together whe=
n they
> [...]

The Sun model has no additional cost.  It moves costs around so that th=
e
people dealing with conflicts are the downstreams, not the upstreams,
and that's exactly as it should be.

(Keep in mind that Solaris gates tended to have large numbers of commit=
s
on any given day, so it was quite common that one would have to rebase
multiple times before successfully pushing.  For large projects with
long test cycles the gates would close to avoid the need to rebase and
re-test.)

> I still favor fixing the underlying problem with cherry-pick and merg=
e
> not working.  :-)  That said, I see how to work around the bug with
> rebase, if I need to.

IMO it could be done, but I can't help that.

> I wish the top google hit were your guide and I wish I never saw all
> the other pages=E2=80=A6  I see now your position, and I see why all =
the

Me too!  I should blog it.

> guides are wrong, if you know just how to use rebase.  I wish the git
> documentation were improved to say as the first sentence under

The Sun model is not the only way to use git though.

> cherry-pick, this feature sucks and doesn=E2=80=99t really work well,=
 it can
> cause excess merge conflicts.  rebase can be used to work around the
> bugs in cherry-pick for now.  And under rebase, instead of saying wha=
t
> it said now, that how one can can trivially and effortlessly use git,
> instead of saying, Do not rebase commits that you have pushed to a
> public repository which I now see is wrong.

I'm glad you understand the Sun model now.  You should evaluate its
applicability to your use case on its own merits.  Don't use it just to
workaround a problem in git; use it because it's good, or don't use it
because it doesn't fit your team's needs.

Nico
--=20

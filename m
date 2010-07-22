From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 21 Jul 2010 21:09:06 -0400
Message-ID: <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 22 03:09:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObkI6-00078R-Lw
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 03:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab0GVBJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 21:09:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41272 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab0GVBJa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 21:09:30 -0400
Received: by wyf19 with SMTP id 19so170530wyf.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 18:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1vn52UmyYf7AK/r3EjrsHvirmxdQop7Jeex8REbiDVY=;
        b=XgVfqpBcD4kV0JoHTvxTPyObrUm9lrnZPUWi4zxTEcoAv7ks9wsQcCuBIdknpRuzNx
         KX6PjFWdcF5Qaqdaw5NZ8VZGrhP5fYMeNemF9bmiPSAADUajYcFuNiRnA1dXrFBHgcz6
         M/4euy86mpFYs5kGedrbOfIePlbR++S854xPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=V2CTrJ+eEK+M9v0Wf5eoEBUswpiUI0nURB0WEeJy+vWn0ZnsFLBn910wZWFWu2mg04
         uGwxGutwO7CdjRTBOmqKRHoHrk0+sxVxnlu0Ncd6OHOPlaQTL0+yfS2qLeSSBRK4Xsd4
         YKNPFT5It/dLTRAe61b/wM6FTy8gYDrZzKo1Q=
Received: by 10.227.155.82 with SMTP id r18mr1035072wbw.70.1279760966264; Wed, 
	21 Jul 2010 18:09:26 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 21 Jul 2010 18:09:06 -0700 (PDT)
In-Reply-To: <4C4778DE.9090905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151439>

On Wed, Jul 21, 2010 at 6:46 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 21.07.2010 23:09, schrieb Avery Pennarun:
>> What we *really* want is a way to have git actually recurse through
>> commit objects when doing *any* operation, as if they were tree
>> objects.
>
> This would not be useful for every work flow (or to put it in other
> words: this is not what I *really* want ;-). And as you pointed
> out, that only works when you have a single repo you are working
> against (like you do in your subtree model).

But you see, the utter failure of the way git-submodule works is that
it required a change to the git repository format, but that repository
format change resulted in absolutely *zero* improvement.

The tree object of the parent points at 'commit xxxx'.  But everything
in git has been *specially modified* to *just ignore* that 'commit
xxxx'.  It would have given exactly the same functionality - and much
less confusingly - if .gitmodules would just include the desired
commitid of the child project.  You could still have the same 'git
submodule' command with the same syntax and semantics.  And it
wouldn't have bastardized the git repo format.

It would have been just as good to just dump something into your
Makefile to go 'git clone' the subprojects from somewhere before
building.  Seriously, it would be one or two lines of code; all of
git-submodule replaces about one or two lines of code in your
Makefile.  And you know what?  If I just used that one or two lines of
code, I'd have all sorts of flexibility in where the subprojects get
cloned from, which I currently don't have, and which is the insanity
that drove me to write git-subtree in the first place.

HOWEVER

I'm not saying we can change that now.  I'm not suggesting that this
feature can be safely removed or changed at all.  Furthermore, I
totally agree that having large subprojects *not* be in your repo is
sometimes a good idea.  I just think it was actually a bad idea to
intrusively add support to git to implement this when it could have
been done without modifying git at all.

I also believe that the vast majority of people who use git-submodules
would rather have it work differently.  (Again, this is not to
subtract functionality.  The existing functionality is useful
sometimes.)

> But unless I got something wrong (which might very well be the
> case, as I never have used subtree myself), all changes to the
> subtree will only show up in that single repo, unless you actively
> push them somewhere else. And that, it seems to me, is as easy to
> forget as you can right now forget to push a submodules commit you
> already recorded and pushed in the superproject). So am I wrong
> assuming that subtree is more focused on a single repo containing
> all commits which /might/ then be shared, while submodules are
> about /always/ sharing code via their own repo?

Yes, this is absolutely intentional.  It also matches exactly with
everything else in the git repo philosophy!

I make my own clone.  I mess with it, I fiddle with it, I make 17
clones on my local machine, I throw away what I don't like, I pull
merge, I rebase, and then *eventually* I submit *some* of my patches
upstream.  git-subtree lets you do all those things.  git-submodule
stomps on you repeatedly if you try.

To wit:

- cloning a local supermodule on my local machine to another copy:
every call to 'git submodule update' re-downloads submodule repos from
the remote machine, because the submodule path is hardcoded to point
at a remote machine.  Better still, if I've modified any of my
subprojects without pushing changes upstream, the clone will fail,
because the new copy of the superproject will have no access to my
subproject's patches.  (If .gitmodules supplies a relative path, it's
even worse, because my 'origin' in the new copy is now pointing to a
local folder, not a remote one, and all the submodules don't exist
there.)

- branching a local supermodule on my local machine: fails to branch
the submodule automatically and makes it super easy to lose patches
altogether (since by default, they're committed to a detached HEAD).

- pulling/merging: always causes a conflict if local and remote have
modified the same submodule.

- rebasing: always causes a conflict if local and remote have modified
the same submodule.  Also requires you to rebase submodules separately
from the supermodule.  (Yes, this happens often in real life.)

- submitting upstream: requires me to have a separate repo that's a
copy of the upstream repo, and to manage at least one subrepo branch
for every superproject branch, just to track my submissions.  With
git-subtree, no extra repos are necessary.

It's very clear that git-submodule's current behaviour totally
mismatches the entire git philosophy.  That's why it's so impossible
to make the git-submodule command usable.

Another mental exercise: try to think of any other part of git where
it would be considered remotely acceptable to put the absolute or
relative URL of one repo inside another repo.  git URLs are an
implementation detail of clone/fetch/push/pull.  The *content* that
git manages should not have to deal with that stuff.  With
git-submodule, it has to.  With git-subtree, it doesn't.

>> There is no good solution to the submodule problem if each submodule
>> has to go in its own repo. =A0I've been thinking about this for year=
s
>> now, and watching lots of discussions about it on the git mailing
>> list, and I just can't see any other option. =A0All the submodules h=
ave
>> to get pushed to and fetched from the same repo by default. =A0Anyth=
ing
>> else is insane.
>
> I have to object here. Your insanity is someone else's work flow ;-)

Sorry.  I was being a little hyperbolic.  Some people might want to do
use multiple repos for certain things - but I believe those people are
much more rare than the kind who want to do it my way.  And
furthermore, even those people would probably actually like it better
if *most* of their subprojects - the smallish ones - could be all in
one repo.

Even if you like multiple repos, I'm sure you don't like being
*forced* to manually fork multiple repos just to fork a single
superproject.  I'm sure you don't like updating .gitmodules to change
the absolute URL of a submodule, and then getting merge conflicts when
someone else had to do the same thing.  There's no way you like that.
If you like that, then you really are insane. :)

> And I am the last one not to admit that there are some severe
> usability warts still to be fixed for submodules (I put up a - not
> necessarily complete - list at
> http://wiki.github.com/jlehmann/git-submod-enhancements/ ). And
> myself and others are actively working on them (the next bigger
> thing after a new config option about when to consider a submodule
> modified are recursive checkouts, so that "git submodule update"
> will hopefully be almost obsolete in the near future).

I don't believe you can fix git-submodule by fixing surface warts.
It's fundamentally broken.  Since we're stuck with supporting the
current behaviour at the end of time, fixing the surface warts might
be necessary and even mildly helpful.  It will also be soul sucking
since no matter how hard you try, people will still hate the result.

Have fun,

Avery

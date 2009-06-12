From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 11:29:09 -0400
Message-ID: <1244818580-sup-60@ntdws12.chass.utoronto.ca>
References: <20090612084207.6117@nanako3.lavabit.com> <4A32366A.6090608@op5.se> <1244807741-sup-7206@ntdws12.chass.utoronto.ca> <20090612140229.GA14628@coredump.intra.peff.net> <1244817396-sup-7368@ntdws12.chass.utoronto.ca> <20090612144857.GA20691@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1244820555-359115-27054-3813-5-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: GIT List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 17:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF8h2-0001zO-69
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 17:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbZFLP3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 11:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbZFLP3P
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 11:29:15 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:35505 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZFLP3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 11:29:14 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:52453 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1MF8gu-0001GC-Ev; Fri, 12 Jun 2009 11:29:16 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1MF8gu-0007qF-2m; Fri, 12 Jun 2009 11:29:16 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n5CFTF8Z030143;
	Fri, 12 Jun 2009 11:29:15 -0400
In-reply-to: <20090612144857.GA20691@coredump.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121430>


--=-1244820555-359115-27054-3813-5-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Jeff King's message of Fri Jun 12 10:48:57 -0400 2009:
> [any reason not to keep this on the git list?]

...no, I just forget to set the CC.

> On Fri, Jun 12, 2009 at 10:36:46AM -0400, Ben Walton wrote:
> 
> > I've aliased 'ci' to 'commit -s', and people either use the alias or
> > are encouraged to add the -s (it is by convention only, after all).
> > We've then setup the root shell such that $USER is leveraged to source
> > in some personalized shell when su is used.  This is where we set
> > GIT_COMMITTER_* on a per-admin basis.  People not doing that edit the
> > SoB line while editing the commit message...this fails with 'ci -m'.
> 
> Makes sense. I have a similar setup where people could be identified by
> the ssh keys they use to log in, but I have never gotten around to
> setting up something automated.
> 
> I suspect SoB may be more convenient than GIT_AUTHOR_* in your scenario
> just because you can tweak the former in the editor, as you note (and it
> sounds like it's possible to not have the other variables set up
> properly in your setup).

It is easier from that perspective, but since nothing is forcing the
use of -s, we'd have the same compliance if we wanted to ask people to
use --author (or set the proper environment).

> > Actually, I'm still wavering on which I'd prefer.  At this point,
> > since git is still fairly new for us in this capacity, we're feeling
> > our way through things.  I went with COMMITTER instead of AUTHOR
> > though since that tends to stand out more in `git log` (at least to my
> > eyes).  Since we're not a finger pointing group :), things like `git
> 
> I would argue that you should do the opposite. AUTHOR is really about
> "who wrote this change" and COMMITTER is about "who put this change into
> the repo". So to me, "Bob wrote the change, logged in as root@box2, and
> committed" should be AUTHOR=Bob, COMMITTER=root@box2.

Your described usage is more semantically correct.  It may make sense
for us to switch to AUTHOR, so that in the future we could pinpoint
changes with less hassle.  I'll be discussing this with my colleagues
shortly.

> But I am coming at it from the perspective that the author is of more
> interest. Finger-pointing aside, I find asking the author is the best
> thing to do when the commit message doesn't quite explain why a change
> was made. But if you think the shared account used to commit is of more
> interest, then it does probably make sense to mark it as the author.

Yes, that's a good point.  We're trying to get in the habit of
referencing ticket id's in commit logs as well, which does mitigate
bad commit messages somewhat.  It doesn't help when a change isn't
driven by a ticket though.

> > blame` aren't typically used in this scenario.  We're more interested
> > in moving away from a `cp -p $file $file.date.initials` style of
> > version control.  (Yes, I know...)
> 
> I think we've all been there. ;)

We're currently testing etckeeper on a few boxes with git as the
backend so that we can move away from individual repos too.  One
stumbling block for us here is that we have a mixed shop and solaris
seems to grow etc directories all over the place! :) etckeeper has a
-d option, but that gets annoying to remember.

> > Some of our other shared projects are managed through gitosis repos,
> > so this doesn't come into play, as people edit the files in their own
> > accounts and push to the central area.  We have our bind config and
> > zones managed this way.  The files are published to our dns servers
> > after a push iff `named-checkconf -z` passes.
> 
> I have tried this, too, but it can get annoying very quickly. In order
> to really deploy and test you have to commit, which discourages quick
> "is this config right?" testing. Which is maybe a good thing on
> production servers, but sometimes you need to do some trial and error to
> diagnose a configuration problem.

In our case, it's not that onerous, since our config is fairly static
in terms of new zones, etc.  I've mitigated this for my own repo by
having a pre-commit hook run named-checkconf too...it's a fast check
so it doesn't hurt much.  If it's clean on my box, it'll be clean on
the servers too, since we're on the same versions of the software.
Any real config problems or major upgrades would be handled with test
environments too, so we're not normally worried about test changes
with this.

Having bad changes kicked out before they're made live has been nice,
although in practice they don't happen that often.  We'd likely be
better served to ensure that changed zone files have newer serials
than the live versions..

Previously, we made changes directly to the copy of the files that
cfengine distributed, so bad edits were seen by the live boxes.  With
this setup, we can still make semantic errors, but syntax problems are
gone.

We don't use this technique for things that lend themselves more to
'quick test' style changes (like adding a new input to our cfengine
setup).  Things aren't typically committed to these repos until the
change is verified though.  This keeps our history cleaner, which is
nice when we're not leveraging branches and personal working copies
and all the other really strong points of git.

Git is making our lives easier, but as you can see, we're still in a
state of flux wrt best practices, etc.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1244820555-359115-27054-3813-5-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFKMnRL8vuMHY6J9tIRArJRAJ0R6mecwHHji+8Wf8StdRe239MopQCgvKTu
ojgRyUcehTOg5YjfrffoE3I=
=7hd3
-----END PGP SIGNATURE-----

--=-1244820555-359115-27054-3813-5-=--

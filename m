From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Thu, 7 May 2009 00:50:42 +0200
Message-ID: <20090506225042.GN15420@raven.wolf.lan>
References: <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com> <20090430222808.GH15420@raven.wolf.lan> <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com> <20090501142811.GI15420@raven.wolf.lan> <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com> <20090502215852.GJ15420@raven.wolf.lan> <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com> <20090504211423.GK15420@raven.wolf.lan> <20090506185224.GM15420@raven.wolf.lan> <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 01:01:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1q6o-0007to-RC
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbZEFXAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 19:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbZEFXAM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:00:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:44300 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928AbZEFXAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 19:00:10 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M1q5y-00047s-7R; Thu, 07 May 2009 01:00:10 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id C592E2CCC1; Thu,  7 May 2009 00:50:42 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118403>

On Wed, May 06, 2009 at 03:23:40PM -0400, Avery Pennarun wrote:
> On Wed, May 6, 2009 at 2:52 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > Here's what I have at this point:
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 ------------------S1TRUNK
> > =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /
> > =A0 --hs1--O1--c2...c2-------S1
> > =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> > =A0 =A0 =A0 =A0 =A0 =A0 `+++++++. =A0 =A0/
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0/
> > =A0 --hs2--O2--c1...c1--S2
> > =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0\
> > =A0 =A0 =A0 =A0 =A0 =A0 -------------S2TRUNK
> >
> > =A0 hs1, hs2: =A0 =A0 =A0 =A0 history imported from svn-1 and svn2,=
 respectively
> > =A0 O1, O2: =A0 =A0 =A0 =A0 =A0 the svn-1-orig and svn-2-orig tags
> > =A0 c1, c2: =A0 =A0 =A0 =A0 =A0 cherries picked from hs1 and hs2, r=
espectively
> > =A0 S1, S2: =A0 =A0 =A0 =A0 =A0 svn-1 and svn-2, the local tracking=
 branches
> > =A0 S1TRUNK, S2TRUNK: the remotes/svn-X/trunk branches
> >
> > I would have expected a symmetrical diagram. =A0But it turns out th=
at the
> > connection marked with plusses is still at O1 instead of S1. =A0So =
it takes
> > no wonder that the c2 cherries get re-applied to the s2 branch on t=
he
> > next merge.
>=20
> That's a well-drawn diagram, but unfortunately I'm still confused.
> What is the "connection marked with plusses" and does it have a name?

Well, the whole history (including this connection) was created by the
commands I posted.  The only exception are hs1 and hs2, which were
imported from the svn repositories (but they are linear).

AFAICS, this connection was created by the very first merge after the
cherry-picking from hs1 (the cherries marked as c1..c1).  After importi=
ng
the svn repositories, I've done this:

  git checkout svn-2                # S2 in the diagram above, but used
                                    #    to be identical to O2 at that =
time
  [ cherry-picking c1...c1 ]        # S2 now moved to its place in diag=
ram
  git merge --no-ff -s ours svn-1   # S1 in the diagram above, but used
                                    #    to be identical to O1 at the
                                    #    time of that merge, This merge
                                    #    creates the mystical
                                    #    "connection marked with plusse=
s"

Then we've done the "detached head" merge, that created the S2TRUNK

  git checkout svn-2/trunk    # S2TRUNK was at O2 at that time
  git merge --no-ff svn-2
  git svn dcommit             # moves S2TRUNK to the place in the diagr=
am

Now take care of the other direction:

  git checkout svn-1                # S1 in the diagram above, but stil=
l
                                    #    identical to O1 at that time
  [ cherry-picking c2...c2 ]        # S1 now moved to its place in diag=
ram
  git merge --no-ff -s ours svn-2   # S2 in the diagram above.  Unlike =
S1,
                                    #    S2 already _is_ at the place w=
here
                                    #    it is drawn in the diagram.  S=
o
                                    #    this merge creates the connect=
ion
                                    #    S2->S1

Now we do the "detached head" merge, that creates the S1TRUNK

  git checkout svn-1/trunk    # S1TRUNK was at O1 at that time
  git merge --no-ff svn-1
  git svn dcommit             # moves S1TRUNK to the place in the diagr=
am

So the "connection marked with plusses" is basically the counterpart of
the "S2->S1" connection.  But while "S2->S1" got its proper position at
the time it was created, the plus-connection was created before the c2
cherries.  And it was never adjusted.  AFAICS, those two connections
should be symmetrical: "S1->S2" and "S2->S1".

> It *looks* to me like both S1TRUNK and S2TRUNK should be okay, but
> it's hard to tell what has actually happened here.

Yes, the trunks (and the svn repositories) look pretty good at _that_
point in time.  But the next merge on S2TRUNK moves all the modificatio=
ns
done by the c2 cherries down to S2TRUNK.

> If you could post a screenshot of 'gitk --all' it might help.

IMHO, Screenshots are not of much help here.  That's why I posted

  http://www.spinics.net/lists/git/msg102609.html

The svn histories are about 1250 commits each.  The cherry-pickings are
about 350 commits each.  This gives histories running in parallel for
long distances.  Add to this gitk's tendency to change lanes at every
occasion:  There's no chance to get multiple screen shots (the interest=
ing
branch/merge-points, as I described in the thread referenced above) in
sync.  There's many opportunities to get confused.  At least for me, as=
 a
newbie to git.

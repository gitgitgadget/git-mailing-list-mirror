From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] git commit --branch
Date: Tue, 30 May 2006 23:05:52 +0200
Message-ID: <20060530210551.GI14325@admingilde.org>
References: <20060529202851.GE14325@admingilde.org> <7vr72b27x9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 23:06:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlBPd-0006Kp-F3
	for gcvg-git@gmane.org; Tue, 30 May 2006 23:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWE3VF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWE3VF6
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 17:05:58 -0400
Received: from admingilde.org ([213.95.32.146]:32996 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932424AbWE3VF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 17:05:57 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FlBPU-0005m7-DU; Tue, 30 May 2006 23:05:52 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr72b27x9.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21044>


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, May 30, 2006 at 02:12:02AM -0700, Junio C Hamano wrote:
> I think this was discussed in the past and I appreciate what you
> are trying to do.  My understanding of the situation your patch
> is trying to improve is this:
>=20
>  - you have done a few topics and you are ready to test;
>=20
>  - you pulled the topics into your test branch and have found
>    problems;
>=20
>  - you made changes while still on the test branch (otherwise
>    you wouldn't be able to test the "fix") and it seems to work
>    OK;
>=20
>  - what now? =20
>=20
> And your approach is to backport the fix to its original topic
> and then re-pull the topic onto the test branch.

yes. I was doing this after working on gitweb a bit.
In order to test gitweb, I need some local adaptations.
I commited these to one branch and put all improvements to
another branch.  Then I merged both branches to one production
path which is then used by the webserver.

> While I think that is _one_ valid workflow, I am not convinced
> that is _the_ best workflow.

Me neigther.
That's why I labeled it RFC and published it before doing too much
testing and polishing ;-)

> What Johannes suggested would
> equally work fine, and honestly speaking probably is a better
> discipline.

He suggested to create a new branch (based on current HEAD) for the
new commit.  Unfortunately that doesn't solve my problem.

> You carry the fix in your working tree back to its
> original topic and make a commit, without pulling the topic onto
> the test branch immediately.  This has two advantages:
>=20
>  - With your workflow, you will have a merge commit onto the
>    testing branch immediately when you commit this fix to the
>    original topic.  But often when I encounter this situation,
>    after moving to the topic to backport the fix to it, I find
>    myself reviewing what is in the topic and making other
>    changes to the topic.

Of course you can do this also while you are still on the test branch.

While looking at code I often see unrelated stuff which can be cleaned
up.  With something like commit --branch it would be possible to stuff
these changes to a "trivial" branch without having to change branches
explicitly.

> Johannes's workflow feels more natural
>    to me from this aspect -- I take the fix I discovered while
>    on the testing branch to the relevant topic to fix it.  I may
>    or may not make the commit only with that fix (the first
>    commit I make after switching the branches from testing to
>    the topic may contain more than that fix), and after I make
>    one commit, I may keep working on the topic a bit more before
>    I decide it is a good time to test the whole thing again (to
>    pull the topic into testing).  I do not necessarily want that
>    extra merge immediately in the test branch.

But if your commit to the topic is really different to previous
commit on the test branch then you may have merge problems later.
If you merge immediately, you even get the merged tree for free ;-).
The testing branch is more like a throwaway-branch for me.
I can recreate it anytime if I want and I don't care about extra
merge commits here.

>  - A topic branch should be testable alone;

That would be best, yes.
Unfortunately it didn't work for me.
Well I guess I could have put more effort on changing gitweb to
be more general so that I don't need local adaptations.
But I guess there are situations where this is not possible, too.
Of course, now we have to answer the question whether GIT should
support these situations.  I don't know.

--=20
Martin Waitz

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEfLOvj/Eaxd/oD7IRArUmAJ905oPjz/ov0PQb+UsgkHdD3uODIwCfaRd2
kQXnuY3nV8uem0tA66JGBhg=
=Y1uH
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--

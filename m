From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] git-rebase -i: have an option for amending the commit
	message only.
Date: Thu, 12 Jun 2008 00:51:07 +0200
Message-ID: <20080611225107.GB7200@leksak.fem-net>
References: <1213196490-7762-1-git-send-email-madcoder@debian.org> <48501B3D.3000405@free.fr> <20080611222744.GD16439@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Cc: Olivier Marin <dkr+ml.git@free.fr>, git@vger.kernel.org,
	gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 00:52:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ZAr-0004Kw-3S
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 00:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbYFKWvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 18:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbYFKWvN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 18:51:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:37113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753260AbYFKWvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 18:51:12 -0400
Received: (qmail invoked by alias); 11 Jun 2008 22:51:10 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp023) with SMTP; 12 Jun 2008 00:51:10 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18CNgYm1ZoCMkXoWGA1EHnWVBiSiK3MH6QE9Ybin7
	w7FYvaZGvXkpDA
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K6Z9n-0000PN-Ef; Thu, 12 Jun 2008 00:51:07 +0200
Content-Disposition: inline
In-Reply-To: <20080611222744.GD16439@artemis.madism.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84676>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I want to add a quick note as the one who is currently responsible for
future git-sequencer ;-)

> > > +		comment_for_reflog comment
> > > +
> > > +		mark_action_done
> > > +		pick_one $sha1 ||
> > > +			die_with_patch $sha1 "Could not apply $sha1... $rest"
> > > +		output git commit --no-verify --amend -e -C HEAD

I dislike that "comment" does a pick.
Well, your version is consistent with the rest of rebase-i, but=20
inconsistent to the more atomic and general approach of the
git-sequencer thread.

You use
	comment deadf00
instead of
	pick deadf00
Would you mind if you had to use something like this:
	pick deadf00
	comment
to reedit the message of deadf00?

The difference for you as vim user is that you won't type "<Home> c w comme=
nt",
but "o comment" :-)
The outcome is that you can also use it for patches, not only for
cherry-picks ;)

>   To be fair, if someone has a better name, I'm all for it.

What about "amend"? :)
=2E..or "amend-message" or something like this.

> I quite care about the feature, edit needs me to run the --amend myself,
> whereas I often just want to fix a typo in a commit log.

I understand ;)

Well, I like to add it to the sequencer spec and to the prototype as soon=
=20
as the name is clear ;-)

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIUFbbbt3SB/zFBA8RAjAVAJ0b2tnj02LAfzWtDUyJcbPdCisbMQCgxNMJ
7UVS+BsMyILjhSyGRjk18Dc=
=jZae
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

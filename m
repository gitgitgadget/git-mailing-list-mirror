From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as  errors.
Date: Thu, 19 Jun 2008 18:28:01 +0200
Message-ID: <20080619162801.GA2468@artemis.madism.org>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org> <20080619133747.GA31209@sigill.intra.peff.net> <20080619135159.GA19560@artemis.madism.org> <20080619151110.GA31654@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="X1bOJ3K7DJ5YkBrT";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 18:29:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9N1K-0006nA-3K
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 18:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946AbYFSQ2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 12:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756430AbYFSQ2O
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 12:28:14 -0400
Received: from pan.madism.org ([88.191.52.104]:46167 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757870AbYFSQ2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 12:28:04 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 547AEBC4;
	Thu, 19 Jun 2008 18:28:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 939DA513B6D; Thu, 19 Jun 2008 18:28:01 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20080619151110.GA31654@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85488>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2008 at 03:11:10PM +0000, Jeff King wrote:
> On Thu, Jun 19, 2008 at 03:52:00PM +0200, Pierre Habouzit wrote:
> > >   - there is a possible danger with "git push -f", in that you force
> > >     both rejected branches as well as stale branches. Junio and I
> >   Well afaict this is a separate issue, as we're (with such a patch)
> > only changing what gets printed on the console, not the internal
> > behavior. So solving this second issue should not really be a
> > precondition to the inclusion of such a patch.
>=20
> It is a separate issue, but it is exacerbated by hiding stale refs.
> Imagine:
>=20
> $ git push
> To /path/to/repo
>    ! [rejected]        master -> master (non-fast forward)
>=20
> $ git push -f
> To /path/to/repo
>    + 0abfa88...c1ed93b master -> master (forced update)
>    + 0329485...3498576 stale_branch -> stale_branch (forced update)
>=20
> I think that is a nasty surprise to spring on an unsuspecting user.
> Another solution might be "-f" not pushing rewound branches, but then we
> need a way to specify "no, really, push this rewound branch". Perhaps
> "-f -f"?

  Well then we could keep the [stalled] lines for now until this issue
is resolved then, despite what the people at the beginning of the other
thread complained about. My real issue is that I have my shell
configured so that my prompt becomes inverted if the last command
failed. So do many people I know, and well, git push for stalled
references should just not generate an error. _this_ is my sole concern
:)

> >   Please please please do :)
> >   The exit 1 of git-push is really annoying me these days.
>=20
> OK, I will try to take a look in the next few days.
>=20
> -Peff

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhaiQ8ACgkQvGr7W6HudhwNGgCeKKebi+wjl7uEbqneifxgqI36
0BMAn1BTfvWLQ7WtYw/qLOKx5q5mRHxe
=IckY
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

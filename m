From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Thu, 24 Aug 2006 09:50:05 +0200
Organization: Polytechnique.org
Message-ID: <200608240950.08187.madcoder@debian.org>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net> <115637597423-git-send-email-madcoder@debian.org> <7vbqqbgf79.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1857930.2uJHUoDO5r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 09:50:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG9ym-0002DU-Q1
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 09:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWHXHuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 03:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWHXHuN
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 03:50:13 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:50368 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S1750716AbWHXHuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 03:50:11 -0400
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id BA3DD331E7;
	Thu, 24 Aug 2006 09:50:09 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vbqqbgf79.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Thu Aug 24 09:50:09 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000015, queueID=EA4AC331EA
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25945>

--nextPart1857930.2uJHUoDO5r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le jeu 24 ao=FBt 2006 02:17, Junio C Hamano a =E9crit :
> Pierre Habouzit <madcoder@debian.org> writes:
> > Allow a form of virtualhosting, when %h format is used.
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >
> >     This is intended to be a more flexible solution, that also
> > gives virtual hosting as a bonus. I still see no way to deal with
> > older clients when virtual hosting is used by the admin though,
> > having a "default" hostname won't solve anything at all anyway.
>
> I mildly disagree about the last sentence.  Enabling virtual
> hosting does not have to mean all virtual hosts are treated
> equal.  It is conceivable that a site hosts the primary,
> "collection of public repositories everybody would want to go
> to" set, with supplemental ones for specific audiences that are
> done via virtual hosting.  General public who would want to
> access the primary one can come with older clients that way, and
> only the narrower audiences have to be told to upgrade.

hmm, yes, that's indeed fair. Well, adding a --default-hostname that is=20
used if no host=3D is passed is completely obvious and straightforward=20
and solves that issue.

I also spotted a bug in the git_path_fmt function, I test 'pos' at the=20
end of the loop, but the overflow test is not done when there is no=20
format involved, wich could /theorically/ lead to buffer overflow. So=20
please disregard that issue, I will at least provide a patch that fixes=20
that.

> Haven't looked at the rest of the patch yet.  Will comment
> later.
np, TIA

=2D-=20
=B7O=B7  Pierre Habouzit
=B7=B7O                                                madcoder@debian.org
OOO                                                http://www.madism.org

--nextPart1857930.2uJHUoDO5r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE7VowvGr7W6HudhwRAhgRAJ41r3/a2AHS1YkPBxXYXUzJXww1/gCeJ1gm
e/CzBqJbNL3We7Xto1VCn5k=
=PuIn
-----END PGP SIGNATURE-----

--nextPart1857930.2uJHUoDO5r--

From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Use parseopts in builtin-fetch
Date: Mon, 05 Nov 2007 09:55:13 +0100
Message-ID: <20071105085513.GB25574@artemis.corp>
References: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wzJLGUyc3ArbnUjN";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 09:55:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioxk8-00042Z-Ij
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 09:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbXKEIzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 03:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXKEIzQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 03:55:16 -0500
Received: from pan.madism.org ([88.191.52.104]:44814 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbXKEIzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 03:55:14 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9B3D5258FA;
	Mon,  5 Nov 2007 09:55:13 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 409D994E4; Mon,  5 Nov 2007 09:55:13 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63490>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 03:35:34AM +0000, Daniel Barkalow wrote:
> I mostly did this and the next one for practice with the API. I'm=20
> impressed that "git fetch -vv" is even handled correctly without anything=
=20
> special.

  About that: OPTION_BOOLEAN increments the associated variable, to
support this case specifically.

  The last thing that really miss in parse-options is a way to recurse
into a sub-array of struct option, to be able to port the generic diff
and revision arguments.

  Though, there is a difficulty here that I've not yet found how to
circumvent tastefully: right now options take an absolute pointer to
_the_ variable that will be filled with values. I need to be able to
relocate such a structure for sub-arrays for quite obvious reasons, and
that is quite hard to achieve without hazardous APIs. I currently lean
in the direction of simply memdup-ing the array and do fix-ups on
*values pointers. Though how to do that in a graceful way is not obvious
to me yet :)

  This is the issue that currently prevents me from migrating any log
and diff based, though git diff -wbBCM that doesn't work is irritating me
more and more every day, so I'm confident I'll find a solution soon :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLtpxvGr7W6HudhwRAhb+AKCZJzDzD0aGfDMG83oiYEhuRXPh7gCgnTVF
T+i9/dJTyFwZEC63ym3hwfU=
=bjzB
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

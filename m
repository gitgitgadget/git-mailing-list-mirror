From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Bring parse_options to the shell
Date: Fri, 02 Nov 2007 17:09:25 +0100
Message-ID: <20071102160925.GC27505@artemis.corp>
References: <1194016162-23599-1-git-send-email-madcoder@debian.org> <20071102151453.GB27505@artemis.corp> <alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="KN5l+BnMqAQyZLvT";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:09:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inz5a-00056l-7q
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 17:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbXKBQJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 12:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbXKBQJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 12:09:28 -0400
Received: from pan.madism.org ([88.191.52.104]:42011 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbXKBQJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 12:09:27 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5B66127D65;
	Fri,  2 Nov 2007 17:09:26 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8A99C2E37; Fri,  2 Nov 2007 17:09:25 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63141>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2007 at 03:51:13PM +0000, Linus Torvalds wrote:
>=20
>=20
> On Fri, 2 Nov 2007, Pierre Habouzit wrote:
>=20
> > On Fri, Nov 02, 2007 at 03:09:18PM +0000, Pierre Habouzit wrote:
> > > This is also something that itches me, so here is a proposal for a
> > > git-parseopt helper that can be used in shell scripts as an option
> > > normalizer like getopt(1) does.
> > >=20
> > > I migrated the discussed git-clean.sh to use it as a proof of concept.
> >=20
> >   Needless to say, this is fetchable from
> > git://git.madism.org/git.git#ph/parseopt
>=20
> Hmm. Any reason why you didn't just extend on "git rev-parse"?

Because I wasn't aware of the fact it was used to massage arguments of a
function :) Though looking at the code git-rev-parse looks quite
complicated and does not works the proper way:

It show()s the arguments along the way, whereas you definitely need to
parse them first if you end up spitting out the usage. I could of course
plumb it as a new "mode" of git-rev-parse, but it sounds awkward.

> That command was written exactly to parse a command line. This is really=
=20
> cheesy, and doesn't really work right (it splits up numbers too), but you=
=20
> get the idea..

  I get the idea, though parse-options is not incremental at all, this
could probably be done, but would complicate the API (we would need to
allocate a state object e.g.). And parseoptions checks that options
getting an argument have one, checks that options exists and so on. It
looks like to me that it's not easy to plumb into rev-parse without
being a brand new independant mode.

  We can do that, if we don't want yet-another-git-builtin/command, but
in the spirit it'll remain a brand new "thing".

  Though I'd be glad to hear about what others think about it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHK0u1vGr7W6HudhwRAqq0AJ46mpdLx9kHiX5UOzRjojrDbAZdfACfa/Ne
gKvvRwD4DgbQpeYTfiuL6v4=
=B3nD
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--

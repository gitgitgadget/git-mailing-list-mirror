From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/3] Add strbuf_rtrim (to remove trailing spaces).
Date: Sun, 09 Sep 2007 01:44:25 +0200
Message-ID: <20070908234425.GC13385@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11892523992761-git-send-email-madcoder@debian.org> <1189252399433-git-send-email-madcoder@debian.org> <46E2CB4C.8050209@lsrfire.ath.cx> <20070908225353.GB13385@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="4ZLFUWh1odzi/v6L";
	protocol="application/pgp-signature"; micalg=SHA1
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 10:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOo-0003oI-4W
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:44:10 +0200
Received: from mail-mx2.uio.no ([129.240.10.30])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUA4d-0006Fp-7W
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:50:47 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUA4T-0006Ap-Ir
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbXIHXo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 19:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbXIHXo1
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 19:44:27 -0400
Received: from pan.madism.org ([88.191.52.104]:50202 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057AbXIHXo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 19:44:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BE82E1EB09;
	Sun,  9 Sep 2007 01:44:25 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6F37463FA; Sun,  9 Sep 2007 01:44:25 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070908225353.GB13385@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.5, required=12.0, autolearn=disabled, AWL=1.500,UIO_VGER=-3)
X-UiO-Scanned: 20E3EEEBBD5EED0D14648BEFF604830CEF5F8BCE
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -14 maxlevel 200 minaction 2 bait 0 mail/h: 28 total 517785 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58148>


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2007 at 10:53:53PM +0000, Pierre Habouzit wrote:
> On sam, sep 08, 2007 at 04:18:20 +0000, Ren=C3=A9 Scharfe wrote:
> > Pierre Habouzit schrieb:
> > > diff --git a/strbuf.c b/strbuf.c
> > > index acc7fc8..565c343 100644
> > > --- a/strbuf.c
> > > +++ b/strbuf.c
> > > @@ -28,6 +28,13 @@ void strbuf_grow(struct strbuf *sb, size_t extra) {
> > >  	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> > >  }
> > > =20
> > > +void strbuf_rtrim(struct strbuf *sb)
> > > +{
> > > +    while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1=
]))
> > > +        sb->len--;
> > > +    sb->buf[sb->len] =3D '\0';
> > > +}
> >=20
> > Please use tabs instead of spaces to indent, just like you did in your
> > other patches. :)
>=20
>   yeah, good catch.
>   I've added some more patches tonight, and have added another function
> in strbufs, and thanks to the awsome git rebase -i, this patch
> integrates this new function as well, so this patch series is obsolete
> already. I wont repost it until I know if I should rebase it on next
> rather than master though.

  Okay I'm stupid, Junio already merged my patches in next, doh.

  I've seen the conflict btw, and there is a memory leak (on the format)
in builtin-archive.c now... but I'm going to fix it (hopefuly) :)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4zPZvGr7W6HudhwRAjiSAJ46cKMbSeErfsujnnbeVJkEwmK/CACdH0Lo
WyW84BhvAPE7MjAOCKz0I24=
=Gao9
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
